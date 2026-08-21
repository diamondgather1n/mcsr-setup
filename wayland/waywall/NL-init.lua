local waywall = require("waywall")
local helpers = require("waywall.helpers")

local waywall_config_path = os.getenv("HOME") .. "/.config/waywall/"
local set_dpi_path = waywall_config_path .. "resources/set-dpi.py"
local bg_path = waywall_config_path .. "resources/background.png"
local crosshair_path = waywall_config_path .. "resources/crosshair.png"
local tall_overlay_path = waywall_config_path .. "resources/overlay_tall.png"
local thin_overlay_path = waywall_config_path .. "resources/overlay_thin.png"
local wide_overlay_path = waywall_config_path .. "resources/overlay_wide.png"

local pacem_path = waywall_config_path .. "resources/paceman-tracker-0.7.2.jar"
local nb_path = waywall_config_path .. "resources/Ninjabrain-Bot-1.5.2.jar"
local nb_hotkeys_path = waywall_config_path .. "resources/fix-ninbot-hotkeys.py"
local overlay_path = waywall_config_path .. "resources/measuring_overlay.png"
local stretched_overlay_path = waywall_config_path .. "resources/stretched_overlay.png"

local remaps_active = true
local rebind_text = nil
local thin_active = false
local keybinds_text = nil
local crosshair_image = nil
local debug_text_handles = {}
local debug_text = "Press Shift + I to show keybinds.\n\n" ..
    "Look at the Github's README for a guide to config.\n\n" ..
    "disable this message by setting\n" ..
    "\'debug_text\' to false in ~/.config/waywall/init.lua\n"

