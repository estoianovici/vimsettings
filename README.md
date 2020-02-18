# VIM settings

## Plugins
This .vimrc uses [plugged](https://github.com/junegunn/vim-plug) to manage plugins. Any plugin manager would do but this one seems to be the easies to use to me.

The plugins section is split in 3 categories:
 * misc
 * colors
 * dev

### Misc

The MRU plugin is particularly useful. It shows a list of recently open files.
The vim-fontsize plugin allows for quick font adjustment (increase/decrease size) in gvim. I need this because of the mess of having 4k laptop and HD external monitors
The vim-clap plugin is a fuzzy file search. With vim 8.2, it opens a nice modal window where the search happens real time. Really nice

### Colors
I went a bit overboard with colors during the years. Currently I use solarized8 for gvim and the github color scheme for diffs. The terminal vim just uses the default scheme.

### Dev

* nerdtree shows the project folder structure. I used to use it a lot before setting up vim-clap. I don't seem to be using it that much nowadays.
* vim-fugitive is a git plugin. Set it up and then try :Gdiffsplit or :Gblame. You'll never work without it again
* vim-clang-format provides c++ code formatting using clang. You have to have a .clang-format file in your path describing what formatting rules to apply.
* vim-syntax-extra enhances syntax highlighting nicely
* vim-lsc is a language server which is needed for ccls

## Vim settings

This section contains the actual vim modifiers. Most of them are pretty much documented in comments.

The SearchText function can be invoked by pressing F4. To speed up searches, it runs with noautocmd because vim will try to load each file and apply all the plugins if run without it. This means that the first result will be displayed in a vim buffer without any plugins. The user must press :e to reload it with the proper plugins in place
