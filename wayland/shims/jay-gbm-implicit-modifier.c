#define _GNU_SOURCE
#include <dlfcn.h>
#include <gbm.h>
#include <libdrm/drm_fourcc.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct gbm_bo *(*create_with_modifiers2_fn)(
    struct gbm_device *gbm, uint32_t width, uint32_t height, uint32_t format,
    const uint64_t *modifiers, const unsigned int count, uint32_t flags);

static int should_log(void)
{
    static int cached = -1;
    if (cached == -1)
        cached = getenv("JAY_GBM_IMPLICIT_SHIM_LOG") ? 1 : 0;
    return cached;
}

struct gbm_bo *gbm_bo_create_with_modifiers2(
    struct gbm_device *gbm, uint32_t width, uint32_t height, uint32_t format,
    const uint64_t *modifiers, const unsigned int count, uint32_t flags)
{
    static create_with_modifiers2_fn real_fn;
    if (!real_fn)
        real_fn = (create_with_modifiers2_fn)dlsym(RTLD_NEXT, "gbm_bo_create_with_modifiers2");

    struct gbm_bo *bo = real_fn(gbm, width, height, format, modifiers, count, flags);
    if (bo || !modifiers || count == 0)
        return bo;

    int has_linear_or_invalid = 0;
    for (unsigned int i = 0; i < count; i++) {
        if (modifiers[i] == DRM_FORMAT_MOD_LINEAR ||
            modifiers[i] == DRM_FORMAT_MOD_INVALID) {
            has_linear_or_invalid = 1;
            break;
        }
    }
    if (!has_linear_or_invalid)
        return NULL;

    if (count == 1 && modifiers[0] == DRM_FORMAT_MOD_LINEAR)
        ((uint64_t *)modifiers)[0] = DRM_FORMAT_MOD_INVALID;

    bo = real_fn(gbm, width, height, format, NULL, 0, flags);
    if (bo && should_log()) {
        fprintf(stderr,
                "jay-gbm-implicit-modifier: retried %ux%u format=0x%x flags=0x%x as implicit modifier\n",
                width, height, format, flags);
    }
    return bo;
}
