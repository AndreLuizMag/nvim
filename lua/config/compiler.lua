-- ~/.config/nvim/config/compiler.lua
--
-- COMPILADOR C PARA OS PARSERS DO TREESITTER (somente Windows)
--
-- O nvim-treesitter delega a compilação dos parsers ao tree-sitter CLI, que por
-- sua vez usa o crate `cc`. No Windows esse crate assume MSVC e tenta chamar
-- `cl.exe`; sem o Visual Studio instalado toda compilação morre com
-- "Error: program not found", e os parsers ficam congelados na versão antiga
-- (o sintoma é `Invalid field name` ao carregar uma query nova).
--
-- A saída é apontar CC/CXX para um shim que repassa tudo ao zig, que já vem
-- com um clang completo. Dois detalhes fazem isso funcionar:
--
--   1. O nome do arquivo importa. O crate `cc` deduz a família do compilador
--      pelo nome do executável: "zig" ele não reconhece e trata como MSVC
--      (passando /Fo, -link e afins, que o zig rejeita). Com "gcc"/"g++" ele
--      manda flags no estilo GCC, que o `zig cc` entende.
--   2. O crate injeta `--target=x86_64-pc-windows-msvc`, um triple que o zig
--      0.16 não consegue parsear. Por isso o shim anexa
--      `-target x86_64-windows-gnu` DEPOIS dos argumentos recebidos: no driver
--      do clang o último -target vence. O .so resultante usa a ABI gnu e é
--      carregado normalmente pelo Neovim compilado com MSVC.
--
-- Precisa rodar antes do lazy.setup(), porque plugins/treesitter.lua dispara
-- install() já na configuração do plugin.

if vim.fn.has("win32") == 1 then
  local bin = vim.fn.stdpath("config") .. "/bin/"
  vim.env.CC = bin .. "gcc.bat"
  vim.env.CXX = bin .. "g++.bat"
end
