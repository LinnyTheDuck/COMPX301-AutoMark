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

For example:
automark.sh -r ../12345_12345/
Will mark a students regex and search assignment in the 12345_12345 folder (remember the .. to go up a directory)
```

## Assumptions
- The file names are well formed and the students have followed all asessment instructions
- This is based on the 2021 and 2022 assignment specifications (however it could be adapted for other changes)

## Todos
- Sorting: alphabet check, bash script
- Compression: more accurate cmp feedback, pack/unpack cycle