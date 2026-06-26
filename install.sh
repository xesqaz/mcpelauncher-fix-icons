#!/usr/bin/env bash

set -e

c_reset='\033[0m'
c_bold='\033[1m'
c_green='\033[0;32m'
c_blue='\033[0;34m'
c_yellow='\033[1;33m'
c_red='\033[0;31m'

echo -e "${c_blue}${c_bold}=== Установка фикса иконок Minecraft Bedrock (mcpelauncher) ===${c_reset}\n"

if ! command -v curl &> /dev/null; then
    echo -e "${c_red}[!] Ошибка: утилита curl не найдена. Установите её и попробуйте снова.${c_reset}"
    exit 1
fi

APP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/hicolor/scalable/apps"

RAW_URL_BASE="https://raw.githubusercontent.com/xesqaz/mcpelauncher-fix-icons/refs/heads/main"
GITHUB_DL_BASE="https://github.com/xesqaz/mcpelauncher-fix-icons/raw/refs/heads/main"

echo -e "${c_yellow}[*] Подготовка директорий...${c_reset}"
mkdir -p "$APP_DIR"
mkdir -p "$ICON_DIR"

echo -e "${c_yellow}[*] Скачивание ярлыков...${c_reset}"
curl -sL "$RAW_URL_BASE/mcpelauncher-client.desktop" -o "$APP_DIR/mcpelauncher-client.desktop"
curl -sL "$RAW_URL_BASE/io.mrarm.mcpelauncher.desktop" -o "$APP_DIR/io.mrarm.mcpelauncher.desktop"
curl -sL "$GITHUB_DL_BASE/io.mrarm.mcpelauncher-ui-qt.desktop" -o "$APP_DIR/io.mrarm.mcpelauncher-ui-qt.desktop"

echo -e "${c_yellow}[*] Скачивание векторной иконки (SVG)...${c_reset}"
curl -sL "$GITHUB_DL_BASE/Minecraft_Bedrock_2023.svg" -o "$ICON_DIR/Minecraft_Bedrock_2023.svg"

echo -e "${c_yellow}[*] Обновление кэша Plasma и иконок...${c_reset}"

if command -v update-desktop-database &> /dev/null; then
    update-desktop-database "$APP_DIR"
fi

if command -v gtk-update-icon-cache &> /dev/null; then
    gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" > /dev/null 2>&1 || true
fi

if command -v kbuildsycoca6 &> /dev/null; then
    kbuildsycoca6 > /dev/null 2>&1
elif command -v kbuildsycoca5 &> /dev/null; then
    kbuildsycoca5 > /dev/null 2>&1
fi

echo -e "\n${c_green}${c_bold}[✔] Готово! Фикс успешно установлен.${c_reset}"
echo -e "Иконка будет отображаться корректно. Если она не обновилась сразу, то просто перезапусти лаунчер."
