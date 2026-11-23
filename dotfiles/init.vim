" nvim defaults already cover: nocompatible ai ls=2 hls is wmnu bs ar hidden ttimeoutlen
filetype plugin indent on | syntax on                                                           " explicit: nvim's defaults run after init, and its syntax load would clear our FileType syn rules
set shell=/bin/bash rnu nu scs nowrap et ve=block noswf nobk nowb sw=2 sts=2 ts=2 path+=** udf udir=~/.nvim/undodir
set grepprg=rg\ --vimgrep grepformat^=%f:%l:%c:%m complete= shada='50,<5000,s100 tags=./tags,tags,.tags,local/tags  " big shada so registers survive between instances
let g:netrw_banner = 0 | let mapleader = "\<Space>"
ino jk <Esc>| nn K <Nop>| nn U <Nop>| nn Q <Nop>
for c in ['Qa qa','QA qa','Q q','W w','WQ wq','Wq wq','E Explore'] | exe 'com! -bar' c | endfor | unl c  " typos; E beats ambiguity (eg. Emmet)
xn < <gv| xn > >gv|                                                                             " visual mode indenting
xn <leader>s "vy:%s/<C-R>v//g<Left><Left>|                                                      " search visual
xn <leader>S "vy:%s//<C-R>v/g<C-b><Right><Right><Right>|
nn <leader>s :%sno/<C-R><C-W>//g<Left><Left>|                                                   " search word
nn <leader>S :%sno//<C-R><C-W>/g<C-b><Right><Right><Right><Right><Right>|
nn <leader>z <Cmd>noh<CR>|                                                                      " clear search highlight
nn <leader>0 <Cmd>set scroll=0<CR>|                                                             " scroll reset
xn <C-y> "*y| xn <C-p> "*p|                                                                     " clipboard yank/paste
nn <C-j> <Cmd>m .+1<CR>==| nn <C-k> <Cmd>m .-2<CR>==|                                           " shuffle line up/down
ino <C-j> <Esc><Cmd>m .+1<CR>==gi| ino <C-k> <Esc><Cmd>m .-2<CR>==gi|
xn <C-j> :m '>+1<CR>gv=gv| xn <C-k> :m '<-2<CR>gv=gv|
nn <C-w>v <Cmd>echo "disabled"<CR>| nn <C-w>s <Cmd>echo "disabled"<CR>
no <leader>; :call nerdcommenter#Comment(1, 'toggle')<CR>|                                      " NERD commenter installed in setup. ':' not <Cmd>: needs visual/count range
cno <C-a> <Home>| cno <C-e> <End>
let g:fzf_vim = #{preview_window: ['right,50%,<50(hidden)', 'ctrl-/']}
com! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(#{options: '--delimiter : --nth 4..'}), <bang>0)
com! -bang Dirs call fzf#run(fzf#wrap(#{source: 'fd -t d --hidden --no-ignore --exclude .git', sink: 'e', options: '--preview "ls -la {}"'}, <bang>0))
nn <leader>d <Cmd>Dirs<CR>|                                                                     " fzf directories
nn <leader><leader> <Cmd>Files<CR>| nn <leader>/ <Cmd>Rg<CR>| nn <leader>. <Cmd>BLines<CR>| nn <leader>m <Cmd>History<CR>

" per git project session state, shared between vim instances
fu! GitRoot()
  let r = trim(system('git rev-parse --show-toplevel 2>/dev/null')) | return v:shell_error ? '' : r
endf
fu! GitPath()
  let r = GitRoot() | return '/tmp/'.(r == '' ? 'global' : sha256(r))
endf
fu! SearchHist()                                               " global search history: other instances' entries, then ours (newest last)
  let h = filter(map(range(1, histnr('search')), {_, i -> histget('search', i)}), 'v:val != ""')
  let o = filereadable('/tmp/vimsearchhist.txt') ? readfile('/tmp/vimsearchhist.txt') : []
  let l = filter(o, 'index(h, v:val) < 0') + h | return l[max([0, len(l) - 500]):]
endf
fu! OnBlur()
  let f = GitPath() | exe 'wshada! '.f.'.shada'
  if @" != '' | call writefile([@"], '/tmp/vimcopy.txt') | endif
  if @/ != '' | call writefile([@/], '/tmp/vimsearch.txt') | endif
  call writefile(SearchHist(), '/tmp/vimsearchhist.txt')
  call writefile([expand('%:p').':'.line('.')], f.'.file')
endf
" called externally on 'e'. Restore cursor at last position and file in git project
fu! Restore()
  let f = GitPath().'.file'
  if filereadable(f)
    let b = split(get(readfile(f), 0, ''), ':')
    if len(b) > 1 | exe 'e '.fnameescape(b[0]) | call cursor(b[1], 0) | endif
  endif
  call RestoreFocus()