local function build_config(cfg, remaps)
    local keyboard_remaps = remaps.remapped_kb
    local other_remaps = remaps.normal_kb
    local ninbot_show_until_ms = -1
    local ninbot_active_overworld = false
    local ninbot_last_api_probe_ms = -1000
    local ninbot_last_eye_fingerprint = ""
    local ninbot_last_eye_count = nil
    local ninbot_api_url = "http://127.0.0.1:52533/api/v1/stronghold"

    local config = {
        input = {
            layout = (cfg.xkb_config.enabled and cfg.xkb_config.layout) or nil,
            rules = (cfg.xkb_config.enabled and cfg.xkb_config.rules) or nil,
            variant = (cfg.xkb_config.enabled and cfg.xkb_config.variant) or nil,
            options = (cfg.xkb_config.enabled and cfg.xkb_config.options) or nil,

            repeat_rate = cfg.repeat_rate or 40,
            repeat_delay = cfg.repeat_delay or 300,
            remaps = keyboard_remaps,
            sensitivity = (cfg.sens_change.enabled and cfg.sens_change.normal) or 1.0,
            confine_pointer = false,
        },
        theme = {
            background = cfg.bg_col,
            background_png = cfg.toggle_bg_picture and bg_path or nil,
            ninb_anchor = cfg.ninbot_anchor,
            ninb_opacity = cfg.ninbot_opacity,
        },
        experimental = {
            debug = false,
            jit = false,
            tearing = false,
        },
        window = {
            fullscreen_width = cfg.resolution[1],
            fullscreen_height = cfg.resolution[2],
        }
    }

    local is_running = function(pattern)
        local handle = io.popen("ps aux | grep '" .. pattern .. "'")
        local result = handle:read("*l")
        handle:close()
        return result ~= nil
    end
    local is_ninb_running = function()
        return is_running("[N]injabrain-Bot.*\\.jar")
    end
    local repair_ninbot_hotkeys = function()
        os.execute("/usr/bin/python3 " .. nb_hotkeys_path .. " >/dev/null 2>&1")
    end
    local request_ninbot_state
    local current_ms = function()
        local ok, now = pcall(waywall.current_time)
        if ok and type(now) == "number" then
            return now
        end

        return 0
    end
    local keep_ninbot_visible = function(sec)
        if not sec or sec <= 0 then
            return
        end

        local new_show_until_ms = current_ms() + sec * 1000
        ninbot_show_until_ms = math.max(ninbot_show_until_ms, new_show_until_ms)
    end
    local apply_ninbot_visibility = function()
        if ninbot_active_overworld
            or ninbot_show_until_ms > current_ms()
        then
            waywall.show_floating(true)
        else
            waywall.show_floating(false)
        end
    end
    local show_ninbot = function(sec, launch_delay_ms)
        if not is_ninb_running() then
            repair_ninbot_hotkeys()
            waywall.exec("java -Dawt.useSystemAAFontSettings=on -jar " .. nb_path)
            if launch_delay_ms and launch_delay_ms > 0 then
                waywall.sleep(launch_delay_ms)
            end
        end

        keep_ninbot_visible(sec)
        apply_ninbot_visibility()
    end
    local hide_ninbot = function()
        ninbot_show_until_ms = -1
        waywall.show_floating(false)
    end
    local finish_ninbot_window = function(_sec)
        -- Long waywall.sleep timers have been observed crashing Waywall while
        -- resuming Lua callbacks. Visibility still expires through state/input
        -- updates via ninbot_show_until_ms.
        apply_ninbot_visibility()
    end
    local send_ninbot_input = function(key)
        show_ninbot(cfg.ninbot_hide_time_input or 10)
        return false
    end
    local eye_throws_state = function(data)
        local section = data:match('"eyeThrows"%s*:%s*%[(.-)%]%s*,%s*"resultType"')
            or data:match('"eyeThrows"%s*:%s*%[(.-)%]')
            or ""
        local count = 0

        for _ in section:gmatch('"xInOverworld"%s*:') do
            count = count + 1
        end

        return count, section
    end
    local update_ninbot_from_api = function(data)
        if not data or data == "" or data == "nil" or data == "(null)" then
            return
        end

        local eye_count, eye_fingerprint = eye_throws_state(data)
        local has_measurement = eye_count > 0
        local in_overworld = data:find('"isInOverworld"%s*:%s*true') ~= nil
        local in_nether = data:find('"isInNether"%s*:%s*true') ~= nil
        local measurement_changed = eye_fingerprint ~= ninbot_last_eye_fingerprint
        local count_increased = ninbot_last_eye_count ~= nil and eye_count > ninbot_last_eye_count
        local count_decreased = ninbot_last_eye_count ~= nil and eye_count < ninbot_last_eye_count

        if not has_measurement then
            ninbot_active_overworld = false
        elseif in_overworld and (measurement_changed or ninbot_last_eye_count == nil) then
            ninbot_active_overworld = true
        elseif in_nether and count_increased then
            ninbot_active_overworld = false
            keep_ninbot_visible(cfg.ninbot_hide_time_coords or 30)
        end

        if measurement_changed then
            if ninbot_last_eye_fingerprint ~= "" and (eye_count == 0 or count_decreased) then
                keep_ninbot_visible(cfg.ninbot_hide_time_input or 10)
            end

            ninbot_last_eye_fingerprint = eye_fingerprint
        end
        ninbot_last_eye_count = eye_count

        apply_ninbot_visibility()
    end
    request_ninbot_state = function(_)
        return
    end
    local is_pacem_running = function()
        return is_running("[p]aceman-tracker.*\\.jar")
    end
    local set_dpi = function(dpi)
        if cfg.dpi_change.path then
            waywall.exec(("%s %d"):format(set_dpi_path, dpi))
        else
            waywall.exec(("/usr/bin/polychromatic-cli -d mouse --dpi %d >/dev/null 2>&1"):format(dpi))
        end
    end
    local set_mouse = function(dpi, sensitivity)
        if cfg.dpi_change and cfg.dpi_change.enabled then
            set_dpi(dpi)
        end
        if cfg.sens_change.enabled then
            waywall.set_sensitivity(sensitivity)
        end
    end
    local set_normal_mouse = function()
        set_mouse(cfg.dpi_change and cfg.dpi_change.normal, cfg.sens_change.normal)
    end
    local set_tall_mouse = function()
        set_mouse(cfg.dpi_change and cfg.dpi_change.tall, cfg.sens_change.tall)
    end

    local pie_colors = {
        { input = "#EC6E4E", output = cfg.pie_chart_1 },
        { input = "#46CE66", output = cfg.pie_chart_2 },
        { input = "#CC6C46", output = cfg.pie_chart_2 },
        { input = "#464C46", output = cfg.pie_chart_2 },
        { input = "#E446C4", output = cfg.pie_chart_3 }
    }
    local percentage_colors = {
        { input = "#E96D4D", output = cfg.percentage_1 or (cfg.percentages_match_text and cfg.text_col or cfg.pie_chart_1), slot = 0, sources_key = "orange_sources", crop_from_right_key = "orange_crop_from_right" },
        { input = "#45CB65", output = cfg.percentage_2 or (cfg.percentages_match_text and cfg.text_col or cfg.pie_chart_2), slot = 1, sources_key = "green_sources", crop_from_right_key = "green_crop_from_right" },
    }
    local pie_dst = function(pie_cfg, height)
        local w = 420 * pie_cfg.size / 4
        local h = height * pie_cfg.size / 4

        return { x = pie_cfg.x - w / 2, y = pie_cfg.y - h / 2, w = w, h = h }
    end
    local right_src = function(res, y_from_bottom, preferred_w, h)
        local w = math.min(preferred_w, res[1])
        return { x = res[1] - w, y = res[2] - y_from_bottom, w = w, h = h }
    end
    local percent_sources = function(percent_cfg, ck)
        if percent_cfg.rows and ck.crop_from_right_key then
            local crop_from_right = percent_cfg[ck.crop_from_right_key] or percent_cfg.crop_from_right or 93
            local sources = {}
            for _, crop_from_bottom in ipairs(percent_cfg.rows) do
                table.insert(sources, {
                    crop_from_right = crop_from_right,
                    crop_from_bottom = crop_from_bottom,
                    crop_w = percent_cfg.crop_w,
                    crop_h = percent_cfg.crop_h,
                })
            end
            return sources
        end
        if ck.sources_key and percent_cfg[ck.sources_key] then
            return percent_cfg[ck.sources_key]
        end
        if percent_cfg.sources then
            return percent_cfg.sources
        end
        if percent_cfg.crop2_from_right then
            return {
                { crop_from_right = percent_cfg.crop_from_right, crop_w = percent_cfg.crop_w, crop_h = percent_cfg.crop_h },
                { crop_from_right = percent_cfg.crop2_from_right, crop_w = percent_cfg.crop2_w or percent_cfg.crop_w, crop_h = percent_cfg.crop2_h or percent_cfg.crop_h },
            }
        end
        return { percent_cfg }
    end
    local percent_src = function(res, percent_cfg, source_cfg)
        source_cfg = source_cfg or percent_cfg
        local crop_from_right = source_cfg.crop_from_right or percent_cfg.crop_from_right or 93
        local x = math.max(0, res[1] - crop_from_right)
        local w = math.min(source_cfg.crop_w or percent_cfg.crop_w or 93, res[1] - x)
        local h = source_cfg.crop_h or percent_cfg.crop_h or 25
        local y = source_cfg.crop_y or percent_cfg.crop_y or (res[2] - (source_cfg.crop_from_bottom or percent_cfg.crop_from_bottom or 221))
        return { x = x, y = y, w = w, h = h }
    end
    local percent_dst = function(percent_cfg, slot)
        local w = percent_cfg.dst_w or percent_cfg.crop_w or 93
        local h = percent_cfg.dst_h or percent_cfg.crop_h or 25
        local scaled_w = w * percent_cfg.size
        local x = percent_cfg.x or 0
        local y = percent_cfg.y or 0
        if slot == 0 then
            x = percent_cfg.orange_x or x
            y = percent_cfg.orange_y or y
        else
            x = percent_cfg.green_x or (x + scaled_w + (percent_cfg.gap or 0))
            y = percent_cfg.green_y or y
        end
        return {
            x = x,
            y = y,
            w = scaled_w,
            h = h * percent_cfg.size,
        }
    end
    local pie_top_percent_src = function(res, percent_cfg)
        return {
            x = percent_cfg.crop_x or (res[1] - (percent_cfg.crop_from_right or 50)),
            y = res[2] - (percent_cfg.crop_from_bottom or 422),
            w = percent_cfg.crop_w or 44,
            h = percent_cfg.crop_h or 18,
        }
    end
    local pie_top_percent_dst = function(pie_cfg, percent_cfg)
        local pie = pie_dst(pie_cfg, 423)
        local size = percent_cfg.size or pie_cfg.size or 5
        local w = (percent_cfg.crop_w or 44) * size
        local h = (percent_cfg.crop_h or 18) * size

        return {
            x = percent_cfg.x or (pie.x + pie.w - w),
            y = (percent_cfg.y or (pie.y - h - (percent_cfg.gap or 12))) + (percent_cfg.y_offset or 0),
            w = w,
            h = h,
        }
    end
    local mirror_percent = function(res, percent_cfg)
        for _, ck in ipairs(percentage_colors) do
            for _, source_cfg in ipairs(percent_sources(percent_cfg, ck)) do
                helpers.res_mirror(
                    {
                        src = percent_src(res, percent_cfg, source_cfg),
                        dst = percent_dst(percent_cfg, ck.slot),
                        depth = 3,
                        color_key = { input = ck.input, output = ck.output },
                    },
                    res[1], res[2]
                )
            end
        end
    end
    local mirror_pie_top_percent = function(res, pie_cfg, percent_cfg)
        if not pie_cfg or not pie_cfg.enabled or not percent_cfg or not percent_cfg.enabled then
            return
        end

        for _, color in ipairs(percent_cfg.colors or { false }) do
            helpers.res_mirror({
                src = pie_top_percent_src(res, percent_cfg),
                dst = pie_top_percent_dst(pie_cfg, percent_cfg),
                depth = percent_cfg.depth or 3,
                color_key = color and { input = color, output = color } or nil,
            }, res[1], res[2])
        end
    end
    local mirror_pie = function(res, pie_cfg)
        if not pie_cfg.enabled then
            return
        end

        if pie_cfg.colorkey then
            for _, ck in ipairs(pie_colors) do
                helpers.res_mirror(
                    {
                        src = right_src(res, 406, 340, 178),
                        dst = pie_dst(pie_cfg, 423),
                        depth = 2,
                        color_key = ck,
                    },
                    res[1], res[2]
                )
            end
        else
            helpers.res_mirror(
                {
                    src = right_src(res, 406, 340, 221),
                    dst = pie_dst(pie_cfg, 273),
                    depth = 2,
                },
                res[1], res[2]
            )
        end
    end
    local fullscreen_percent_src = function(percent_cfg)
        return {
            x = percent_cfg.crop_x or 0,
            y = percent_cfg.crop_y or 0,
            w = percent_cfg.crop_w or 1,
            h = percent_cfg.crop_h or 1,
        }
    end
    local fullscreen_percent_dst = function(percent_cfg)
        local size = percent_cfg.size or 1
        local w = (percent_cfg.crop_w or 1) * size
        local h = (percent_cfg.crop_h or 1) * size

        return {
            x = (percent_cfg.x or cfg.resolution[1] / 2) - w / 2,
            y = (percent_cfg.y or cfg.resolution[2] / 2) - h / 2,
            w = w,
            h = h,
        }
    end
    local mirror_fullscreen_percent = function(percent_cfg)
        if not percent_cfg or not percent_cfg.enabled then
            return
        end

        for _, color in ipairs(percent_cfg.colors or { false }) do
            helpers.res_mirror({
                src = fullscreen_percent_src(percent_cfg),
                dst = fullscreen_percent_dst(percent_cfg),
                depth = percent_cfg.depth or 4,
                color_key = color and { input = color, output = percent_cfg.output_color or color } or nil,
            }, 0, 0)
        end
    end

    if cfg.e_count.enabled then
        local e_count_src = cfg.e_count.show_c
            and { x = 1, y = 28, w = 49, h = 18 }
            or { x = 13, y = 37, w = 37, h = 9 }
        local e_count_dst = cfg.e_count.show_c
            and { x = cfg.e_count.x, y = cfg.e_count.y, w = 49 * cfg.e_count.size, h = 18 * cfg.e_count.size }
            or { x = cfg.e_count.x, y = cfg.e_count.y, w = 37 * cfg.e_count.size, h = 9 * cfg.e_count.size }
        local e_count_colors = {}
        for _, color in ipairs(cfg.e_count_colors or { "#DDDDDD" }) do
            table.insert(e_count_colors, color)
        end
        if cfg.e_count_pause_colors then
            for _, color in ipairs(cfg.e_count_pause_colors) do
                table.insert(e_count_colors, color)
            end
        end
        for _, res in ipairs({ cfg.thin_res, cfg.tall_res }) do
            for _, color in ipairs(cfg.e_count.colorkey and e_count_colors or { false }) do
                helpers.res_mirror(
                    {
                        src = e_count_src,
                        dst = e_count_dst,
                        depth = 2,
                        color_key = color and {
                            input = color,
                            output = cfg.e_count_col or cfg.text_col,
                        } or nil,
                    },
                    res[1], res[2]
                )
            end
        end
    end

    mirror_pie(cfg.thin_res, cfg.thin_pie)
    mirror_pie_top_percent(cfg.thin_res, cfg.thin_pie, cfg.thin_pie_top_percent)

    if cfg.thin_percent.enabled then
        mirror_percent(cfg.thin_res, cfg.thin_percent)
    end

    mirror_pie(cfg.tall_res, cfg.tall_pie)
    mirror_pie_top_percent(cfg.tall_res, cfg.tall_pie, cfg.tall_pie_top_percent)

    if cfg.tall_percent.enabled then
        mirror_percent(cfg.tall_res, cfg.tall_percent)
    end

    mirror_fullscreen_percent(cfg.fullscreen_spawner_percent)

    helpers.res_mirror(
        {
            src = cfg.stretched_measure
                and { x = (cfg.tall_res[1] - 30) / 2, y = (cfg.tall_res[2] - 580) / 2, w = 30, h = 580 }
                or { x = (cfg.tall_res[1] - 60) / 2, y = (cfg.tall_res[2] - 580) / 2, w = 60, h = 580 },
            dst = { x = cfg.measuring_window.x, y = cfg.measuring_window.y, w = 70 * cfg.measuring_window.size, h = 40 * cfg.measuring_window.size },
            depth = 2,
        },
        cfg.tall_res[1], cfg.tall_res[2]
    )

    helpers.res_image(
        cfg.stretched_measure and stretched_overlay_path or overlay_path,
        {
            dst = { x = cfg.measuring_window.x, y = cfg.measuring_window.y, w = 70 * cfg.measuring_window.size, h = 40 * cfg.measuring_window.size },
            depth = 3,
        },
        cfg.tall_res[1], cfg.tall_res[2]
    )
    for _, image in ipairs({
        { path = tall_overlay_path, res = cfg.tall_res },
        { path = wide_overlay_path, res = cfg.wide_res },
        { path = thin_overlay_path, res = cfg.thin_res },
    }) do
        helpers.res_image(
            image.path,
            {
                dst = { x = 0, y = 0, w = cfg.resolution[1], h = cfg.resolution[2] },
                depth = 1,
            },
            image.res[1], image.res[2]
        )
    end

    waywall.listen("load", function()
        set_normal_mouse()
        if cfg.crosshair and cfg.crosshair.enabled then
            local size = cfg.crosshair.size or 2
            crosshair_image = waywall.image(crosshair_path, {
                dst = {
                    x = (cfg.resolution[1] - size) / 2 + (cfg.crosshair.x or 0),
                    y = (cfg.resolution[2] - size) / 2 + (cfg.crosshair.y or 0),
                    w = size,
                    h = size,
                },
                depth = cfg.crosshair.depth or 100,
            })
        end
        if cfg.debug_text then
            for _, text_cfg in ipairs({
                { x = 10, y = 10, color = "#FFFF00" },
                { x = 11, y = 11, color = "#FFFF00" },
                { x = 13, y = 13, color = "#000000" },
                { x = 14, y = 14, color = "#000000" },
            }) do
                text_cfg.size = 3
                table.insert(debug_text_handles, waywall.text(debug_text, text_cfg))
            end
        end

        apply_ninbot_visibility()
    end)

    local thin_enable = function()
        thin_active = true
        set_normal_mouse()
    end
    local tall_enable = function()
        set_tall_mouse()
        thin_active = false
    end
    local wide_enable = function()
        set_normal_mouse()
        thin_active = false
    end
    local res_disable = function()
        set_normal_mouse()
        thin_active = false
    end

    local make_res = function(width, height, enable, disable)
        return function()
            local active_width, active_height = waywall.active_res()

            if active_width == width and active_height == height then
                if cfg.enable_resize_animations then
                    os.execute('echo "0x0" > ~/.resetti_state')
                    waywall.sleep(17)
                end
                waywall.set_resolution(0, 0)
                disable()
            else
                if cfg.enable_resize_animations then
                    os.execute(string.format('echo "%dx%d" > ~/.resetti_state', width, height))
                    waywall.sleep(17)
                end
                waywall.set_resolution(width, height)
                enable()
            end
        end
    end

    local resolutions = {
        thin = make_res(cfg.thin_res[1], cfg.thin_res[2], thin_enable, res_disable),
        tall = make_res(cfg.tall_res[1], cfg.tall_res[2], tall_enable, res_disable),
        wide = make_res(cfg.wide_res[1], cfg.wide_res[2], wide_enable, res_disable),
    }

    local function resize_helper(mode, run, ingame_only)
        local resize = function()
            if not remaps_active then
                return false
            end
            if mode.f3_safe and waywall.get_key("F3") then
                return false
            end
            return run()
        end

        if ingame_only then
            return helpers.ingame_only(resize)
        end

        return resize
    end

    local function bind_resize(actions, mode, run)
        local action = resize_helper(mode, run, mode.ingame_only)

        actions[mode.key] = action
        if mode.alt_key then
            actions[mode.alt_key] = action
        end
        if mode.xf86_key then
            actions[mode.xf86_key] = action
        end
        if mode.extra_keys then
            for _, key in ipairs(mode.extra_keys) do
                actions[key] = action
            end
        end
    end

    local function key_set(key, alt_key, xf86_key, extra_keys)
        local keys = {}
        if key then
            table.insert(keys, key)
        end
        if alt_key then
            table.insert(keys, alt_key)
        end
        if xf86_key then
            table.insert(keys, xf86_key)
        end
        if extra_keys then
            for _, extra_key in ipairs(extra_keys) do
                table.insert(keys, extra_key)
            end
        end
        return keys
    end

    local function key_list(mode)
        return table.concat(key_set(mode.key, mode.alt_key, mode.xf86_key, mode.extra_keys), " / ")
    end

    local function action_key_list(key, extra_keys)
        return table.concat(key_set(key, nil, nil, extra_keys), " / ")
    end

    local function bind_action_keys(actions, key, extra_keys, action)
        for _, action_key in ipairs(key_set(key, nil, nil, extra_keys)) do
            actions[action_key] = action
        end
    end

    config.actions = {}
    bind_resize(config.actions, cfg.thin, resolutions.thin)
    bind_resize(config.actions, cfg.wide, resolutions.wide)
    bind_resize(config.actions, cfg.tall, resolutions.tall)

    local function bind_shift_hotbar(key, output)
        config.actions[key] = helpers.ingame_only(function()
            waywall.press_key(output)
        end)
    end
    bind_shift_hotbar("*-Shift-2", "1")
    bind_shift_hotbar("*-Shift-3", "2")
    bind_shift_hotbar("*-Shift-4", "3")
    bind_shift_hotbar("*-Shift-5", "4")
    config.actions["*-Shift-6"] = helpers.ingame_only(function()
        return true
    end)
    bind_shift_hotbar("*-Shift-7", "6")

    config.actions[cfg.toggle_fullscreen_key] = waywall.toggle_fullscreen
    config.actions[cfg.launch_paceman_key] = function()
        if is_pacem_running() then
            print("Paceman Already Running")
        else
            waywall.exec("java -jar " .. pacem_path .. " --nogui")
            print("Paceman Running")
        end
    end
    config.actions[cfg.toggle_ninbot_key] = function()
        if not is_ninb_running() or not waywall.floating_shown() then
            show_ninbot(cfg.ninbot_hide_time_input or 10, cfg.ninbot_launch_delay_ms or 250)
            request_ninbot_state(cfg.ninbot_api_after_input_delay_ms or 150)
            finish_ninbot_window(cfg.ninbot_hide_time_input or 10)
        else
            hide_ninbot()
        end
    end
    config.actions["*-C"] = function()
        if not remaps_active or not waywall.get_key("F3") then
            return false
        end

        waywall.press_key("C")
        show_ninbot(cfg.ninbot_hide_time_coords or 30, cfg.ninbot_launch_delay_ms or 250)
        request_ninbot_state(cfg.ninbot_api_after_input_delay_ms or 150)
        finish_ninbot_window(cfg.ninbot_hide_time_coords or 30)
    end
    for _, key in ipairs(cfg.ninbot_input_keys or {}) do
        config.actions[key] = function()
            return send_ninbot_input(key)
        end
    end
    local toggle_remaps = function()
        if rebind_text then
            rebind_text:close()
            rebind_text = nil
        end
        if remaps_active then
            remaps_active = false
            waywall.set_remaps(other_remaps)

            if cfg.xkb_config.enabled then
                waywall.set_keymap({
                    layout = nil,
                    rules = nil,
                    variant = nil,
                    options = nil,
                })
            end

            rebind_text = waywall.text(cfg.remaps_text_config.text,
                {
                    x = cfg.remaps_text_config.x,
                    y = cfg.remaps_text_config.y,
                    color = cfg.remaps_text_config.color,
                    size = cfg.remaps_text_config.size
                })
        else
            remaps_active = true
            waywall.set_remaps(keyboard_remaps)

            if cfg.xkb_config.enabled then
                waywall.set_keymap({
                    layout = cfg.xkb_config.layout,
                    rules = cfg.xkb_config.rules,
                    variant = cfg.xkb_config.variant,
                    options = cfg.xkb_config.options
                })
            end
        end
    end
    bind_action_keys(config.actions, cfg.toggle_remaps_key, cfg.toggle_remaps_extra_keys, toggle_remaps)
    config.actions["Shift-I"] = function()
        if keybinds_text then
            keybinds_text:close()
            keybinds_text = nil
            return false
        end
        keybinds_text = waywall.text(
            "KEYBINDS:\n" ..
            "Thin = " .. key_list(cfg.thin) .. "\n" ..
            "Wide = " .. key_list(cfg.wide) .. "\n" ..
            "Tall = " .. key_list(cfg.tall) .. "\n" ..
            "Toggle Ninbot = " .. cfg.toggle_ninbot_key .. "\n" ..
            "Launch paceman = " .. cfg.launch_paceman_key .. "\n" ..
            "Fullscreen = " .. cfg.toggle_fullscreen_key .. "\n" ..
            "Chat Mode = " .. action_key_list(cfg.toggle_remaps_key, cfg.toggle_remaps_extra_keys) .. "\n"
            ,
            { x = 10, y = 10, color = "#FFFFFF", size = 3 })
        if #debug_text_handles > 0 then
            for i, handle in ipairs(debug_text_handles) do
                handle:close()
                debug_text_handles[i] = nil
            end
        end
    end
    return config
