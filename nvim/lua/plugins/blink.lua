return {
  "Saghen/blink.cmp",
  opts = {
    sources = {
      per_filetype = {
        sql = { "dadbod", "buffer" },
        mysql = { "dadbod", "buffer" },
        postgresql = { "dadbod", "buffer" },
      },
      providers = {
        path = { score_offset = 3 },
        lsp = { score_offset = 0 },
        snippets = { score_offset = -1 },
        buffer = { score_offset = -3 },
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
    },
  },
}
