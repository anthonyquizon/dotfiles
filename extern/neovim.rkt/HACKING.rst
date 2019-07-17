.. default-role:: code

################################
 The Racket API client for Nvim
################################


This project consists of two components: a Racket package (API client) and a
Neovim plugin (Racket host). The top-level directory structure is that of a
Neovim plugin, so the repository can be used with the common Neovim package
managers. This client's source code, documentation and tests are all contained
inside the `nvim-client` directory, that way the client can be installed as a
Racket package without the Neovim files interfering.


Overview
########

Neovim is able to communicate synchronously and asynchronously with other
processes. This allows the remote process to control Neovim, as well as Neovim
to control the remote process. This project features:

- A Neovim client library for Racket
- A Racket host for Neovim remote plugins

Remote plugins are Nvim plugins written in Racket. They are called “remote”
because they are not run by the Neovim process that uses them, but in a remote
Racket process. The following drawing illustrates this relationship:

.. code::

   +-----------------+                       +-----------------+
   |     RACKET      |                       |     RACKET      |
   |=================|<--RPC--+    +---RPC-->|=================|
   |                 |        |    |         |                 |
   |     Client      |   +----+----+-----+   |     Client      |
   |                 |   |     Nvim      |   | Remote Plugin 1 |
   | Running e.g. in |   +----+----+-----+   | Remote Plugin 2 |
   | the REPL        |        |    |         |        .        |
   |                 |>--RPC--+    +---RPC--<|        .        |
   |                 |                       |        .        |
   +-----------------+                       +-----------------+

This relationship can be chained arbitrarily; we could for example run a Racket
process which embeds a Neovim process which runs a remote plugin which embeds
another Neovim process and so on, whether this is useful or not.

The API client provides a number of API-related classes which Racket can use to
control Neovim.

.. code:: racket

   (require nvim/api)
   ;;; Call the Vim 'echo' command
   (send (current-nvim-instance) command "echo 'Hello world!'")

These API messages block until a response is received from the server.


Layers of the library
=====================

Separation of concern is maintained by enforcing the following layering inside
the library. Layers can reach down the tower, but not up.

.. code::

   +----------------------+
   |         Nvim         |
   +----------------------+
   |    Remote Plugins    |
   +----------------------+
   |       Nvim API       |
   +----------------------+
   |    MessagePack RPC   |
   +--------+-------------+
   | Racket | MessagePack |
   +--------+-------------+

The topmost layer is just a public interface intended for end-users. The
MessagePack RPC layer could eventually be made into its own library, so it is
imperative for it to not reach up the tower.


The API client
##############

Communication with Neovim happens in a thread which synchronises on either
outgoing API messages or incoming RPC messages.

Neovim session instances
========================

One Racket process can manage multiple session instances. In order to keep
track of the instances the connecting procedure returns a session object.  The
user can then set the `current-nvim-session` parameter to the session he wishes
to use.

.. code:: racket

   (define nvim-1 (nvim-attach in1 out1))
   (define nvim-2 (nvim-attach in2 out2))

   (send nvim-1 command "echo 'This is the first session'")
   (send nvim-2 command "echo 'This is the second session'")
   (parameterize ([current-nvim-instance nvim-1])
     (send (current-nvim-session) "echo 'This is the current session'")

API classes
===========

API is provided by the `neovim/api` module and provides Racket classes with
methods which correspond to the API methods.

.. code:: racket

   (define current-buffer (send nvim get-current-buffer))
   (send current-buffer set-name "main_buffer")

The `nvim%` class represent Neovim instances, and the other classes represent
Neovim apy types (see `:h api-types`).

Remote plugins
##############

Remote plugins are Racket modules placed in the `rplugin/racket` directory of a
Neovim plugin. Remote plugins of different Neovim instances don't know anything
about each other. Here is how a remote plugin is hooked up:

#) Neovim starts, it sources the file `plugin/racket_host.vim`
#) This file starts a Racket process which is instructed to `require` the file
   `autoload/host/bootstrap.rkt`. That module only gets the Racket process
   ready to receive RPC requests, but it does not register any plugins yet.
#) The `racket_host.vim` file performs a hand shake with Racket and then sends
   it an RPC request to register all remote plugins, along with a list of
   remote plugin paths.
#) Due to the request Racket uses `dynamic-require` on all the remote plugins
   one at a time. As a side effect of being required each plugin registers its
   Neovim function-, command- and autocommand specifications in a hash table.

When a Neovim users executes `:UpdateRemotePlugins` Racket is sent a request
and replies back with the above mentioned specifications. There are a couple of
caveats in this sequence of operations:

- The Neovim instance has to be instantiated before any API calls are issued.
- The RPC callbacks have to be registered before any RPC messages get
  processed.
- Every remote plugin callback is run on its own thread, so we have to make
  sure that they all have access to the same Neovim instance.

See the implementation for how these issues are addressed.
