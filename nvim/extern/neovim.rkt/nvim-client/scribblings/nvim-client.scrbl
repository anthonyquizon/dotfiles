#lang scribble/manual

@title{Neovim client for Racket}
@author[@author+email["Alejandro Sanchez" "hiphish@openmailbox.org"]]
@defmodule[nvim]


The @hyperlink["https://neovim.io/"]{Neovim} text editor offers an RPC API to
let the editor communicate with external processes. This API client library
provides the functionality to connect to a Neovim process and exchange
information with it. It can be used control Neovim, write Racket remote
plugins, or implement a GUI in Racket.

Source code: @url["https://gitlab.com/HiPhish/neovim.rkt"]

@table-of-contents[]

@include-section["intro.scrbl"]
@include-section["rpc.scrbl"]
@include-section["api.scrbl"]
@include-section["rplugin.scrbl"]
