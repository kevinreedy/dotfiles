# kevinreedy's dotfiles

This repo helps me set up a new computer and keep several machines in sync, settings-wise. I've done this various ways over the years, including [configuration management tools](https://github.com/kevinreedy/kreedy_workstation) and [homebrew python scripts to manage symlinks](https://github.com/kevinreedy/dotfiles/blob/0aa30418d5d8ddc665488f17fab6f3548c9f6b8e/install.py). This time around, I'm using a delightful tool called [chezmoi](https://www.chezmoi.io/).

Currently only MacOS is supported, but I'll be adding [Windows / WSL](https://github.com/kevinreedy/dotfiles/issues/10), [Linux](https://github.com/kevinreedy/dotfiles/issues/22), and [GitHub Codespaces](https://github.com/kevinreedy/dotfiles/issues/23) soon.

To set up a computer:
 - Install Xcode Command Line Tools by running `xcode-select --install`
 - Install [Homebrew](https://brew.sh/) by running `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
 - Install [chezmoi](https://www.chezmoi.io/), by running `brew install chezmoi`
 - Run `chezmoi init --apply kevinreedy`

 To simplify installation, I plan to [have chezmoi install Xcode Command Line Tools and Homebrew](https://github.com/kevinreedy/dotfiles/issues/11)
