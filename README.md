# FZL
FZL is keystroke-launcher like Alfred/[dmenu](https://github.com/aario/dmenu). It creates a terminal window to display a selection interface defined by fzs.

[fzs](#https://github.com/squirreljetpack/fzs) is a flexible framework for organizing collections of executables. Point it to your script folder, and it will namespace them, and generate a selection [widget](#https://linux.die.net/man/1/zshzle) for them.

```
image
```

FZL sets up a floating terminal window to run fzs in non-widget mode, and provides a smooth entrypoint to capabilities such as quickly running one-off commands, launching files, applications, and [more](#examples). 


# Installation

```shell
sudo install.zsh # installs into /etc/fzl and /usr/local/bin/fzl
```
or
```shell
sudo INSTALL_PATH=~/.local/bin/fzl FZS_DATA_DIR=$FZS_DATA_DIR install.zsh # for a user-specific installation with custom FZS_DATA_DIR. Writing the default configurations still requires root.
```



## Dependencies

**[fzs](#https://github.com/squirreljetpack/fzs)**, for generating "plugins" for your scripts, and
*[fzf](#https://github.com/junegunn/fzf)*, which draws the selector interface defined by them.


##### macOS

- alacritty

(For window management: )
- yabai
- jq


##### X11

- alacritty

(For window management: )
- wmctrl
- xdotool
- xwininfo


# Getting Started

1. Install [dependencies](#dependencies)

2. Install fzs plugins

```shell
cargo install fzs

# install from a repository
fzs install squirreljetpack/fzs-basic-plugins

# Optionally, create your own plugin:
mkdir .fzs/my-plugin
echo 'echo Greetings; read' > .fzs/my-plugin/name_alias_description
echo 'echo Goodbye; sleep 5' > ".fzs/my-plugin/bye_gb_fare thee well"
```

3. Run `fzl m._select.wg` to launch the main selector. Binding the command to a hotkey is recommended.

# Images

###### Application launch

- open/reveal

###### File search

- bookmarks
- files

###### Previews

- plugins
- files
- config

###### Scratchpad

- monitor -> pueue -> summary

###### Other

- explain
- procs + code
- more screenshots
  - mac system prefs

- Package:
  - utils: o, pu.add
  - docker
  - main
    - find
    - fzf
    - fns: window/app (yabai dependency)
    - system
      - simple aliases
  - misc
    - explain
  - monitor
    - btop
    - procs
    - daemons (todo)

# Examples

### docker

### app launcher

### file launcher

### Launch clipboard in mpv

### Command preview

### Status previews

# Configuration

Configuration file are read from `$XDG_CONFIG_HOME/fzl`, falling back to `~/.config/fzl`.

Run `fzl dump <file>` to copy the file containing the default values into the configuration folder.

###### settings.env

This file controls the setup of the terminal window.

###### start.zshrc

This file configures the initialization of the terminal session. It should source your fzs initialization files.

###### start_opts.zshrc

This file configures the behavior of the selection interface. The default file configures keybinds and appearances via `FZF_DEFAULT_OPTS`. This file is sourced after start.zshrc.

###### scratch.env

This file configures the behavior of the scratch terminal.

The scratch terminal is accessible by accepting any command with `alt-enter`, or by appropriately defined actions. It's main purpose is to auto-close the terminal after a command is run but can be further configured.

# Todo

- [ ] Images and video
- [ ] complete fzs integration
- [ ] Custom terminal
- [ ] completions
- [ ] Packaging
  - Customizable install (directory)?