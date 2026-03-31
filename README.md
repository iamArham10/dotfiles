# Dotfiles

This repository contains my personal dotfiles, for Arch-based Linux distributions with Wayland compositors. The structure is organized for simplicity, so you can easily pick and use configurations for Neovim, Hyprland, terminals, and more.

## Structure

```
.
├── editors/                 # Text editors configs
│   ├── nvim/               # Neovim (full IDE setup)
│   └── ideavim/            # IdeaVim (IntelliJ Vim emulation)
│
├── wayland/                 # Wayland compositor configs
│   ├── hyprland/           # Hyprland configs
│   ├── sway/               # Sway configs
│   ├── waybar/             # Waybar (status bar)
│   └── swaync/             # SwayNC (notifications)
│
├── terminals/               # Terminal emulator configs
│   ├── ghostty/            # Ghostty terminal
│   └── alacritty/          # Alacritty terminal
│
├── cli/                     # Command-line tool configs
│   ├── zsh/                # Zsh shell
│   ├── git/                # Git
│   ├── tmux/               # Tmux
│   ├── lazygit/            # Lazygit
│   └── yazi/               # Yazi file manager
│
├── apps/                    # Apps configs
│   ├── zathura/            # Zathura PDF viewer
│   ├── fuzzel/             # Fuzzel launcher
│   ├── wofi/               # Wofi launcher
│   └── rofi/               # Rofi launcher
│
├── keyboard/                # Keyboard remapping
│   └── keyd/               # Colemak-DH Wide layout
│
└── scripts/                 # Useful scripts
    ├── grid-nav.sh         # Grid navigation script
    ├── fuzzel-search.sh    # Fuzzel file search
    ├── toggle-laptop-keyboard.sh # Toggle laptop keyboard on/off
    └── cycle-monitor.sh    # Switch notifications monitor
```

## Usage

### Neovim

```bash
ln -sf ~/dotfiles/editors/nvim ~/.config/nvim
```

### Hyprland

```bash
ln -sf ~/dotfiles/wayland/hyprland ~/.config/hypr
```

### Zsh

```bash
ln -sf ~/dotfiles/cli/zsh/.zshrc ~/.zshrc
```

## License

This repository is available under the MIT License.

