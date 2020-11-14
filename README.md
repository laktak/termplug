
# TermPlug

This is a "plugin" to preview files and videos from a terminal file manager, like ranger.

Previewing in the terminal works for some emulators but it often has drawbacks (like not working inside tmux) and is not very fast.

TermPlug is a native app that runs on top (in front of) the terminal and can preview images, videos, pdfs, etc.

## Installation

### TermPlug.app

Open the `macos` folder in Terminal and run `./build-dist` to build the app and `./install` to copy it to `/Applications`

### Bash

Copy `bash/termplug` to `~/.local/bin/termplug`.

```
mkdir -p ~/.local/bin
cp bash/termplug ~/.local/bin/termplug
```

If `~/.local/bin` is not in your path add

```
export PATH=$PATH:~/.local/bin
```

to your `~/.bashrc`.

### Ranger

Copy the `ranger/commands.py` and the `ranger/plugins/` directory to `~/.config/ranger`.

If you already have a `~/.config/ranger/commands.py` file you can add the imports and the two functions to it.

In `~/.config/ranger/rc.conf` map a key (like `\`) to toggle termplug:

```
map \ toggle_termplug
```
