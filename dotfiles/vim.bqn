Comment⇐{
  # TODO get nearest non whitespace
  # TODO assert
  c←{𝕩/˜¬((⊢∨»)≠∘⊢↑"%s"⊸⍷)𝕩}⊑𝕨
  a‿b←2↑((c∾' ')⊸∾)⌾(1⊸⊑)(⌈`' '⊸≠)⊸⊔𝕩
  #⍟c≤○≠◶0‿(⊣≡≠⊸↑)𝕩
}

Foo⇐{ •Show 𝕩
}

# main
t←>⟨
  ⟨"comment", "foo"⟩
  ⟨Comment,    Foo ⟩
⟩

Main⇐{
  •Show "--"
  f←(1⊏t)⊑˜⟨⊑𝕨⟩⊐˜⊏t
  (1↓𝕨) F 𝕩
}

# TODO read from stdin and print •Out
Main⍟(0⊸<≠) •args
