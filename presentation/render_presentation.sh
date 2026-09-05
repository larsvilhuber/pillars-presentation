#!/bin/bash

# Call this from the main directory, go up a directory if we are in the presentation directory
if [[ $(basename "$PWD") == "presentation" ]]; then
    cd ..
fi

echo "Listing contents of $(pwd):"
ls -al
echo "Listing contents of presentation:"
ls -al presentation

[[ -z $QUARTO_OPTS ]] && QUARTO_OPTS="--output-dir _html"
quarto render presentation/index.qmd $QUARTO_OPTS
