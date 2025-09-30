vim.cmd([[
	set number
	" Use spaces instead of tabs
	set expandtab
	" Set the number of spaces per tab
	set tabstop=2
	" Set the number of spaces for indentation
	set shiftwidth=2
	" Make backspace delete the correct number of spaces
	set softtabstop=2


	" Autoinstall vim-plug
	if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
	    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

	" " Specify plugin directory
	call plug#begin()
	  " Built-in LSP
	  "   run `:help lsp` for more information
	  Plug 'neovim/nvim-lspconfig'

	  Plug 'kabouzeid/nvim-lspinstall'

	  " Color scheme
	  Plug 'morhetz/gruvbox' 

	  " Neovim Completion Manager
	  "   run `:help ncm2` for more information
	  Plug 'ncm2/ncm2'
	  Plug 'roxma/nvim-yarp'

	  "" Completion Sources
	  """ General Purpose
	  Plug 'ncm2/ncm2-bufword'
	  Plug 'ncm2/ncm2-path'

	  """ Python
	  Plug 'ncm2/ncm2-jedi'

	  "" Floating Terminal
	  Plug 'voldikss/vim-floaterm'

	  """" Python Docstrings
	  Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }

	  """ Snippets
	  " Plug 'SirVer/ultisnips'
	  " Plug 'honza/vim-snippets'

	  " Treesitter
	  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	  Plug 'nvim-treesitter/nvim-treesitter-refactor'
	  Plug 'nvim-treesitter/playground'

	  " nvim-compe
	  "   run `:help compe` for more information
	  Plug 'hrsh7th/nvim-compe'

	  " Telescope
	  "   run `:help telescope` for more information

	  "" Dependencies
	  Plug 'nvim-lua/popup.nvim'
	  Plug 'nvim-lua/plenary.nvim'

	  Plug 'nvim-telescope/telescope.nvim'

	  " Fugitive (git wrapper for vim)
	  "   run `:help fugitive` for more information
	  Plug 'tpope/vim-fugitive'

	  " FZF
	  "   run `:help fzf` for more information
	  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	  Plug 'junegunn/fzf.vim'

	  " Markdown
	  Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}

	  " Vim Merge Request
	  Plug 'google/vim-maktaba'
	  Plug 'google/vim-glaive'
	  Plug 'LucHermitte/lh-vim-lib'
	  Plug 'omrisarig13/vim-mr-interface'

	  " Floaterm
	  Plug 'voldikss/vim-floaterm'

	  Plug 'junegunn/limelight.vim'
	  Plug 'junegunn/goyo.vim'
	" Initialize the plugin system 
	call plug#end()

	colorscheme gruvbox

	"" Run fzf.vim - command is Files
	let g:fzf_default_opts = '--layout=reverse --preview "bat --style=numbers --color=always --line-range :300 {}" --preview-window right:90% --height 20%'

	" For excluding directories, use FZF_DEFAULT_COMMAND instead
	let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!sorbet/" --glob "!.git/" --glob "!sw-bazel/" --glob "!venv/" --glob "!node_modules/" --glob "!dist/" --glob "!chroma_db/" --glob "!__pycache__/" --glob "!__pypackages__/" --glob "!.DS_Store/"'
	nnoremap <Leader>f :Files<CR>

	"" Telescope
	nnoremap <Leader>g :Telescope live_grep<CR>
	nnoremap <Leader>s :LiveGrepDir<CR>
	nnoremap <Leader>r :Telescope resume<CR>

	"" Limelight 
	nnoremap <Leader>l :Limelight!!<CR>

	"" Goyo 
	nnoremap <Leader>F :Goyo 150<CR>

	"" Floating Terminal
	nnoremap <silent> <Leader>t   :FloatermToggle<CR>
	tnoremap <silent> <Leader>t   <C-\><C-n>:FloatermToggle<CR>

	" " auto brackets
	inoremap " ""<left>
	inoremap ' ''<left>
	inoremap ( ()<left>
	inoremap [ []<left>
	inoremap { {}<left>
	inoremap {<CR> {<CR>}<ESC>O
	inoremap {;<CR> {<CR>};<ESC>O

	" Config for LimeLight
	" Color name (:help cterm-colors) or ANSI code
	let g:limelight_conceal_ctermfg = 'gray'
	let g:limelight_conceal_ctermfg = 240

	" Color name (:help gui-colors) or RGB color
	let g:limelight_conceal_guifg = 'DarkGray'
	let g:limelight_conceal_guifg = '#777777'

	" Default: 0.5
	let g:limelight_default_coefficient = 0.7

	" Number of preceding/following paragraphs to include (default: 0)
	let g:limelight_paragraph_span = 10 

	" Beginning/end of paragraph
	"   When there's no empty line between the paragraphs
	"   and each paragraph starts with indentation
	let g:limelight_bop = '^\s'
	let g:limelight_eop = '\ze\n^\s'

	" Highlighting priority (default: 10)
	"   Set it to -1 not to overrule hlsearch
	let g:limelight_priority = -1

	"" Goyo config
	let g:goyo_linenr = 0
	function! s:goyo_enter()
	  if executable('tmux') && strlen($TMUX)
	    silent !tmux set status off
	    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
	  endif
	  set noshowmode
	  set noshowcmd
	  set scrolloff=999
	  set number
	endfunction
	autocmd! User GoyoEnter nested call <SID>goyo_enter()

	" Enable copilot on start
	let g:copilot#enabled = 1
]])

vim.api.nvim_create_user_command('LiveGrepDir', function()
  require('telescope.builtin').live_grep({
    search_dirs = { vim.fn.input("Search directory: ") }
  })
end, {})

-- Replace your current Telescope setup with this:
require('telescope').setup({
  pickers = {
    live_grep = {
      additional_args = function()
        return {
          "--glob=!venv/",
          "--glob=!chroma_db/",
          "--glob=!node_modules/",
          "--glob=!sorbet/",
          "--glob=!sw-bazel/",
          "--glob=!.git/",
          "--glob=!dist/"
        }
      end
    }
  }
})

-- Make the function available globally with newline handling
_G.get_visual_selection = function()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  -- Replace newlines with spaces and trim
  return string.gsub(table.concat(lines, ' '), '%s+', ' '):gsub('^%s*(.-)%s*$', '%1')
end

-- Replace your current telescope mapping with these:
vim.api.nvim_set_keymap('n', '<Leader>g', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>g', ':<C-u>lua require("telescope.builtin").live_grep({ default_text = get_visual_selection() })<CR>', { noremap = true, silent = true })

