#!/bin/bash

source settings.conf # import settings
dir=$(pwd) # store the current dir

# if no temp folder make one
if [[ ! -d temp ]]
then
    mkdir temp
fi

javac "$1"/*.java 2> temp/log.txt # compile

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
    if [[ -f REcompile.java && -f REsearch.java ]]
    then # run the different regex tests
        java REcompile "$regex_0" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/regout_0.txt
        java REcompile "$regex_1" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/regout_1.txt
        java REcompile "$regex_2" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/regout_2.txt
        java REcompile "$regex_3" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/regout_3.txt
        java REcompile "$regex_4" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/regout_4.txt
        java REcompile "$regex_5" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/regout_5.txt
        java REcompile "$regex_6" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/regout_6.txt
        java REcompile "$regex_7" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/regout_7.txt
        java REcompile "$regex_8" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/regout_8.txt 
        java REcompile "$regex_9" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/regout_9.txt
        java REcompile "$regex_fail" > "$dir"/temp/errout.txt
        cd "$dir"/src
        java checkregex "$search_file"
        printf "\nFor any tests that fail, check a few things:
- Make sure the rules in the README cover it
- The student has formatted the output incorrectly
- The program doesn't actually work...
- As a last resort, mark manually

Results:
Deduct approx 1.5 marks for each failed test
However this can sway depending on further testing and understanding
"
    else
        printf "\nSomething went a bit haywire with running the java files
Estimated grade: 0-89%%

Things that could've possibly happened:
- The student has named the java files incorrectly
- There is only one of the files submitted
- The student can't follow instructions and has decided to take in arguments instead of using standard i/o

Things to do:
- Rename the files to be correct
- If all else fails you might have to manually mark... sorry
"
    fi
fi
