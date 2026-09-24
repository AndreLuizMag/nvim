# Keymaps

Leader key is `<Space>`. Every mapping below is a real default from the module's own documentation (or an explicit override noted as such) — nothing here is from memory.

---

## Native Neovim

### Tabs

| Key | Action |
| --- | --- |
| `gt` | Go to the next tab |
| `gT` | Go to the previous tab |
| `:tabnew` | Open a new tab |
| `:tabmove +1` / `-1` | Move tab right / left |
| `:tabmove 0` / `:tabmove` | Move tab to end / start |
| `:tabclose` (`:tabc`) | Close tab |

### Windows

| Key | Action |
| --- | --- |
| `<C-w>h/j/k/l` | Move cursor to the window left/below/above/right |
| `<C-w>H/J/K/L` | Move the current window to the far left/bottom/top/right |
| `<C-w>R` | Rotate windows |
| `<C-w>>` / `<C-w><` | Resize wider / narrower |
| `<C-w>20>` | Resize by 20 columns |

### Folds

| Key | Action |
| --- | --- |
| `za` / `zA` | Toggle fold (recursively) |
| `zo` / `zc` | Open / close fold |
| `zO` / `zC` | Open / close recursively |
| `zR` / `zM` | Open / close all folds |
| `zj` / `zk` | Jump to next / previous fold |

### LSP (Neovim 0.11+ built-in defaults)

All native — see `:h lsp-defaults` / `:h diagnostic-defaults`. None of these are redefined by this config.

| Key | Action |
| --- | --- |
| `gra` | Code action (Normal, Visual) |
| `gri` | Go to implementation |
| `grn` | Rename |
| `grr` | References |
| `grt` | Type definition |
| `grx` | Run codelens |
| `gO` | Document symbols |
| `K` | Hover |
| `<C-s>` (Insert) | Signature help |
| `]d` / `[d` / `]D` / `[D` | Next/previous/last/first diagnostic — **now served by `mini.bracketed`**, same keys (see below) |
| `<C-w>d` | Diagnostic float at cursor |
| **`gd`** | **Go to definition** — the one gap the defaults don't cover; added via `LspAttach` in `config/lsp.lua` |

---

## Navigation (`<leader>` — Etapa 3)

| Key | Action |
| --- | --- |
| `<leader>e` | Open file explorer (`mini.files`) |
| `<leader>ff` | Find files (`mini.pick`) |
| `<leader>fg` | Live grep (`mini.pick`) |
| `<leader>fb` | List buffers (`mini.pick`) |
| `<leader>fh` | Search help tags (`mini.pick`) |
| `<leader>fr` | Resume last picker (`mini.pick`) |
| `<leader>fs` | Grep the word under cursor (`mini.pick`, no native equivalent existed) |

## `mini.files`

| Key | Action |
| --- | --- |
| `l` / `h` | Go in / go out |
| `L` / `H` | Go in plus (keep same window) / go out plus |
| `=` | **Synchronize** — apply create/rename/delete edits made by editing the buffer |
| `q` | Close |
| `g?` | Help |
| `@` | Reveal cwd |
| `m` | Set mark |
| `'` | Go to mark |
| `<` / `>` | Trim left / right window |

## `mini.pick`

| Key | Action |
| --- | --- |
| `<CR>` | Choose |
| `<C-s>` / `<C-v>` / `<C-t>` | Choose in split / vsplit / tab |
| `<M-CR>` | Choose all marked |
| `<C-x>` / `<C-a>` | Mark / mark all |
| `<C-n>` / `<C-p>` | Move down / up |
| `<C-g>` | Move to start |
| `<Tab>` / `<S-Tab>` | Toggle preview / info |
| `<C-Space>` / `<M-Space>` | Refine / refine marked |
| `<C-f>` / `<C-b>` | Scroll down / up |
| `<C-u>` / `<C-w>` | Delete to start / delete word |
| `<Esc>` | Stop |

24 extra pickers are registered via `mini.extra` and reachable with `:Pick <name>` (`buf_lines`, `colorschemes`, `commands`, `diagnostic`, `explorer`, `git_branches`, `git_commits`, `git_files`, `git_hunks`, `hipatterns`, `history`, `hl_groups`, `keymaps`, `list`, `lsp`, `manpages`, `marks`, `oldfiles`, `options`, `registers`, `spellsuggest`, `treesitter`, `visit_paths`, `visit_labels`) — none has a dedicated keymap.

## `mini.ai` (textobjects)

Prefix `a` (around) / `i` (inside) + an identifier. Builtins: `(`/`[`/`{`/`<`/`b` (any bracket) — balanced pairs, `"`/`'`/`` ` ``/`q` (any quote), `t` tag, `f` function call, `a` argument, `?` prompt.

| Key | Action |
| --- | --- |
| `af` / `if` | Around/inside function call — e.g. `vaf`, `dif` |
| `at` / `it` | Around/inside tag |
| `aq` / `iq` | Around/inside any quote |
| `an` / `in` | Next textobject (overrides native ≥0.12 incremental selection) |
| `al` / `il` | Last textobject (overrides native ≥0.13 incremental selection) |
| `g[` / `g]` | Move to left/right edge of the `a` textobject |

## `mini.surround`

| Key | Action |
| --- | --- |
| `sa` | Add surrounding — e.g. `saiw"` wraps a word in quotes |
| `sd` | Delete surrounding — e.g. `sd"` |
| `sr` | Replace surrounding |
| `sf` / `sF` | Find surrounding (right / left) |
| `sh` | Highlight surrounding |

