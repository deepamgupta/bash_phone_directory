#! /bin/bash

while :; do
	echo "Welcome to phone directory"
	echo "1. Add a contact"
	echo "2. Search Contact"
	echo "3. Delete Contact"
	echo "4. View Phone Directory"
	echo "5. Quit"

	read -p "Enter your choice : " usr_cmd

	clear

	case $usr_cmd in
	1)
		echo "ADD NEW CONTACT"
		read -p "Enter Name : " name

		while [ -z $name ]; do
			read -p "Please Enter a name : " name
		done
		echo "Got that!"
		read -p "Enter Number : " number
		while [ -z $number ]; do
			read -p "Please Enter a number : " number
		done

		clear
		echo "New Contact Info : "
		echo "-> Name: $name. -> Number: $number"
		echo "$name : $number" >>phonedir.log
		echo "Saved Successfully!!"
		;;
	2)
		echo "SEARCH CONTACTS"
		read -p "Enter Contact Name to Search : " search_query
		clear
		echo "SEARCH RESULTS: "
		occurance=$(grep -c $search_query phonedir.log)
		if [ $occurance -eq 0 ]; then
			echo "It seems like there is no such entry."
		else
			grep -i $search_query phonedir.log #grep => globally search a regular expression and print
		fi
		;;
	3)
		echo "DELETE CONTACT"
		read -p "Enter contact name to be deleted(case-sensetive) : " delete_string
		sed -i -e "/$delete_string/d" phonedir.log #sed => stream editor
		echo "Deleted Successfully!!"
		;;
	4)
		echo "PHONE DIRECTORY"
		echo
		cat phonedir.log
		;;
	5) break ;;
	*) echo "INVALID OPTION, Please try again..." ;;
	esac

	echo "Press 5 to exit, anything else to return to main menu..."
	read -p ">> " confirm_exit

	if [ -z $confirm_exit ]; then
		confirm_exit=0
	fi

	if [ $confirm_exit -eq 5 ]; then
		break
	fi

done
