EDITOR=vim
export EDITOR
PATH=$PATH:/usr/local/sbin
export PATH

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s /Users/kreedy/.nvm/nvm.sh ]] && . /Users/kreedy/.nvm/nvm.sh # This loads NVM