Native `s` (substitute character) is disabled by this module (mapped to `<Nop>`) — use `cl` instead.

## `mini.pairs`

Typing `(`, `[`, `{`, `"`, `'`, `` ` `` auto-inserts the closing pair; `<BS>` deletes both if the pair is empty. Insert mode only.

## `mini.operators`

| Key | Action |
| --- | --- |
| `g=` / `g==` (Visual: `g=`) | Evaluate textobject / line / selection |
| `gx` / `gxx` | Exchange textobject / line (native `gx`, open URL, was auto-remapped to `gX`) |
| `gm` / `gmm` | Multiply (duplicate) textobject / line |
| **`cr` / `crr`** | Replace with register — **customized prefix**; the default `gr` would delete the native LSP `gr*` family above |
| `gs` / `gss` | Sort textobject / line |

## `mini.splitjoin`

| Key | Action |
| --- | --- |
| `gS` | Toggle split/join — e.g. on `func(a, b, c)` splits each argument to its own line; repeat to join back |

## `mini.move`

| Key | Action |
| --- | --- |
| `<M-h>` / `<M-l>` | Move line/selection left / right |
| `<M-j>` / `<M-k>` | Move line/selection down / up |

Works in both Normal (current line) and Visual (selection) mode.

## `mini.bracketed`

`]x` / `[x` (next / previous), `]X` / `[X` (last / first):

| Suffix | Target |
| --- | --- |
| `b` | Buffer |
| `c` | Comment block |
| `x` | Conflict marker |
| `d` | Diagnostic *(replaces the native Neovim mapping — same keys, adds severity filtering)* |
| `f` | File on disk |
| `j` | Jump list |
| `l` | Location list |
| `o` | Old files |
| `q` | Quickfix list |
| `t` | Treesitter node |
| `u` | Undo state |
| `w` | Window |
| `y` | Yank history over the put region |

`indent` (`]i`/`[i`) is **disabled** — `mini.indentscope` already owns those keys.

## `mini.indentscope`

| Key | Action |
| --- | --- |
| `ii` / `ai` | Inside/around indent-scope textobject |
| `[i` / `]i` | Go to top / bottom edge of the current scope |

## `mini.completion`

| Key | Action |
| --- | --- |
| `<C-Space>` | Force two-stage completion |
| `<A-Space>` | Force fallback completion |
| `<C-f>` / `<C-b>` | Scroll info/signature window down / up |

`completeopt` (`menuone,noselect`) is set automatically by the module — not configured in `options.lua`.

## `mini.snippets`

| Key | Action |
| --- | --- |
| `<C-j>` | Expand snippet at cursor (Insert mode) |
| `<C-l>` / `<C-h>` | Jump to next / previous tab stop |
| `<C-c>` | Stop active session |

Snippets load from `friendly-snippets` via a custom `lang_patterns` mapping (that project doesn't expose a filetype-to-file mapping `mini.snippets` can read automatically — see `plugins/mini.lua`).

## `mini.diff`

| Key | Action |
| --- | --- |
| `gh` / `gH` | Apply / reset hunks (textobject or Visual region) — e.g. `ghip` |
| `ghgh` / `gHgH` | Apply / reset the hunk under cursor |
| `]h` / `[h` | Next / previous hunk |
| `]H` / `[H` | Last / first hunk |
| `<leader>gd` | Toggle inline diff overlay (no default mapping exists for this) |

Requires Git ≥2.38. No support for unstaging — use the git CLI.

## `mini.git`

| Command | Action |
| --- | --- |
| `:Git <args>` | Any git subcommand — e.g. `:Git status`, `:Git log --oneline`, `:vert Git blame -- %` |

Branch name and file status are exposed automatically to `mini.statusline` (`vim.b.minigit_summary_string`) — no extra keymap.

## `mini.clue`

Press and hold to see available continuations (default delay 1000ms). Triggers configured on:

| Trigger | Covers |
| --- | --- |
| `<Leader>` (Normal, Visual) | All `<leader>*` mappings above, with `<leader>f` labeled "+Find/Buscar" |
| `g` (Normal, Visual) | Built-in `g*` clues, including the LSP `gr*` family and `mini.operators`/`mini.ai` mappings |
| `z` (Normal, Visual) | Fold commands |
| `[` / `]` (Normal) | `mini.bracketed` targets |
| `'` / `` ` `` (Normal, Visual) | Marks |
| `"` (Normal, Visual) / `<C-r>` (Insert, Cmdline) | Registers |
| `<C-w>` (Normal) | Window commands |
| `<C-x>` (Insert) | Built-in insert-mode completion submenu |
