let s:developmentDir = '~/Development/'
let s:projectDir = 'Projects/'

" TODO create ignore array variable
" TODO ignore images
" TODO ignore __

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

	" TODO set dir to git root

	exec 'Ag'
endfunction

function! ProjectFiles()
	" TODO cannot do gdiff after using this command
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

function! DirOpen(name) 
	let dir_name = s:developmentDir . a:name
	" TODO cd into directory
	exec 'Explore ' . dir_name . '/'
endfunction

function! ProjectOpen(name) 
	let project_name = s:projectDir . a:name
	call DirOpen(project_name)
endfunction


function! ListDevelopmentDir()
	call fzf#run({
				\ 'source': 'find . -maxdepth 4 -name .git -type d  -prune -not -path "**/__*" | xargs -n 1 dirname | sed "s/.\///"', 
				\ 'dir': s:developmentDir,
				\ 'down': '40%',
				\ 'sink': function('DirOpen'),
				\ 'options': '-m --prompt "Development> "'
				\})
endfunction

function! ListProjects()
	call fzf#run({
				\ 'source': 'find . -maxdepth 4 -name .git -type d  -prune -not -path "**/__*" | xargs -n 1 dirname | sed "s/.\///"',
				\ 'dir': s:developmentDir.s:projectDir,
				\ 'down': '40%',
				\ 'sink': function('ProjectOpen'),
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
