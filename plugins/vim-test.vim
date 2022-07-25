let test#strategy = "neovim"
let test#neovim#term_position = "bot 20"

let test#enabled_runners = ["javascript#cypress", "javascript#jest", "go#gotest"]
let test#javascript#cypress#file_pattern = 'e2e/'
let g:test#javascript#jest#file_pattern = '\v.*test\.(js|jsx)$'
