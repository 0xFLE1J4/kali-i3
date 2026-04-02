#!/bin/bash

# Script d'installation i3wm complet - Version améliorée
# Testé sur Debian 12 / Ubuntu 22.04+

set -e  # Arrêt sur erreur
set -u  # Erreur sur variable non définie

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

echo_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

echo_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Vérification que le script est dans le bon répertoire
if [ ! -d ".config" ]; then
    echo_error "Dossier .config non trouvé dans le répertoire courant"
    echo_error "Assurez-vous d'exécuter le script depuis le dossier contenant vos configs"
    exit 1
fi

echo_info "Mise à jour du système..."
sudo apt update && sudo apt upgrade -y

echo_info "Installation des outils de base..."
sudo apt-get install -y wget curl git thunar
curl https://sh.rustup.rs -sSf | sh


echo_info "Installation de l'environnement i3..."
sudo apt-get install -y arandr flameshot arc-theme feh i3blocks i3status i3 i3-wm \
    lxappearance python3-pip rofi unclutter cargo compton papirus-icon-theme \
    imagemagick libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev \
    libxcb-util0-dev libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev \
    libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev \
    libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev \
    libxcb-xrm0 libxcb-xrm-dev autoconf meson libxcb-render-util0-dev \
    libxcb-shape0-dev libxcb-xfixes0-dev zsh picom

# Création du dossier fonts
mkdir -p ~/.local/share/fonts/

# Installation Sublime Text
echo_info "Installation de Sublime Text..."
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null
echo -e 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc' | sudo tee /etc/apt/sources.list.d/sublime-text.sources
sudo apt-get update -y 
sudo apt-get install -y sublime-text

# Installation des Nerd Fonts (version à jour)
echo_info "Installation des Nerd Fonts..."
NERD_FONT_VERSION="v3.2.1"
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/${NERD_FONT_VERSION}/Iosevka.zip
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/${NERD_FONT_VERSION}/RobotoMono.zip
unzip -q Iosevka.zip -d ~/.local/share/fonts/
unzip -q RobotoMono.zip -d ~/.local/share/fonts/
rm Iosevka.zip RobotoMono.zip
fc-cache -fv

# Installation Alacritty
echo_info "Installation d'Alacritty..."
if ! command -v alacritty &> /dev/null; then
    # Méthode 1: Via cargo (recommandé)
    echo_info "Installation d'Alacritty via cargo..."
    cargo install alacritty
    
    # Si cargo install échoue, essayer via apt (si disponible)
    if ! command -v alacritty &> /dev/null; then
        echo_warn "Installation cargo échouée, tentative via apt..."
        sudo apt-get install -y alacritty || echo_warn "Alacritty non disponible via apt"
    fi
else
    echo_info "Alacritty déjà installé"
fi

# Compilation i3-gaps
echo_info "Compilation d'i3-gaps..."
if [ -d "i3-gaps" ]; then
    echo_warn "Dossier i3-gaps existe déjà, suppression..."
    rm -rf i3-gaps
fi

git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
mkdir -p build && cd build
meson --prefix /usr/local ..
ninja
sudo ninja install
cd ../..

# Installation pywal
echo_info "Installation de pywal..."
pip3 install pywal --break-system-packages 2>/dev/null || pip3 install pywal

# Création des dossiers de configuration
echo_info "Création de l'arborescence de configuration..."
mkdir -p ~/.config/i3
mkdir -p ~/.config/rofi
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/picom
mkdir -p ~/.config/i3blocks

# Copie des fichiers de configuration
echo_info "Copie des fichiers de configuration..."
# ─── i3 Window Manager ────────────────────────────────────
cp .config/i3/config ~/.config/i3/config                        # Copy i3 main config
cp .config/i3/clipboard_fix.sh ~/.config/i3/clipboard_fix.sh   # Copy clipboard fix script
chmod +x ~/.config/i3/clipboard_fix.sh                         # Make it executable

# ─── i3blocks (status bar) ────────────────────────────────
cp .config/i3blocks/i3blocks.conf ~/.config/i3blocks/i3blocks.conf     # Copy i3blocks config
cp .config/i3blocks/cpu_useage.sh ~/.config/i3blocks/cpu_useage.sh     # Copy CPU usage script
chmod +x ~/.config/i3blocks/cpu_useage.sh                              # Make it executable

# ─── Alacritty (terminal) ─────────────────────────────────
cp .config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml # Copy terminal config

# ─── Rofi (app launcher) ──────────────────────────────────
cp .config/rofi/config.rasi ~/.config/rofi/config.rasi          # Copy rofi theme/config

# ─── Picom (compositor) ───────────────────────────────────
cp .config/picom/picom.conf ~/.config/picom/picom.conf          # Copy compositor config

# wallpaper configuration
echo_info "wallpaper configuration..."
cp .config/i3/wallpaper.sh ~/.config/i3/wallpaper.sh
chmod +x ~/.config/i3/wallpaper.sh

# Copie des wallpapers
if [ -d ".wallpaper" ]; then
    cp -r .wallpaper ~/.wallpaper
    echo_info "Wallpapers copiés dans ~/.wallpaper"
fi

# Nettoyage
echo_info "Nettoyage des fichiers temporaires..."
rm -rf i3-gaps

echo ""
echo_info "═══════════════════════════════════════════════════════════"
echo_info "Installation terminée avec succès!"
echo_info "═══════════════════════════════════════════════════════════"
echo ""
echo_info "Prochaines étapes:"
echo "  1. Choisir un wallpaper et exécuter: pywal -i /path/to/image"
echo "  2. Éditer ~/.fehbg pour définir le wallpaper au démarrage"
echo "  3. Redémarrer votre système"
echo "  4. Sélectionner 'i3' sur l'écran de connexion"
echo "  5. Lancer 'lxappearance' et sélectionner 'Arc-Dark'"
echo ""

# Installation Oh-My-Zsh (optionnelle)
echo ""
read -p "Voulez-vous installer Oh-My-Zsh? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo_info "Installation d'Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    # Définir zsh comme shell par défaut
    if [ -f /usr/bin/zsh ]; then
        echo_info "Définition de zsh comme shell par défaut..."
        chsh -s $(which zsh)
        echo_warn "Vous devrez vous reconnecter pour que zsh devienne le shell par défaut"
    fi
else
    echo_info "Oh-My-Zsh non installé"
fi

echo ""
echo_info "Configuration terminée! Profitez de votre nouvel environnement i3wm! 🚀"
