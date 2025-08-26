# Load NVM if our shell is not interactive. If it is interactive, it will be
# lazy-loaded in .zshrc.
if ! [[ -o interactive ]]
then
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
fi
