read -p "How many minutes do you want to study for? " study_length
read -p "How many minutes for breaks? " break_length
echo "You'll study for $study_length minutes with a $break_length minute break."
secs=60
mins=$study_length
pomo_study () {
	# while seconds is greater than 0
	while [ $secs -gt 0 ]; do
		# -ne: -n blocks newline, -e interprets backslash symbols
		# \033[0K deletes to end of line
		# \r carriage return
		echo -ne "Get to work! Time left: $((mins-1)):$secs\033[0K\r"
		sleep .1
		let secs--
	done
}


pomo_main () {
	while [ $mins -gt 0 ]; do
		pomo_study
		secs=60
		let mins--
	done
}

pomo_main
