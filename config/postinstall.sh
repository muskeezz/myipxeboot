#!/bin/bash

# get subnet
subnet=`ip a | grep "inet " | tail -1 | awk '{print $2}'`
IP=`hostname -I | awk '{print $1}'`
sz=`echo $subnet | awk -F / '{print $2}'`

# get router/gateway
router=`ip route show | head -1 | awk '{print $3}'`

# fetch the UUID
UUID=`nmcli connection show | tail -1 | awk '{print $4}'`
# UUID=`nmcli connection show | head -2 | tail -1 | awk '{print $3}'` # Mint

# run commands to set up the permanent IP address
nmcli connection modify $UUID IPv4.address $IP/$sz
nmcli connection modify $UUID IPv4.gateway $router
nmcli connection modify $UUID IPv4.method manual
nmcli connection up $UUID
