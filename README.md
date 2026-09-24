# Neovim Configuration (mini.nvim experiment)

A from-scratch rebuild of the [production config](https://github.com/AndreLuizMag/nvim) (`main` branch) that replaces as much as possible with modules from the [mini.nvim](https://nvim-mini.org/mini.nvim) library, built on top of [lazy.nvim](https://github.com/folke/lazy.nvim).

This branch (`feat/mini`) is a self-contained experiment. It lives in its own worktree (`~/.config/nvim-mini`, run with `NVIM_APPNAME=nvim-mini`) and never touches the production config. See [Reverting](#reverting) if you want to discard it.

**Result:** 20 plugin repositories → **7**. 12 `.lua` files → **9**. 0 mini modules → **21**, all from one repository.

---

## Requirements

Before installing, make sure you have the following:

**Neovim 0.12 or newer**
This configuration uses the native LSP API introduced in 0.11, and the native Treesitter integration introduced in 0.12. Older versions will not work.

**ripgrep** — *new requirement introduced by this branch*
Powers `mini.pick`'s `files`, `grep`, and `grep_live` pickers (a single tool covers all three). Without it, `mini.pick` falls back to `git` inside a git repository, or nothing at all outside one.

- On **Linux**, install via your package manager, e.g. `sudo dnf install ripgrep` (Fedora), `sudo apt install ripgrep` (Debian/Ubuntu). On an immutable/atomic distro where `dnf`/`apt` don't apply (Fedora Silverblue, Bazzite, etc.), `rpm-ostree install ripgrep` works but only takes effect after a reboot — `brew install ripgrep` (via [Homebrew on Linux](https://brew.sh)) is the faster path if you already have it.
- On **Windows**, `winget install BurntSushi.ripgrep.MSVC`.

**Tree-sitter CLI**
Required by nvim-treesitter to generate and compile syntax parsers locally.

- On **Linux**, install via Cargo: `cargo install --locked tree-sitter-cli`, or through your distro's package manager.
- On **Windows**, grab a prebuilt binary from the [official releases page](https://github.com/tree-sitter/tree-sitter/releases/latest).

**Git 2.38 or newer**
Required by lazy.nvim to download and update plugins. Version 2.38 is the minimum for `mini.diff`, which reads the index through `git` to build its reference text.

**A C compiler**
Required by nvim-treesitter (together with the Tree-sitter CLI above) to compile every syntax parser locally.

- On **Linux**, `gcc` is usually already available.
- On **Windows**, install Zig via `winget install zig.zig`. The Tree-sitter CLI resolves its compiler through Rust's `cc` crate, which on Windows assumes MSVC and calls `cl.exe` — with no Visual Studio installed every parser build dies with `Error: program not found`. This repo ships two shims in `bin/` that hand the work to Zig instead, and `lua/config/compiler.lua` points `CC`/`CXX` at them. Nothing else to install or configure; see that file for why the shim is named `gcc.bat` and why the `-target` flag comes last.

**Fira Code Nerd Font / Nerd Font**
`mini.icons` and the statusline/tabline depend on a font with special glyphs. Set one as the default in your terminal emulator (and Neovide, if used).

---

## Installation (this experimental branch)

```bash
cd ~/.config/nvim   # your existing clone of the production config
git worktree add ~/.config/nvim-mini feat/mini
```

Then always run this config with:

```bash
NVIM_APPNAME=nvim-mini nvim
```

This isolates config (`~/.config/nvim-mini`), plugin data (`~/.local/share/nvim-mini`), and state (`~/.local/state/nvim-mini`) from the production install — running plain `nvim` continues to open the production config untouched.

On first launch, `lazy.nvim` installs itself and downloads all 7 plugins automatically (`mini.nvim`'s modules compile no native code; only `nvim-treesitter`'s 8 parsers need the C compiler above). Mason then downloads the 6 language servers in the background — this needs an interactive (non-headless) session, since `mason-lspconfig` skips its auto-install step when run headless.

---

## File Structure

```
~/.config/nvim-mini/
├── init.lua
├── lazy-lock.json
├── README.md
├── keymaps.md
├── bin/                    ← Zig shims used as the C compiler on Windows
│   ├── gcc.bat
│   └── g++.bat
└── lua/
    ├── config/
    │   ├── compiler.lua    ← Points the parser build at a working C compiler (Windows)
    │   ├── lazy.lua        ← Plugin manager setup and leader key
    │   ├── options.lua     ← Editor behavior settings
    │   ├── lsp.lua         ← Native vim.lsp.config/vim.lsp.enable activation
    │   └── neovide.lua     ← Neovide GUI settings (no-op in the terminal)
    └── plugins/
        ├── mini.lua        ← All 21 mini.nvim modules, in one file, by section
        ├── lsp.lua         ← Mason + mason-lspconfig + nvim-lspconfig specs
        └── treesitter.lua  ← Parser installation and folding
```

> Fixes a long-standing inconsistency in the production config: its `plugins/lsp.lua` header references a `config/lsp.lua` that was never actually created. Here, that separation is real: `config/lsp.lua` is native activation, `plugins/lsp.lua` is only lazy.nvim specs.

---

## What Each File Does

### `init.lua`
The entry point. Loads, in order: `compiler.lua` (must run before `lazy.setup()`, since `plugins/treesitter.lua` triggers a parser `install()` as soon as it's configured), `lazy.lua`, `options.lua`, `lsp.lua`, `neovide.lua`.

### `config/compiler.lua`
Windows only, a no-op everywhere else. See Requirements above.

### `config/lazy.lua`
Installs and configures lazy.nvim. Defines the leader key (`<Space>`) before any plugin loads, and the fallback install colorscheme (`miniwinter`).

### `config/options.lua`
Native editor behavior, no plugin dependencies: line numbers, always-visible sign column (so `mini.diff` marks don't shift text), 2-space indentation, `wrap` off everywhere except `markdown`/`text` files, and `foldlevel = 99` so folds start open.

### `config/lsp.lua`
Native LSP activation (`vim.lsp.config` / `vim.lsp.enable`, Neovim 0.11+ API — never `require('lspconfig').<server>.setup{}`), global completion capabilities from `mini.completion`, and the one keymap (`gd`) that Neovim doesn't map by default.

### `config/neovide.lua`
Unchanged GUI-only settings, no-op in the terminal.

---

## Plugins

### The 7 repositories

| Plugin | Purpose |
|---|---|
| `folke/lazy.nvim` | Plugin manager |
| `nvim-mini/mini.nvim` | The entire mini.nvim library — 21 modules enabled, one repo |
| `williamboman/mason.nvim` | Language server installer (`:Mason`) |
| `williamboman/mason-lspconfig.nvim` | Installs the 6 servers listed in `ensure_installed`; `automatic_enable = false` since servers are enabled explicitly in `config/lsp.lua` |
| `neovim/nvim-lspconfig` | Provides server definitions consumed by `vim.lsp.config` |
| `nvim-treesitter/nvim-treesitter` (branch `main`) | Parser installation for highlighting/folding |
| `rafamadriz/friendly-snippets` | Snippet **data** only (JSON files) — consumed by `mini.snippets`, no config or keymaps of its own |

### The 21 mini.nvim modules, by category

**Visual core:** `mini.icons`, `mini.statusline`, `mini.tabline`, `mini.notify`, `mini.indentscope`, `mini.hipatterns`

**Navigation:** `mini.files`, `mini.pick`, `mini.extra`

**Completion & snippets:** `mini.completion`, `mini.snippets`

**Editing — passive gains:** `mini.ai`, `mini.pairs`, `mini.surround`

**Editing — new habits:** `mini.operators`, `mini.splitjoin`, `mini.move`, `mini.bracketed`

**Git & discovery:** `mini.diff`, `mini.git`, `mini.clue`

Colorscheme: `miniwinter` (a `mini.hues`-based scheme bundled with `mini.nvim`), activated with `vim.cmd.colorscheme("miniwinter")` in `plugins/mini.lua` — no `setup()` of its own.

LSP servers active: `ts_ls`, `html`, `cssls`, `emmet_ls`, `jsonls`, `lua_ls` (same 6 as the production config).

See `keymaps.md` for the full, per-module keymap reference.

---

## Known trade-offs

Registered here as accepted, conscious differences from the production config — not bugs.

1. **`indent-blankline` → `mini.indentscope`.** Not equivalent: `indent-blankline` draws a guide at *every* indent level; `mini.indentscope` only visualizes the *current* scope. No mini module draws guides at every level. Revert: reinstall `lukas-reineke/indent-blankline.nvim`.
2. **`adwaita.nvim` → `miniwinter`.** The point of this experiment is "maximum mini," so the colorscheme goes too. Revert: reinstall `Mofiqul/adwaita.nvim`.
3. **`nvim-cmp` + `LuaSnip` → `mini.completion` + `mini.snippets`.** Different philosophy: two-stage chain completion (LSP first, then a fallback action) instead of parallel sources. By default only items starting with the typed word are kept, ordered per the LSP spec — fuzzy matching exists but needs `lsp_completion.process_items`. Highest-friction item of the migration.
4. **`neo-tree` → `mini.files`.** Not a persistent sidebar: a floating, column-based explorer where file manipulation happens by *editing text* (rename = edit the line, delete = remove the line, confirm in batch with `=`). Re-learning, not a drop-in replacement.
5. **`mini.operators`'s default `replace` prefix (`gr`) is *not* used.** Its own documented default removes the native Neovim 0.11+ `gr*` LSP family (`gra`, `gri`, `grn`, `grr`, `grt`, `grx`) to make room for itself. Customized to `cr` instead — the 6 native LSP mappings stay intact, and `cr` was free (native `c` + `r` isn't a valid motion combination).
6. **`mini.bracketed`'s `indent` target is disabled** (`suffix = ""`). Its own docs recommend this exact setup when `mini.indentscope` is already active (it owns `[i`/`]i` with more features).
7. **`]d`/`[d`/`]D`/`[D` now come from `mini.bracketed`, not Neovim core.** Same keys, different owner — `mini.bracketed`'s version additionally supports severity filtering.
8. **Native `s` (substitute character) is disabled**, remapped to `<Nop>` by `mini.surround` (its own documented default, to avoid an accidental trigger while typing an `s*` surround command). Use `cl` instead.
9. **`<leader>r`/`<leader>c` groups were never created.** An earlier draft of this migration's plan assumed dedicated rename/code-action leader mappings; the native `grn`/`gra` (and friends) already cover that, so no group exists for `mini.clue` to describe.
10. **`friendly-snippets` has no JSON snippets.** Not a regression — the production config's `LuaSnip` setup didn't have JSON coverage either.
11. **`mini.ai` deliberately overrides** the native Neovim ≥0.12 incremental-selection mappings (`an`/`in`) and ≥0.13 (`al`/`il`) with its own "next"/"last" textobjects — intentional upstream design, not a project choice.

---

## Why lazy.nvim, not mini.deps or vim.pack

`mini.deps`'s own docs say that on Neovim ≥0.12 the recommended path forward is `vim.pack`, and that `mini.deps` stays in the library but likely won't get new features — it's in maintenance mode.

`vim.pack` is also out: this config is synced between Fedora and Windows 11, and `lazy-lock.json` gives reproducible, version-controlled state. `mini.deps`'s snapshot feature has no real equivalent here — loading a snapshot doesn't change the spec inside `MiniDeps.add()`, so the next update can silently undo it.

Switching plugin managers is an orthogonal decision to adopting mini — this branch didn't mix the two.

---

## Metrics

| | `main` (production) | `feat/mini` (this branch) |
|---|---|---|
| Plugin repositories | 20 | **7** |
| `.lua` files | 12 | **9** |
| Mini modules enabled | 0 | **21** (1 repository) |
| Startup time (median of 3, headless) | ~84ms | **~59ms** |

`:checkhealth` is clean — the only `ERROR` is lazy.nvim's own generic `luarocks`/`hererocks` check, unrelated to any of the 7 plugins here (none need luarocks). Remaining `WARNING`s are all for language toolchains this config doesn't use (Go, Ruby, PHP, Java, Julia, Perl providers, etc).

---

## Maintaining the Configuration

### Updating plugins
`:Lazy update`, or `U` inside the `:Lazy` UI.

### Inspecting any mini module
Every module's help is `:h mini.<module>` (e.g. `:h mini.pick`). Its **effective** configuration (after your overrides merge with defaults) is always inspectable at runtime:
```
:lua vim.print(MiniPick.config)
```
Replace `MiniPick` with the module's global (`MiniFiles`, `MiniCompletion`, `MiniClue`, …).

### If Treesitter parsers get out of sync
Symptom: `Query error: Invalid field name "..."` on open, most often right after `:Lazy update`. Fix: `:TSUpdate` (or open a fresh headless session — this branch installs the `lua` parser from the same package as the front-end languages specifically to avoid this, see the comment in `plugins/treesitter.lua`).

If the rebuild itself fails, the compiler is the problem, not the parser — check the `bin/` shims and `config/compiler.lua`.

### Installing a new language server
1. `:Mason`, find the server, press `i`.
2. Add its name to `ensure_installed` in `plugins/lsp.lua`.
3. Add `vim.lsp.config("server_name", {})` and include it in `vim.lsp.enable({...})` in `config/lsp.lua`. **Never** `require('lspconfig').<server>.setup{}`.

### Configuring mini.pick's search exclusions
`mini.pick`'s CLI-backed pickers (`files`, `grep`, `grep_live`) are called with only basic arguments — there is no `file_ignore_patterns`-style option in Lua. Exclusions are configured through each underlying tool: `RIPGREP_CONFIG_PATH` (env var pointing to an `rg` config file) for `rg`, `.fdignore`/`--exclude` for `fd`, `.gitignore` for `git`.

### Adding a new plugin
Create a new `.lua` file inside `lua/plugins/` (or add to an existing one) — lazy.nvim scans the whole folder automatically.

### Checking plugin status
- `:Lazy` — plugin manager UI
- `:Mason` — language server installer
- `:checkhealth nvim-treesitter` — installed parsers, `tree-sitter-cli`/compiler detection
- `:checkhealth mini.pick` (or any `mini.*` health section inside `:checkhealth`) — CLI tool detection for pickers
- `:LspInfo` — active language servers in the current buffer

---

## Reverting

The experiment is disposable by construction:

```bash
cd ~/.config/nvim
git worktree remove ~/.config/nvim-mini --force
git branch -D feat/mini
rm -rf ~/.local/share/nvim-mini ~/.local/state/nvim-mini
```

Production config in `~/.config/nvim` was never touched and stays exactly as it was.

For a **partial** revert (keep mini, undo one specific piece), see the paths noted in [Known trade-offs](#known-trade-offs).
