import java.math.BigInteger;
import java.util.InputMismatchException;
import java.util.Scanner;


public class Menu {
    private final Scanner scanner;

    public Menu(Scanner scanner) {
        this.scanner = scanner;
    }

    private void printMenu() {
        println("1. Create fraction;");
        println("2. +");
        println("3. -");
        println("4. *");
        println("5. /");
        println("6. Exit");
    }

    private static void print(String s) {
        System.out.print(s);
    }

    private static void println(String s) {
        System.out.println(s);
    }

    private BigFraction mainFraction = new BigFraction();
    private BigFraction secFraction = new BigFraction();
    private BigFraction res = new BigFraction();

    private boolean flag = false;

    private String num = "";
    private String den = "";

    private String getStringNum() {
        String num;
        do {
            print("Enter num: ");
            num = this.scanner.next();
            num = num.replaceAll("[^0-9-]", "");
            scanner.nextLine();
        } while (num.length() == 0);
        return num;
    }

    private String getStringDen() {
        String den;
        do {
            print("Enter den: ");
            den = this.scanner.next();
            den = den.replaceAll("[^0-9-]", "");
            scanner.nextLine();
        } while (den.length() == 0);
        return den;
    }

    private  void secFrac() {
        num = getStringNum();
        den = getStringDen();
        secFraction = new BigFraction(new BigInteger(num), new BigInteger(den));
    }

    private void printRes() {
        print("Your fraction: ");
        println(mainFraction.toString(10));
        print("Second fraction: ");
        println(secFraction.toString(10));
        print("Result: ");
        println(res.toString(10));
        println("-------------------------------------------");
    }

    private void operations(String op) {
        if (op.equals("+")) {
            secFrac();
            res = mainFraction.sum(secFraction);
            printRes();
        }
        if (op.equals("-")) {
            secFrac();
            res = mainFraction.sub(secFraction);
            printRes();
        }
        if (op.equals("*")) {
            secFrac();
            res = mainFraction.mul(secFraction);
            printRes();
        }
        if (op.equals("/")) {
            secFrac();
            res = mainFraction.div(secFraction);
            if (res != null) {
                printRes();
            } else {
                println("Please enter a non-null value!");
            }
        }
    }

    public void start() {
        if (this.scanner != null) {
            int key;

            do {
                printMenu();
                print("Input the number: ");
                key = 0;

                try {
                    key = this.scanner.nextInt();
                } catch (InputMismatchException e) {
                    println("Input the number from 1 to 7!");
                    scanner.nextLine();
                    println("");
                    continue;
                }

                switch (key) {
                    case 1 -> {
                        num = getStringNum();
                        den = getStringDen();
                        mainFraction = new BigFraction(new BigInteger(num),
                                new BigInteger(den));
                        flag = true;
                        print("Your fraction: ");
                        println(mainFraction.toString(10));
                        println("-------------------------------------------");
                    }
                    case 2 -> {
                        if (flag) {
                            operations("+");
                        } else {
                            println("Enter the fraction!!");
                        }
                    }
                    case 3 -> {
                        if (flag) {
                            operations("-");
                        } else {
                            println("Enter the fraction!!");
                        }
                    }
                    case 4 -> {
                        if (flag) {
                            operations("*");
                        } else {
                            println("Enter the fraction!!");
                        }
                    }
                    case 5 -> {
                        if (flag) {
                            operations("/");
                        } else {
                            println("Enter the fraction!!");
                        }
                    }
                    case 6 -> println("Exit...");
                    default -> println("Error!!!");
                }
            } while (key != 6);
        }
    }

}
