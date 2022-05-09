#!/bin/bash

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
        java REcompile "hon" | java REsearch "$dir"/test_files/Quotes.txt > "$dir"/temp/regout_0.txt
        java REcompile "..!" | java REsearch "$dir"/test_files/Quotes.txt > "$dir"/temp/regout_1.txt
        java REcompile "\*p?" | java REsearch "$dir"/test_files/Quotes.txt > "$dir"/temp/regout_2.txt
        java REcompile "\qu?" | java REsearch "$dir"/test_files/Quotes.txt > "$dir"/temp/regout_3.txt
        java REcompile "\*p*" | java REsearch "$dir"/test_files/Quotes.txt > "$dir"/temp/regout_4.txt
        java REcompile "\*p+" | java REsearch "$dir"/test_files/Quotes.txt > "$dir"/temp/regout_5.txt
        java REcompile "ki|SAm|h.p" | java REsearch "$dir"/test_files/Quotes.txt > "$dir"/temp/regout_6.txt
        java REcompile "m[aoieu]n" | java REsearch "$dir"/test_files/Quotes.txt > "$dir"/temp/regout_7.txt
        java REcompile "(p|c)l(a+|e+)" | java REsearch "$dir"/test_files/Quotes.txt > "$dir"/temp/regout_8.txt 
        java REcompile "pr+[oe]" | java REsearch "$dir"/test_files/Quotes.txt > "$dir"/temp/regout_9.txt
        java REcompile "???***" > "$dir"/temp/errout.txt
        cd "$dir"
        java checkregex
        printf "\nFor any tests that fail, check a few things:
- Make sure the rules in the README cover it
- The student has formatted the output incorrectly
- The program doesn't actually work...
- As a last resort, mark manually
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
