#!/usr/bin/env bash

# Get IP version option from command line arguments or user input
if [ "$#" -gt 0 ]; then
    ip_version=$1
else
    read -p "Enter IP version to use (4/6/B for both): " ip_version
fi

# Check if IP version is valid
if [ "$ip_version" != "4" ] && [ "$ip_version" != "6" ] && [ "$ip_version" != "B" ] && [ "$ip_version" != "b" ]; then
    echo "Invalid option. Please enter 4, 6, or B for both."
    exit 1
fi

# URLs for getting IP addresses
ipv4_urls="http://ipv4.whatismyip.akamai.com
           http://ipv4.tyk.nu
           http://ipv4.icanhazip.com
           http://ipv4.ifconfig.me"

ipv6_urls="http://ipv6.whatismyip.akamai.com
           http://ipv6.tyk.nu
           http://ipv6.icanhazip.com
           http://ipv6.ifconfig.me"

# Get a random URL from the list for the specified IP version
if [ "$ip_version" = "4" ]; then
    urls=$ipv4_urls
elif [ "$ip_version" = "6" ]; then
    urls=$ipv6_urls
else
    urls="$ipv4_urls"$'\n'"$ipv6_urls"
fi

url=$(echo "$urls" | shuf -n 1)

# Get IP address from the selected URL
ip=$(curl -s "$url")

# Check if the IP address was retrieved successfully
if [ -z "$ip" ]; then
    echo "Failed to retrieve IP address from $url"
    exit 1
fi

# Print the IP address
echo "$ip"
