---@type LazySpec
return {
  {
    "3rd/image.nvim",
    -- scope activation to the obsidian vault so it doesn't fire on every markdown file
    event = { "BufReadPre */20_areas/Obsidian/*.md", "BufNewFile */20_areas/Obsidian/*.md" },
    -- pick a backend that actually exists in the installed image.nvim version
    opts = function()
      local backends = vim.fn.readdir(vim.fn.stdpath "data" .. "/lazy/image.nvim/lua/image/backends")
      local chosen
      if vim.env.KITTY_WINDOW_ID and vim.tbl_contains(backends, "kitty") then
        chosen = "kitty"
      elseif vim.tbl_contains(backends, "sixel") then
        chosen = "sixel"
      end
      return {
        backend = chosen,
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown" },
          },
        },
        max_height_window_percentage = 50,
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
      }
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    cmd = { "PasteImage", "ImgClipDebug", "ImgClipConfig" },
    opts = {
      default = {
        -- absolute save dir; resolves to <vault>/Study/content/Webbacillus/99 - Space/Resource
        save_dir = function()
          return "/home/webbacillus/20_areas/Obsidian/Study/content/Webbacillus/99 - Space/Resource"
        end,
        use_absolute_path = false,
        prompt_for_file_name = false,
        drag_and_drop = { insert_mode = true },
        default_filename = function()
          return "img-" .. os.date "%Y-%m-%d-%H%M%S"
        end,
      },
    },
  },
}
