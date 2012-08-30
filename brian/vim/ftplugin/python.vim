let python_highlight_builtin_objs = 1
let python_highlight_builtin_funcs = 1
" constant=red
highlight link pythonConditional Constant 
highlight link pythonRepeat Constant
highlight link pythonOperator Constant
highlight link pythonPreCondit Constant 
highlight link pythonException Constant 


" special=orange
highlight link pythonHexNumber Special
highlight link pythonOctNumber Special
highlight link pythonBinNumber Special
highlight link pythonNumber Special
highlight link pythonFloat Special
highlight link pythonBuiltinObj Special 

" identifier=blue 
highlight link pythonStatement Identifier 

" Type=green
highlight link pythonFunction Type 

" Function=pink
highlight link pythonBuiltinFunc Function 


" PEP 8

set expandtab
set tabstop=8
set softtabstop=4
set shiftwidth=4
set autoindent
