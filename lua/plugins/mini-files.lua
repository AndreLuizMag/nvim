-- mini.files — https://nvim-mini.org/mini.nvim/doc/mini-files
-- Explorador de arquivos modal em janelas flutuantes (colunas lado a lado).
-- Navega e manipula o sistema de arquivos editando texto; `=` sincroniza.
-- Extra (sem módulo novo): barra `▏` na coluna de sinais com o status git de cada
-- entrada — verde novo/staged, amarelo modificado, vermelho conflito. Diretório
-- herda o status do que tem dentro. Feito com autocmd + `git status` assíncrono.
require('mini.files').setup()

-- Abre no diretório do arquivo atual
vim.keymap.set('n', '<leader>e', function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = 'Explorador de arquivos' })

-- Status git na coluna de sinais ---------------------------------------------
local ns = vim.api.nvim_create_namespace('MiniFilesGit')

-- Converte os dois caracteres `XY` do `git status --porcelain` em grupo de highlight
-- (reutiliza os grupos do mini.diff). Arquivo apagado (`D`) não aparece na listagem.
local function status_hl(xy)
  if xy:find('U') then return 'MiniDiffSignDelete' end
  if xy == '??' or xy:find('A') then return 'MiniDiffSignAdd' end
  if xy:find('[MRCT]') then return 'MiniDiffSignChange' end
  return nil
end

-- Monta tabela caminho → highlight a partir da saída `-z`; diretórios herdam dos
-- filhos (status único mantém a cor; status misto vira "modificado").
local function parse_status(root, out)
  local status, fields, i = {}, vim.split(out, '\0', { trimempty = true }), 1
  while i <= #fields do
    local xy, path = fields[i]:sub(1, 2), fields[i]:sub(4)
    -- Rename/copy: o campo seguinte é o caminho original, não interessa
    if xy:find('[RC]') then i = i + 1 end
    local hl = status_hl(xy)
    if hl then
      local full = root .. '/' .. path
      status[full] = hl
      for dir in vim.fs.parents(full) do
        if #dir < #root then break end
        local cur = status[dir]
        status[dir] = (cur == nil or cur == hl) and hl or 'MiniDiffSignChange'
      end
    end
    i = i + 1
  end
  return status
end

-- Coloca a barra em cada linha do buffer cujo caminho tem status
local function apply(buf, status)
  -- Buffer pode ter sido fechado ou editado enquanto o git rodava
  if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].modified then return end
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  for line = 1, vim.api.nvim_buf_line_count(buf) do
    local entry = MiniFiles.get_fs_entry(buf, line)
    local hl = entry and status[vim.fs.normalize(entry.path)]
    if hl then
      vim.api.nvim_buf_set_extmark(buf, ns, line - 1, 0, { sign_text = '▏', sign_hl_group = hl })
    end
  end
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferUpdate',
  desc = 'Status git nas entradas do mini.files',
  callback = function(args)
    local buf = args.data.buf_id
    -- Só buffers de diretório com conteúdo (preview de arquivo e pasta vazia saem)
    local ok, entry = pcall(MiniFiles.get_fs_entry, buf, 1)
    if not ok or entry == nil then return end
    local dir = vim.fs.dirname(entry.path)

    -- Fora de repositório (ou sem git instalado): sai em silêncio
    pcall(vim.system, { 'git', '-C', dir, 'rev-parse', '--show-toplevel' }, { text = true }, function(res)
      if res.code ~= 0 then return end
      local root = vim.fs.normalize(vim.trim(res.stdout))
      vim.system(
        { 'git', '-C', root, 'status', '--porcelain', '-z', '--untracked-files=all' },
        { text = true },
        function(res2)
          if res2.code ~= 0 then return end
          -- Callback roda em contexto rápido (fast event); API do editor exige schedule
          vim.schedule(function() apply(buf, parse_status(root, res2.stdout)) end)
        end
      )
    end)
  end,
})
