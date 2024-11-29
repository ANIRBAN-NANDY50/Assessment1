#!/bin/bash

# Get the  used and free RAM
used_memory=$(free -h | awk '/^Mem:/ {print $3}')
free_memory=$(free -h | awk '/^Mem:/ {print $4}')

# Display the results
echo "The Used And Free Memory In RAM"
echo "Used RAM: $used_memory"
echo "Free RAM: $free_memory"

echo "-----------------------------------------"

#Printing Current Disk Space Usage Percentage 
echo "Generate Alert If Disk Space Is Greater Than 50%" 
#Setting a threshold
disk_space=50

# Get the current disk usage percentage 
usage=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%'  -f1)
echo "Current Disk Usage: $usage %"
used_disk=$(df -H /)
echo "Used Disk Space: $used_disk"
# Check if the usage is greater 
if [ "$usage" -ge "$disk_space" ]; then
	notification="Notification Directory"
	mkdir "$notification"
	file="Alert.txt"
	path="$notification/$file"
	{
  		echo "Alert: Disk space usage is ${usage}% which is greater than or equal to ${disk_space}%."
	} > "$path"	
fi  

echo "-----------------------------------------"

#Find And Print The 10 Largest Files in File System
echo "The Top Ten Files With MAX Size Are Shown Below"
top_10=$(find . -type f -printf '%s %p\n' | sort -nr | head -n 10)
echo " Size   Path"
echo "$top_10"
echo "-----------------------------------------"
