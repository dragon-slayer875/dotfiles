# Load NVM if our shell is not interactive. If it is interactive, it will be
# lazy-loaded in .zshrc.
if ! [[ -o interactive ]]
then
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
fi

# Exporting terminals
export TERM='kitty'
export TERMINAL='kitty'

# paths
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=$PATH:/home/rudraksht/go/bin
export JAVA_HOME=/opt/android-studio/jbr
export ANDROID_HOME="$HOME/Android/Sdk"
export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$HOME/.cargo/bin:$PATH
export PATH="$HOME/.bun/bin:$PATH"
export PYTHONPATH=/usr/lib/python3.13:/usr/lib/python3.13/lib-dynload

# You may need to manually set your language environment
export LANG=en_US.UTF-8

