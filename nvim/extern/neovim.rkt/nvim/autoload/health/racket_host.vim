" Copyright 2017 Alejandro Sanchez
"
" This file is part of neovim.rkt
" 
"     Neovim.rkt is free software: you can redistribute it and/or modify it
"     under the terms of the GNU General Public License as published by the
"     Free Software Foundation, either version 3 of the License, or (at your
"     option) any later version.
" 
"     Neovim.rkt is distributed in the hope that it will be useful, but
"     WITHOUT ANY WARRANTY; without even the implied warranty of
"     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
"     General Public License for more details.
" 
"     You should have received a copy of the GNU General Public License along
"     with neovim.rkt.  If not, see <http://www.gnu.org/licenses/>.

function! health#racket_host#check()
	call health#report_start('Racket host')
	let l:version = matchstr(system(g:racket_host_prg.' -v'), '\v\d+\.\d+')
	let [l:major, l:minor] = split(l:version, '\v\.')

	if l:major == 6 && l:minor >= 10
		let l:msg = 'Racket version '. l:major.'.'.l:minor.' detected.'
		call health#report_ok(l:msg)
	elseif l:major >= 6
		let l:msg = 'Racket version '.l:major.'.'.l:minor.
		           \'; major version is greater than 6, compatibility not guaranteed.'
		call health#report_warn(l:msg)
	else
		let l:msg = 'Racket version '.l:major.'.'.l:minor
		call health#report_error(l:msg, ['Needs at least version 6.10'])
	endif

	if empty(system('raco pkg show nvim | grep nvim'))
		call health#report_error('Neovim Racket package no installed')
	else
		call health#report_ok('Neovim Racket package detected.')
	endif
endfunction
