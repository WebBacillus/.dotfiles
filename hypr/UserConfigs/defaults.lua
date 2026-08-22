local home = assert(os.getenv("HOME"), "HOME is not set")

hl.env("EDITOR", "nvim")

return {
    home = home,
    main_mod = "SUPER",
    user_main_mod = "ALT",
    terminal = "kitty",
    file_manager = "thunar",
    editor = os.getenv("EDITOR") or "nvim",
    search_engine = "https://www.google.com/search?q={}",
    scripts_dir = home .. "/.config/hypr/scripts",
    user_scripts_dir = home .. "/.config/hypr/UserScripts",
    user_configs_dir = home .. "/.config/hypr/UserConfigs",
}
