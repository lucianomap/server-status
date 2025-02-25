#! /bin/bash

echo "-----System Information-----"

hostnamectl
uptime | awk '{gsub (/,/,""); printf "Uptime = %s \n", $3}'


echo "-----Total CPU Usage-----"
top -bn1 | grep "%Cpu(s):" | cut -d ',' -f 4 | awk '{print "Usage: " 100-$1 "%"}'
echo ""

echo "-----Total Memory Usage-----"
free --si | grep "Mem:" -w | awk '{printf "Total = %.2f GB\n Used = %.2f GB (%.2f%)\n Free = %.2f GB (%.2f%)\n", $2/1024^2, $3/1024^2, $3/($3+$4) *100, $4/1024^2, $4/($3+$4) *100}'
echo ""

echo "-----Total Disk Usage-----"
df -h | grep "/" -w | awk '{printf "Total = %sG\nUsed = %s (%.2f%%)\nFree = %s (%.2f%%)\n",$3 + $4, $3, $3/($3+$4) * 100, $4, $4/($3+$4) * 100}'
echo ""

echo "-----Top 5 processes by CPU Usage----- "
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo ""

echo "-----Top 5 processes by Memory Usage-----"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo ""
~          