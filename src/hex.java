import java.util.Scanner;

public class hex {

    public static void main(String[] args) {
        Scanner S = new Scanner(System.in).useDelimiter("(\\b|\\B)");
        String inputString = "";

        while (S.hasNext()) {
            inputString += S.next();
        }
        toHexadecimal(inputString);
        S.close();
    }

    public static void toHexadecimal(String text) {
        byte[] bytes;
        try {
            bytes = text.getBytes("UTF-8");
            for (byte b : bytes) {
                String s = String.format("%02X", b);
                System.out.print(s.toUpperCase());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
