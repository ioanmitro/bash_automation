#!/bin/bash

# The output will be split only if the input exceedsnout limit, but the split command 
# always creates at least one new file

# The following code illustrates a way to break up input into fixed sizes only
# if the input exceeds the size limit

# Function of fixed-size pieces split when the limit is exceeded 
function split {

	local myfile = $1
	local prfx = $2
	local limit_tp = $3
	local limit_sz = $4
	local wc_option
 
	if [ -z "$myfile" ]; then
		printf "%b" "Split: requires a valid file name!\n"
		return 1
	fi 
	if [ -z "$prfx" ]; then
		printf "%b" "Split: requires an output file prefix!\n"
		return 1
	fi 
	if [ -z "$limit_tp" ]; then
		printf "%b" \
		   "Split: requires a limits option!\n"
		return 1
	fi 

	if [ -z "$limit_sz" ]; then
		printf "%b" "Split: requires a limit size!\n"
		return 1
	fi
	
	# Split options to wc options
	case $limit_tp in 
		-b|--bytes) 		wc_option='-c';;
		-c|--line-bytes)	wc_option='-L';;
		-l|--lines)		wc_option='-l';;
	esac 

	# If limit size exceeded 
	if [ "$(wc $wc_option $file | awk '{print $1}')" -gt $limit_sz ]; then
		# Split into pieces
		split --verbose $limit_tp $limit_sz $myfile $prfx
	fi 

}
