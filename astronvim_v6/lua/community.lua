-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.completion.copilot-cmp" },
  { import = "astrocommunity.ai.avante-nvim" },
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.game.leetcode-nvim" },
  { import = "astrocommunity.recipes.heirline-mode-text-statusline" },
  { import = "astrocommunity.note-taking.obsidian-nvim" },
  { import = "astrocommunity.media.image-nvim" },
  { import = "astrocommunity.media.img-clip-nvim" },
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
      require("obsidian").setup(opts)
      -- Patch bug in obsidian.nvim (commit 7861be4): link.resolve_link_path calls
      -- M.resolve_attachment_path which doesn't exist; should be attachment.resolve_attachment_path.
      -- Triggers a silent error on any `gf` or `:Obsidian follow_link` over a PDF/image attachment.
      local attachment = require("obsidian.attachment")
      local link = require("obsidian.link")
      local api = require("obsidian.api")
      local orig = link.resolve_link_path
      link.resolve_link_path = function(location)
        if attachment.is_attachment_path(location) then
          return tostring(api.resolve_attachment_path(location))
        end
        return orig(location)
      end
    end,
  },
  -- { import = "astrocommunity.workflow.hardtime-nvim" },
}
