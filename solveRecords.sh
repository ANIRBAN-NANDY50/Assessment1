#!/bin/bash

file="Records.csv"

main_dir="Project_Directory"

mkdir -p "$main_dir"

month=$(date +%m)
year=$(date +%Y)

#echo "Month: $month"
#echo "Year: $year"

while IFS="," read -r Code FullName Bank Number Holder CVV IssueDate ExpiryDate BillingDate CardPIN CreditLimit
do	
	if [[ "$Code" = "Code" ]]; then
		continue
	fi


	card_code=$(echo "$Code")
	card_fullname=$(echo "$FullName")	
	card_number=$(echo "$Number") 
	card_bank=$(echo "$Bank")
	card_holder=$(echo "$Holder")
	card_cvv=$(echo "$CVV")
	card_issue=$(echo "$IssueDate")
	card_expiry=$(echo "$ExpiryDate")
	card_billing=$(echo "$BillingDate")
	card_pin=$(echo "$CardPIN")
	card_limit=$(echo "$CreditLimit")
	
	exp_month=$(echo "$ExpiryDate" | cut -d'/' -f1)
	exp_year=$(echo "$ExpiryDate" | cut -d'/' -f2)





	#echo "Month: $exp_month"
	#echo "Year: $exp_year"
	
	if [ "$exp_year" -gt "$year" ] || { [ "$exp_year" -eq "$year" ] && [ "$exp_month" -gt "$month" ] ; }
	then
		cardIs="active"
	else
		cardIs="expired"
	fi

	fullname_dir="$main_dir/$FullName"
	bank_dir="$fullname_dir/$Bank"

	mkdir -p "$bank_dir"

	new_file="${card_number}.${cardIs}"
	file_path="$bank_dir/$new_file"
	{
	  	echo "Card Code: $card_code"
   		echo "Card Full Name: $card_fullname"
	     	echo "Issuing Bank: $card_bank"
		echo "Card Number: $card_number"
		echo "Card Holder Name: $card_holder"
		echo "Card CVV/CVV2: $card_cvv"
		echo "Card Issue Date: $card_issue"
		echo "Card Expiry Date: $card_expiry"
		echo "Card Billing Date: $card_billing"
		echo "Card PIN: $card_pin"
		echo "Card Credit Limit: $card_limit USD"
		echo "------------------------------------"
	} > "$file_path"	

done < "$file"


