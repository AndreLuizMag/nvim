# Keymaps

Referência rápida dos comandos e atalhos desta config. Uma seção por assunto.

## Indentação e quebra de linha

| Comando | Modo | O que faz |
|---|---|---|
| `=` | Visual | Reindenta a seleção (só indentação, não quebra linha) |
| `==` | Normal | Reindenta a linha atual |
| `gg=G` | Normal | Reindenta o arquivo inteiro |
| `>` / `<` | Visual | Aumenta / diminui um nível de indentação na seleção |
| `>>` / `<<` | Normal | Aumenta / diminui um nível de indentação na linha atual |
| `gq` | Visual | Formata a seleção pelo LSP. Em HTML quebra texto longo em 80 colunas (`colorcolumn`) e mantém tags intactas |
| `gqq` | Normal | Formata a linha atual pelo LSP |
| `:lua vim.lsp.buf.format()` | Comando | Formata o arquivo inteiro pelo LSP |

Notas:
- `gq` usa o servidor LSP do buffer quando há um anexado. Em HTML o limite de 80 vem de `html.format.wrapLineLength` em `lua/plugins/nvim-lspconfig.lua`.
- `=` em HTML indenta o conteúdo de `<p>` graças a `vim.g.html_indent_inctags = "p"` em `lua/config/options.lua`.
- Fluxo típico para um bloco HTML com texto longo: selecionar com `V`, apertar `gq`.
- Em `.tsx` / `.jsx` use `gq` (ou `gggqG` no arquivo inteiro) em vez de `=`: o indent nativo do Neovim não entende JSX, só o LSP (vtsls) aninha as tags corretamente.

## Vários arquivos ao mesmo tempo (splits)

Tudo nativo do Neovim. `<C-w>` = `Ctrl+w`, seguido da tecla.

### Abrir

| Comando | Modo | O que faz |
|---|---|---|
| `:vsplit arquivo` ou `:vs arquivo` | Comando | Abre `arquivo` em split vertical (lado a lado) |
| `:split arquivo` ou `:sp arquivo` | Comando | Abre `arquivo` em split horizontal (um sobre o outro) |
| `<C-w>v` | Normal | Divide a janela atual na vertical, mesmo arquivo nos dois lados |
| `<C-w>s` | Normal | Divide a janela atual na horizontal |
| `:e arquivo` | Comando | Dentro de uma janela, troca o arquivo dela por outro |

Fluxo típico: `:vs outro.html` abre o segundo arquivo à esquerda. Sem argumento (`:vs`) duplica o atual e depois `:e` troca.

### Navegar entre janelas

| Comando | Modo | O que faz |
|---|---|---|
| `<C-w>h` / `<C-w>l` | Normal | Vai para a janela da esquerda / direita |
| `<C-w>j` / `<C-w>k` | Normal | Vai para a janela de baixo / cima |
| `<C-w>w` | Normal | Alterna para a próxima janela |
| `<C-w>p` | Normal | Volta para a janela anterior |

### Trocar de lado

| Comando | Modo | O que faz |
|---|---|---|
| `<C-w>x` | Normal | Troca a janela atual com a vizinha (inverte os lados) |
| `<C-w>r` / `<C-w>R` | Normal | Gira as janelas no sentido horário / anti-horário |
| `<C-w>H` / `<C-w>L` | Normal | Move a janela atual para ocupar toda a esquerda / direita |
| `<C-w>K` / `<C-w>J` | Normal | Move a janela atual para ocupar todo o topo / base (vira horizontal) |

### Redimensionar

| Comando | Modo | O que faz |
|---|---|---|
| `<C-w>>` / `<C-w><` | Normal | Alarga / estreita a janela atual em 1 coluna |
| `<C-w>+` / `<C-w>-` | Normal | Aumenta / diminui a altura em 1 linha |
| `10<C-w>>` | Normal | Com número antes, aplica N colunas de uma vez (vale para todos acima) |
| `:vertical resize 80` | Comando | Largura exata da janela atual (`:vertical resize +10` para relativo) |
| `:resize 20` | Comando | Altura exata da janela atual |
| `<C-w>=` | Normal | Iguala o tamanho de todas as janelas |
| `<C-w>_` / `<C-w>\|` | Normal | Maximiza altura / largura da janela atual (sem fechar as outras) |

### Fechar

