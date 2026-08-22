-- Hyprland 0.56+ Lua entrypoint.
local home = assert(os.getenv("HOME"), "HOME is not set")

package.path = home .. "/20_areas/?/init.lua;" .. package.path

require("configs/Keybinds")
require("configs/Startup_Apps")
require("UserConfigs/Startup_Apps")
require("configs/ENVariables")
require("UserConfigs/ENVariables")
require("configs/Laptops")
require("UserConfigs/Laptops")
require("UserConfigs/LaptopDisplay")
require("configs/WindowRules")
require("UserConfigs/WindowRules")
require("configs/SystemSettings")
require("UserConfigs/UserDecorations")
require("UserConfigs/UserAnimations")
require("UserConfigs/UserKeybinds")
require("UserConfigs/UserSettings")
require("UserConfigs/KeyRemap")

-- nwg-displays-managed monitor layout and workspace rules.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
require("monitors")
require("workspaces")
require("UserConfigs/MonitorRecovery")

hl.on("hyprland.start", function()
    hl.exec_cmd(home .. "/.config/hypr/initial-boot.sh")
end)

-- hyprwhspr toggle mode.
hl.bind(
    "SUPER + ALT + D",
    hl.dsp.exec_cmd("/usr/lib/hyprwhspr/config/hyprland/hyprwhspr-tray.sh record"),
    { description = "Speech-to-text" }
)
