public class Sleep{
    public static void main(String[] args)  throws InterruptedException {
        System.out.println("Sleeping");
        Thread.sleep(Integer.MAX_VALUE);
        System.out.println("Woke up!");
    }
}