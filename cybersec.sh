#!/bin/bash

# Replace "YOUR_API_KEY" with your actual Shodan API key
API_KEY="YOUR_API_KEY"

check_api_key() {
    local response=$(curl -s "https://api.shodan.io/api-info?key=$API_KEY")
    if [[ $? -ne 0 ]]; then
        echo "Error occurred while checking API key. Please try again later."
        exit 1
    fi

    local status=$(echo "$response" | jq -r '.status')
    if [[ "$status" == "error" ]]; then
        local error_msg=$(echo "$response" | jq -r '.error')
        echo "Error: $error_msg"
        exit 1
    fi

    echo "API key is valid and working."
    local plan=$(echo "$response" | jq -r '.plan')
    echo "Plan: $plan"
    local query_credits=$(echo "$response" | jq -r '.query_credits')
    echo "Query Credits: $query_credits"
    read -n 1 -s -r -p "Press any key to continue..."
}

clear_screen() {
    clear
}

print_ascii_art() {
    local green_color="\033[32m"  # Green color code
    local reset_color="\033[0m"   # Reset to default color code

    # Function to display ASCII art
    display_ascii_art() {
        cat "ascii.txt"
    }

    echo -e "${green_color}"
    display_ascii_art
    echo -e "${reset_color}"
}

display_credits() {
    echo "Credits:"
    echo "Nikolaos Bermparis"
}

# Function to perform a Shodan search
shodan_search() {
    local query="$1"
    local response=$(curl -s "https://api.shodan.io/shodan/host/search?key=$API_KEY&query=$query")
    echo "$response"
}

# Function to parse and display Shodan search results
parse_results() {
    local json_data="$1"
    local total=$(echo "$json_data" | jq -r '.total')

    if [[ "$total" == "0" ]]; then
        echo "No results found."
    else
        echo "Found $total results. Displaying the following IPs:"
        echo "$json_data" | grep -oE '"ip_str": "[^"]+"' | cut -d'"' -f4
    fi
}

# Function to search for devices on Shodan
search_devices() {
    read -p "Enter your Shodan search query: " search_query
    local response=$(shodan_search "$search_query")

    if [[ $? -ne 0 ]]; then
        echo "Error occurred while querying Shodan."
    else
        parse_results "$response"
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

main_menu() {
    clear_screen
    print_ascii_art

    echo "------------------------------------"
    echo "1. Check API Key"
    echo "2. Search for Devices on Shodan"
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
            check_api_key
            ;;
        2)
            search_devices
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