end

local DISABLED = "F12"

local remaps = {
    remapped_kb = {
        ["Esc"] = DISABLED,
        ["1"] = "F3",
        ["2"] = "F17",
        ["3"] = "F18",
        ["4"] = "F19",
        ["5"] = "F20",
        ["6"] = DISABLED,
        ["7"] = DISABLED,

        -- Waywall disables these while wrapped Minecraft is active.
        ["8"] = DISABLED,
        ["9"] = DISABLED,
        ["0"] = DISABLED,
        ["TAB"] = "PROG1",
        ["X"] = "TAB",

        ["MINUS"] = DISABLED,
        ["EQUAL"] = DISABLED,

        ["Y"] = DISABLED,
        ["U"] = DISABLED,
        ["I"] = DISABLED,
        ["O"] = DISABLED,
        ["P"] = DISABLED,

        ["H"] = DISABLED,
        -- J is intentionally omitted so Ninjabrain receives the native lock key.
        ["K"] = DISABLED,
        ["L"] = DISABLED,
        ["SEMICOLON"] = DISABLED,
        ["GRAVE"] = "Esc",
        ["BACKSLASH"] = DISABLED,

        ["COMMA"] = DISABLED,
        ["DOT"] = DISABLED,
        ["SLASH"] = DISABLED,
        ["102ND"] = "0",

        ["KPASTERISK"] = DISABLED,
        ["LEFTALT"] = DISABLED,
        ["SCROLLLOCK"] = DISABLED,
        ["KPMINUS"] = DISABLED,
        ["KPPLUS"] = DISABLED,
        ["KPDOT"] = DISABLED,

        ["F1"] = DISABLED,
        ["F2"] = DISABLED,
        ["F5"] = DISABLED,
        ["F6"] = DISABLED,
        ["F7"] = DISABLED,
        ["F8"] = DISABLED,
        ["F9"] = DISABLED,
        ["F10"] = DISABLED,
        ["F11"] = DISABLED,
        ["F12"] = DISABLED,

        ["ZENKAKUHANKAKU"] = DISABLED,
        ["RO"] = DISABLED,
        ["KATAKANA"] = DISABLED,
        ["HIRAGANA"] = DISABLED,
        ["HENKAN"] = DISABLED,
        ["KATAKANAHIRAGANA"] = DISABLED,
        ["MUHENKAN"] = DISABLED,
        ["KPJPCOMMA"] = DISABLED,
        ["KPENTER"] = DISABLED,
        ["SYSRQ"] = DISABLED,
        ["RIGHTALT"] = DISABLED,
        ["LINEFEED"] = DISABLED,
        ["PAGEUP"] = DISABLED,
        ["END"] = DISABLED,
        ["PAGEDOWN"] = DISABLED,
        ["INSERT"] = DISABLED,

        -- Arrow keys are intentionally omitted. Ninjabrain records them more
        -- reliably when Waywall lets the native events pass through untouched.

        ["Mouse5"] = "Home",
        ["Mouse4"] = "Backspace",
        ["MiddleMouse"] = "RightShift",
    },

    normal_kb = {
        ["Mouse5"] = "Home",
        ["Mouse4"] = "Backspace",

        -- Arrow keys pass through natively. Gameplay remaps belong to Waywall,
        -- not keyd's desktop input profile.
    },
}

