import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class checkregex {
    public static List<String> searchLines = new ArrayList<String>();
    public static File answers = new File("../test_files/answers.txt");
    public static void main(String[] args) {
        try {
            File fileToSearch = new File("../test_files/" + args[0]); // input file
            searchLines = read(fileToSearch); // get full file for checking purposes
            int pass = checks(); // run checks for the output files

            // this checks the error test
            File empty = new File("../temp/errout.txt"); // should be empty, errors print to System.err
            BufferedReader br = new BufferedReader(new FileReader(empty));
            String line = br.readLine();
            if (line == null) // if the file is empty
                pass++;
            else{ // otherwise print out contents for debugging purposes
                System.out.println("===== START ERROR OUTPUT =====");
                while(line != null){
                    System.out.println(line);
                    line = br.readLine();
                }
                System.out.println("===== FINISH ERROR OUTPUT =====");
            }
            br.close();

            System.out.println("\nTotal Tests Passed: " + pass);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static int checks(){
        int totalpass = 0, totaltests = 0; // number of tests passed
        boolean worked = true; // toggles false to allow for counting
        File[] outputFiles = gatherOutputFiles(); // stores the output files in an array

        try {
            BufferedReader br = new BufferedReader(new FileReader(answers));

            for (File file : outputFiles) { // for each of the output files
                BufferedReader b = new BufferedReader(new FileReader(file)); // have a file read in

                String[] answerLine = new String[1000]; // should be a list, but I dont think there will be more than 1000 matches?
                answerLine = br.readLine().split(" "); // convert to ints later ig

                for (String s : answerLine) { // compare the ith line to the ith index value in the source
                    String output = b.readLine();
                    if(!output.equals(searchLines.get(Integer.parseInt(s)))){ // if matches keep going
                        System.out.println("===== FILE " + totaltests + " CONTENTS ====="); // print out all file contents
                        Runtime rt = Runtime.getRuntime();
                        Process p = rt.exec("cat ../temp/" + file.getName()); // run bash command
                        BufferedReader console = new BufferedReader(new InputStreamReader(p.getInputStream()));
                        String str; // passes to reader, print reader contents to console
                        while((str = console.readLine()) != null){
                            System.out.println(str);
                        }

                        System.out.println("\n===== FILE " + totaltests + " EXPECTED CONTENTS =====");
                        for (String st : answerLine) { // print out all expected contents
                            System.out.println(searchLines.get(Integer.parseInt(st)));
                        }

                        worked = false;
                        break; // break out of looking at the file
                    }
                }

                if (worked) // check to increment counter
                    totalpass++;
                else
                    worked = true;
                totaltests++;
                b.close();
            }

            br.close();
        } catch (Exception e) {
            System.err.println("something went wrong with the tests");
            e.printStackTrace();
        }

        return totalpass;
    }

    public static File[] gatherOutputFiles(){
        File[] outputFiles = new File[10]; // shove all the output files in an array idk
        for(int i = 0; i < 10; i++){
            outputFiles[i] = new File("../temp/regout_" + i + ".txt");
        }
        return outputFiles;
    }

    public static List<String> read(File f){
        List<String> linesOut = new ArrayList<String>(); // use a list instead of array
        try {
            BufferedReader br = new BufferedReader(new FileReader(f));
            String l = br.readLine();
            linesOut.add(0, ""); // just a placeholder that's never used
            int i = 1;
            while(l != null) { // fill up list
                linesOut.add(i, l); // add l to be the ith element
                i++;
                l = br.readLine();
            }
            br.close();
        } catch (Exception e) {
            System.err.println("error with reading the input file");
            e.printStackTrace();
        }
        return linesOut;
    }
}
