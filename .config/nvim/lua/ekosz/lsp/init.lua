local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "ekosz.lsp.lsp-installer"
require("ekosz.lsp.handlers").setup()
require "ekosz.lsp.null-ls"
