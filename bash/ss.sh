/bin/bash

# Function to check for outdated packages
check_packages() {
    echo "Checking for outdated packages..."
    updates=$(apt-get --just-print upgrade | grep "^Inst")
    if [ -z "$updates" ]; then
        echo "All packages are up to date."
    else
        echo "Outdated packages found:"
        echo "$updates"
    fi
}

# Function to check for open ports
check_ports() {
    echo "Checking for open ports..."
    open_ports=$(netstat -tuln | grep "LISTEN")
    if [ -z "$open_ports" ]; then
        echo "No open ports found."
    else
        echo "Open ports found:"
        echo "$open_ports"
    fi
}

# Main menu function
main_menu() {
    echo "Main Menu:"
    echo "1. Check for outdated packages"
    echo "2. Check for open ports"
    echo "3. Exit"
    read -p "Enter your choice: " choice
    case "$choice" in
    1)
        check_packages
        ;;
    2)
        check_ports
        ;;
    3)
        exit
        ;;
    *)
        echo "Invalid choice."
        ;;
    esac
}

main_menu
