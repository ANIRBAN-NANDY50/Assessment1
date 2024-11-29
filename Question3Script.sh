#!/bin/bash

myfile="Question3.log"

while IFS=" " read -r line
do
	time=$(echo "$line" | awk '{print $1}')
	#echo "$time"
	user=$(echo "$line" | awk '{print $3}')
	echo "$user"
	booking=$(echo "$line" | awk '{print $4}')
	echo "$booking"
done < "$myfile"
