# KaliQuickFix
![Kali Linux](https://img.shields.io/badge/Kali_Linux-557C94?logo=kalilinux&logoColor=white&style=for-the-badge) ![Bash](https://img.shields.io/badge/Bash-blue.svg) ![License](https://img.shields.io/badge/license-MIT-green.svg)
---
**hate when the terminal tells you to --fix-missing or --break-system-packages? well no more! this script will fix both of these issues for good**

A small Bash script that permanently enables APT’s `Fix-Missing` option and pip’s `break-system-packages` setting on Kali Linux—so you never have to type `--fix-missing` or `--break-system-packages` again.

## 🚀 Features

- **Auto‑enable** APT’s `Fix-Missing` globally
- **Auto‑enable** pip’s `break-system-packages` in your user or system config
- **Backs up** any existing configuration files before modification
- **Usable as non‑root** for pip; warns and skips APT when not run as root

## 📋 Requirements

- Kali Linux (or any Debian‑based distro)
- Bash shell
- For APT config changes: root privileges  
- Internet connection to run `apt update` (optional, not built into script)

## 📥 Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/YourUsername/fix-kali.git
   cd fix-kali
   ```
2. Make the script executable:
   ```bash
   chmod +x fix-kali.sh
   ```

## ⚙️ Usage

- **As root** (updates pip and APT configs):
  ```bash
  sudo ./fix-kali.sh
  ```

The script will report which configs were updated and where backups were stored (e.g. `/etc/pip.conf.bak`, `~/.config/pip/pip.conf.bak`, `/etc/apt/apt.conf.d/99fix-missing.bak`).

## 🔍 What It Does

1. **Pip**  
   - Detects if running as root or regular user  
   - Updates `/etc/pip.conf` (system‑wide) or `~/.config/pip/pip.conf` (user)  
   - Adds:
     ```ini
     [global]
     break-system-packages = true
     ```
2. **APT**  
   - Requires root  
   - Writes `/etc/apt/apt.conf.d/99fix-missing`:
     ```plain
     APT::Get::Fix-Missing "true";
     ```

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
