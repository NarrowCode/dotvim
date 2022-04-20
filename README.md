# VIM Dotfile collection

Personal project to sync up vim dotfiles across different computers.

## Installation guide
**Initial GIT setup:**

  git clone git@github.com:zt0ne/dotvim.git ~/.vim

**Create symlinks:**

  ln -s ~/.vim/vimrc ~/.vimrc
  ln -s ~/.vim/tmux.conf ~/.tmux.conf

**Switch to ~/.vim and fetch submodules:**

  cd ~/.vim
  git submodule init
  git submodule update

**Windows (nvim) configuration:**

  There is an issue with git ssh credentials on Windows when working
  with submodules. Change the module paths found in `.git/config` to
  the https URLs and everything should work.

  The default path for nvim on Windows is `C:\Users\...\Appdata\Local\nvim`, 
  in order to get the plugins to work create symlinks to the repo folder.

  ```
  mklink /J C:\Users\...\Appdata\Local\nvim\autoload C:\Users\...\dotvim\autoload
  mklink /J C:\Users\...\Appdata\Local\nvim\bundle C:\Users\...\dotvim\bundle
  mklink C:\Users\...\Appdata\Local\nvim\init.vim C:\Users\...\dotvim\vimrc
  ```

**COC Configuration:**
  After fetching the coc submodule, it needs to be compiled using `npm install`,
  or `yarn install`, respectively - afterwards, it should be properly recognized 
  by Pathogen.

  In order to retrieve additional packages, open nvim and use the following 
  commands:
  ```vim
  " Default web plugins
  :CocInstall coc-json coc-tsserver coc-html coc-css

  " Marketplace for finding additional packages
  :CocInstall coc-marketplace

  " Search marketplace
  :CocList marketplace <search_term>

  " Navigate marketplace with arrow keys and press TAB to choose.
  ```
