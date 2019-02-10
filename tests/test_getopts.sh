#!/bin/bash

function test1 () {
    function func_usage() { echo "test1 -ac -b <parameter>"; return 0 ; }
    
    local OPTIND opt a b c
    while getopts "ab:c" opt; do ## -a and -c are flags, -b is option with argument 
	case "$opt" in
		a)
		echo "-a triggered"
		;;
		b)
		echo "setting local variable b"
		local b=$OPTARG  ##OPTARG stores the flag or unknown option
		echo "local b is $b"
		;;
		c)
		echo "-c triggered"
		;;
		\?)   ## What is \?
        	func_usage
		return 1
        	;;
	        :)
		func_usage
		return 1           	
		;;
       	esac
    done
    return 0
}
