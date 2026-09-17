--- @since 26.5.6

local snapshot = ya.sync(function()
    local paths = {}
    for _, url in pairs(cx.yanked) do
        paths[#paths + 1] = tostring(url)
    end
    return { paths = paths, cut = cx.yanked.is_cut, cwd = tostring(cx.active.current.cwd) }
end)

local function notify(message, level)
    ya.notify({ title = "File clipboard", content = message, level = level or "error", timeout = 5 })
end

local function encode(path)
    return "file://" .. path:gsub("([^A-Za-z0-9/_.~-])", function(c)
        return string.format("%%%02X", c:byte())
    end)
end

local function decode_list(text)
    local paths, seen = {}, {}
    for line in text:gmatch("[^\r\n]+") do
        if line:sub(1, 1) ~= "#" then
            local host, path = line:match("^file://([^/]*)(/.*)$")
            if not path or (host ~= "" and host ~= "localhost") then
                return nil, "Only local copied files are supported."
            end
            if path:gsub("%%%x%x", ""):find("%%") then
                return nil, "Invalid file reference in clipboard."
            end
            path = path:gsub("%%(%x%x)", function(hex) return string.char(tonumber(hex, 16)) end)
            path = path:gsub("/+$", "")
            if path:find("%z") or not path:match("[^/]+$") then
                return nil, "Invalid file reference in clipboard."
            end
            if not seen[path] then
                paths[#paths + 1], seen[path] = path, true
            end
        end
    end
    return paths
end

local function same_paths(a, b)
    if #a ~= #b then return false end
    local present = {}
    for _, path in ipairs(a) do present[path] = true end
    for _, path in ipairs(b) do
        if not present[path] then return false end
    end
    return true
end

local function copy()
    local state, uris = snapshot(), {}
    local paths = state.paths
    if #paths == 0 then return notify("No files selected.", "warn") end
    for _, path in ipairs(paths) do
        if path:sub(1, 1) ~= "/" then return notify("Only local files can be copied to the desktop.") end
        uris[#uris + 1] = encode(path)
    end
    -- URI-list comments distinguish our pending cut from another app's fresh copy.
    if state.cut then table.insert(uris, 1, "# yazi-cut") end
    -- Do not capture wl-copy's inherited output pipes: its clipboard owner stays alive.
    local child, err = Command("wl-copy")
        :arg({ "--type", "text/uri-list", "--", table.concat(uris, "\r\n") .. "\r\n" })
        :stdout(Command.NULL):stderr(Command.NULL):spawn()
    if not child then return notify("Could not start wl-copy: " .. tostring(err)) end
    local status = child:wait()
    if not status or not status.success then
        return notify("Desktop copy failed; the files are still yanked inside Yazi.")
    end
end

local function paste()
    local state = snapshot()
    local output = Command("timeout")
        :arg({ "3s", "wl-paste", "--no-newline", "--type", "text/uri-list" }):output()
    if not output or not output.status.success then
        return notify("No copied files on the desktop clipboard. Use p for Yazi's saved copy/cut.", "warn")
    end
    local paths, err = decode_list(output.stdout)
    if not paths then return notify(err) end
    if #paths == 0 then return notify("No copied files on the desktop clipboard.", "warn") end

    -- Native transfers retain Yazi's task queue, collision handling and cut semantics.
    local own_cut = output.stdout:match("^# yazi%-cut\r?\n") ~= nil
    if same_paths(paths, state.paths) and (not state.cut or own_cut) then
        ya.emit("paste", {})
        return
    end

    -- External clipboard imports use coreutils, preserving directories and symlinks.
    -- --update=none-fail also prevents overwrites if a destination appears mid-copy.
    local copied, skipped, failed = 0, 0, 0
    for _, path in ipairs(paths) do
        local target = Url(state.cwd):join(path:match("[^/]+$"))
        if fs.cha(target, false) then
            skipped = skipped + 1
        else
            local result = Command("cp")
                :arg({ "--archive", "--no-target-directory", "--update=none-fail", "--", path, tostring(target) })
                :output()
            if result and result.status.success then copied = copied + 1 else failed = failed + 1 end
        end
    end
    notify(string.format("Copied: %d. Already exist: %d. Failed: %d.", copied, skipped, failed),
        failed > 0 and "error" or (skipped > 0 and "warn" or "info"))
end

return {
    entry = function(_, job)
        if job.args[1] == "copy" then return copy() end
        if job.args[1] == "paste" then return paste() end
        notify("Unknown clipboard action.")
    end,
}
