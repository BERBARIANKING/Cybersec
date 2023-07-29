#!/bin/bash

clear_screen() {
    clear
}

print_ascii_art() {
    local green_color="\033[32m"  # Green color code
   # local reset_color="\033[0m"   # Reset to default color code

# Function to display ASCII art
display_ascii_art() {
    cat "ascii.txt"
}



    echo -e "${green_color}${ascii_art}${reset_color}"
}

display_credits() {
    echo "Credits:"
   echo "Nikolaos Bermparis"
}

main_menu() {
    clear_screen
    print_ascii_art
    display_ascii_art
    display_credits
   
    
   
    echo "------------------------------------"
    echo "1. Scan for Vulnerabilities"
    echo "2. Capture Packets"
    echo "3. Analyze Logs"
    echo "4. Exit"
}

get_user_choice() {
    read -p "Enter your choice: " choice
}

while true; do
    main_menu
    get_user_choice

    case $choice in
        1)
            # Implement vulnerability scan logic
            echo "Scanning for vulnerabilities..."
            # Add your vulnerability scan code here
            ;;
        2)
            # Implement packet capture logic
            echo "Capturing packets..."
            # Add your packet capture code here
            ;;
        3)
            # Implement log analysis logic
            echo "Analyzing logs..."
            # Add your log analysis code here
            ;;
        4)
            echo "Exiting. Goodbye!"
            break
            ;;
        *)
            echo "Invalid choice. Please select a valid option."
            ;;
    esac
done
      
