public class AvailableProcessors {
    public static void main(String[] args) {
        System.out.println("availableProcessors : " + (Runtime.getRuntime()).availableProcessors());
        System.err.println("availableProcessors : " + (Runtime.getRuntime()).availableProcessors());
    }
}
