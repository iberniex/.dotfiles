# NVIM (neo vi Improved)

So the backstory, 

I wanted to increase my typing speed and was getting clouded with alot of keybindings and settings in my VS code.
Then I started going through using everything in my terminal cause I was so weird just using terminal instances in vscode, zed, everywhere.

So I took up on nvim but without learning vim but try to learn vim first( it realy fun learning vim script ).
But it is really good, try it!

This contains the keybindings and plugins involved to prevent any confusion.

## Global Keybinds
- [lazy.nvim](lua/plugins/nvim-telescope.lua)

| Keybinding | Name | description |
| ------------- | -------------- | -------------- |
|jj  | escape sequence | <ESC> binding. I got tired of using <ESC> and <C-c> |
| "  " | mapleader | a mapping which uses the "g:mapleader" variable |
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
- [toggleterm.nvim](lua/plugins/toggleterm.lua)

| Keybinding | Name | description |
| ------------- | -------------- | -------------- |
|<leader>tt  | open terminal | opening a terminal to the current buffer |
| <leader><Esc> | close terminal | close the terminal created|


## ZK Keybinds
- [zk.nvim](lua/plugins/zk.lua)

| Keybinding | Mode | Name | description |
| ------------- | -------------- | -------------- | -------------- |
|zf | Normal  | creating a fleeting note | a fleet note is created in normal mode|
|zl | Normal  | creating a literature note | a literature note is created in normal mode|
|zft | Visual  | creating a fleeting note from title selection | a fleeting note is created in visual mode|
|zlt | Visual  | creating a literature note from title selection | a permanent note is created in visual mode|
|zfc | Visual  | creating a fleeting note from content selection | a fleeting note is created in visual mode|
|zlc | Visual  | creating a literature note from content selection | a literature note is created in visual mode|
|<leader>zff | Normal  | list of notes | displays a list of notes |
|<leader>zfb | Normal  | list all note buffers | displays the note buffers in play |
|<leader>zbl | Normal  | show possible links | displays a list of links notes|
|<leader>zll | Normal  | creating a fleeting note | a fleet note is created in normal mode|
|zm | Visual  | show possible matches | show possible matches in the grabbed selection|
|zt | Normal  | show possible tags | show possible tags|
|zcd | Normal  | cd to ZK DIR | goes to the ZK root directory |
|zll | Normal  | Insert link | insert link in the current position |
|zil | Visual  | Insert Link | insert link in the current selection|

