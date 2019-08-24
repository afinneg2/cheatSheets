#!/bin/bash

## This script sets aliases for opening referece documents. To use add the following line to bashrc
## source /path/to/this/dir/aliases.sh 


path=$(dirname $BASH_SOURCE )
alias quickRef="open  $path/quickRef.md"
alias quickRef_git="open  $path/quickRef_git.md"
alias quickRef_conda="open $path/conda-cheatsheet.pdf"
alias quickRef_pyPackages="open $path/quickRef_pyPackages.md"
