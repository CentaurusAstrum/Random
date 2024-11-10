public class prime {
    public static void main(String[] args) {
        
        int uniqueNumber[] = new int[100];

        for (int i = 1; i < uniqueNumber.length; i++) {
            boolean multiple = false;
            uniqueNumber[i] = i;
            for (int j = 1; j < i; j++) {
                if(uniqueNumber[i] % uniqueNumber[j] == 0) {
                    uniqueNumber[i] = 1;
                }
            }
        }
        for (int i : uniqueNumber) {
            System.out.println(i);
        }
    }
}
