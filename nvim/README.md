# NVIM (neo vi Improved)

So the backstory, I wanted to increase my typing speed and was getting clouded with alot of keybindings and settings in my VS code.
Then I started going through using everything in my terminal cause I was so weird just using terminal instances in vscode, zed, everywhere.

So I took up on nvim but without learning vim but try to learn vim first( it realy fun learning vim script ).
But it is really good, try it!

This contains the keybindings and plugins involved to prevent any confusion.

## Global Keybinds

| Keybinding | Name | description |
| ------------- | -------------- | -------------- |
|jj  | escape sequence | <ESC> binding. I got tired of using <ESC> and <C-c> |
| " " | mapleader | a mapping which uses the "g:mapleader" variable |
| "//" | maplocalleader | used for mappings which are local to a buffer. |
| <leader>ww | save current buffer | to save the current buffer |
| <leader>wq | save and quit | save and quit the current buffer |
| <leader>wa | save all buffers | save all active buffers |
| <leader>qq | quit | quit neovim  |


## Telescope Keybinds
- [telescope.nvim](lua/plugins/nvim-telescope.lua)

| Keybinding | Name | description |
| ------------- | -------------- | -------------- |
|<leader>ff  | Find Files | telescope find files|
| <leader>fb | Live Grep | finds the string match in current file directory |
| <leader>fh | Help Tags | Telescopt help tags really helpful for searching tags |


## Terminal Keybinds
- [toggleterm.lua](lua/plugins/toggleterm.lua)

| Keybinding | Name | description |
| ------------- | -------------- | -------------- |
|<leader>tt  | open terminal | opening a terminal to the current buffer |
| <leader><Esc> | close terminal | close the terminal created|
