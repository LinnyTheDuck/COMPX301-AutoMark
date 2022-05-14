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
    printf "
The java files didn't compile
Estimated grade: 0-49%%

Things to do:
- Perhaps the student accidentally missed a small syntax error?
- Read through the code to gague an idea of how well the student understands the algorithm
"
else
    cd "$1"
    if [[ -f DistributeRuns.java && -f MergeRuns.java ]]
    then
        cat "$dir"/test_files/"$input_sort" | java CreateRuns "$create_num_1" | java MergeRuns > "$dir"/temp/sorted.txt # default of 2 way merge
        cd "$dir"/src
        java alphabetical "$input_sort"
        rm ../temp/sorted.txt # just incase
        cd ../"$1"
        cat "$dir"/test_files/"$input_sort" | java CreateRuns "$create_num_2" | java MergeRuns "$merge_way" > "$dir"/temp/sorted.txt
        cd "$dir"/src
        java alphabetical "$input_sort"
    else
    printf "
Something went a bit haywire with running the java files
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