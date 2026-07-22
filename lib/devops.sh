install_prometheus() {
    print_section "Installing Prometheus"

    if command -v prometheus &> /dev/null; then
        print_info "Prometheus already installed ($(prometheus --version 2>&1 | head -n1))"
        return 0
    fi

    run_command "sudo apt install -y prometheus" "Prometheus installed"
}

install_terraform() {
    print_section "Installing Terraform"

    if command -v terraform &> /dev/null; then
        print_info "Terraform already installed ($(terraform version | head -n1))"
        return 0
    fi

    if ! dpkg -l | grep -q "^ii  gnupg software-properties-common"; then
        run_command "sudo apt install -y gnupg software-properties-common curl" "Prerequisites installed"
    fi

    run_command "wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg" "HashiCorp GPG key added"

    run_command "echo \"deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com \$(lsb_release -cs) main\" | sudo tee /etc/apt/sources.list.d/hashicorp.list" "HashiCorp repo added"

    run_command "sudo apt update && sudo apt install -y terraform" "Terraform installed"
}

install_aws_cli() {
    print_section "Installing AWS CLI"

    if command -v aws &> /dev/null; then
        print_info "AWS CLI already installed ($(aws --version))"
        return 0
    fi

    run_command "curl \"https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip\" -o \"/tmp/awscliv2.zip\"" "AWS CLI installer downloaded"
    run_command "unzip -q /tmp/awscliv2.zip -d /tmp" "AWS CLI installer extracted"
    run_command "sudo /tmp/aws/install" "AWS CLI installed"
    rm -rf /tmp/aws /tmp/awscliv2.zip
}

install_azure_cli() {
    print_section "Installing Azure CLI"
    if command -v az &> /dev/null; then
        print_info "Azure CLI already installed ($(az version --output tsv --query '\"azure-cli\"' 2>/dev/null || az --version | head -n1))"
        return 0
    fi
    if ! dpkg -l | grep -q "^ii  ca-certificates curl apt-transport-https lsb-release gnupg"; then
        run_command "sudo apt install -y ca-certificates curl apt-transport-https lsb-release gnupg" "Prerequisites installed"
    fi
    run_command "curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null" "Microsoft GPG key added"
    run_command "echo \"deb [arch=\$(dpkg --print-architecture)] https://packages.microsoft.com/repos/azure-cli/ \$(lsb_release -cs) main\" | sudo tee /etc/apt/sources.list.d/azure-cli.list" "Azure CLI repo added"
    run_command "sudo apt update && sudo apt install -y azure-cli" "Azure CLI installed"
}

install_ansible() {
    print_section "Installing Ansible"
    if command -v ansible &> /dev/null; then
        print_info "Ansible already installed ($(ansible --version | head -n1))"
        return 0
    fi
    if ! dpkg -l | grep -q "^ii  software-properties-common"; then
        run_command "sudo apt install -y software-properties-common" "Prerequisites installed"
    fi
    run_command "sudo add-apt-repository --yes --update ppa:ansible/ansible" "Ansible PPA added"
    run_command "sudo apt install -y ansible" "Ansible installed"
}

install_kubectl() {
    print_section "Installing Kubernetes (kubectl)"

    if command -v kubectl &> /dev/null; then
        print_info "kubectl already installed ($(kubectl version --client --short 2>/dev/null || kubectl version --client))"
        return 0
    fi

    run_command "sudo apt install -y apt-transport-https ca-certificates curl gpg" "Prerequisites installed"
    run_command "curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg" "Kubernetes GPG key added"
    run_command "echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list" "Kubernetes repo added"
    run_command "sudo apt update && sudo apt install -y kubectl" "kubectl installed"
}

install_minikube() {
    print_section "Installing Minikube"

    if command -v minikube &> /dev/null; then
        print_info "Minikube already installed ($(minikube version --short))"
        return 0
    fi

    run_command "curl -Lo /tmp/minikube.deb https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb" "Minikube package downloaded"
    run_command "sudo apt install -y /tmp/minikube.deb" "Minikube installed"
    rm -f /tmp/minikube.deb
}

install_eksctl() {
    print_section "Installing eksctl"

    if command -v eksctl &> /dev/null; then
        print_info "eksctl already installed ($(eksctl version))"
        return 0
    fi

    run_command "curl --silent --location \"https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz\" | tar xz -C /tmp" "eksctl downloaded"
    run_command "sudo mv /tmp/eksctl /usr/local/bin" "eksctl installed"
}

install_devops_tools() {
    print_section "Installing DevOps Tools"

    install_prometheus
    install_terraform
    install_aws_cli
    install_azure_cli
    install_ansible
    install_kubectl
    install_minikube
    install_eksctl

    log_action "DevOps tools installed (Prometheus, Terraform, AWS CLI, Azure CLI, Ansible, kubectl, Minikube, eksctl)"
}
