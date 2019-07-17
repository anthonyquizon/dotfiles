.. default-role:: code

###############################
 API client library for Neovim
###############################

This is the Neovim client library and host for Racket, it allows communication
between the Neovim text editor and Racket using the MessagePack RPC.


Installation
############

To use the API client you have to install the `nvim-client` Racket package, and
in order to use remote plugins written in Racket you have to install the Racket
language host. This repository contains both of them together.


Installing the API client
=========================

The easiest way is to install it from the Racket `package catalog`_:

.. code:: sh

   raco pkg install nvim-client

If you wish to install the collection from this repository directly you will
have to install the `nvim-client` subdirectory.

.. code:: sh

   cd neovim.rkt
   make install
   # To remove the package
   make remove

This will install the package as a directory type, so keep the repository
around. Type `make help` for more details or see the contents of the makefile_.


.. _package catalog: https://pkgs.racket-lang.org/
.. _makefile: makefile


Installing the Racket host
==========================

The Racket host is a Neovim package inside the `nvim` subdirectory. Install
this repository using your method of choice and make sure to select the
subdirectory as the runtime path. Modern package managers will usually have an
option called `rtp` (or similar) you can specify in the plugin specification.


Using Neovim and Racket
#######################

You can use the client to control a Neovim instance from Racket, as well as to
let Neovim control a Racket instance.

Connecting to a running Neovim instance on the REPL
===================================================

.. code:: racket

   ;; Connecting over a Unix socket with path "nvim-listen-address"
   (require nvim racket/unix-socket)
   (define-values (in out) (unix-socket-connect nvim-listen-address))
   (define nvim (nvim-attach in out))
   (send nvim command "echo 'Hello world!'")

We connect to a running Neovim process which over a Unix domain socket whose
path is `nvim-listen-address` [1]_. The connection is reprsented by the `nvim`
object and we can issue API calls by sending messages to it. Here we send the
`command` message to execute a command (passed as a string).

We can connect to any number of Neovim instances at any time, each one of them
is represented by a different object.


Remote plugins
==============

Remote plugins are Racket files which define functions, commands and
auto-commands for Neovim. This is the Racket translation of the `Neovim remote
plugin example`_ [2]_:

.. code:: racket 

   (require nvim)

   (define calls 0)
   (define (increment-calls)
     (cond
       [(= calls 5) (raise "Too many calls!")]
       [else (set! calls (add1 calls))]))


   (nvim-command "Cmd" #:range "" #:nargs #\* #:sync #t
     (λ (args range)
       (increment-calls)
       (send (current-nvim-instance) set-current-line
         (format "Command: Called ~a times, args: ~a, range ~a"
                 calls args range)))) 

   (nvim-autocmd "BufEnter" #:pattern "*.rkt" #:eval "expand('<afile>')" #:sync #t
     (λ (filename)
       (increment-calls)
       (send (current-nvim-instance) set-current-line
         (format "Autocmd: Called ~a times, file: ~a" calls filename))))

   (nvim-function "Func"
     (λ (args)
       (increment-calls)
       (send (current-nvim-instance) set-current-line
         (format "Function: Called ~a times, args: ~a" calls args))))

We could have also written `(define nvim (current-nvim-instance))` so we don't
have to spell the entire parameter out every time.


.. _Neovim remote plugin example:
   https://neovim.io/doc/user/remote_plugin.html#remote-plugin-example

.. [1] See `:h v:servername` and `:h $NVIM_LISTEN_ADDRESS`
.. [2] See `:h remote-plugin-example`


Status of the project
#####################

The project is still in an experimental state and names *might* change. Do not
use it for production. It does work though, so if you want to tinker go right
ahead.


License
#######

Released under the GNU GPLv3+ license, see the COPYING_ file for details.

.. _COPYING: COPYING.txt

