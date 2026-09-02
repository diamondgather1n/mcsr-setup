#define _GNU_SOURCE

#include <dlfcn.h>
#include <gio/gio.h>
#include <glib.h>
#include <stdbool.h>
#include <string.h>

typedef void (*g_dbus_proxy_call_fn)(GDBusProxy *proxy, const gchar *method_name,
                                     GVariant *parameters, GDBusCallFlags flags,
                                     gint timeout_msec, GCancellable *cancellable,
                                     GAsyncReadyCallback callback, gpointer user_data);

static GVariant *rewrite_select_sources(GVariant *parameters)
{
    const gchar *session_handle = NULL;
    GVariantIter *iter = NULL;
    GVariantBuilder builder;
    bool changed = false;

    if (!parameters || !g_variant_is_of_type(parameters, G_VARIANT_TYPE("(oa{sv})")))
        return parameters;

    g_variant_get(parameters, "(&oa{sv})", &session_handle, &iter);
    g_variant_builder_init(&builder, G_VARIANT_TYPE("a{sv}"));

    const gchar *key = NULL;
    GVariant *value = NULL;
    while (g_variant_iter_loop(iter, "{&sv}", &key, &value)) {
        if (strcmp(key, "cursor_mode") == 0) {
            changed = true;
            continue;
        }

        g_variant_builder_add(&builder, "{sv}", key, g_variant_ref(value));
    }

    g_variant_iter_free(iter);

    if (!changed)
        return parameters;

    g_message("obs-jay-portal-cursor: dropped ScreenCast cursor_mode");
    return g_variant_new("(oa{sv})", session_handle, &builder);
}

void g_dbus_proxy_call(GDBusProxy *proxy, const gchar *method_name, GVariant *parameters,
                       GDBusCallFlags flags, gint timeout_msec, GCancellable *cancellable,
                       GAsyncReadyCallback callback, gpointer user_data)
{
    static g_dbus_proxy_call_fn real_g_dbus_proxy_call;

    if (!real_g_dbus_proxy_call)
        real_g_dbus_proxy_call =
            (g_dbus_proxy_call_fn)dlsym(RTLD_NEXT, "g_dbus_proxy_call");

    if (method_name && strcmp(method_name, "SelectSources") == 0)
        parameters = rewrite_select_sources(parameters);

    real_g_dbus_proxy_call(proxy, method_name, parameters, flags, timeout_msec,
                           cancellable, callback, user_data);
}
