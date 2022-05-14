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
    # java Stars <test file> <index in csv for start point> <index in csv for end point> <distance value>
    printf "Testing Small CSV\n"
    java Stars "$dir"/test_files/"$small_csv" "$start_index_1" "$end_index_1" "$small_D"
    java Stars "$dir"/test_files/"$small_csv" "$start_index_1" "$end_index_1" "$large_D"
    printf "Testing Medium CSV\n"
    java Stars "$dir"/test_files/"$mid_csv" "$start_index_2" "$end_index_2" "$small_D"
    java Stars "$dir"/test_files/"$mid_csv" "$start_index_2" "$end_index_2" "$large_D"
    printf "Testing Large CSV\n"
    java Stars "$dir"/test_files/"$large_csv" "$start_index_3" "$end_index_3" "$small_D"
    java Stars "$dir"/test_files/"$large_csv" "$start_index_3" "$end_index_3" "$large_D"

    printf "
Grading:
For each test that doesn't work correctly remove around 1.5 marks,
dependant on how well the algorithm attempt is.
"
fi