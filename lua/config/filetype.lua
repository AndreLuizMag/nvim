-- lua/config/filetype.lua
--
-- FILETYPE DETECTION
-- Extensões que o Neovim não reconhece sozinho (:h vim.filetype.add).
-- O filetype decide syntax, indent (=, gq) e qual servidor LSP ativa.
-- Para conferir o filetype do buffer atual: :set filetype?
vim.filetype.add({
  extension = {
    opml = 'xml', -- OPML é XML
    OPML = 'xml', -- OPML é XML
  },
})
