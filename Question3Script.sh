#!/bin/bash

myfile="Question3.log"

declare -A ticket_count

while IFS=" " read -r line
do
	time=$(echo "$line" | awk '{print $1}')
	#echo "$time"
	user=$(echo "$line" | awk '{print $3}')
	#echo "$user"
	booking=$(echo "$line" | awk '{print $4}')
	#echo "$booking"
	
	if [ "$booking" == "booked" ]; then
		((ticket_count["$user"]++))
	elif [ "$booking" == "cancelled" ]; then
		((ticket_count["$user"]--))
	fi

	echo " User: $user      |  Count: ${ticket_count["$user"]}"
	
done < "$myfile"
