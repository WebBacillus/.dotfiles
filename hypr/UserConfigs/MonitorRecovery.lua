-- Restore the internal display if removing an output leaves no active monitor.
-- This replaces the legacy socket watcher and its Lua-incompatible
-- `hyprctl keyword monitor` call.

hl.on("monitor.removed", function()
    if #hl.get_monitors() ~= 0 then
        return
    end

    hl.monitor({
        output = "eDP-1",
        mode = "preferred",
        position = "auto",
        scale = 1,
        disabled = false,
    })

    hl.exec_cmd("notify-send -u critical 'Display recovery' 'Restored eDP-1 after the last monitor was removed'")
end)
