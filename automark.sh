#!/bin/bash

if [ "$1" == '-h' ]
then   
    printf "How To Use This Program:
./automark.sh <options> <directory>

Options are:
-h                              view help menu

--generate <algorithm_option>   generate solutions for a specified algorithm (compression and A*)
--hex <input_file>              generate a hex output for a plaintext input

-s                              mark sorting algorithm (works with both external sort and polyphase)
-c                              mark compression algorithm (works with LZ77, LZ78 and LZW)
-r                              mark regex and search
-a                              mark A*

For example:
./automark.sh -r ../12345_12345/
Will mark a students regex and search assignment in the 12345_12345 folder (remember the .. to go up a directory)

./automark.sh --generate -r
Will generate a regex solution based on the parameters specified in settings.conf
"
else
    cd src
    javac *.java # complie java programs
    cd ..
    if [ "$1" == '--generate' ]
    then
        if [ "$2" == '-r' ]
        then
            printf "Generating Regex Solution: On the TODO list\n"
        elif [ "$2" == '-a' ]
        then
            printf "Generating A\* Solution: On the TODO list\n"
        else # more error checking
            printf "no algorithm specified, run 'automark.sh -h' to see instructions \n"
        fi
    elif [ "$1" == '--hex' ]
    then
        if [ -z $2 ]
        then
            printf "no file specified, run './automark.sh -h' to see instructions \n"
        else
            printf "Generating hex file: On the TODO list\n"
        fi
    elif [ -z "$2" ] # error checking
    then
        printf "no directory specified, run './automark.sh -h' to see instructions \n"
    elif [ -z "$1" ]
    then
        printf "no option specified, run './automark.sh -h' to see instructions \n"
    else
        if [ "$1" == '-s' ] # running options
        then
            ./src/sorting.sh "$2"
        elif [ "$1" == '-c' ]
        then
            ./src/compression.sh "$2"
        elif [ "$1" == '-r' ]
        then
            ./src/regex.sh "$2"
        elif [ "$1" == '-a' ]
        then
            ./src/astar.sh "$2"
        else # more error checking
            printf "invalid option, run 'automark.sh -h' to see instructions \n"
        fi
    fi
fi