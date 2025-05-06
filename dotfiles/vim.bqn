lf←@+10
ws←' '∾@+9

Comment⇐{ 𝕨 𝕊 in:
  c←{𝕩/˜¬((⊢∨»)≠∘⊢↑"%s"⊸⍷)𝕩}⊑𝕨
  l←1⊸↓¨(⊣⊔˜·+`lf⊸⍷)in # split into lines
  g←>(2⊸↑(⌈`' '⊸≠)⊸⊔)¨l # split into table of leading whitespace and non-whitespace
  t←{c≡(≠c)↑1⊑𝕩}˘g # mark toggle values
  f←(1=⊑t)⊑(c⊸∾)‿(1⊸↓) # pick toggle function 
  v←F¨⌾(((⊣=⊑)t)⊸/) 1⊏⍉g # apply toggle 
  •Show ∾¯1↓∾⟜lf¨v∾˜¨⊏⍉g
}

# TODO BF


# main
t←>⟨
  ⟨"comment"⟩
  ⟨Comment  ⟩
⟩

Main⇐{
  •Show 𝕩
  •SHow •FLines "/dev/stdin"
  #f←(1⊏t)⊑˜⟨⊑𝕨⟩⊐˜⊏t⋄(1↓𝕨)F𝕩
}

# TODO read from stdin and print •Out
Main⍟(0⊸<≠) •args
