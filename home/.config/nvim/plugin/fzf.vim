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

function! s:function(name)
    return function(substitute(a:name, '^s:', matchstr(expand('<sfile>'), '<SNR>\d\+_\zefunction$'), ''))
endfunction

function! s:escape(path)
  return escape(a:path, ' %#''"\')
endfunction


function! s:ag_to_qf(line)
    let parts = split(a:line, ':')
    return {'filename': &acd ? fnamemodify(parts[0], ':p') : parts[0], 'lnum': parts[1], 'col': parts[2],
                \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(line)
    let info = s:ag_to_qf(a:line)
    echom info.filename

    execute 'e' info.filename
    execute info.lnum
    execute 'normal!' info.col.'|zz'
endfunction

function! ProjectAg() "TODO populate quickfix file
    let root = systemlist('git rev-parse --show-toplevel')[0]

    if v:shell_error
        return s:warn('Not in git repo')
    endif

    return fzf#run({
                \ 'source':  'ag --nogroup --column "^(?=.)"', 
                \ 'dir': root,
                \ 'sink': s:function('s:ag_handler'),
				\ 'options': '--delimiter : --nth 4.. --multi --prompt "Search Files> "'})
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

function! s:dirOpen(name) 
    " TODO set current working directory to project folder
	let dir_name = s:developmentDir . a:name
    
    execute 'Explore' dir_name
    execute 'normal!' 'j'
endfunction

function! s:projectOpen(name) 
	let project_name = s:projectDir . a:name
	call s:dirOpen(project_name)
endfunction


function! ListDevelopmentDir()
	call fzf#run({
				\ 'source': 'find . -maxdepth 4 -name .git -type d  -prune -not -path "**/__*" | xargs -n 1 dirname | sed "s/.\///"', 
				\ 'dir': s:developmentDir,
				\ 'down': '40%',
				\ 'sink': s:function('s:dirOpen'), 
				\ 'options': '-m --prompt "Development> "'
				\})
endfunction

function! ListProjects()
	call fzf#run({
				\ 'source': 'find . -maxdepth 4 -name .git -type d  -prune -not -path "**/__*" | xargs -n 1 dirname | sed "s/.\///"',
				\ 'dir': s:developmentDir.s:projectDir,
				\ 'down': '40%',
				\ 'sink': s:function('s:projectOpen'),
				\ 'options': '-m --prompt "Projects> "'
				\})
endfunction


function! NetrwMapping()
    nnoremap <buffer> s :call ProjectAg()<CR>
endfunction

augroup netrw_fzf
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

nnoremap <leader>f :call ProjectFiles()<CR>
nnoremap <leader>s :call ProjectAg()<CR>
nnoremap <leader>p :call ListDevelopmentDir()<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>w :Windows<CR>
nnoremap <leader>m :History<CR>
nnoremap <leader>hc :History:<CR>
nnoremap <leader>hs :History/<CR>
nnoremap <leader>hd :Helptags<CR>
nnoremap <leader>hk :Maps<CR>
