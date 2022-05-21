#!/bin/bash
# this bash doesn't do good checks yet, it assumes the program is correct

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
    printf "\nThe java files didn't compile, I don't think these solutions will work...
"
else
    cd "$1"
    if [[ -f REcompile.java && -f REsearch.java ]]
    then # run the different regex tests
        java REcompile "$regex_0" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/ans_regout_0.txt
        java REcompile "$regex_1" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/ans_regout_1.txt
        java REcompile "$regex_2" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/ans_regout_2.txt
        java REcompile "$regex_3" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/ans_regout_3.txt
        java REcompile "$regex_4" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/ans_regout_4.txt
        java REcompile "$regex_5" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/ans_regout_5.txt
        java REcompile "$regex_6" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/ans_regout_6.txt
        java REcompile "$regex_7" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/ans_regout_7.txt
        java REcompile "$regex_8" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/ans_regout_8.txt 
        java REcompile "$regex_9" | java REsearch "$dir"/test_files/"$search_file" > "$dir"/temp/ans_regout_9.txt
        cd "$dir"/src

        #java createregexsoln "$search_file" # create the actual answers.txt file here

        cd "$dir"/temp
        rm ans_*
        printf "\nSolutions created!
"
    else
        printf "\nSomething went a bit haywire with running the java files, I don't think this solution works...
"
    fi
fi

