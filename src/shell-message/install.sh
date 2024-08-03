#!/bin/bash
set -e

# Ubuntu packages
install_ubuntu_packages() {
    export DEBIAN_FRONTEND=noninteractive
    apt install -y software-properties-common
    add-apt-repository -y ppa:zhangsongcui3371/fastfetch
    apt update -o Dir::Etc::sourcelist="sources.list.d/zhangsongcui3371-ubuntu-fastfetch-$(lsb_release -cs).list" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"
    apt install -y fastfetch
}

# Debian packages
install_debian_packages() {
    ARCH=$(dpkg --print-architecture)
    if [ "$ARCH" = "arm64" ]; then
        wget https://github.com/fastfetch-cli/fastfetch/releases/download/2.20.0/fastfetch-linux-aarch64.deb
        dpkg -i fastfetch-linux-aarch64.deb
        rm fastfetch-linux-aarch64.deb
    elif [ "$ARCH" = "amd64" ]; then
        wget https://github.com/fastfetch-cli/fastfetch/releases/download/2.20.0/fastfetch-linux-amd64.deb
        dpkg -i fastfetch-linux-amd64.deb
        rm fastfetch-linux-amd64.deb
    else
        echo "Unsupported architecture: $ARCH"
        exit 1
    fi
}

# Alpine packages
install_alpine_packages() {
    apk update
    apk add --upgrade fastfetch
}

# Red Hat packages
install_redhat_packages() {
    dnf update
    dnf install -y fastfetch
}


# ******************
# ** Main section **
# ******************

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# Bring in ID, ID_LIKE, VERSION_ID, VERSION_CODENAME
. /etc/os-release

# Get an adjusted ID independent of distro variants
if [ "${ID}" = "ubuntu" ]; then
    ADJUSTED_ID="ubuntu"
elif [ "${ID}" = "debian" ] || [ "${ID_LIKE}" = "debian" ]; then
    ADJUSTED_ID="debian"
elif [[ "${ID}" = "rhel" || "${ID}" = "fedora" || "${ID}" = "mariner" || "${ID_LIKE}" = *"rhel"* || "${ID_LIKE}" = *"fedora"* || "${ID_LIKE}" = *"mariner"* ]]; then
    ADJUSTED_ID="rhel"
elif [ "${ID}" = "alpine" ]; then
    ADJUSTED_ID="alpine"
else
    echo "Linux distro ${ID} not supported."
    exit 1
fi

# Install packages for appropriate OS
case "${ADJUSTED_ID}" in
    "ubuntu")
        install_ubuntu_packages
        ;;
    "debian")
        install_debian_packages
        ;;
    "rhel")
        install_redhat_packages
        ;;
    "alpine")
        install_alpine_packages
        ;;
esac


# Output the config file to the default location, this allows other
# repos to override at will.
# Read the SERVICE_CHECKS environment variable
IFS=',' read -r -a service_checks <<< "${SERVICECHECKS}"

# Read the config.jsonc file
config_file=$(<./config.jsonc)

# Replace the service placeholders with the service checks
service_placeholder="// <--service placeholder-->"
service_lines=""
for service_check in "${service_checks[@]}"; do
    service_port=$(echo "$service_check" | cut -d':' -f2)
    service_name=$(echo "$service_check" | cut -d':' -f1)
    service_colour=$(echo "$service_check" | cut -d':' -f3)
    service_colour=${service_colour:-34}
    service_lines+="        {\n"
    service_lines+="            \"key\": \"│             │\\\\u001b[13D{#$service_colour}$service_name\",\n"
    service_lines+="            \"type\": \"command\",\n"
    service_lines+="            \"shell\": \"sh\",\n"
    service_lines+="            \"format\": \"\",\n"
    service_lines+="            \"text\": \"if curl -s http://127.0.0.1:$service_port > /dev/null; then echo '\\\\u001b[32m●\\\\u001b[0m Up'; else echo '\\\\u001b[31m● Down'; fi\"\n"
    service_lines+="        },\n"
done

# Replace the placeholders in the config file
config_file=$(echo "$config_file" | sed "s|$service_placeholder|$service_lines|")

# Write the updated config file back
mkdir -p ~/.config/fastfetch
echo "$config_file" > ~/.config/fastfetch/config.jsonc

# Add a post-create script.
cat post-create.sh > /usr/local/share/kolatr-shell-message-post-create.sh
chmod +x /usr/local/share/kolatr-shell-message-post-create.sh
