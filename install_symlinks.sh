#!/usr/bin/env bash
set -e

# ==============================================================================
# Dotfiles Symlink & Setup Script
# ==============================================================================

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${HOME}/.config"
LOCAL_BIN="${HOME}/.local/bin"

echo "==> Setting up dotfiles from: ${DOTFILES_DIR}"

mkdir -p "${CONFIG_DIR}"
mkdir -p "${LOCAL_BIN}"

# Helper function to link files or directories safely
link_item() {
    local src="$1"
    local dest="$2"

    if [ -e "${dest}" ] || [ -L "${dest}" ]; then
        if [ -L "${dest}" ] && [ "$(readlink -f "${dest}")" = "$(readlink -f "${src}")" ]; then
            echo "  [OK] ${dest} is already linked."
            return
        fi
        echo "  [REPLACE] Removing existing ${dest}"
        rm -rf "${dest}"
    fi

    echo "  [LINK] ${dest} -> ${src}"
    ln -sfn "${src}" "${dest}"
}

echo ""
echo "--> Linking Shell & CLI dotfiles..."
link_item "${DOTFILES_DIR}/cli/bash/.bashrc" "${HOME}/.bashrc"
link_item "${DOTFILES_DIR}/cli/zsh/.zshrc" "${HOME}/.zshrc"
link_item "${DOTFILES_DIR}/cli/git/.gitconfig" "${HOME}/.gitconfig"
link_item "${DOTFILES_DIR}/cli/tmux/.tmux.conf" "${HOME}/.tmux.conf"
link_item "${DOTFILES_DIR}/cli/tmux/tmux_config" "${CONFIG_DIR}/tmux"
link_item "${DOTFILES_DIR}/cli/starship" "${CONFIG_DIR}/starship"
link_item "${DOTFILES_DIR}/cli/btop" "${CONFIG_DIR}/btop"
link_item "${DOTFILES_DIR}/cli/lazygit" "${CONFIG_DIR}/lazygit"
link_item "${DOTFILES_DIR}/cli/yazi" "${CONFIG_DIR}/yazi"

echo ""
echo "--> Linking Editors & GUI Apps..."
link_item "${DOTFILES_DIR}/editors/nvim" "${CONFIG_DIR}/nvim"
link_item "${DOTFILES_DIR}/apps/zed" "${CONFIG_DIR}/zed"
link_item "${DOTFILES_DIR}/apps/neovide" "${CONFIG_DIR}/neovide"
link_item "${DOTFILES_DIR}/apps/rofi" "${CONFIG_DIR}/rofi"
link_item "${DOTFILES_DIR}/apps/zathura" "${CONFIG_DIR}/zathura"

echo ""
echo "--> Linking Terminals..."
link_item "${DOTFILES_DIR}/terminals/ghostty" "${CONFIG_DIR}/ghostty"
link_item "${DOTFILES_DIR}/terminals/alacritty" "${CONFIG_DIR}/alacritty"

echo ""
echo "--> Linking Wayland & Desktop Environment..."
link_item "${DOTFILES_DIR}/wayland/hypr" "${CONFIG_DIR}/hypr"
link_item "${DOTFILES_DIR}/wayland/waybar" "${CONFIG_DIR}/waybar"
link_item "${DOTFILES_DIR}/wayland/fuzzel" "${CONFIG_DIR}/fuzzel"
link_item "${DOTFILES_DIR}/wayland/swaync" "${CONFIG_DIR}/swaync"
link_item "${DOTFILES_DIR}/wayland/wofi" "${CONFIG_DIR}/wofi"

echo ""
echo "--> Installing custom scripts to ${LOCAL_BIN}..."
if [ -d "${DOTFILES_DIR}/scripts" ]; then
    for script in "${DOTFILES_DIR}/scripts"/*; do
        if [ -f "${script}" ]; then
            sname="$(basename "${script}")"
            link_item "${script}" "${LOCAL_BIN}/${sname}"
            chmod +x "${script}"
        fi
    done
fi

echo ""
echo "--> Checking keyd setup..."
if [ -f "${DOTFILES_DIR}/keyboard/keyd/default.conf" ]; then
    echo "  Keyd configuration found at ${DOTFILES_DIR}/keyboard/keyd/default.conf"
    if [ "$EUID" -ne 0 ]; then
        echo "  To apply keyd on this system, run:"
        echo "    sudo cp ${DOTFILES_DIR}/keyboard/keyd/default.conf /etc/keyd/default.conf"
        echo "    sudo systemctl enable --now keyd"
        echo "    sudo keyd reload"
    else
        mkdir -p /etc/keyd
        cp "${DOTFILES_DIR}/keyboard/keyd/default.conf" /etc/keyd/default.conf
        systemctl enable --now keyd || true
        keyd reload || true
        echo "  [APPLIED] keyd config updated and service reloaded."
    fi
fi

echo ""
echo "==> All dotfiles and symlinks successfully configured!"