local cfg = {
    debug_text = false,
    resolution = { 1920, 1080 },
    bg_col = "#000000",
    toggle_bg_picture = true,
    text_col = "#FFFFFF",
    pie_chart_1 = "#EC6E4E",
    pie_chart_2 = "#46CE66",
    pie_chart_3 = "#E446C4",

    ninbot_anchor = { position = "topright", x = 0, y = 80 },
    ninbot_opacity = 1,
    thin_res = { 330, 1080 },
    wide_res = { 1920, 300 },
    tall_res = { 330, 16384 },

    e_count = { enabled = true, x = 1200, y = 0, size = 6, colorkey = true, show_c = true },
    e_count_col = "#FF6A1A",
    e_count_colors = { "#DDDDDD" },
    e_count_pause_colors = {},

    thin_pie = { enabled = true, x = 1500, y = 540, size = 5, colorkey = true },
    tall_pie = { enabled = true, x = 1500, y = 540, size = 5, colorkey = true },
    thin_pie_top_percent = { enabled = true, crop_x = 280, crop_from_bottom = 422, crop_w = 44, crop_h = 18, size = 6, gap = 12, y_offset = 50, colors = { "#FCFCFC" } },
    tall_pie_top_percent = { enabled = true, crop_x = 280, crop_from_bottom = 422, crop_w = 44, crop_h = 18, size = 6, gap = 12, y_offset = 50, colors = { "#FCFCFC" } },
    fullscreen_spawner_percent = {
        enabled = true,
        crop_x = 1812,
        crop_y = 858,
        crop_w = 70,
        crop_h = 42,
        x = 1760,
        y = 788,
        size = 4,
        colors = { "#4DE1CA" },
        output_color = "#000080",
    },

    thin_percent = {
        enabled = true,
        size = 6,
        crop_w = 46,
        crop_h = 8,
        rows = { 220, 212, 204, 196, 188 },
        orange_crop_from_right = 118,
        green_crop_from_right = 118,
        orange_x = 1350,
        orange_y = 500,
        green_x = 1470,
        green_y = 530,
    },
    tall_percent = {
        enabled = true,
        size = 6,
        crop_w = 46,
        crop_h = 8,
        rows = { 220, 212, 204, 196, 188 },
        orange_crop_from_right = 118,
        green_crop_from_right = 118,
        orange_x = 1350,
        orange_y = 500,
        green_x = 1470,
        green_y = 530,
    },
    percentage_1 = "#000000",
    percentage_2 = "#FFFFFF",
    percentages_match_text = false,

    measuring_window = { x = 0, y = 0, size = 11.36 },
    stretched_measure = false,
    crosshair = { enabled = true, size = 2, x = 0, y = 0, depth = 100 },

    thin = { key = "*-Multi_key", alt_key = "*-F13", xf86_key = "*-XF86Tools", f3_safe = false, ingame_only = false },
    wide = { key = "*-F16", alt_key = nil, xf86_key = "*-XF86Launch7", extra_keys = { "*-N" }, f3_safe = false, ingame_only = true },
    tall = { key = "*-Alt_L", alt_key = "*-F14", xf86_key = "*-F15", extra_keys = { "*-H", "*-XF86Launch5", "*-XF86Launch6" }, f3_safe = false, ingame_only = false },

    toggle_fullscreen_key = "Shift-O",
    launch_paceman_key = "Shift-P",
    toggle_ninbot_key = "Shift-apostrophe",
    ninbot_launch_delay_ms = 250,
    ninbot_hide_time_coords = 30,
    ninbot_hide_time_input = 10,
    ninbot_api_after_input_delay_ms = 150,
    ninbot_api_min_interval_ms = 250,
    -- Do not hook these as Waywall actions. They must pass through cleanly to
    -- Ninjabrain; wrapping them broke wheel/arrow input.
    ninbot_input_keys = {},
    -- PgDn reports as keysym Next in wev. Insert stays as a fallback.
    toggle_remaps_key = "Next",
    toggle_remaps_extra_keys = { "Page_Down", "Insert" },

    repeat_rate = 200,
    repeat_delay = 150,

    xkb_config = {
        enabled = true,
        layout = "mcsr",
        rules = nil,
        variant = "norwegian",
        options = nil,
    },
    remaps_text_config = { text = "chat mode", x = 100, y = 100, size = 2, color = "#000000" },

    dpi_change = {
        enabled = true,
        normal = 2000,
        tall = 200,
        path = "/sys/devices/pci0000:00/0000:00:02.1/0000:03:00.0/0000:04:0c.0/0000:0a:00.0/usb1/1-5/1-5:1.0/0003:1532:0098.0006/dpi",
    },
    sens_change = { enabled = false, normal = 1.0, tall = 0.1 },
    enable_resize_animations = false,
}

return build_config(cfg, remaps)
