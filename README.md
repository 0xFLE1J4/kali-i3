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
git clone https://github.com/0xFLE1J4/kali-i3.git
cd kali-i3
./install.sh
```

The script will update your system and install all required packages.

## After Installation

1. Reboot your system
2. On the login screen, select **i3** (top right corner)
3. Open a terminal with `$mod+Return`


## Key Bindings
`mod` --> Alt

| Shortcut             | Action                  |
| -------------------- | ----------------------- |
| `$mod+Return`        | Terminal (Alacritty)    |
| `$mod+Space`         | App launcher (Rofi)     |
| `$mod+w`             | Close focused window    |
| `$mod+h/j/k/l`       | Focus (Vim-style)       |
| `$mod+Shift+h/j/k/l` | Move window (Vim-style) |
| `$mod+1..0`          | Switch workspace        |
| `$mod+q`             | Cycle wallpaper         |
| `$mod+p`             | Screenshot (Flameshot)  |
| `$mod+Ctrl+s`        | shutdown                |
| `$mod+Shift+c`       | Reload i3 config        |
| `$mod+Shift+r`       | Restart i3              |
| `$mod+Shift+e`       | Exit i3                 |

## Alacritty
| -------------------- | ----------------------- |
| `Alt+c`              | Copy                    |
| `Alt+v`              | Paste                   |


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
    │   ├── clipboard_fix.sh      # VM clipboard fix
    │   ├── config                # i3 configuration
    │   └── wallpaper.sh          # Wallpaper cycling
    │
    ├── i3blocks/
    │   ├── cpu_useage.sh
    │   └── i3blocks.conf
    │
    ├── picom/
    │   └── picom.conf            # Picom configuration
    │   
    ├── alacritty/
    │   └── alacritty.toml        # Alacritty configuration
    │  
    └── rofi/
        └── config.rasi           # rofi configuration
    
    .wallpaper/               # Drop your wallpapers here


## Final
<img width="1908" height="1036" alt="image" src="https://github.com/user-attachments/assets/c22a12d1-c43c-4c75-9332-be64a2f3279b" />


