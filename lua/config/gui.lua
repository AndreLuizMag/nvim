-- lua/config/gui.lua
--
-- GUI OPTIONS (Neovide)
-- Fonte e espaçamento só existem em GUI; no terminal quem manda é o emulador.
-- Neovide define vim.g.neovide ao conectar; fora dele este arquivo não faz nada.

if not vim.g.neovide then
  return
end

-- Fonte e tamanho: "Família:hTAMANHO" (sintaxe nativa de 'guifont').
-- Usar o nome da FAMÍLIA ("Maple Mono"), não da face ("Maple Mono Light"):
-- o Neovide resolve via DirectWrite/Skia e não encontra nomes de face.
-- Peso (Light etc.) não é configurável por 'guifont' no Neovide; só via
-- config.toml do Neovide ([font] style = "Light"), fora deste repositório.
vim.o.guifont = 'Maple Mono:h12'

-- Espaço vertical extra entre linhas, em pixels ("line-height")
vim.opt.linespace = 4
