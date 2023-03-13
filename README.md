# VIM Dotfile collection

Personal project to sync up vim dotfiles across different computers.

## Installation (LUA)

**Symlinks, Packer (MacOS):**

  ```bash
  ln -s ~/.vim/vimrc ~/.vimrc
  ln -s ~/.vim/tmux.conf ~/.tmux.conf
  ln -s ~/.ideavimrc ~/.vim/.ideavimrc

  ln -s ~/.config/nvim ~/.vim
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  ```

**Symlinks, Packer (Windows):**
Use admin powershell to avoid having a bad time (junction creation).

  ```bash
  cmd /c mklink ~/.ideavimrc ~/.vim/.ideavimrc
  cmd /c mklink /J ~/AppData/Local/nvim ~/.vim
  git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
  ```

**First launch:**
Run `PackerInstall` to load packages :)



---



## Installation guide (V1) - Deprecated

**Initial GIT setup:**

  `git clone git@github.com:NarrowCode/dotvim.git ~/.vim`

**Create symlinks:**

  ```bash
  ln -s ~/.vim/vimrc ~/.vimrc
  ln -s ~/.vim/tmux.conf ~/.tmux.conf
  ```

**Switch to ~/.vim and fetch packages:**

  ```bash
  cd ~/.vim
  ```

**Inside nvim:**
  Run `:PlugInstall` to load plugins and `:PlugUpdate` to update them using vim-pack.

**Mac (OSX) specific configuration**
  In the past, there were some issues with iTerm2 and vim-devicons, as documented
  [here](https://github.com/ryanoasis/vim-devicons/issues/226).
  Fix by grabbing Hack NF from brew:

  ```bash
  brew tap homebrew/cask-fonts
  brew install --cask font-hack-nerd-font
  ```

**Windows (nvim) configuration:**

  There is an issue with git ssh credentials on Windows when working
  with submodules. Change the module paths found in `.git/config` to
  the https URLs and everything should work.

  The default path for nvim on Windows is `C:\Users\...\Appdata\Local\nvim`,
  in order to get the plugins to work create symlinks to the repo folder.

  ```bat
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

  " Other useful extensions
  :CocInstall coc-ltex coc-git coc-markdown-preview coc-webview coc-markdownlint coc-prettier

  " Marketplace for finding additional packages
  :CocInstall coc-marketplace

  " Search marketplace
  :CocList marketplace <search_term>

  " Navigate marketplace with arrow keys and press TAB to choose.
  
  " In :CocConfig, add:
  "diagnostic.checkCurrentLine": true
  ```
