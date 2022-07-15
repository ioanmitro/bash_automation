#!/bin/bash

# A program to know the IP address of the machine you are unning on.

# ifconfig output is parsed to look for IP addresses.
# The commands will either return the first IP address that is not a loopback or nothing if
# there are no interfaces configured or up.

/sbin/ifconfig -a | awk '/(cast)/ { print $2 }' | cut -d':' -f2 | head -1

#It will print out your IPv4 address 


