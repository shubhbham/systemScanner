#!/bin/bash

# Function to check if a command exists and install it if not
install_if_missing() {
    if ! command -v "$1" &> /dev/null; then
        echo "$1 not found, installing..."
        sudo apt-get update
        sudo apt-get install -y "$2"
    else
        echo "$1 is already installed."
    fi
}

# Install necessary packages
install_if_missing iproute2 iproute2
install_if_missing ethtool ethtool
install_if_missing dmidecode dmidecode
install_if_missing lsb_release lsb-release
install_if_missing curl curl
install_if_missing smartctl smartmontools
install_if_missing net-tools net-tools

# Function to get IP address
get_ip() {
    echo "IP Address:"
    ip addr show | awk '/inet / {print $2}' | grep -v '127.0.0.1'
}

# Function to get the owner's name (assuming it's the user logged in)
get_owner() {
    echo "Owner:"
    echo $USER
}

# Function to get the data speed (network interface speed)
get_data_speed() {
    echo "Data Speed:"
    ethtool $(ip route | grep default | awk '{print $5}') | grep -i speed
}

# Function to get the system model
get_model() {
    echo "Model:"
    sudo dmidecode -s system-product-name
}

# Function to get the operating system details
get_os() {
    echo "Operating System:"
    lsb_release -a
}

# Function to get the current date and time
get_date() {
    echo "Date and Time:"
    date
}

# Function to get the system location (geolocation based on IP)
get_location() {
    echo "Location:"
    curl -s ipinfo.io | grep -E "city|region|country"
}

# Function to get the storage left
get_storage() {
    echo "Storage Left:"
    df -h --total | grep total
}

# Function to get the system specifications (CPU, Memory)
get_specs() {
    echo "System Specifications:"
    echo "CPU Info:"
    lscpu | grep 'Model name\|Socket(s)\|Thread(s) per core\|Core(s) per socket\|CPU(s)'
    echo "Memory Info:"
    free -h
}

# Function to get other system complete information (as needed)
get_other_info() {
    echo "Other System Information:"
    echo "Kernel Version:"
    uname -r
    echo "Uptime:"
    uptime
    echo "Mounted File Systems:"
    mount | column -t
    echo "Environment Variables:"
    printenv
    echo "Open Ports:"
    sudo netstat -tuln
}

# Function to check for system errors and troubleshooting
get_troubleshooting_info() {
    echo "Troubleshooting Information:"
    echo "System Logs:"
    sudo dmesg | tail -n 50
    echo "Disk Health (using smartctl):"
    sudo smartctl -a /dev/sda | grep -iE "SMART overall-health|Reallocated_Sector_Ct|Power_On_Hours|Temperature_Celsius"
    echo "Memory Errors:"
    sudo dmesg | grep -i memory
    echo "Hardware Errors:"
    sudo dmesg | grep -i hardware
}

# Main function to call all other functions
get_system_info() {
    echo "Collecting System Information..."
    echo "==============================="
    get_ip
    echo "==============================="
    get_owner
    echo "==============================="
    get_data_speed
    echo "==============================="
    get_model
    echo "==============================="
    get_os
    echo "==============================="
    get_date
    echo "==============================="
    get_location
    echo "==============================="
    get_storage
    echo "==============================="
    get_specs
    echo "==============================="
    get_other_info
    echo "==============================="
    get_troubleshooting_info
    echo "==============================="
    echo "System Information Collection Complete."
}

# Execute the main function
get_system_info
