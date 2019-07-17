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

if exists('g:loaded_racket_host')
  finish
endif
let g:loaded_racket_host = 1

" =============================================================================
" Path to bootstrap file which does all the Racket-side work
let s:bootstrap_file = expand('<sfile>:p:h').'/bootstrap.rkt'

" Options for spawning the host job
let s:job_opts = {'rpc': v:true}
function! s:job_opts.on_stderr(job_id, data, event) dict
	echohl ErrorMsg
	for l:datum in a:data
		echom l:datum
	endfor
	echohl NONE
endfunction


" =============================================================================
" This function is run to start the Racket job
function! host#racket#Require(host) abort
	" We will pass this list of plugin paths to the host as a request
	let l:plugin_paths = copy(remote#host#PluginsForHost(a:host.name))
	let l:plugin_paths = map(l:plugin_paths, {_,v -> v.path})
	" The Racket binary
	let l:bin = g:racket_host_prg
	" Make Racket process the bootstrap module
	let l:cmd = [l:bin, '--require', s:bootstrap_file]

	try
		let l:job_id = jobstart(l:cmd, s:job_opts)
		" Perform a handshake with the host
		if rpcrequest(l:job_id, 'poll') == 'ok'
			" Load the remote plugins
			call rpcrequest(l:job_id, 'LoadRemotePlugins', l:plugin_paths)
		else
			call jobstop(l:job_id)
			throw 'Racket host did not respond to handshake'
		endif
		return l:job_id
	catch
		echoerr v:exception
	endtry
	throw 'Failed to launch Racket host.'
endfunction


" =============================================================================
" vim:ts=4
