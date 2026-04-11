# Neovim Configuration

A personal Neovim setup focused on JavaScript and TypeScript development, built on top of [lazy.nvim](https://github.com/folke/lazy.nvim).

---

## Requirements

Before installing, make sure you have the following:

**Neovim 0.11 or newer**
This configuration uses the native LSP API introduced in 0.11. Older versions will not work.

**Git**
Required by lazy.nvim to download and update plugins.

**A C compiler**
Required by nvim-treesitter to compile syntax parsers.

- On **Linux**, `gcc` is usually already available. If not: `sudo apt install gcc` (Debian/Ubuntu) or the equivalent for your distro.
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
The entry point. Neovim reads this file first on startup. It loads the three config files in order: plugin manager, editor options, and language server activation.

### `config/lazy.lua`
Installs and configures [lazy.nvim](https://github.com/folke/lazy.nvim), the plugin manager. Also defines the leader key (`Space`), which is used as the prefix for all custom keymaps. The leader key must be set here, before any plugin loads.

### `config/options.lua`
General editor settings with no plugin dependencies:
- Line numbers (absolute + relative)
- Indentation with 2 spaces
- All code folds open by default

### `config/lsp.lua`
Activates the language servers that Mason has installed. The servers configured are: `ts_ls` (JavaScript/TypeScript), `html`, `cssls`, and `emmet_ls`.

---

## Plugins

### Language Server Protocol (LSP) — `plugins/lsp.lua`

| Plugin | Purpose |
|---|---|
| `mason.nvim` | GUI installer for language servers. Open with `:Mason`. |
| `mason-lspconfig.nvim` | Automatically installs the servers listed in `ensure_installed`. |
| `nvim-lspconfig` | Provides server definitions used by mason-lspconfig. |

Servers installed automatically: `ts_ls`, `html`, `cssls`, `emmet_ls`.

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
[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) parses source code into a syntax tree, providing more accurate highlighting than regex-based approaches. It also enables code folding based on actual code structure.

Languages installed: `javascript`, `typescript`, `tsx`, `html`, `css`, `json`, `lua`.

Folding is enabled for all file types. All folds are open by default (controlled by `foldlevel = 99` in `options.lua`). Use `za` to toggle a fold manually.

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

### If an update breaks nvim-treesitter
Treesitter compiles C parsers during installation. If an update fails midway, the plugin can end up in a corrupted state. The fix is to delete the installation and let lazy reinstall from scratch:

```bash
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter
rm -rf ~/.cache/nvim
```

Then reopen Neovim and wait for the automatic reinstall to complete.

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
- `:TSInstallInfo` — lists all Treesitter parsers and their status
- `:LspInfo` — shows which language servers are active in the current buffer
