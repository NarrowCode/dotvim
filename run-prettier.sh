#!/bin/bash

# Get the absolute path to the file to be formatted
file_path="$2"

# Get the Git root directory of the file's repository
git_root=$(cd "$(dirname "$file_path")"; git rev-parse --show-toplevel 2>/dev/null)

# Change to Git root, or stay in the current directory if not in a Git repository
if [[ -n $git_root ]]; then
    # echo "changing to git root: $git_root" >> ~/.vim/prettier-log.txt
    cd "$git_root" > /dev/null
fi

# Attempt to run local prettier
if yarn prettier --version > /dev/null 2>&1; then
    echo "$(yarn prettier --version) at $(yarn bin prettier) with $@" >> ~/.vim/prettier-log.txt
    yarn prettier "$@" # | tee -a ~/.vim/prettier-exec-log.txt
else
    # Fallback to global prettier
    echo "$(prettier --version) at $(which prettier) with $@" >> ~/.vim/prettier-log.txt
    prettier "$@" # | tee -a ~/.vim/prettier-exec-log.txt
fi
