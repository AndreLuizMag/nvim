# Neovim Configuration

A personal Neovim setup focused on JavaScript and TypeScript development, built on top of [lazy.nvim](https://github.com/folke/lazy.nvim).

---

## Requirements

Before installing, make sure you have the following:

**Neovim 0.12 or newer**
This configuration uses the native LSP API introduced in 0.11, and the native Treesitter integration introduced in 0.12. Older versions will not work.

**Tree-sitter CLI**
Required by nvim-treesitter to generate and compile syntax parsers locally.

- On **Linux**, install via Cargo: `cargo install --locked tree-sitter-cli`, or through your distro's package manager (e.g. `sudo dnf install tree-sitter-cli` on Fedora).
- On **Windows**, grab a prebuilt binary from the [official releases page](https://github.com/tree-sitter/tree-sitter/releases/latest).

**Git**
Required by lazy.nvim to download and update plugins.

**A C compiler**
Required by nvim-treesitter (together with the Tree-sitter CLI above) to compile every syntax parser locally — this is now mandatory, not optional.

- On **Linux**, `gcc` is usually already available. If not: `sudo apt install gcc` (Debian/Ubuntu), `sudo dnf install gcc gcc-c++` (Fedora), or the equivalent for your distro.
- On **Windows**, install Zig via winget:
  ```
  winget install zig.zig
  ```

**Fira Code Nerd Font**
The file explorer and status icons depend on a font that includes special symbols (Nerd Font). Download [Fira Code Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip), install it on your system, and set it as the default font in your terminal emulator.

---

## Installation

**Linux**
Clone this repository into the Neovim config directory:
```bash
git clone https://github.com/AndreLuizMag/nvim.git ~/.config/nvim
```

**Windows**
Clone this repository into the equivalent directory:
```
git clone https://github.com/AndreLuizMag/nvim.git C:\Users\USERNAME\AppData\Local\nvim
```
Replace `USERNAME` with your actual Windows username.

After cloning, open Neovim. lazy.nvim will install itself and then download all plugins automatically. Wait for the installation to finish, then close and reopen Neovim.

---

## File Structure

```
~/.config/nvim/
├── init.lua                  ← Entry point, loads everything else
└── lua/
    ├── config/
    │   ├── lazy.lua          ← Plugin manager setup and leader key
    │   ├── options.lua       ← Editor behavior settings
    └── plugins/
        ├── lsp.lua           ← Mason (language server installer)
        ├── completion.lua    ← Autocomplete menu
        ├── navigation.lua    ← File explorer and fuzzy finder
        ├── treesitter.lua    ← Syntax highlighting and code folding
        ├── theme.lua         ← Color scheme
        └── ui.lua            ← Visual enhancements
```

---

## What Each File Does

### `init.lua`
The entry point. Neovim reads this file first on startup. It loads two files, in order: the plugin manager setup (which also triggers lazy.nvim to load everything under `plugins/`, including LSP activation) and the editor options.
### `config/lazy.lua`
Installs and configures [lazy.nvim](https://github.com/folke/lazy.nvim), the plugin manager. Also defines the leader key (`Space`), which is used as the prefix for all custom keymaps. The leader key must be set here, before any plugin loads.

### `config/options.lua`
General editor settings with no plugin dependencies:
- Line numbers (absolute + relative)
- Indentation with 2 spaces
- All code folds open by default

---

## Plugins

### Language Server Protocol (LSP) — `plugins/lsp.lua`

This file does two things:

1. At the top, the native LSP servers are activated directly via `vim.lsp.config(...)` and `vim.lsp.enable({...})` — Neovim's built-in API (introduced in 0.11), used here instead of calling `require('lspconfig').<server>.setup{}`.
2. Below that, the `return { ... }` table tells lazy.nvim which plugins to install:

| Plugin | Purpose |
|---|---|
| `mason.nvim` | GUI installer for language servers. Open with `:Mason`. |
| `mason-lspconfig.nvim` | Automatically installs the servers listed in `ensure_installed`. |
| `nvim-lspconfig` | Provides server definitions used by mason-lspconfig. |

Servers activated and installed automatically: `ts_ls`, `html`, `cssls`, `emmet_ls`.

### Autocompletion — `plugins/completion.lua`

| Plugin | Purpose |
|---|---|
| `nvim-cmp` | The completion engine that shows the popup menu while you type. |
| `LuaSnip` | Snippet engine — expands abbreviations into full code blocks. |
| `friendly-snippets` | A collection of ready-made snippets for many languages. |
| `cmp-nvim-lsp` | Feeds LSP suggestions into the completion menu. |
| `cmp-buffer` | Feeds words from the current file into the menu. |
| `cmp-path` | Feeds file system paths into the menu. |

Keymaps:

| Key | Action |
|---|---|
| `<C-Space>` | Open the menu manually |
| `<CR>` | Confirm selected suggestion |
| `<C-e>` | Close the menu |
| `<Tab>` | Move down / expand snippet |
| `<S-Tab>` | Move up / jump back in snippet |

### Navigation — `plugins/navigation.lua`

| Plugin | Purpose |
|---|---|
| `neo-tree.nvim` | Sidebar file explorer, similar to VS Code's file tree. |
| `telescope.nvim` | Fuzzy finder for files, text search, and buffer switching. |

Keymaps:

| Key | Action |
|---|---|
| `<Space>e` | Open / close the file explorer |
| `<Space>ff` | Find files by name |
| `<Space>fg` | Search text across the entire project |
| `<Space>fb` | List currently open buffers |

### Syntax Highlighting — `plugins/treesitter.lua`
[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) handles parser installation only; highlighting and folding themselves are powered natively by Neovim (built-in since 0.12).

> **Note:** the nvim-treesitter project was archived by its maintainer in April 2026 after a full rewrite (the `main` branch). This config pins that branch explicitly — the previous default branch no longer exists for new installs, and no further updates are expected upstream.

Languages installed: `lua`, `javascript`, `typescript`, `tsx`, `html`, `css`, `scss`, `json`.

Highlighting and Treesitter-based folding are enabled explicitly for the front-end languages above via a `FileType` autocommand (Lua gets this automatically from Neovim's own bundled `ftplugin`). Folds are open by default (controlled by `foldlevel = 99` in `options.lua`). Use `za` to toggle a fold manually.

Treesitter-based indentation is available upstream but intentionally **not enabled** here — it's marked experimental, and formatting is already handled by Biome.js/ESLint/Prettier.
### Theme — `plugins/theme.lua`
[Adwaita.nvim](https://github.com/Mofiqul/adwaita.nvim) — a color scheme inspired by GNOME's default UI style. Loaded with high priority to prevent a flash of incorrect colors on startup.

### UI Enhancements — `plugins/ui.lua`
[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) draws a thin vertical line (`│`) at each indentation level, making nested code easier to scan. Also highlights the indentation level of the block the cursor is currently in.

---

## Maintaining the Configuration

### Updating plugins
Open Neovim and run:
```
:Lazy update
```
Or press `U` inside the `:Lazy` interface.

### If Treesitter parsers get out of sync
Since parsers are compiled locally, a parser can occasionally fall out of sync with its highlighting query — usually after a fresh install or a Neovim upgrade that ships a different bundled parser. The symptom is a `Query error: Invalid field name "..."` when opening a file.

Fix by reinstalling just the affected language:

```
:TSUninstall lua

:TSUpdate
```
(Replace `lua` with whichever language is failing, or use `all` to reset everything.)

Parsers compiled by this branch live in `~/.local/share/nvim/site/parser/` — not inside the plugin's own folder, so deleting `~/.local/share/nvim/lazy/nvim-treesitter` no longer has any effect on installed parsers.

### Installing a new language server
1. Open `:Mason` and find the server you want.
2. Press `i` to install it.
3. Add the server name to `ensure_installed` in `plugins/lsp.lua` (so it stays installed on future machines).
4. Add `vim.lsp.config("server_name", {})` and include it in `vim.lsp.enable({...})` in `config/lsp.lua`.

### Adding a new plugin
Create a new `.lua` file inside `lua/plugins/` (or add to an existing one). lazy.nvim scans that entire folder automatically — no need to register anything in `init.lua`.

### Checking plugin status
- `:Lazy` — opens the plugin manager UI (shows installed, pending updates, errors)
- `:Mason` — opens the language server installer
- `:checkhealth nvim-treesitter` — shows installed parsers and verifies `tree-sitter-cli`/the C compiler are found
- `:LspInfo` — shows which language servers are active in the current buffer
