#!/usr/bin/env bash

# Define services for fetching IPV4 and IPV6 addresses
_wimip_svc_ipv4="http://ipv4.whatismyip.akamai.com
                 http://ipv4.tyk.nu
                 http://ipv4.icanhazip.com
                 http://ipv4.ifconfig.me"

_wimip_svc_ipv6="http://ipv6.whatismyip.akamai.com
                 http://ipv6.tyk.nu
                 http://ipv6.icanhazip.com
                 http://ipv6.ifconfig.me"

# Check if IP version was provided as command line argument
if [[ $# -eq 0 ]]; then
    # Prompt the user to select IPV4 or IPV6
    read -p "Enter 4 for IPV4 or 6 for IPV6: " ip_version
else
    ip_version=$1
fi

# Select the appropriate service based on the user's choice
if [[ "$ip_version" == "4" ]]; then
  _wimip_svcs=$_wimip_svc_ipv4
elif [[ "$ip_version" == "6" ]]; then
  _wimip_svcs=$_wimip_svc_ipv6
else
  echo "Invalid selection. Please enter 4 or 6."
  exit 1
fi

# Get a random line out of # of lines in _wimip_svcs
_wimip_rand=$[ $RANDOM % `echo "$_wimip_svcs" | wc -l` ]
if (( _wimip_rand == 0 )); then
    _wimip_rand=$[ $RANDOM % `echo "$_wimip_svcs" | wc -l` ]
fi
# Grab that line and cleanup spaces & tabs
_wimip_svc=`echo "$_wimip_svcs" | sed -n "$_wimip_rand"p | sed -e 's#[\t ]\+##g'`
# Hit the service to get IP
_wimip_myip=`curl -s $_wimip_svc` || echo "Failed: $_wimip_svc"
# Echo IP out
if [[ `echo "$_wimip_myip" | grep "[\<\>\/]"` != "" ]]; then
   echo "Failed: $_wimip_svc"
else
   echo -ne "$_wimip_myip\n"
fi
