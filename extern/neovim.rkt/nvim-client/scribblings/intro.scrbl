#lang scribble/manual

@(require scribble/example (for-label racket nvim racket/unix-socket))

@title{Introduction}

Neovim can be controlled programmatically through its RPC API (@code{:h rpc}).
The processes which use this API to communicate with Neovim are called RPC
clients. A client can be any Racket process, e.g. a GUI, a remote plugin, or a
REPL instance.

This client library abstracts away the process of connecting to Neovim and
handling RPC messages; it supports arbitrarily many concurrent connections and
provides functions which mirror the Neovim API calls.

@section{Installation}

First install this library like you would install any other Racket library. The
easiest option would be using @code{raco}.

@commandline{raco pkg install nvim-client}

If you also want to write Neovim remote plugins in Racket you need to install
this library as a Neovim plugin. You can install the Git repository as a Neovim
plugin, but it is recommended that you instead use the installed @code{raco}
package as the source. That way your plugins will launch faster because the
Racket host has been compiled.

To get the directory where this library was installed to use @commandline{raco
pkg show nvim-client} and use the path with your plugin manager. Follow the
instructions in the README of the project.

@section{An example session}

For the example session we will connect to a running Neovim instance using Unix
domain sockets. If you whish to follow along start Neovim now and get the
server address (@code{:h v:servername}).

@(examples
  #:label '()
  (code:comment "Import the libraries first")
  (eval:alts (require nvim)
             (require nvim racket/unix-socket))
  (code:comment "Connect to the socket (insert your server address)")
  (eval:alts (define-values (in out) (unix-socket-connect "/var/folders/..."))
             (void))
  (code:comment "Start the client session")
  (eval:alts (define nvim (nvim-attach in out))
             (void))
  (code:comment "Send a \"Hello world!\" command to Neovim")
  (eval:alts (send nvim command "echo 'Hello world!'")
             (void)))

First we connected to the Unix domain socket; the client library is ambivalent
as to which transport method is being used, so you are free to use any one you
want. In order to start a session we must provide an input- and output port
over which communication takes place.

Once the RPC session has been intialised we get an object representing the
Neovim instance. There can be multiple instances at the same time,
so we need a handle to send messages to. We call the @code{command} method to
display a "Hello world!" message in Neovim's command line.
