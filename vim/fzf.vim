"FZF
nnoremap <leader>f :FZF<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>w :Windows<CR>
nnoremap <leader>m :History<CR>
nnoremap <leader>c :History:<CR>

" TODO ag in git repo
nnoremap <leader>s :Ag<CR> 

nnoremap <leader>hd :Helptags<CR>
nnoremap <leader>hk :Maps<CR>

function! s:warn(message)
	echohl WarningMsg
	echom a:message
	echohl None
	return 0
endfunction

function! Antho_FZFProjectAg()
	" TODO command function
	let root = systemlist('git rev-parse --show-toplevel')[0]
	if v:shell_error
		return s:warn('Not in git repo')
	endif

	exec 'Ag '.root
endfunction

function! Antho_FZFProjectFiles()
	let root = systemlist('git rev-parse --show-toplevel')[0]
	if v:shell_error
		return s:warn('Not in git repo')
	endif
	" TODO default properties eg height
	call fzf#run({
				\ 'source': 'git ls-files -c -o --exclude-standard',
				\ 'dir': root,
				\ 'sink': 'e',
				\ 'options': '-m --prompt "GitFiles> "'
				\})
endfunction

nnoremap <leader>f :Files 
nnoremap <leader><leader>f :call Antho_FZFProjectFiles()<CR>
nnoremap <leader><leader>s :call Antho_FZFProjectAg()<CR>

" TODO git root directory
" git rev-parse --show-toplevel 

" TODO FZF autocomplete
" TODO set FZF of project root 
"

" TODO fzf in project directory patterns
