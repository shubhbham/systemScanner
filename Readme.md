# System Information Collector

## Overview

The System Information Collector is a comprehensive Bash script designed to gather extensive details about a Linux system. This script installs necessary packages (if they are not already installed) and collects various pieces of system information, including IP address, owner, data speed, system model, OS details, date and time, geolocation, storage, system specifications, other system information, and troubleshooting information.

## Features

- **Package Installation**: Automatically installs required packages if they are not present.
- **IP Address**: Retrieves the system's IP address.
- **Owner**: Displays the name of the logged-in user.
- **Data Speed**: Shows the speed of the network interface.
- **System Model**: Displays the system model name.
- **Operating System**: Provides detailed information about the operating system.
- **Date and Time**: Shows the current date and time.
- **Geolocation**: Fetches the geolocation based on the IP address.
- **Storage**: Displays the available storage space.
- **System Specifications**: Provides details about the CPU and memory.
- **Other System Information**: Includes kernel version, uptime, mounted file systems, environment variables, and open ports.
- **Troubleshooting Information**: Collects system logs, disk health, memory errors, and hardware errors for troubleshooting purposes.

## Usage

1. **Clone the Repository**
    ```bash
    git clone https://github.com/shubhbham/systemScanner.git
    cd systemScanner
    ```

2. **Make the Script Executable**
    ```bash
    chmod +x systemScanner.sh
    ```

3. **Run the Script**
    ```bash
    ./systemScanner.sh
    ```

## Script Breakdown

### Installation of Necessary Packages

The script first checks if certain packages are installed on the system. If any package is missing, it installs it using `apt-get`.

```bash
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
```

### Information Collection Functions

The script defines several functions to gather different types of system information:

- **get_ip**: Fetches the IP address.
- **get_owner**: Displays the name of the logged-in user.
- **get_data_speed**: Shows the network interface speed.
- **get_model**: Displays the system model.
- **get_os**: Provides detailed OS information.
- **get_date**: Displays the current date and time.
- **get_location**: Fetches the geolocation based on the IP address.
- **get_storage**: Displays the available storage.
- **get_specs**: Provides CPU and memory information.
- **get_other_info**: Includes kernel version, uptime, mounted file systems, environment variables, and open ports.
- **get_troubleshooting_info**: Collects system logs, disk health, memory errors, and hardware errors.

### Main Function

The main function calls all the above functions and prints the collected information.

```bash
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
```

## Contributing

Feel free to submit issues, fork the repository, and send pull requests. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License.

---

This README is designed to provide a comprehensive overview of the System Information Collector script, highlighting its features, usage, and functionality to help users and contributors effectively utilize and improve the script.