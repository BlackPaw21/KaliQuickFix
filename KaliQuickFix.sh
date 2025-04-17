# Function to update pip configuration.
update_pip_config() {
    echo "Updating pip configuration..."
    if [ "$EUID" -eq 0 ]; then
        # Running as root, update system-wide configuration.
        CONF_FILE="/etc/pip.conf"
    else
        # Update user-specific configuration.
        CONF_DIR="$HOME/.config/pip"
        mkdir -p "$CONF_DIR"
        CONF_FILE="$CONF_DIR/pip.conf"
    fi

    echo "Pip configuration file: $CONF_FILE"

    # Backup existing configuration if it exists.
    if [ -f "$CONF_FILE" ]; then
        cp "$CONF_FILE" "${CONF_FILE}.bak"
        echo "Backup created at ${CONF_FILE}.bak"
    fi

    # Append the setting if it isn't already present.
    if grep -q "break-system-packages" "$CONF_FILE" 2>/dev/null; then
        echo "Pip configuration already contains the break-system-packages setting."
    else
        {
            echo "[global]"
            echo "break-system-packages = true"
        } >> "$CONF_FILE"
        echo "Pip configuration successfully updated."
    fi
}

# Function to update APT configuration.
update_apt_config() {
    echo "Updating APT configuration..."
    # APT configuration must be updated as root.
    if [ "$EUID" -ne 0 ]; then
        echo "Warning: Root privileges are required to update APT configuration."
        echo "Skipping APT configuration update. Run this script as root to update APT settings."
        return
    fi

    CONF_FILE="/etc/apt/apt.conf.d/99fix-missing"
    echo "APT configuration file: $CONF_FILE"

    # Backup existing configuration if it exists.
    if [ -f "$CONF_FILE" ]; then
        cp "$CONF_FILE" "${CONF_FILE}.bak"
        echo "Backup created at ${CONF_FILE}.bak"
    fi

    # Write the fix-missing configuration.
    cat <<EOF > "$CONF_FILE"
APT::Get::Fix-Missing "true";
EOF

    echo "APT configuration successfully updated."
}

# Main execution: update pip and apt configurations.
update_pip_config
update_apt_config

echo "All applicable configurations have been updated."
