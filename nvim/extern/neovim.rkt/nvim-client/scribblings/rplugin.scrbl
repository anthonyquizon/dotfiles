#lang scribble/manual
@(require (for-label racket nvim))

@title{Remote plugins}

Remote plugins are Racket modules which are distributed as Neovim plugins.
Please refer to @code{:h remote-plugin} for details. A remote plugin can
contain any Racket code, which will be executed when the Racket host is
launched. What you most likely will be interested in is to define functions,
commands and auto-commands for Neovim in Racket. These can then be treated as
if they were a regular part of Neovim.

@section{An example remote plugin}

Save the following contents as a Racket file in the @code{rplugin/racket}
subdirectory of one of your runtime directories (e.g. @code{~/.config/nvim}).

@racketblock[
   (require nvim)

   (define calls 0)
   (define (increment-calls!)
     (cond
       [(= calls 5) (raise "Too many calls!")]
       [else (set! calls (add1 calls))]))


   (nvim-command "Cmd" #:range "" #:nargs #\* #:sync #t
     (λ (args range)
       (increment-calls!)
       (send (current-nvim-instance) set-current-line
         (format "Command: Called ~a times, args: ~a, range ~a"
                 calls args range)))) 

   (nvim-autocmd "BufEnter" #:pattern "*.rkt" #:eval "expand('<afile>')" #:sync #t
     (λ (filename)
       (increment-calls!)
       (send (current-nvim-instance) set-current-line
         (format "Autocmd: Called ~a times, file: ~a" calls filename))))

   (nvim-function "Func"
     (λ (args)
       (increment-calls!)
       (send (current-nvim-instance) set-current-line
         (format "Function: Called ~a times, args: ~a" calls args))))]

Now restart Neovim and execute @code{:UpdateRemotePlugins}. Restart Neovim one
more time and you will be able to use the function, command and auto-command
defined in this remote plugin. Notice how we use the
@racket[current-nvim-instance] parameter as a target for our API calls.


@section{Defining remote plugins}

A remote plugin can define functions, commands and auto-commands for Neovim.
Each of these is represented by a Racket callback function which gets called
with the necessary arguments applied.

Each of the following procdures takes in a name, a function and a number of
keyword arguments. The name is the name under which the function or command
will be registered in Neovim and the same restrictions apply as for all
user-defined functions and commands in Neovim.

All procedures have a @code{#:sync} keyword argument; if it is true the remote
call will be synchronous, otherwise it will be asynchronous.

@margin-note{
  I am not yet sure about the arity of callback procedures, so take that
  information with a grain of salt.
}


@defproc[(nvim-function [name string?]
                        [proc procedure?]
                        [#:range range? boolean? #f]
                        [#:eval eval (or/c void? string?) (void)]
                        [#:sync sync? boolean? #t])
         any]{
  Defines a Neovim function call by the name @racket[name], which has to be a
  valid Neovim function name. If @racket[range?] is true then @racket[proc] has
  arity two, otherwise it has arity one.

  @racket[proc] is a procedure of one or two arguments; the first argument is a
  vector of arguments passed to the Neovim function, the second argument (if
  applicable) is a vector of two integers: the first in is the first line of
  the range, the second one is the last line of the range. The result of
  @racket[proc] will be returned by the RPC call.

  If @racket[sync] is false the function call will not block Neovim, but Neovim
  will not receive the return value of @racket[proc], it will use some default
  value like @racket[0] instead. Asynchronous functions are only useful for
  their side effects.
}


@defproc[(nvim-command [name string?]
                       [proc procedure?]
                       [#:nargs nargs (or/c 0 1 #\* #\? #\+) 0]
                       [#:complete complete (or/c #f string?) #f]
                       [#:range range (or/c #f #t #\% exact-nonnegative-integer?) #f]
                       [#:count count (or/c #f exact-nonnegative-integer?) #f]
                       [#:bang bang? boolean? #f]
                       [#:register register? boolean? #f]
                       [#:eval eval (or/c void? string?) (void)]
                       [#:sync sync? boolean? #t])
          any]{
  Defines a Neovim command by the name @racket[name], which has to be a valid
  Neovim command name. The default arity of @racket[proc] is zero, but if some
  keyword arguments are different from their default value the arity is
  increased by one for each.  The order of arguments is the same as the
  following order of their descriptions.

  @racket[nargs] is either @racket[0] (no arguments), @racket[1] (exactly one
  argument), @racket[#\*] (any number of arguments), @racket[#\?] (zero or one
  arguments), or @racket[#\+] (at least one arguments). The arguments will be
  passed as a @racket[vector] to @racket[proc] (unless @racket[nargs] is
  @racket[0], in which case nothing will be passed).

  @racket[complete] is a string describing the completetion method (see
  @code{:h :command-completetion}). This argument does not affect the arity of
  @racket[proc].

  @racket[range] and @racket[count] are mutually exclusive, and both increase
  the arity of @racket[proc] by one. The @racket[range] is either @racket[#f]
  (no range) allowed, @racket[#t] (range allowed), @racket[#\%], or an
  @racket[exact-nonnegative-integer?]. The @racket[count] is either @racket[#f]
  (no count) or a @racket[exact-nonnegative-integer?].  See @code{:h
  :command-range} for details. If @racket[count] is given or @racket[range] is
  an integer, one number representing that count is passed as an argument. For
  other values (@racket[#t] and @racket[#\%]) of @racket[range] a vector of two
  numbers is passed, the first one being the first line, the second one the last
  line.

  @racket[bang] is either @racket[#f] (no bang allowed) or @racket[#t] (bang
  allowed). If @racket[#t], an integer will be passed to @racket[proc]
  indicating whether the bang was specified (non-zero) or not (zero).

  @racket[register] is either @racket[#f] (no register allowed) or @racket[#t]
  (register allowed). If @racket[#t], a string containing the register name
  will be passed to @racket[proc]. If no register was given that string will be
  empty.
}

@defproc[(nvim-autocmd [name string?]
                       [proc procedure?]
                       [#:pattern pattern string? "*"]
                       [#:eval eval (or/c void? string?) (void)]
                       [#:sync sync? boolean? #f])
         any]{
  Defines a Neovim auto-command by the name @racket[name], which has to be a
  valid Neovim auto-command name. The arity of @racket[proc] is zero.

  The @racket[pattern] is a string describing the pattern of the auto-command,
  see @code{:h autocmd-patterns} for details.
}


