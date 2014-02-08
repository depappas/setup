#!/bin/bash

# make sure opt exists
if [ ! -d ~/opt ]; then
    mkdir ~/opt
fi

# homebrew
# download if not exists
if [ ! -d ~/opt/homebrew ]; then
    mkdir ~/opt/homebrew
    (cd ~/opt && curl -L https://github.com/Homebrew/homebrew/tarball/master | tar xz --strip 1 -C homebrew)
fi
# load
export HOMEBREW=~/opt/homebrew
export HOMEBREW_CACHE=~/Library/Caches/Homebrew
export PATH=$HOMEBREW/bin:$PATH

# pass
PASS_BASH_COMPLETION=$(brew list pass | grep 'bash_completion')
if [ -f $PASS_BASH_COMPLETION ]; then
    source $PASS_BASH_COMPLETION
fi

export PATH=~/bin:$PATH