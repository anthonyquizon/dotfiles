⟨Main⟩←•Import "vim.bqn"

"comment"‿"#%s" Main "        foo bar baz    "

#R←{
#  # TODO 𝕨 acc
#  l←•file.List 𝕩
#  •Show l
#  𝕊¨l/˜'d'=•file.Type¨l
#}
#
#R "."

# filter files in gitignore?
