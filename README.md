# COMPX301 AutoMark

As the COMPX301 tutor for 2022 I realised that marking is tedious. So of course I automate it.

## Running the Software

Run `automark.sh <option> <directory>` to mark a students submission

You may need to `chmod 744 *.sh` to be able to run the bash files

```
Options are:
-h             view help menu
-s             mark sorting algorithm (works with both external sort and polyphase)
-c             mark compression algorithm (works with LZ77, LZ78 and LZW)
-r             mark regex and search
-a             mark A*

For example:
automark.sh -r ../12345_12345/
Will mark a students regex and search assignment in the 12345_12345 folder 
(remember the .. to go up a directory)
```

## Assumptions

- The file names are well formed and the students have followed all assessment instructions
- This is based on the 2021 and 2022 assignment specifications (however it could be adapted for other changes)

## Modifications

If you would like to modify the parameters of the tests themselves, then below are instructions in order to go about it.

Currently answers for the Regex and A* markers must be manually written, automatic solution generation may or may not be avaliable in the future.

### settings.conf

This file determines the parameters each test is run with. They are separated into categories based on each assignment. Refer to the comments by each setting for detailed information about each one.

Some things to note:

- File names must not include directories, unless if they are subdirectories inside `test_files`
- The first merge in the **Sorting** test should default to 2, so no parameter is given
- The contents of the hex file for **Compression** should consist of upper-case hex characters on a single line: this may or may not be able to be auto generated in the future
- The final test in **Regex** should intentionally be an illegal expression
- The start and end values for **A\*** are the indexes of the coodinates in the CSV file. Just take the line number in the corresponding CSV and subtract 1.

### Replacing Testing Files

You can add new testing files into the `test_files` directory. Remember to update the reference in the `settings.conf` file.

### Auto Generating Solutions

This is on the todolist, needs to be done without allowing students to view the code.
## Todos

- A*: get solutions to the tests? If uses GUI how to verify?
- Implement config mods
- Make getting awnswers for regex and a* more intuitive -  auto solution generator?
- Same thing for generating hex from plaintext?
- Code/comment cleanup and put files in src
- Better feedback for compression and regex