| Comando | Modo | O que faz |
|---|---|---|
| `<C-w>q` ou `:q` | Normal / Comando | Fecha a janela atual |
| `<C-w>o` ou `:only` | Normal / Comando | Fecha todas as outras, mantém só a atual |

## Abas (tabpages)

Tudo nativo do Neovim. Uma aba é um conjunto de janelas (splits), não um arquivo. A barra de abas só aparece quando há mais de uma.

### Abrir e fechar

| Comando | Modo | O que faz |
|---|---|---|
| `:tabnew` | Comando | Abre uma aba nova vazia |
| `:tabnew arquivo` ou `:tabe arquivo` | Comando | Abre `arquivo` em uma aba nova |
| `<C-w>T` | Normal | Move a janela (split) atual para uma aba nova |
| `:tabclose` ou `:tabc` | Comando | Fecha a aba atual (com todas as janelas dela) |
| `:tabonly` ou `:tabo` | Comando | Fecha todas as outras abas, mantém só a atual |
| `:q` | Comando | Fecha a janela atual; se era a última da aba, fecha a aba |

### Navegar

| Comando | Modo | O que faz |
|---|---|---|
| `gt` | Normal | Próxima aba |
| `gT` | Normal | Aba anterior |
| `3gt` | Normal | Vai para a aba número 3 (contagem a partir de 1) |
| `:tabn` / `:tabp` | Comando | Próxima / anterior (mesmo que `gt` / `gT`) |
| `:tabfirst` / `:tablast` | Comando | Primeira / última aba |
| `:tabs` | Comando | Lista todas as abas e as janelas de cada uma |

### Reordenar

| Comando | Modo | O que faz |
|---|---|---|
| `:tabmove 0` | Comando | Move a aba atual para o início |
| `:tabmove` | Comando | Move a aba atual para o fim |
| `:tabmove +1` / `:tabmove -1` | Comando | Move a aba atual uma posição para a direita / esquerda |
| `:tabmove 2` | Comando | Coloca a aba atual depois da aba 2 |

### Executar em todas

| Comando | Modo | O que faz |
|---|---|---|
| `:tabdo comando` | Comando | Roda `comando` em cada aba (ex.: `:tabdo e` recarrega os arquivos) |

## Pesquisa (mini.pick)

Abre um picker flutuante: digita e a lista filtra ao vivo. Configurado em `lua/plugins/mini-pick.lua`.

### Abrir um picker

| Comando | Modo | O que faz |
|---|---|---|
| `<leader>ff` | Normal | Arquivos do projeto (pasta atual, recursivo). Filtra pelo nome |
| `<leader>fg` | Normal | Texto em todos os arquivos do projeto, ao vivo (ripgrep). Cada linha = arquivo:linha com o termo |
| `<leader>fb` | Normal | Buffers abertos |
| `<leader>fh` | Normal | Tags do help do Neovim |
| `<leader>fr` | Normal | Reabre o último picker com a busca que estava |
| `:Pick grep` | Comando | Igual `<leader>fg`, mas pergunta o termo uma vez (sem ao vivo) |

### Dentro do picker

| Tecla | O que faz |
|---|---|
| `<C-n>` / `<C-p>` | Item de baixo / de cima |
| `<CR>` | Abre o item na janela atual |
| `<C-s>` / `<C-v>` / `<C-t>` | Abre em split horizontal / vertical / aba nova |
| `<Tab>` | Liga/desliga preview do item |
| `<S-Tab>` | Mostra informações e todos os atalhos do picker |
| `<C-x>` | Marca/desmarca o item atual |
| `<C-a>` | Marca/desmarca todos |
| `<M-CR>` | Abre os marcados. No `grep_live` manda todos para o quickfix |
| `<C-Space>` | Refina: os resultados atuais viram a lista base, nova busca em cima deles |
| `<Esc>` | Fecha |

Notas:
- Busca em todos os arquivos abertos: usar `<leader>fg` (busca no projeto inteiro, que inclui os abertos). Busca só nas linhas dos buffers abertos (`buf_lines`) é do mini.extra, não instalado.
- `<leader>fg` respeita `.gitignore` (ripgrep), então não entra em `node_modules`.
- Substituir em vários arquivos: `<leader>fg`, termo, `<C-a>`, `<M-CR>` (vai para o quickfix), depois `:cfdo %s/termo/novo/g | update`.
