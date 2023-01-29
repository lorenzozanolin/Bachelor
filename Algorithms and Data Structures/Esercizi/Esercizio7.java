import java.util.Scanner;

public class Esercizio7 {
    public static void main(String[] args) {

        int[] vettore = CaricaArray();
        int s = Integer.valueOf(new Scanner(System.in).nextLine()); //ora legge il numero a capo

        int[] coppiaIndici = ordineNLogN(vettore,s); //coppia indici trovati
        System.out.println(coppiaIndici[0] + " " + coppiaIndici[1]);

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

        return array;
    }

    /**
     * RETURN the indexes of two elements of the array whose sum is equal to s
     * @param v: the integer array. REQUIRED non-null
     * @param s: represents the sum of two values that has to be matched
     * @return an integer array containing indexes of the couple of numbers found in the array, if none of the couples are valid returns an array containing {-1,-1}
     * i throw SOLO SE NON SONO GESTITI DENTRO CON I TRY E CATCH VANNO DICHIARATI NEL CONTRATTO
     */
    public static int[] ordineNQuadro(int[] v, int s){ //complessita' di O(n^2)
        try{
            int complementare;
            for(int i=0;i<v.length;i++){
                complementare =s-v[i];
                for(int j=i+1;j<v.length;j++){
                    if(v[j] == complementare)
                        return new int[] {i,j};
                }
            }
            return new int[]{-1,-1};
        }catch (NullPointerException npe){
            System.out.println("Array vuoto");
            return new int[]{-1,-1};
        }catch (ArrayIndexOutOfBoundsException aob){
            return new int[]{-1,-1};
        }
    }

    
    public static int[] ordineNLogN(int v[], int s) { //complessita' di O(nlogn)

        int complementare;
        int indice;
        for(int i=0;i<v.length;i++){ //per ogni elemento dell'array cerco con la ricerca binaria
            complementare = s - v[i]; //complementare da cercare all'interno dell'array
            indice = ricercaBinaria(v,complementare,i+1,v.length); //indice dell'elemento che sommato al complementare da s
            if(indice != -1) //se ha trovato effettivamente un'occorrenza
                return new int[]{i,indice};
        }
        return new int[]{-1,-1};
    }


    private static int ricercaBinaria(int[] a, int K, int i, int j) {
        if (j - i == 1) {
            if(a[i] == K)
                return i;
            else
                return -1;
        }
        int m = (j + i) / 2;
        if (a[m] == K) {
            return m;
        }
        if (a[m] < K) {
            return ricercaBinaria(a, K, m, j);
        } else {
            return ricercaBinaria(a, K, i, m-1);
        }
    }

}
