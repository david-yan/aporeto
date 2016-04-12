STATES=(Alabama Alaska Arizona Arkansas California Colorado Connecticut Delaware Florida Georgia Hawaii Idaho Illinois Indiana Iowa Kansas Kentucky Louisiana Maine Maryland Massachusetts Michigan Minnesota Mississippi Missouri Montana Nebraska Nevada "New Hampshire" "New Jersey" "New Mexico" "New York" "North Carolina" "North Dakota" Ohio Oklahoma Oregon Pennsylvania "Rhode Island" "South Carolina" "South Dakota" Tennessee Texas Utah Vermont Virginia Washington "West Virginia" Wisconsin Wyoming)


#Check for no arguments
if [ $# -eq 0 ]; then
	echo "ERROR: Missing arguments or options"
	echo "(run $0 --help|-h for help)"
	exit 1
fi

if [[ $1 == --create-file=* ]]; then
	filename=$(echo $1| cut -d"=" -f 2)
	if [ -z $filename ]; then
		echo "ERROR: cannot have empty filename"
		echo "(run $0 --help|-h for help)"
		exit 1
	fi

	#Check options
	NOPROMPT=false
	VERBOSE=false
	CREATE_FILE=false
	for option in "$@"; do
		if [ $option = "--no-prompt" ]; then
			if $NOPROMPT; then
				echo "ERROR: Repeated option --no-prompt"
				echo "(run $0 --help|-h for help)"			
				exit 1
			fi
			NOPROMPT=true
		elif  [ $option = "--verbose" ]; then
			if $VERBOSE; then
				echo "ERROR: Repeated option --verbose"
				echo "(run $0 --help|-h for help)"
				exit 1
			fi
			VERBOSE=true
		elif [[ $option = --create-file=* ]]; then
			if $CREATE_FILE; then
				echo "ERROR: Cannot create multiple files"
				echo "(run $0 --help|-h for help)"
				exit 1
			fi
			CREATE_FILE=true
		else
			echo "ERROR: Invalid argument $option"
			echo "(run $0 --help|-h for help)"
			exit 1
		fi
	done

	if [ -e $filename ] && $VERBOSE; then
		echo "File already exists"
	fi

	if [ -e $filename ] && ! $NOPROMPT; then
		valid=false
		while ! $valid; do
			read -p "File exists. Overwrite (y/n) ?"
			if [ $REPLY = "y" ]; then
				valid=true
				rm $filename
				if [ $VERBOSE ]; then
					echo "File removed"
				fi
			elif [ $REPLY = "n" ]; then
				valid=true
				exit 0
			fi
		done
	fi
	printf "%s\n" "${STATES[@]}" > $filename
	if $VERBOSE; then
		echo "File created"
	fi
elif [ $1 = "-h" ] || [ $1 = "--help" ]; then
	if [ ! $# -eq 1 ]; then
		echo "ERROR: Invalid arguments"
		echo "(run $0 --help|-h for help)"
		exit 1
	fi
	echo "Usage: bash_example --create-file=<filename> [options]"
	echo "	options:"
	echo "	  --no-prompt		Automatically overwrites file"
	echo "	  --verbose"
else
	echo "ERROR: Invalid arguments"
	echo "(run $0 --help|-h for help)"
	exit 1
fi
exit 0
