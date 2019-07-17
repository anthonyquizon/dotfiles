#lang scribble/manual
@(require (for-label racket nvim))

@title{Neovim RPC sessions}

A Remote procedure call (RPC in short) is the process of calling a procedure in
a remote process as if it were a local procedure. What this essentially means
is that a programmer may offload some work onto a remote process and get the
result back without having to deal with the messy details of remote
communication. In the particular case of the Racket Neovim client we achieve
this by attaching to a Neovim process, which gives us back an object which we
can then send messages to.


The @racket{nvim} module provides all the components of the Neovim client; it
implicitly provieds the API and remote plugin submodules, which are described
in their own sections.

@defproc[(nvim-attach [in input-port?] [out output-port?]) nvim%]
Attach to a running Neovim process over the @racket[in] input port and the
@racket[out] output port. The result is an object representing that Neovim
instance.

@defparam[current-nvim-instance nvim (or/c void? (is-a?/c nvim%)) #:value (void)]{
  Represents the current Neovim instance, @racket[void] by default. This
  parameter will be autmatically set in remote plugins.
}
