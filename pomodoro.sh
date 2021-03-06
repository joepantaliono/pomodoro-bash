bold=$(tput bold)
normal=$(tput sgr0)
sessions=0
secs=60

pomo_main () {
	take_input
	while [ $sessions -lt 10 ]; do
		pomo_study
		pomo_break
		let sessions++
	done
}

take_input () {
	echo "Welcome to ${bold}Pomodoro Timer! ${normal}This timer will run for 10 sessions"
	echo "You can quit at any time by pressing CTRL+C [^C]"
	read -p "How many minutes do you want to study for? " study_length
	if ! [[ $study_length =~ ^-?[0-9]+$ ]]; then
		echo "Please enter an integer."
		take_input
	fi
	read -p "How many minutes for breaks? " break_length
	if ! [[ $break_length =~ ^-?[0-9]+$ ]]; then
		echo "Please enter an integer."
		take_input
	fi
}

pomo_timer () {
	while [ $mins -gt 0 ]; do
                while [ $secs -gt 0 ]; do
                        # -ne: -n blocks newline, -e interprets backslash symbols
                        # \033[0K deletes to end of line
                        # \r carriage return
			if [ $secs -le 10 ]; then
                        	echo -ne "$message Time left:${bold} $((mins-1)):0$((secs-1))\033[0K\r"
                        else
				echo -ne "$message Time left:${bold} $((mins-1)):$((secs-1))\033[0K\r"
			fi
			sleep 1
                        let secs--
		done
	let mins--
	secs=60
	done
	osascript -e 'display notification "Great work! Keep going." with title "Times up!" sound name "bell.wav"'
	
}

pomo_study () {
	read -p "Get ready! ${bold}Press enter ${normal}when you're ready to study!"
	mins=$study_length
	message="${bold}Studying! ${normal}Get to work!"
	pomo_timer
}

pomo_break () {
	read -p "Great job! ${bold}Press enter ${normal}when ready for break!"
	mins=$break_length
	message="${bold}On break! ${normal}Enjoy your break!"
	pomo_timer

}

pomo_main
