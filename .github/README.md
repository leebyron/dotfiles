# Dotfiles

This is a git repository hosting configuration I share between machines.

It works by a git bare repository hosted within `~/.config/dotfiles` with
a working directory of `~`.

To install:

```sh
git clone git@github.com:leebyron/dotfiles.git --bare ~/.config/dotfiles
dotfiles='/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

The last step may fail with a message about overwriting files, if so make sure
nothing would be lost and rerun with `--force`.

Afterwards, run the `dotfiles` command like you would `git`, for example:

```sh
dotfiles add ~/.config/nvim/init.vim
dotfiles commit -m "Update nvim config"
dotfiles push
```
