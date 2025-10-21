-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Detect the current operating system
local os_name = vim.loop.os_uname().sysname

-------------------------------------------------------------------------------
-- Conditional OS Setup (Shell and Clipboard)
-------------------------------------------------------------------------------

if os_name == "Windows" then
  -- === WINDOWS ONLY CONFIGURATION ===

  -- 1. Enable powershell as your default shell (Crucial for UTF8 handling on Windows)
  vim.opt.shell = "pwsh.exe"
  vim.opt.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]

  -- 2. Set a compatible clipboard manager (requires win32yank.exe)
  vim.g.clipboard = {
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
  }

elseif os_name == "Linux" or os_name == "Darwin" then
  -- === LINUX/MACOS ONLY CONFIGURATION ===
  -- LunarVim/Neovim defaults usually handle the shell and clipboard well on these systems.
  -- We explicitly unset the Windows-specific shell options to ensure system defaults are used.
  vim.opt.shell = "" -- Use system default
  vim.opt.shellcmdflag = ""
  
  -- Note: We skip setting vim.g.clipboard. This allows Neovim to automatically
  -- use standard clipboard providers (xclip, xsel, pbcopy) which is the robust method
  -- on Unix-like systems.
end

-------------------------------------------------------------------------------
-- Plugin Management (Universal)
-------------------------------------------------------------------------------

lvim.plugins = {
    {
        "sainnhe/gruvbox-material",
        lazy = false, -- Load immediately so it's available for setting the colorscheme
        priority = 1000, -- Ensure it loads before others
    },
}

-------------------------------------------------------------------------------
-- Appearance (Universal)
-------------------------------------------------------------------------------

lvim.colorscheme = "gruvbox-material"
vim.g.gruvbox_material_background = "medium"
-- lvim.transparent_window = true

-------------------------------------------------------------------------------
-- Other
-------------------------------------------------------------------------------

-- Set filetype for .dbml files
vim.filetype.add({
  extension = { dbml = 'dbml' },
})

-- Configure DBML Language Server Protocol
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dbml',
  callback = function()
    -- This assumes 'dbml-language-server' is installed and available in the PATH
    vim.lsp.start({
      name = 'dbml-language-server',
      cmd = {'dbml-language-server'},
      -- Attempt to find the root directory based on a .git folder
      root_dir = vim.fs.dirname(vim.fs.find({'.git'}, { upward = true })[1] or vim.fn.getcwd()),
    })
  end,
})
