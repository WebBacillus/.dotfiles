return {
  "AstroNvim/astrolsp",
  opts = {
    config = {
      pyright = {
        settings = {
          pyright = {
            disableTaggedHints = true,
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              diagnosticSeverityOverrides = {
                reportUnusedImport = "none",
                reportWildcardImportFromLibrary = "none",
              },
            },
          },
        },
      },
    },
  },
}
