# Kali-i3 

A customized i3wm setup for Kali Linux, featuring an i3blocks status bar,
rofi as application launcher, and Nerd Fonts for a clean look.

## Requirements

- Kali Linux (Debian-based)
- Non-root user with sudo privileges
- Git installed

## Installation

Clone the repo and run the install script:

```js
git clone git@github.com:0xFLE1J4/kali-i3.git
cd kali-i3
./install.sh
```

The script will update your system and install all required packages.

## After Installation

1. Reboot your system
2. On the login screen, select **i3** (top right corner)
3. Open a terminal with `$mod+Return`


## Key Bindings

| Shortcut             | Action                  |
| -------------------- | ----------------------- |
| `$mod+Return`        | Terminal (Alacritty)    |
| `$mod+Space`         | App launcher (Rofi)     |
| `$mod+w`             | Close focused window    |
| `$mod+h/j/k/l`       | Focus (Vim-style)       |
| `$mod+Shift+h/j/k/l` | Move window (Vim-style) |
| `$mod+1..0`          | Switch workspace        |
| `$mod+c`             | Cycle wallpaper         |
| `$mod+p`             | Screenshot (Flameshot)  |
| `$mod+Shift+c`       | Reload i3 config        |
| `$mod+Shift+r`       | Restart i3              |
| `$mod+Shift+e`       | Exit i3                 |

## What's Included

- **i3** — tiling window manager with gaps
- **i3blocks** — status bar (CPU, RAM, disk, network, time)
- **Rofi** — application launcher
- **Alacritty** — GPU-accelerated terminal
- **Picom** — compositor (transparency, shadows)
- **Feh** — wallpaper manager with auto-cycling
- **Flameshot** — screenshot tool
- **Nerd Fonts** — Iosevka & RobotoMono
- **Oh-My-Zsh** — optional, prompted at end of install

## Structure

    .config/
    ├── i3/
    │   ├── config            # i3 configuration
    │   ├── i3blocks.conf     # Status bar
    │   ├── wallpaper.sh      # Wallpaper cycling
    │   └── clipboard_fix.sh  # VM clipboard fix
    ├── alacritty/
    │   └── alacritty.toml
    └── rofi/
        └── config
    .wallpaper/               # Drop your wallpapers here


## Final
<img width="1901" height="1026" alt="image" src="https://github.com/user-attachments/assets/ec3dcc38-c0cf-4eea-95c8-94047ca0221f" />
<img width="1900" height="624" alt="image" src="https://github.com/user-attachments/assets/9ff4218d-6cfa-4c3d-8583-55c16111af93" />

