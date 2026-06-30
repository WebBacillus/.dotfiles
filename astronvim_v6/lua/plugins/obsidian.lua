---@type LazySpec
return {
  {
    "obsidian-nvim/obsidian.nvim",
    event = { "BufReadPre */20_areas/Obsidian/*.md", "BufNewFile */20_areas/Obsidian/*.md" },
    cmd = { "Obsidian" },
    ft = "markdown",
    opts = {
      workspaces = {
        {
          name = "Obsidian",
          path = "/home/webbacillus/20_areas/Obsidian",
          attachments = {
            img_folder = "Study/content/Webbacillus/99 - Space/Resource",
            confirm_img_paste = false,
          },
        },
      },
    },
    config = function(_, opts)
      if opts.completion then
        opts.completion.nvim_cmp = nil
        opts.completion.blink = nil
      end

      require("obsidian").setup(opts)

      -- Patch obsidian.nvim attachment links until upstream resolve_link_path handles them.
      local attachment = require "obsidian.attachment"
      local link = require "obsidian.link"
      local api = require "obsidian.api"
      local orig = link.resolve_link_path

      link.resolve_link_path = function(location)
        if attachment.is_attachment_path(location) then return tostring(api.resolve_attachment_path(location)) end
        return orig(location)
      end
    end,
  },
}
