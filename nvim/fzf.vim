let s:developmentDir = '~/Development/'
let s:projectDir = '~/Development/Projects/'

function! s:warn(message)
	echohl WarningMsg
	echom a:message
	echohl None
	return 0
endfunction

function! ProjectAg()
	let root = systemlist('git rev-parse --show-toplevel')[0]
	if v:shell_error
		return s:warn('Not in git repo')
	endif

	exec 'Ag '.root
endfunction

function! ProjectFiles()
	let root = systemlist('git rev-parse --show-toplevel')[0]
	if v:shell_error
		return s:warn('Not in git repo')
	endif

	call fzf#run({
				\ 'source': 'git ls-files -c -o --exclude-standard',
				\ 'dir': root,
				\ 'down': '40%',
				\ 'sink': 'e',
				\ 'options': '-m --prompt "GitFiles> "'
				\})
endfunction

function! ListDevelopmentDir()
	call fzf#run({
				\ 'source': 'find '.s:developmentDir.' -maxdepth 4 -name .git -type d  -prune -not -path "**/__*" | xargs -n 1 dirname',
				\ 'down': '40%',
				\ 'sink': 'Explore',
				\ 'options': '-m --prompt "Development> "'
				\})
endfunction

function! ListProjects()
	call fzf#run({
				\ 'source': 'find '.s:projectDir.' -maxdepth 4 -name .git -type d  -prune -not -path "**/__*" | xargs -n 1 dirname',
				\ 'down': '40%',
				\ 'sink': 'Explore',
				\ 'options': '-m --prompt "Projects> "'
				\})
endfunction

nnoremap <leader>f :call ProjectFiles()<CR>
nnoremap <leader>s :call ProjectAg()<CR>
nnoremap <leader>p :call ListDevelopmentDir()<CR>
nnoremap <leader><leader>p :call ListProjects()<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>w :Windows<CR>
nnoremap <leader>m :History<CR>
nnoremap <leader>hc :History:<CR>
nnoremap <leader>hs :History/<CR>
nnoremap <leader>hd :Helptags<CR>
nnoremap <leader>hk :Maps<CR>

" TODO FZF autocomplete
