function! s:warn(message)
	echohl WarningMsg
	echom a:message
	echohl None
	return 0
endfunction

function! s:project_ag()
	let root = systemlist('git rev-parse --show-toplevel')[0]
	if v:shell_error
		return s:warn('Not in git repo')
	endif

	exec 'Ag '.root
endfunction

function! Project_files()
	let root = systemlist('git rev-parse --show-toplevel')[0]
	if v:shell_error
		return s:warn('Not in git repo')
	endif
	" TODO default properties eg height
	call fzf#run({
				\ 'source': 'git ls-files -c -o --exclude-standard',
				\ 'dir': root,
				\ 'down': '40%',
				\ 'sink': 'e',
				\ 'options': '-m --prompt "GitFiles> "'
				\})
endfunction

nnoremap <leader>f :call Project_files()<CR>
nnoremap <leader>s :call Project_ag()<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>w :Windows<CR>
nnoremap <leader>m :History<CR>
nnoremap <leader>c :History:<CR>
nnoremap <leader>hd :Helptags<CR>
nnoremap <leader>hk :Maps<CR>

" TODO FZF autocomplete
