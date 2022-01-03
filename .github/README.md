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
nvim ~/.config/nvim/init.vim
dotfiles add -u
dotfiles commit -m "Update nvim config"
dotfiles push
```

## Notable:

* Karabiner bindings, generated with [a script](.local/karabiner).
* A pretty [neat script](.local/bin/pbshift) to cycle through pasteboards.
* Synced Brew installation via some simple aliases.
  * `brew add` instead of `brew install` to auto update the `~/.Brewfile`
  * `brew remove` instead of `brew uninstall`
  * `brew sync` to sync local state with Brewfile.
  * *Requires running `brew alias` and `brew bundle` once per machine first*
