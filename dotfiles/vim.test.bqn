⟨Main⟩←•Import "vim.bqn"

lf←@+10
•SHow "--"
#•Show "comment"‿"#%s" Main "        foo bar baz    "
#•SHow "comment"‿"#%s" Main "       #foo bar baz    "
"comment"‿"#%s" Main ∾⟨"       should comment    ",lf," #should not uncomment"⟩
"comment"‿"#%s" Main ∾∾⟜lf¨"  #should uncomment    "‿"  should not comment"‿" "‿"  #should uncomment"

