

hook global BufCreate .*[.](re?i) %{
  set-option buffer filetype reasonml
}

hook -group reasonml-highlight global WinSetOption filetype=reasonml %{ add-highlighter window/reasonml ref reasonml }
hook -group reasonml-highlight global WinSetOption filetype=(?!reasonml).* %{ remove-highlighter window/reasonml }



