#!/bin/bash

ip="0.0.0.0"
exampleIP="google.com"

gatewayTime="$(ping -c 5 $ip | tail -n1 | cut -d '/' -f5)"
echo "Ping time to default gateway: $gatewayTime ms"

exampleTime="$(ping -c 5 $exampleIP | tail -n1 | cut -d '/' -f5)"
echo "Ping time to google.com: $exampleTime ms"

numInterfaces="$(netstat -i | tail -n +3 | grep -v "lo" | wc -l)"

upInterfaces="$(ip link show | grep -v "lo" | grep -c "UP")"

echo "Interface count: $numInterfaces, and $upInterfaces/$numInterfaces is up"

TCP_LISTEN="$(netstat -lt | tail -n +3 | wc -l)"
echo "$TCP_LISTEN TCP ports are in the LISTEN state"
