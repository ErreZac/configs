
vim.lsp.enable("pyright")
vim.lsp.enable("clangd")
vim.lsp.enable("texlab")

vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
})
