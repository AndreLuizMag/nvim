-- lua/config/neovide.lua
--
-- NEOVIDE (GUI)
-- vim.g.neovide is set automatically by Neovide itself when it connects.
-- If this variable doesn't exist (i.e. you're in a terminal via `nvim .`),
-- the whole file is skipped — it doesn't affect your terminal session.

if not vim.g.neovide then
  return
end

-- Font: "Family:hSIZE" — same syntax as the native `guifont` option.
-- Use the FAMILY name, not a face name ("X Light"): Neovide resolves fonts
-- via DirectWrite/Skia and won't find face names.
--
-- Mono font is the OS's own default monospace, since guifont needs an exact
-- installed family name (no generic "monospace" alias support in Neovide):
-- Windows -> Consolas (built in since Vista), Linux -> Fira Code (this
-- machine's GNOME monospace-font-name via gsettings).
--
-- Comma-separated list = fallback: a glyph missing in the first font is taken
-- from the next. Plain text fonts have no Nerd Font glyphs (mini.icons uses
-- U+E000+ and U+F0000+), so Symbols Nerd Font Mono (icons-only, no code
-- glyphs) supplies them without needing a patched build of the main font.
--
-- Options (":h10") go ONCE, at the end, and apply to every font in the list.
-- Neovide splits on ":" before ",", so "Font A:h10,Font B:h10" leaves only
-- "Font A" loaded and silently drops the fallback — U+F0000+ icons then
-- render as the PUA glyph of Neovide's embedded LastResort font (a planet).
--
-- h10 matches the terminal's size on this machine: Ptyxis uses the OS
-- monospace font at its configured point size (`gsettings get
-- org.gnome.desktop.interface monospace-font-name` -> "Fira Code 10").
local mono_font = vim.fn.has('win32') == 1 and 'Consolas' or 'Fira Code'
vim.o.guifont = mono_font .. ',Symbols Nerd Font Mono:h10'

-- Vertical spacing between lines (pixels)
vim.opt.linespace = 4

-- Space between the OS window border and the buffer content
vim.g.neovide_padding_top = 4
vim.g.neovide_padding_bottom = 4
vim.g.neovide_padding_right = 4
vim.g.neovide_padding_left = 4

-- Cmd line hidden by default
vim.o.cmdheight = 0

-- Statusline hidden too: `laststatus` (default 2) always reserves one row
-- at the bottom regardless of `cmdheight` — that's the empty bar left over
-- after hiding the cmdline above. No statusline plugin is configured, so
-- that row shows nothing useful; hidden here only, terminal keeps it.
vim.o.laststatus = 0

-- Animation duration (seconds). Lower for a snappier feel, 0 disables.
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_scroll_animation_length = 0.20

-- Ask for confirmation when closing with unsaved buffers
vim.g.neovide_confirm_quit = true
