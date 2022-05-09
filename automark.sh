#!/bin/bash

if [ "$1" == '-h' ]
then   
    printf "How To Use This Program:
automark.sh <option> <directory>

Options are:
-h             view help menu
-s             mark sorting algorithm (works with both external sort and polyphase)
-c             mark compression algorithm (works with LZ77, LZ78 and LZW)
-r             mark regex and search
-a             mark A*

For example:
automark.sh -r ../12345_12345/
Will mark a students regex and search assignment in the 12345_12345 folder (remember the .. to go up a directory)
"
else
    javac *.java # complie java programs
    if [ -z "$2" ] # error checking
    then
        printf "no directory specified, run 'automark.sh -h' to see instructions \n"
    elif [ -z "$1" ]
    then
        printf "no option specified, run 'automark.sh -h' to see instructions \n"
    else
        if [ "$1" == '-s' ] # running options
        then
            ./sorting.sh "$2"
        elif [ "$1" == '-c' ]
        then
            ./compression.sh "$2"
        elif [ "$1" == '-r' ]
        then
            ./regex.sh "$2"
        elif [ "$1" == '-a' ]
        then
            ./astar.sh "$2"
        else # more error checking
            printf "invalid option, run 'automark.sh -h' to see instructions \n"
        fi
    fi
fi