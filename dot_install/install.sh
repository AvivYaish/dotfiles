#!/bin/zsh

# Install everything
if [ ! -d ${local_bin} ]; then
  mkdir -p ${local_bin}
fi

if ! test -f ${local_bin}/antigen.zsh; then
  curl -L git.io/antigen > ${local_bin}/antigen.zsh
fi

# zap
curl https://raw.githubusercontent.com/srevinsaju/zap/main/install.sh | bash -s # Install zap
for app in firefox pomotroid; do
  if ! command -v ${app} &> /dev/null; then
    zap install ${app}
  fi
done

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
for app in neovim chezmoi zoxide rs/tap/curlie bat lsd git-delta ripgrep sd universal-ctags tealdeer fd nvm byobu fzf lf procs bottom glow googler; do
  case ${app} in
    rs/tap/curlie)      appCommand="curlie";; # A curl front-end inspired by HTTPie
    git-delta)          appCommand="delta";;  # Snazzier 'diff', with One Half Dark support
    universal-ctags)    appCommand="ctags";;  # If your ctags is outdated, this is required for VIM's tagbar
    ripgrep)            appCommand="rg";;     # Faster, better 'grep'!
    tealdeer)           appCommand="tldr";;   # A good companion for 'man', with succint descriptions and useful examples
    nvm)                appCommand="${local_bin}/homebrew/opt/nvm/nvm-exec";; # nvm is used to install node, which is required by nvim-coc, a plugin for programming language server protocols (for autocompletions, etc').
    *)                  appCommand=${app};;
  esac
  if ! command -v ${appCommand} &> /dev/null; then
    brew install ${app}
  fi
done

# pip
for app in epy-reader ptpython euporie visidata pynvim; do
  case ${app} in
    epy-reader)         appCommand="epy";;      # A curl front-end inspired by HTTPie
  esac
  if ! command -v ${appCommand} &> /dev/null; then
    pip install ${app}
  fi
done

# Bat and delta require some other modifications:
# See where bat's config file is (`bat --config-file`), and take my config there (from `.config`)
chezmoi init https://github.com/AvivYaish/dotfiles.git
chezmoi apply -v

# Set up neovim to use ~/.vimrc
vim -c "call mkdir(stdpath('config'),'p')" -c "call writefile(['set runtimepath^=~/.vim runtimepath+=~/.vim/after', 'let &packpath = &runtimepath', 'source ~/.vimrc'], stdpath('config').'/init.vim', 'a')" +qall 

# Set up byobu's .tmux.conf
[[ $(diff ~/.tmux.conf ~/.byobu/.tmux.conf) ]] && cp .tmux.conf .byobu/.tmux.conf  # if your .tmux.conf file is not in the correct place
