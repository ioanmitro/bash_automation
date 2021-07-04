#!/bin/bash

# The output will be split only if the input exceedsnout limit, but the split command 
# always creates at least one new file

#The following code illustrates a way to break up input into fixed sizes only
#if the input exceeds the size limit


#Output fixed-size pieces of input ONLY if the limit is exceeded 
# Called like: Split <file> <prefix> <limit option> <limit argument>
# e.g. Split $output ${output} 

function split {

	local file = $1
	local prfx = $2
	local limit_tp = $3
	local limit_sz = $4
	local wc_option


	# Sanity checks 
	if [ -z "$file" ]; then
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

#Convert split options to wc options. Sigh
# Not all options supported by all wc/splits on all systems

	case $limit_tp in 
		-b|--bytes) 		wc_option='-c';;
		-c|--line-bytes)	wc_option='-L';;
		-l|--lines)		wc_option='-l';;
	esac 

#If the limit is exceeded 
	if [ "$(wc $wc_option $file | awk '{print $1}')" -gt $limit_sz ]; then
	# Actually do something
		split --verbose $limit_tp $limit_sz $file $prfx
	fi 

}
