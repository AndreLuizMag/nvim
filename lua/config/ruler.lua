-- lua/config/ruler.lua
--
-- RULER (thin vertical guide at column 80)
-- Native alternative to 'colorcolumn', which paints a whole character cell.
-- A decoration provider (:h nvim_set_decoration_provider) runs on every
-- redraw and places an ephemeral extmark per visible line: the thin glyph
-- "▏" (U+258F, same one mini.diff uses) drawn as virtual text at window
-- column 80 — i.e. right after the 80th character, Prettier printWidth /
-- Biome lineWidth default. Visual hint only, never wraps text.

local COLUMN = 80
local GLYPH = '▏'
local HL = 'RulerLine'

local ns = vim.api.nvim_create_namespace('ruler')

-- :colorscheme clears all highlight groups, so (re)define ours on each change.
local function set_hl()
  vim.api.nvim_set_hl(0, HL, { fg = '#434347' })
end
set_hl()
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('ruler_hl', { clear = true }),
  callback = set_hl,
})

vim.api.nvim_set_decoration_provider(ns, {
  -- Only regular file windows: skip floats (mini.files, popups) and special buffers.
  on_win = function(_, winid, bufnr)
    return vim.bo[bufnr].buftype == '' and vim.api.nvim_win_get_config(winid).relative == ''
  end,
  on_range = function(_, _, bufnr, begin_row, _, end_row, end_col)
    -- Range is end-exclusive; (end_row, 0) means the previous line's EOL.
    local last = end_col == 0 and end_row - 1 or end_row
    for row = begin_row, last do
      vim.api.nvim_buf_set_extmark(bufnr, ns, row, 0, {
        virt_text = { { GLYPH, HL } },
        virt_text_win_col = COLUMN,
        hl_mode = 'combine',
        ephemeral = true,
      })
    end
  end,
})
