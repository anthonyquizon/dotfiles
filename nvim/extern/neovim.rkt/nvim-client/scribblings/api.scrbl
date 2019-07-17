#lang scribble/manual
@(require (for-label racket nvim msgpack))

@title{Neovim API}

The Neovim API is exposed through an object-oriented interface in Racket. A
Neovim instance is represented as an instance of the @racket[nvim%] class, and
its buffers, windows and tab pages are represented as instances of the
@racket[buffer%], @racket[window%] and @racket[tabpage%] classes respectively.
Global API calls are implemented as methods of @racket[nvim%], and API calls to
buffers, windows and tab pages are implemented as methods of their respective
classes.

As a general rule, method names are the same as the API function names, except
that underscores (@code{_}) have been replaced by hyphens (@code{-}), the
prefixes (e.g. @code{nvim_} or @code{nvim_buf_}) have been stripped away and
API calls returning a boolean value (predicates) have a question mark
(@code{?}) appended. For example, @code{nvim_buf_is_valid} becomes
@code{is-valid?}, and instead of providing a buffer ID as the first argument
the method is sent to the buffer object in question.

You do not instantiate API object from their constructors directly, they are
returned to you by functions like @racket[nvim-attach] or methods of other API
objects like @racket[get-current-buf].

@#reader scribble/comment-reader
  (racketblock
    ;; Attach to a Neovim instance and keep the return value
    (define nvim (nvim-attach in out))
    ;; Get a reference to the current buffer
    (define current-buf (send nvim get-current-buf))
    ;; Set the name of the current buffer
    (send current-buf set-name "Main Buffer")
)

Should an object become invalid (e.g. the @racket[window%] handle of a window
that has been closed), sending it a message will result in an RPC error.

