#!/bin/bash

# ============================================
# APT Package Installation Functions
# ============================================

install_git() {
    print_section "Installing Git"

    if command -v git &> /dev/null; then
        print_info "Git already installed ($(git --version))"
        return 0
    fi

    run_command "sudo apt install -y git" "Git installed"
}

install_security_tools() {
    print_section "Installing Security Tools"

    if ! dpkg -l | grep -q "^ii  keepassxc"; then
        run_command "sudo apt install -y keepassxc" "KeePassXC installed"
    else
        print_info "KeePassXC already installed"
    fi

    if ! snap list | grep -q "localsend"; then
        run_command "sudo snap install localsend" "LocalSend installed"
    else
        print_info "LocalSend already installed"
    fi

    if ! dpkg -l | grep -q "^ii  network-manager-openvpn"; then
        run_command "sudo apt install -y network-manager-openvpn openvpn" "OpenVPN installed"
    else
        print_info "OpenVPN already installed"
    fi
}

install_python_env() {
    print_section "Installing Python Environment"

    if ! dpkg -l | grep -q "^ii  python3-pip"; then
        run_command "sudo apt install -y python3-pip python3-venv" "Python tools installed"
    else
        print_info "Python tools already installed"
    fi

    if ! pip3 list 2>/dev/null | grep -q "fastapi"; then
        run_command "pip3 install fastapi uvicorn" "FastAPI and Uvicorn installed"
    else
        print_info "FastAPI and Uvicorn already installed"
    fi

    if command -v leme &> /dev/null; then
        print_info "Leme already installed ($(leme --version 2>&1))"
    else
        if command -v pipx &> /dev/null; then
            run_command "pipx install leme" "Leme DevOps CLI installed (pipx)"
        elif command -v pip3 &> /dev/null; then
            run_command "pip3 install --user --break-system-packages leme" "Leme DevOps CLI installed (pip3)"
        else
            print_error "Neither pipx nor pip3 found - cannot install Leme"
        fi

        export PATH="$HOME/.local/bin:$PATH"

        if command -v leme &> /dev/null; then
            print_success "Leme verified: $(leme --version 2>&1)"
            log_action "Leme installed and verified ($(leme --version 2>&1))"
        else
            print_error "Leme was installed but isn't on PATH yet. Add \$HOME/.local/bin to your PATH (restart terminal), then re-run this option."
            log_action "Leme install completed but verification failed - PATH issue likely"
        fi
    fi

    log_action "Python environment configured"
}

install_nodejs_tools() {
    print_section "Installing Node.js Tools"

    if ! command -v npm &> /dev/null; then
        run_command "sudo apt install -y npm" "NPM installed"
    else
        print_info "NPM already installed ($(npm --version))"
    fi

    if ! command -v pnpm &> /dev/null; then
        run_command "sudo npm install -g pnpm" "PNPM installed"
    else
        print_info "PNPM already installed ($(pnpm --version))"
    fi

    print_info "NVM will be installed via Homebrew (option 18)"
}

install_browsers() {
    print_section "Installing Additional Browsers"

    if command -v google-chrome &> /dev/null; then
        print_info "Google Chrome already installed ($(google-chrome --version))"
        return 0
    fi

    print_info "Installing Google Chrome..."
    if wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome.deb >> "$LOG_FILE" 2>&1; then
        run_command "sudo apt install -y /tmp/chrome.deb" "Google Chrome installed"
        rm -f /tmp/chrome.deb
    else
        print_error "Failed to download Chrome"
    fi
}

install_utility_tools() {
    print_section "Installing Utility Tools"

    if ! dpkg -l | grep -q "^ii  kdiskmark"; then
        run_command "sudo apt install -y kdiskmark" "Disk benchmark tool installed"
    else
        print_info "KDiskMark already installed"
    fi

    if ! command -v balena-etcher &> /dev/null; then
        print_info "Downloading Balena Etcher from GitHub..."
        ETCHER_URL=$(curl -s https://api.github.com/repos/balena-io/etcher/releases/latest | grep "browser_download_url.*amd64.deb" | cut -d '"' -f 4)

        if [ -n "$ETCHER_URL" ]; then
            if wget -q "$ETCHER_URL" -O /tmp/balena-etcher.deb >> "$LOG_FILE" 2>&1; then
                run_command "sudo apt install -y /tmp/balena-etcher.deb" "Balena Etcher installed"
                rm -f /tmp/balena-etcher.deb
            else
                print_error "Failed to download Balena Etcher"
            fi
        else
            print_error "Failed to find Balena Etcher download URL"
        fi
    else
        print_info "Balena Etcher already installed"
    fi
}

install_system_tools() {
    print_section "Installing System Tools"

    if ! dpkg -l | grep -q "^ii  openssh-server"; then
        run_command "sudo apt install -y openssh-server" "SSH server installed"
    else
        print_info "SSH server already installed"
    fi

    if ! dpkg -l | grep -q "^ii  nano"; then
        run_command "sudo apt install -y nano" "Text editor"
    else
        print_info "Nano already installed"
    fi

    if ! dpkg -l | grep -q "^ii  kde-spectacle"; then
        run_command "sudo apt install -y kde-spectacle" "Screenshot tool installed"
    else
        print_info "KDE Spectacle already installed"
    fi

    if ! dpkg -l | grep -q "^ii  cmake"; then
        run_command "sudo apt install -y cmake automake ninja-build clang" "Build tools installed"
    else
        print_info "Build tools already installed"
    fi

    if ! dpkg -l | grep -q "^ii  flatpak"; then
        run_command "sudo apt install -y flatpak" "Flatpak installed"
    else
        print_info "Flatpak already installed"
    fi

    print_info "Nginx will be installed via Homebrew (option 18)"
}

install_databases() {
    print_section "Installing Databases"

    print_info "SQLite and MySQL will be installed via Homebrew (option 18)"
    print_info "Skipping APT database installation..."
}