endf
fu! RestoreFocus()
  sleep 20m                                                    " avoid races between instances
  sil! exe 'rshada! '.GitPath().'.shada'
  for [r, f] in [['"', '/tmp/vimcopy.txt'], ['/', '/tmp/vimsearch.txt']]
    if filereadable(f) | call setreg(r, join(readfile(f), "\n")) | endif
  endfor
  if filereadable('/tmp/vimsearchhist.txt') | for s in readfile('/tmp/vimsearchhist.txt') | call histadd('search', s) | endfor | endif
  call histadd('search', @/) | let v:hlsearch = 1
endf

" BQN keymap: \ prefix for glyphs, | prefix for extras
let a ='`1234567890-= ~!@#$%^&*()_+ qwertyuiop[]  QWERTYUIOP{} asdfghjkl;''\ ASDFGHJKL:"| zxcvbnm,./    ZXCVBNM<>?   '
let b ='˜˘¨⁼⌜´˝7∞¯•÷× ¬⎉⚇⍟◶⊘⎊⍎⍕⟨⟩√⋆ ⌽𝕨∊↑∧◁⊔⊏⊐π←→  ↙𝕎⍷𝕣⍋◀U⊑⊒⍳⊣⊢ ⍉𝕤↕𝕗𝕘⊸∘○⟜⋄↩\  ↖𝕊D𝔽𝔾«↺⌾»·˙| ⥊𝕩↓∨⌊□≡∾≍≠    ⋈𝕏C⍒⌈■≢≤≥⇐   '
let c ='AdDESsTtoONkyRrQqZij01234)!@#*-_|'
let d ="∀ΔΔ∃□□ᐪ◁○⬤ℕ✓☺ℝ↺▫▯Σᵢⱼ₀₁₂₃₄⁰¹²³꘎ⁿₙ|" | " g used for •SHOW
let[a,b]=map([a,b],{i,x->split(x,'\zs *')}) | let a+=['<space>']|let b+=['‿']
for l in ['i','c']|for i in range(len(a))|exe escape(l.'no'.'\'.a[i].' '.b[i],'|')|endfor|endfor
for l in ['i','c']|for i in range(len(c))|exe escape(l.'no'.'|'.c[i].' '.matchstr(d,'.',0,i+1),'|')|endfor|endfor
unl a b c d l i
nn <Bar>r <Cmd>source $MYVIMRC<CR>
nn <Bar>D mm:%s/•SHOW //g<CR>:noh<CR>`m
nn <Bar>d :s/•SHOW //g<CR>:noh<CR>
xn <Bar>d :s/\%V•SHOW //gi<CR><Esc>
ino <Bar>g •SHOW<Space>| ino <Bar>G •SHOW<Space>
nn <Bar>g i•SHOW <Esc>| nn <Bar>G I•SHOW <Esc>| xn <Bar>g I•SHOW <Esc>
fu! FmtBQN()
  call setline(1, split(system('bqf', join(getline(1, '$'), "\n")), "\n", 1))
endf
fu! ExpBQN(l)
  echo system('bqe '.shellescape(a:l))
endf
no <leader>ff <Cmd>call FmtBQN()<CR>
xn <leader>e "vy<Cmd>call ExpBQN(@v)<CR>
nn <leader>e <Cmd>call ExpBQN(getline('.'))<CR>

" Replace mode: hjkl/yubn navigate instead of typing
nn R <Cmd>set ve+=insert<CR>R
for [k, v] in items(#{j:'<Down>', k:'<Up>', h:'<Left>', l:'<Right>', n:'<Right><Down>', b:'<Left><Down>', u:'<Right><Up>', y:'<Left><Up>'})
  exe printf('ino <expr> %s mode()[0] ==# "R" ? "\%s" : "%s"', k, v, k)
endfor | unl k v

aug Vimrc
  au!
  au BufRead,BufNewFile * if getline(1) =~ '^#!.*bqn$' | setf bqn | endif
  au BufRead,BufNewFile *.bqn setf bqn
  au FileType bqn syn match bqncom "#.*$" | hi link bqncom Comment
  au FileType bqn setl sts=2 ts=2 sw=2 et cms=#%s
  au FileType yaml setl ai< ci< si<
  au ModeChanged *:R* sil! iunmap jk
  au ModeChanged R*:* ino jk <Esc>
  au InsertLeave * set ve-=insert
  au InsertLeave,TextChanged * sil! w
  au VimEnter * let r=GitRoot() | if r!='' | exe 'cd' fnameescape(r) | endif
  au VimEnter * nested call RestoreFocus()
  au TextYankPost,VimLeave,FocusLost * call OnBlur()
  au FocusGained * call RestoreFocus()
  au VimEnter,FocusGained,BufEnter * let @/ = ''
aug END
