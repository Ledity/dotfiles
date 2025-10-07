# Dotfiles

This repository contains all dotfiles I want to share within my computers.

Some of the configs are located in separate repositories and added here as submodules, including:

+ [Neovim config](https://github.com/Ledity/nvim-dotfiles.git)
+ [Fish config](https://github.com/Ledity/fish-dotfiles.git)

## How to deploy

To deploy my dotfiles you have to clone this repository. Since the submodule URLs are in SSH-format, you need to add your SSH-key to your profile.

```bash
git clone git@github.com/Ledity/dotfiles.git $HOME/.dotfiles
```

Then, pull the submodules.

```bash
cd $HOME/.dotfiles
git submodule update --init --recursive
```

Now you have to create symlinks for all the files. You can do it by hand or with a bash-script, but the easiest way will be to use GNU Stow utility, which can be found in your distro's repository.

```bash
cd $HOME/.dotfiles
stow .
```

It will smartly create symlinks for every file in your repository.

Stow also gives you an ability to check, if the target directory already contains the conflicting files with option `--simulate`. If the directory already contains such files, delete them and run `stow .` again. It is recommended to switch to `bash` before doing that as fish might create a default config directory after deleting an existing one.
