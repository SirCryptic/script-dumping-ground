#!/bin/bash

# Function to encrypt a file
encrypt_file() {
    # Get the file name and password from the user
    read -p "Enter the file name to encrypt: " file
    read -p "Enter a password to encrypt the file: " password
    
    # Encrypt the file using openssl
    openssl enc -aes-256-cbc -salt -in "$file" -out "${file}.enc" -k "$password"
    echo "File successfully encrypted!"
}

# Function to decrypt a file
decrypt_file() {
    # Get the file name and password from the user
    read -p "Enter the file name to decrypt: " file
    read -p "Enter the password used to encrypt the file: " password
    
    # Decrypt the file using openssl
    openssl enc -aes-256-cbc -d -in "$file" -out "${file%.enc}" -k "$password"
    echo "File successfully decrypted!"
}

# Main menu function
main_menu() {
    echo "Main Menu:"
    echo "1. Encrypt a file"
    echo "2. Decrypt a file"
    echo "3. Exit"
    read -p "Enter your choice: " choice
    case "$choice" in
    1)
        encrypt_file
        ;;
    2)
        decrypt_file
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
