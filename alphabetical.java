import java.io.*;

public class alphabetical {
    public static void main(String[] args) {
        try {
            File sorted = new File("temp/sorted.txt");
            BufferedReader br = new BufferedReader(new FileReader(sorted));
            String one = br.readLine();
            String two = br.readLine();
            int compare = one.compareTo(two);
            while(compare <= 0) {  // loop to check order
                one = two;
                two = br.readLine();
                if (two == null)
                    break;
                else
                compare = one.compareTo(two);
            }  
            if (compare > 0){ // print out the place where there is an issue for err checking
                System.out.println(one);
                System.out.println(two);
            }
            else
                System.out.println("Alphabetical order check sucsessful!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
