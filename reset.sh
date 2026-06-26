#!/usr/bin/env bash

c_reset='\033[0m'
c_bold='\033[1m'
c_green='\033[0;32m'
c_blue='\033[0;34m'
c_yellow='\033[1;33m'
c_red='\033[0;31m'

echo -e "${c_blue}${c_bold}=== Удаление фикса и откат к дефолтным настройкам Flatpak ===${c_reset}\n"

APP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/hicolor/scalable/apps"

echo -e "${c_yellow}[*] Удаление кастомных ярлыков из local...${c_reset}"
rm -f "$APP_DIR/mcpelauncher-client.desktop"
rm -f "$APP_DIR/io.mrarm.mcpelauncher.desktop"
rm -f "$APP_DIR/io.mrarm.mcpelauncher-ui-qt.desktop"

echo -e "${c_yellow}[*] Удаление кастомной иконки...${c_reset}"
rm -f "$ICON_DIR/Minecraft_Bedrock_2023.svg"

echo -e "${c_yellow}[*] Принудительный сброс системного кэша иконок и меню...${c_reset}"

if command -v update-desktop-database &> /dev/null; then
    update-desktop-database "$APP_DIR"
fi

if command -v gtk-update-icon-cache &> /dev/null; then
    gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" > /dev/null 2>&1 || true
fi

if command -v kbuildsycoca6 &> /dev/null; then
    kbuildsycoca6 --noincremental > /dev/null 2>&1
elif command -v kbuildsycoca5 &> /dev/null; then
    kbuildsycoca5 --noincremental > /dev/null 2>&1
fi

echo -e "\n${c_green}${c_bold}[✔] Откат завершен! Система полностью очищена от фикса.${c_reset}"
echo -e "Дефолтный ярлык лаунчера Flatpak восстановлен и снова доступен в меню."