All API methods can be called in a synchronous (blocking) or asynchronous
(non-blocking) way by providing the optional @code{#:async} keyword argument.
The default is always asynchronous. Asynchronous calls never return a value, so
calling a pure getter method makes little sense, but it is technically possible.

@section{Classes}

If a method is lacking documentation please refer to the Neovim API reference
(@code{:h api}) for details. There is no point in repeating the same thing here
as well.

@defclass[nvim% object% ()]{
  Represents a Neovim instance.

  @defmethod[(request [method string?] [param any/c] ...) any/c]{
    Perform a raw RPC request with procedure name @racket[method] and procedure
    argument @racket[param]. The result is whatever the remote procedure
    returns back over the connection. Blocks until a result is returned.

    In practice you should not have to call this method yourself, use the API
    methods instead. They have the proper signature, take a fixed number of
    arguments and specify more accurate contracts.
  }

  @defmethod[(notify [method string?] [param any/c] ...) void]{
    Similar to @racket[request], except no value is returned and execution does
    not block after the RPC message has been sent off.
  }

  @defmethod[(command [cmd string?] [#:async async? boolean? #f]) void]{
	Execute the ex-command @racket[cmd].
  }

  @defmethod[(get-hl-by-name [name string?] [rgb? boolean?] [#:async async? boolean? #f]) hash?]{
    Gets a highlight definition by @racket[name]. If @racket[rgb?] is true,
    then the colour is an RGB value.
  }

  @defmethod[(get-hl-by-id [id integer?] [rgb? boolean?] [#:async async? boolean? #f]) hash?]{
    Gets a highlight definition by @racket[id]. If @racket[rgb?] is true,
    then the colour is an RGB value.
  }

  @defmethod[(feedkeys [keys string?] [mode string?] [escape-csi? boolean?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(input [keys string?] [#:async async? boolean? #f]) integer?]{
  }

  @defmethod[(replace-termcodes [str string?] [from-part? boolean?] [do-lt? boolean?] [special? boolean?] [#:async async? boolean? #f]) string?]{
  }

  @defmethod[(command-output [str string?] [#:async async? boolean? #f]) string?]{
  }

  @defmethod[(eval [expr string?] [#:async async? boolean? #f]) packable?]{
  }

  @defmethod[(call-function [fname string?] [args (vector packable?)] [#:async async? boolean? #f]) packable?]{
  }

  @defmethod[(execute-lua [code string?] [args (vector packable?)] [#:async async? boolean? #f]) packable?]{
  }

  @defmethod[(strwidth [text string?] [#:async async? boolean? #f]) integer?]{
  }

  @defmethod[(list-runtime-paths [#:async async? boolean? #f]) (vectorof string?)]{
  }

  @defmethod[(set-current-dir [dir string?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(get-current-dir [#:async async? boolean? #f]) string?]{
  }

  @defmethod[(set-current-line [line string?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(get-current-line [#:async async? boolean? #f]) string?]{
  }

  @defmethod[(del-current-line [#:async async? boolean? #f]) void]{
  }

  @defmethod[(set-var [name string?] [value packable?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(get-var [name string?] [#:async async? boolean? #f]) packable?]{
  }

  @defmethod[(del-var [name string?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(get-vvar [name string?] [#:async async? boolean? #f]) packable?]{
  }

  @defmethod[(set-option [name string?] [value packable?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(get-option [name string?] [#:async async? boolean? #f]) packable?]{
  }

  @defmethod[(out-write [str string?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(err-write [str string?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(err-writeln [str string?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(list-bufs [#:async async? boolean? #f]) (vectorof (instanceof/c buffer%))]{
  }

  @defmethod[(get-current-buf [#:async async? boolean? #f]) (instanceof/c buffer%)]{
  }

  @defmethod[(set-current-buf [buffer (instanceof/c buffer% [#:async async? boolean? #f])]) void]{
  }

  @defmethod[(list-wins [#:async async? boolean? #f]) (vectorof (instanceof/c window%))]{
  }

  @defmethod[(get-current-win [#:async async? boolean? #f]) (instanceof/c window%)]{
  }

  @defmethod[(set-current-win [window (instanceof/c window% [#:async async? boolean? #f])]) void]{
  }

  @defmethod[(list-tabpages [#:async async? boolean? #f]) (vectorof (instanceof/c tabpage%))]{
  }

  @defmethod[(get-current-tabpage [#:async async? boolean? #f]) (instanceof/c tabpage%)]{
  }

  @defmethod[(set-current-tabpage [tabpage (instanceof/c tabpage% [#:async async? boolean? #f])]) void]{
  }
  
  @defmethod[(subscribe [event string?] [#:async async? boolean? #f]) void]{
  }
  
  @defmethod[(unsubscribe [event string?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(get-color-by-name [name string?] [#:async async? boolean? #f]) integer?]{
  }

  @defmethod[(get-color-map [#:async async? boolean? #f]) hash?]{
  }

  @defmethod[(get-mode [#:async async? boolean? #f]) hash?]{
  }

  @defmethod[(get-keymap [mode string?] [#:async async? boolean? #f]) (vectorof hash?)]{
  }

  @defmethod[(get-api-info [#:async async? boolean? #f]) vector?]{
  }

  @defmethod[(call-atomic [calls vector?] [#:async async? boolean? #f]) vector?]{
  }

  @defmethod[(ui-attach [width integer?] [height integer?] [options hash?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(ui-detach [#:async async? boolean? #f]) void]{
  }

  @defmethod[(ui-try-resize [width integer?] [height integer?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(ui-set-option [name string?] [value packable?] [#:async async? boolean? #f]) void]{
  }
}

@defclass[buffer% object% (printable<%>)]{
  Represents an instance of a Neovim buffer.

  @defmethod[(line-count [#:async async? boolean? #f]) integer?]{
  }

  @defmethod[(get-lines [start integer?] [end integer?] [strict-indexing? boolean?] [#:async async? boolean? #f]) (vectorof string?)]{
  }

  @defmethod[(set-lines [start integer?] [end integer?] [strict-indexing? boolean?] [replacement string?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(get-var [name string?] [#:async async? boolean? #f]) packable?]{
  }

  @defmethod[(set-var [name string?] [value packable?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(del-var [name string?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(get-chagedtick [#:async async? boolean? #f]) integer?]{
  }

  @defmethod[(get-keymap [mode string?] [#:async async? boolean? #f]) (vectorof hash?)]{
  }

  @defmethod[(get-option [name string?] [#:async async? boolean? #f]) packable?]{
  }

  @defmethod[(set-option [name string?] [value packable?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(get-name [#:async async? boolean? #f]) string?]{
  }

  @defmethod[(set-name [name string?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(is-valid? [#:async async? boolean? #f]) boolean?]{
  }

  @defmethod[(get-mark [name string?] [#:async async? boolean? #f]) (vector/c integer? integer? #:flat #t #:immutable #t)]{
  }

  @defmethod[(add-highlight [src-id integer?] [hl-group string?] [line integer?] [col-start integer?] [col-end integer?] [#:async async? boolean? #f]) integer?]{
  }

  @defmethod[(clear-highlight [src-id integer?] [line-start integer?] [line-end integer?] [#:async async? boolean? #f]) void]{
  }
}

@defclass[window% object% (printable<%>)]{
  Represents an instance of a Neovim window.

  @defmethod[(get-buf [#:async async? boolean? #f]) (is-a?/c buffer%)]{
  }

  @defmethod[(get-tabpage [#:async async? boolean? #f]) (is-a?/c tabpage%)]{
  }

  @defmethod[(get-cursor [#:async async? boolean? #f]) (vector/c integer? integer? #:flat #t #:immutable #t)]{
  }

  @defmethod[(get-height [#:async async? boolean? #f]) integer?]{
  }

  @defmethod[(set-height [height integer?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(get-width [#:async async? boolean? #f]) integer?]{
  }

  @defmethod[(set-width [width integer?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(get-var [name string?] [#:async async? boolean? #f]) packable?]{
  }

  @defmethod[(set-var [name string?] [value packable?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(del-var [name string?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(get-option [name string?] [#:async async? boolean? #f]) packable?]{
  }

  @defmethod[(set-option [name string?] [value packable?] [#:async async? boolean? #f]) void]{
  }

  @defmethod[(get-position [#:async async? boolean? #f]) (vector/c integer? integer? #:flat #t #:immutable #t)]{
  }

  @defmethod[(get-number [#:async async? boolean? #f]) integer?]{
  }

  @defmethod[(is-valid? [#:async async? boolean? #f]) boolean?]{
  }
}

@defclass[tabpage% object% (printable<%>)]{
  Represents an instance of a Neovim tab page.

  @defmethod[(list-windows [#:async async? boolean? #f]) (vectorof (is-a?/c window%))]{
    Returns a vector of @racket[window%] objects contained in @this-obj[].
  }

  @defmethod[(get-winow [#:async async? boolean? #f]) (is-a?/c window%)]{
    Returns the current window in @this-obj[].
  }

  @defmethod[(get-number [#:async async? boolean? #f]) integer?]{
    Returns the tab page nuber of @this-obj[].
  }

  @defmethod[(get-var [name string?] [#:async async? boolean? #f]) any/c]{
    Returns the value of the tab-local variable @racket[name] in @this-obj[].
  }

  @defmethod[(set-var [name string?] [value any/c] [#:async async? boolean? #f]) void]{
    Sets the value of the tab-local variable @racket[name] in @this-obj[].
  }

  @defmethod[(del-var [name string?] [#:async async? boolean? #f]) any/c]{
    Deletes the value of the tab-local variable @racket[name] in @this-obj[].
  }

  @defmethod[(is-valid? [#:async async? boolean? #f]) boolean?]{
    Checks whether @this-obj[] is valid.
  }
}
