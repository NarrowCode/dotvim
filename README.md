# VIM Dotfile collection

Personal project to sync up vim dotfiles across different computers.

## Installation guide
**Initial GIT setup:**

    git clone git@github.com:zt0ne/dotvim.git ~/.vim

**Create symlinks:**

    ln -s ~/.vim/vimrc ~/.vimrc

**Switch to ~/.vim and fetch submodules:**

    cd ~/.vim
    git submodule init
    git submodule update
