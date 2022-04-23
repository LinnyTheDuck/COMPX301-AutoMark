import java.io.*;

public class comparesum {
    public static void main(String[] args) {
        try {
            BufferedReader br = new BufferedReader(new FileReader("temp/log.txt"));
            String[] orig = br.readLine().split("  ");
            String[] out = br.readLine().split("  "); // take the hashes

            if(out[0].equals(orig[0])) // std output result of comparison
                System.out.print("true");
            else
                System.out.print("false");

            br.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}