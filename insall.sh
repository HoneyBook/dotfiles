#!/bin/bash

excluded=(. .. .git .gitignore bootstrap.sh Gemfile Gemfile.lock Rakefile README.md rvm)
dotfiles=( $(ls -a files/) )

# back up old profile files

backupdir="$HOME/.dotfiles-backup/$(date "+%Y%m%d%H%M.%S")"
mkdir -p backupdir

# for file in "${dotfiles[@]}"; do
#  in_array $file "${excluded[@]}" || cp -Rf "$HOME/$file" "$backupdir/$file"
#done
