#!/bin/bash

fail=false
type=0 # check the command type

source settings.conf # import settings
dir=$(pwd) # store the current dir

# if no temp folder make one
if [[ ! -d temp ]]
then
    mkdir temp
fi

javac "$1"/*.java 2> temp/log.txt # compile

# check if we can proceed with testing the program
if [ -s temp/log.txt ] # check if log is empty
then
    cat temp/log.txt # there were compilation errors
    printf "\nThe java files didn't compile
Estimated grade: 0-49%%

Things to do:
- Perhaps the student accidentally missed a small syntax error?
- Read through the code to gague an idea of how well the student understands the algorithm
"
else
    cd "$1"
    # check cycle with regular 
    if [[ -f Enhex.java ]] # in the case where hex is used
    then
        cat "$dir"/test_files/"$input_plaintext" | java Enhex | java LZWencode | java LZWdecode | java Dehex > "$dir"/temp/out.txt 
        type=4
    elif [[ -f LZencode.java ]] # generic LZ
    then
        cat "$dir"/test_files/"$input_plaintext" | java LZencode | java LZdecode > "$dir"/temp/out.txt 
        type=1
    elif [[ -f LZWencode.java ]] # for LZW
    then
        (cat "$dir"/test_files/"$input_plaintext" | java LZWencode | java LZWdecode > "$dir"/temp/out.txt type=2) || (cat "$dir"/test_files/"$input_hex" | java LZWencode | java LZWdecode > "$dir"/temp/out.txt type=3)
    else 
        printf "\nSomething went a bit haywire with running the java files
Estimated grade: 0-89%%

Things that could've possibly happened:
- The student has named the java files incorrectly
- The student can't follow instructions and has decided to take in arguments instead of using standard i/o

Things to do:
- Rename the files to be correct
- If all else fails you might have to manually mark... sorry
"
        fail=true
    fi

    #check the sha256sum hashes
    cd "$dir"
    if [ type == 3 ] # special case for hex input
    then
        sha256sum test_files/"$input_hex" temp/out.txt > temp/log.txt # check shasum
    else
        sha256sum test_files/"$input_plaintext" temp/out.txt > temp/log.txt # check shasum
    fi

    # if the compress cycle is sucsessful, start the pack cycle
    if [ "$fail" == false ]
    then
        cd src
        equal=$(java comparesum) # check if sums match
        cd ..

        # if the sums match equal test the pack cycle
        if [ "$equal" == true ] 
        then
            printf "
LZ cycle sucsessful!
Current estimated grade: 85%%

Testing packer/unpacker...
"
            cd "$1"

            # test the pack/unpack cycle here 
            if [[ -f LZpack.java || -f LZWpack.java ]] # check if they did packing
            then
                if [ type == 1 ]
                then #printf "test each corresponding type of input THIS IS A TODO\n"
                    #this should work for lz77 and lz78 or lzw if named without the w
                    cat "$dir"/test_files/"$input_plaintext" | java LZencode | java LZpack | java LZunpack | java LZdecode > "$dir"/temp/out.txt
                elif [ type == 2 ]
                then
                    cat "$dir"/test_files/"$input_plaintext" | java LZWencode | java LZWpack | java LZWunpack | java LZWdecode > "$dir"/temp/out.txt
                elif [ type == 3 ]
                then
                    cat "$dir"/test_files/"$input_hex" | java LZWencode | java LZWpack | java LZWunpack | java LZWdecode > "$dir"/temp/out.txt
                elif [ type == 4 ]
                then
                    cat "$dir"/test_files/"$input_plaintext" | java Enhex | java LZWencode | java LZWpack | java LZWunpack | java LZWdecode | java Dehex > "$dir"/temp/out.txt
                fi

                cd "$dir"
                if [ type == 3 ] # special case for hex input
                then
                    sha256sum test_files/"$input_hex" temp/out.txt > temp/log.txt # check shasum
                else
                    sha256sum test_files/"$input_plaintext" temp/out.txt > temp/log.txt # check shasum
                fi

                cd src
                equal=$(java comparesum) # check if sums match
                cd ..

                if [ "$equal" == true ] # if equal test the pack cycle
                then
                    printf "
LZ cycle sucsessful!
Final grade: 100%% (A+)
"
                else
                    printf "
LZ cycle unsucsessful! Check if only the packer works manually
Estimated Final Grade: 85 - 95%%
"
                fi
            else
                printf "No packer/unpacker found
Final Grade: 89%% (A)"
            fi

        # otherwise compare the files 
        else
            if [ type == 3 ] # special case for hex input
            then
                cmp test_files/"$input_hex" temp/out.txt > temp/log.txt
            else
                cmp test_files/"$input_plaintext" temp/out.txt > temp/log.txt
            fi
            
            printf "
Looks like the sha256sum didn't match.
Estimated grade: 0-84%%

Check the log.txt file for detailed feedback via cmp

Things to check for:
- it could just be an extra null char or newline at the end of the file - don't take off marks for this
- The output/input may not be consistent (ie lower and upper case hex)
- anything more severe may need manual marking...

Log file contents:
"

            cat temp/log.txt
        fi
    fi
fi