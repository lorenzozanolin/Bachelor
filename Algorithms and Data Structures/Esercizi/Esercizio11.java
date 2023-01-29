import java.util.Scanner;

public class Esercizio11{

    private static int periodIterative(String S) {

        int n = S.length();
        int[] r = new int[n];
        r[0] = -1;
        int z;

        char x;
        char y;
        String str;

        for (int i = 0; i < n-1; i++) {
            
            z = r[i];
            x = S.charAt(z+1);
            y = S.charAt(i+1);
            str = S.substring(0, i+1);

            while ( (z >= 0) && (S.charAt(z+1) != S.charAt(i+1)) ) {
                z = r[z];
            }
            
            if ( S.charAt(z+1) == S.charAt(i+1) ) {
                r[i+1] = z+1;
            } else {
                r[i+1] = -1;
            }

        }
        
        return n - (r[n-1] + 1); 

    }

    public static void main(String[] args) {

        Scanner S = new Scanner(System.in);
        String myString = S.nextLine();
        S.close();
        System.out.println( periodIterative(myString) );
        
    }

}