#!/bin/bash

set -e

pushd "$HOME/.zsh/plugins/workdir/repos/https-COLON--SLASH--SLASH-github.com-SLASH-olivierverdier-SLASH-zsh-git-prompt"

stack setup
stack install

popd
