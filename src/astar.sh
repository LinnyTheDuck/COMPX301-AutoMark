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
    printf "Testing 4th CSV\n"
    java Stars "$dir"/test_files/"$fourth_csv" "$start_index_4" "$end_index_4" "$small_D"
    java Stars "$dir"/test_files/"$fourth_csv" "$start_index_4" "$end_index_4" "$large_D"

    printf "
Grading:
[10 mks] test cases for small.csv work fine
[10 mks] test cases for clusters.csv work fine
[10 mks] test cases for spiral.csv works fine
[10 mks] test cases for trap.csv works fine
[5 mks] Code check: A* is clearly visible and correct in the code (I have asked them to clearly highlight where the A* code is)
[5 mks] Code check: comments, formatting, etc, correct
Deduct marks for instructions not being followed
Deduct marks if test cases that should fail do not fail gracefully (e.g. due to low D, or incorrect command line parameters)
Deduct marks if runtime is unusually slow \– I\’ve talked about some common sense optimisations in the lecture

Total marks: 50

Solution verifying will have to be eyeballed, according to Michael
"
fi