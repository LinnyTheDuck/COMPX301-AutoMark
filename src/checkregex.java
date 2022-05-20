import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class checkregex {
    public static List<String> lines = new ArrayList<String>();
    public static File answers = new File("../test_files/answers.txt");
    public static void main(String[] args) {
        try {
            File quotes = new File("../test_files/" + args[0]); // input file
            lines = read(quotes); // get full file for checking purposes
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

            System.out.println("Total Tests Passed: " + pass);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static int checks(){
        int totalpass = 0, totaltests = 0; // number of tests passed
        boolean worked = true;
        File[] farray = filearray();
        try {
            BufferedReader br = new BufferedReader(new FileReader(answers));
            for (File file : farray) { // for each of the output files
                BufferedReader b = new BufferedReader(new FileReader(file)); // have a file read in

                String[] num = new String[20]; // should be a list
                num = br.readLine().split(" "); // convert to ints later ig
                // TODO: store all the indexes inside the list as integers

                for (String s : num) { // compare the ith line to the ith index value in the source
                    String out = b.readLine();
                    if(!out.equals(lines.get(Integer.parseInt(s)))){ // if matches keep going
                        System.out.println("===== FILE " + totaltests + " CONTENTS =====");
                        // print out all file contents
                        System.out.println("\n===== FILE " + totaltests + " EXPECTED CONTENTS =====");
                        // print out all expected contents
                        //System.out.println(out);
                        worked = false;
                        break; // break out of looking at the file
                    }
                }
                if (worked)
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

    public static File[] filearray(){
        File[] outlines = new File[10]; // shove all the output files in an array idk
        for(int i = 0; i < 10; i++){
            outlines[i] = new File("../temp/regout_" + i + ".txt");
        }
        return outlines;
    }

    public static List<String> read(File f){
        List<String> lines_out = new ArrayList<String>(); // use a list instead of array
        try {
            BufferedReader br = new BufferedReader(new FileReader(f)); 
            String l = br.readLine();
            lines_out.add(0, ""); // just a placeholder that's never used
            int i = 1;
            while(l != null) { // fill up list
                lines_out.add(i, l); // add l to be the ith element 
                i++;
                l = br.readLine();
            }
            br.close();
        } catch (Exception e) {
            System.err.println("error with reading the input file");
            e.printStackTrace();
        }
        return lines_out;
    }
}
