export PYTHONSTARTUP=~/.pythonrc
export EDITOR=nvim
export DEVELOPMENT=$HOME/Development
export NPM_PATH=$HOME/.npm-packages/bin

export PYTHON2_PATH=$(python3 -m site --user-base)/bin
export PYTHON3_PATH=$(python3 -m site --user-base)/bin
export YARN_PATH=$HOME/.config/yarn/global/node_modules/.bin
export PATH=$PATH:$HOME/.cargo/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PYTHON3_PATH:$PYTHON2_PATH:$YARN_PATH:$NPM_PATH
