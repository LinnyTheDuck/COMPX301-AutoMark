import java.io.*;

public class checkregex {
    public static String[] lines; // global for full file
    public static File answers = new File("test_files/answers.txt");
    public static void main(String[] args) {
        try {
            File quotes = new File("test_files/Quotes.txt");
            lines = read(quotes); // get full file for checking purposes
            int pass = checks(); // run checks for the output files

            File empty = new File("temp/errout.txt"); // should be empty
            BufferedReader br = new BufferedReader(new FileReader(empty));
            String line = br.readLine();
            if (line == null) //System.out.println("No errors, and file empty");
                pass++;
            else
                while(line != null){
                    System.out.println(line);
                    line = br.readLine();
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
            for (File file : farray) { // for each of teh files
                BufferedReader b = new BufferedReader(new FileReader(file)); // have a file read in
                String[] num = new String[20];
                num = br.readLine().split(" "); // convert to ints later ig
                for (String s : num) { // compare the ith line to the ith index value in the source
                    String out = b.readLine();
                    if(!out.equals(lines[Integer.parseInt(s)])){ // if matches keep going
                        System.out.println("File Number: " + totaltests);
                        System.out.println(out);
                        worked = false;
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
            outlines[i] = new File("temp/regout_" + i + ".txt");
        }
        return outlines;
    }

    public static String[] read(File f){
        String[] lines_out = new String[53]; // array of length 51
        try {
            BufferedReader br = new BufferedReader(new FileReader(f)); 
            String l = br.readLine();
            int i = 1;
            while(l != null) { // fill up array
                lines_out[i] = l;
                i++;
                l = br.readLine();
            }
            br.close();
        } catch (Exception e) {
            System.err.println("error with reading the quotes files");
            e.printStackTrace();
        }
        return lines_out;
    }
}
