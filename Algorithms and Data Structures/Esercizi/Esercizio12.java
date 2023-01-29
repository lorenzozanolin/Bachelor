import java.util.Scanner;

public class Esercizio12 {
    
    public static void main(String[] args) {

        int[] vettore = CaricaArray();
        insertionSort(vettore);
        for(int i : vettore){
            System.out.println(i);
        }
    }

    private static int[] CaricaArray(){

        Scanner input = new Scanner(System.in); //una volta che lo legge, va alla riga a capo..anche se lo richiamo su un'altra istanza Scanner
        String s = input.nextLine(); //dato che devo prendere i numeri senza gli spazi
        String[] vettorePulito = s.split(" ");

        int[] array = new int[vettorePulito.length];
        int i=0;

        for(String st : vettorePulito){
            array[i] = Integer.valueOf(st);
            i++;
        }
        //input.close();
        return array;
    }

    public static void insertionSort(int[] arr){
        int n = arr.length;
        for (int i = 1; i < n; i++) {
            int key = arr[i];
            int j = i - 1;
 
            /* Move elements of arr[0..i-1], that are
               greater than key, to one position ahead
               of their current position */
            while (j >= 0 && arr[j] > key) {
                arr[j + 1] = arr[j];
                j = j - 1;
            }
            arr[j + 1] = key;
        }
    }
}
