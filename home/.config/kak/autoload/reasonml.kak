
hook global BufCreate .*[.](re|rei) %{
  set-option buffer filetype reasonml
}

add-highlighter shared/ regions -default code reasonml  \
    string '"'    (?<!\\)(\\\\)*" '' \
    comment       /\*    \*/             '' \

add-highlighter shared/reasonml/string fill string
add-highlighter shared/reasonml/comment       fill comment

hook -group reasonml-highlight global WinSetOption filetype=reasonml %{
  add-highlighter window ref reasonml
}
hook -group reasonml-highlight global WinSetOption filetype=(?!reasonml).* %{
  remove-highlighter window/reasonml
}
