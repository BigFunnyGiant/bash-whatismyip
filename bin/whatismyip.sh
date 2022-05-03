#!/bin/bash

_wimip_svcs="http://whatismyip.akamai.com
	     http://ip.tyk.nu
	     http://l2.io/ip
	     http://ipinfo.io/ip
             https://api.ipify.org
	     https://wtfismyip.com/text
	     http://ipecho.net/plain
	     http://ident.me
	     http://ipof.in/txt
	     http://icanhazip.com
	     http://ifconfig.co
             http://ifconfig.me
	     http://wgetip.com
	     http://ipecho.net/plain"

# get a random line out of # of lines in _wimip_svcs
_wimip_rand=$[ $RANDOM % `echo "$_wimip_svcs" | wc -l` ]
# grab that line and cleanup spaces & tabs
_wimip_svc=`echo "$_wimip_svcs" | sed -n "$_wimip_rand"p | sed -e 's#[\t ]\+##g'`
# hit the service to get ip
_wimip_myip=`curl -s $_wimip_svc` || echo "Failed: $_wimip_svc"
# echo ip out.
if [[ `echo "$_wimip_myip" | grep "[\<\>\/]"` != "" ]]; then
   echo "Failed: $_wimip_svc"
else
   echo -ne "$_wimip_myip\n"
fi
