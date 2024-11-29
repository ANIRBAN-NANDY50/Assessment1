#!/bin/bash

source Quetion1.properties

Assesment_dir="Main Directory"
mkdir -p "$Assesment_dir"

IFS=',' read -r -a time <<< "$time"
IFS=',' read -r -a emailIds <<< "$emailIds"
IFS=',' read -r -a task <<< "$tasks"

#echo "Time: $time"
#echo "Email ID: $emailIds"
#echo "Tasks: $task"

#Generation the Alert Time 
alert_time_function() {
	task_time=$1
	task_time_hr=$(echo "$time" | cut -d':' -f1)
	task_time_min=$(echo "$time" | cut -d':' -f2)
	int_task_time=$((task_time_hr * 60 + task_time_min))
	int_alert_time=$((int_task_time - 30))
	alert_hr=$((int_alert_time / 60))
	alert_min=$((int_alert_time % 60))
	echo "$alert_hr : $alert_min"
}

#Calculating Alert Time For Every Task
for t1 in "${!time[@]}";
do
        #task_time=$1
        #task_time_hr=$(echo "$time" | cut -d':' -f1)
        #task_time_min=$(echo "$time" | cut -d':' -f2)
        #int_task_time=$((task_time_hr * 60 + task_time_min))
        #int_alert_time=$((int_task_time - 30))
        #alert_hr=$((int_alert_time / 60))
        #alert_min=$((int_alert_time % 60))
        # echo "$alert_hr : $alert_min"
	
	alert=$(alert_time_function "${time[$t1]}")
	subject="Task at ${time[$t1]}"
	notification="${task[$t1]} at ${time[$t1]}"
#Creation of User Directory and Sending Alert File
	for mail in "${!emailIds[@]}"; 
	do
		inner_dir="$Assesment_dir/$mail"
		mkdir -p "$inner_dir"
		new_notif="${mail}.txt"
		notif_path="$inner_dir/$new_notif"
#Message being sent to the respective notification file 
		{
			echo "Your Notification: $notification"
		} > "$notif_path"
	done
done
