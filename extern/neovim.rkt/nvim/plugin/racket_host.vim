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
"
if !exists('g:racket_host_prg')
	let g:racket_host_prg = 'racket'
endif

call remote#host#Register('racket', '*.rkt', function('host#racket#Require'))
