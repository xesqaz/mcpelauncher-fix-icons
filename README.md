# mcpelauncher-fix-icons

Небольшой скрипт для исправления отображения дефолтной иконки иксов (или Wayland) на панели задач при запуске Minecraft Bedrock Edition через Flatpak-лаунчер (`io.mrarm.mcpelauncher`) на Linux.

Проблема возникает из-за того, что оконный менеджер не всегда понимает, к какому приложению относится запущенное окно игры, и не может привязать к нему правильную иконку.

Что делает этот фикс:
* Скрывает дубли и лишние ярлыки из стартового меню.
* Размещает правильные .desktop файлы с жестко прописанным классом окна (`StartupWMClass`) в `~/.local/share/applications/`.
* Копирует кастомную SVG-иконку в стандартную директорию `hicolor`.
* Автоматически обновляет кэш иконок и сбрасывает кэш Plasma, чтобы изменения применились без перезагрузки системы.

## Установка

Команда для установки:

```bash
curl -sL [https://raw.githubusercontent.com/xesqaz/mcpelauncher-fix-icons/main/install.sh](https://raw.githubusercontent.com/xesqaz/mcpelauncher-fix-icons/main/install.sh) | bash
```

Примечание: Если после установки у открытого окна всё ещё старая иконка, просто перезапустите игру.

## Удаление (Откат)

Команда для удаления фикса и возврата к дефолтным настройкам Flatpak:

```bash
curl -sL [https://raw.githubusercontent.com/xesqaz/mcpelauncher-fix-icons/main/reset.sh](https://raw.githubusercontent.com/xesqaz/mcpelauncher-fix-icons/main/reset.sh) | bash
```

---
Скрипт создавался в первую очередь для KDE Plasma, но поскольку используется стандартная структура директорий Linux, он должен работать и в других графических окружениях.
