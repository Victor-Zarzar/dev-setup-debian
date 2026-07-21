<h1 id="screenshot">Screenshots</h1>

<p align="center">
  <img src="https://github.com/user-attachments/assets/05a56792-6687-4031-8404-d0a53f2ccf8f" width="1000" height="600" alt="Screenshot">
</p>

# Debian/Ubuntu Development Environment Setup

A modular, idempotent automated setup script for Debian/Ubuntu that installs and configures a complete development environment.

## Features

- **Modular Architecture**: Organized into separate library files for maintainability
- **Idempotent Execution**: Safe to run multiple times without duplicating installations
- **Hybrid Package Strategy**: Uses APT, Snap, Flatpak, Homebrew, NPM, and Pip
- **Interactive Menu**: Choose individual components or run complete setup
- **Automatic Logging**: Detailed timestamped logs for troubleshooting

## What Gets Installed

### Text Editors & IDEs

- Zed Editor (official installer)
- Sublime Text (Snap)
- Android Studio (Snap)

### Shell & Terminal

- Zsh with autosuggestions
- Starship prompt (Homebrew)
- Exa (modern ls replacement)
- Bat (better cat replacement)
- Zoxide (better cd replacement)

### Development Tools

- Git, Docker, Docker Compose V2
- Node.js tools: NPM, PNPM, NVM, Bun
- Python: Pip, Venv, FastAPI, Uvicorn, Pyenv
- Build tools: CMake, Automake, Ninja, Clang
- OpenJDK 21, Nginx, OpenSSH Server
- DevOps: kubectl, Minikube, eksctl, Terraform, Prometheus, Aws-cli

### Databases

- SQLite, MySQL, PostgreSQL17, Redis

### Applications

- **Snap**: Postman, Figma-App, Proton VPN, Notion, Trello, WhatsApp, Slack, Telegram, Sidra (Apple Music)
- **Flatpak**: LibreOffice, CPU-X, PDF Arranger, Boxes (VM manager)
- **Browsers**: Firefox, Google Chrome, Brave

### Graphics & Drivers

- **Nvidia Drivers**: Proprietary drivers with automatic detection and installation

### Security & Utilities

- KeePassXC, LocalSend, OpenVPN
- KDE Spectacle, JetBrains Mono font

### Homebrew Packages

- FVM (Flutter Version Manager)
- NVM, Pyenv, Alembic
- Starship, Nginx, MySQL, SQLite, PostgreSQL17, Redis

## Requirements

- Debian 10+ or Ubuntu 20.04+
- Sudo privileges
- Internet connection

## Installation

```bash
git clone https://github.com/Victor-Zarzar/dev-setup-debian
cd dev-setup-debian
chmod +x setup.sh
./setup.sh
```

## Directory Structure

```
dev-setup-debian/
├── setup.sh          # Main entry point
├── lib/
│   ├── utils.sh      # Utility functions and logging
│   ├── apt.sh        # APT package installations
│   ├── colors.sh     # Color functions
│   ├── snap.sh       # Snap package installations
│   ├── flatpak.sh    # Flatpak package installations
│   ├── fonts.sh      # Font installations
│   ├── brew.sh       # Homebrew installations
│   ├── manual.sh     # Manual installations (Zed, Bun)
│   ├── docker.sh     # Docker and Compose setup
│   ├── devops.sh     # DevOps utility functions and logging
│   ├── git.sh        # Git configuration
│   ├── helpers.sh    # Helper functions
│   ├── nvidia.sh     # Nvidia driver installation
│   └── system.sh     # System configuration
└── README.md
```

## Menu Options

```
 1) Run complete setup
 2) Update system
 3) Setup Snapd
 4) Setup directories
 5) Install Git
 6) Install text editors (Zed, Sublime)
 7) Install security tools
 8) Install Python environment
 9) Install Snap applications
10) Install Node.js tools
11) Install Docker
12) Install DevOps tools (Prometheus, Terraform, AWS CLI, kubectl, Minikube, eksctl)
13) Install browsers
14) Install fonts (JetBrains Mono, Nerd, Fira, Cascadia, Hack)
15) Install system tools
16) Install utility tools
17) Install Flatpak applications
18) Install databases
19) Install Homebrew
20) Install Homebrew packages
21) Install Zsh
22) Configure Git
23) Install Bun
24) Install Nvidia drivers
25) View installation log
 0) Exit
```

## Post-Installation

1. **Log out and log back in** for Docker group changes
2. **Restart terminal** for shell configurations (Homebrew, Pyenv, NVM, Starship)
3. **Reboot system** if Nvidia drivers were installed
4. **Set Zsh as default**: `chsh -s $(which zsh)`
5. **Install Python**: `pyenv install 3.11.0 && pyenv global 3.11.0`
6. **Install Node.js**: `nvm install --lts && nvm use --lts`
7. **Install Flutter**: `fvm install stable && fvm global stable`
8. **Start services**: `brew services start mysql && brew services start nginx`

## Nvidia Drivers

The script automatically detects Nvidia GPUs and installs the appropriate proprietary drivers. After installation:

```bash
# Verify installation
nvidia-smi

# Check driver version
nvidia-detector
```

**Important**: A system reboot is required after Nvidia driver installation for changes to take effect.

## Docker Usage

Docker Compose V2 is installed as a plugin:

```bash
docker compose up
docker compose down
docker compose version
```

## Log Files

Logs are created at: `~/debian_setup_YYYYMMDD_HHMMSS.log`

## Troubleshooting

**Snap apps not appearing:**

```bash
sudo systemctl restart snapd
```

**Docker permission denied:**

```bash
# Log out and log back in, then:
docker run hello-world
```

**Flatpak issues:**

```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

**Nvidia driver issues:**

```bash
# Check if Nvidia GPU is detected
lspci | grep -i nvidia

# Remove existing drivers (if needed)
sudo apt remove --purge nvidia-*
sudo apt autoremove

# Reinstall using the script
./setup.sh  # Select option 22
```

## License

MIT License

## Author

Victor Zarzar
