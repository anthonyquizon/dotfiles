# Copyright 2017 Alejandro Sanchez
#
# This file is part of Neovim.rkt
# 
#     Neovim.rkt is free software: you can redistribute it and/or modify it
#     under the terms of the GNU General Public License as published by the
#     Free Software Foundation, either version 3 of the License, or (at your
#     option) any later version.
# 
#     Neovim.rkt is distributed in the hope that it will be useful, but WITHOUT
#     ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#     FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#     more details.
# 
#     You should have received a copy of the GNU General Public License along
#     with Neovim.rkt.  If not, see <http://www.gnu.org/licenses/>.

# ===[ Public variables ]=====================================================
RACO = raco

# ===[ Phony targets ]========================================================
.PHONY: help install remove

help:
	@echo 'Usage: make (help | install | uninstall)'
	@echo '  help     Print this message'
	@echo '  install  Install the Neovim client as a Racket directory package'
	@echo '  remove   Uninstall the Neovim client Racket package'
	@echo 'The following variables can be specified:'
	@echo '  $$(RACO)  Binary for raco, default "raco"'

install: nvim-client
	@$(RACO) pkg install --type dir nvim-client

remove:
	@$(RACO) pkg remove nvim-client
