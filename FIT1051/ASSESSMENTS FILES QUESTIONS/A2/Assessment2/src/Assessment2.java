/*
 * Assessment 2
 *
 * Copyright (c) 2022  Monash University
 *
 * Written by  Jonny Low
 *
 *
 */

import java.util.Scanner; // Import this to be able to use scanner class

public class Assessment2 {
    public static void main(String[] args){

        Assessment2 a2 = new Assessment2();

        // Instruction: To run your respective task, uncomment below individually
        a2.task1();
        a2.task2();
        a2.task3();
        a2.task4();

//        test your task 5 here
        double a = 7.0;
        double b = 4.0;
        a2.pythagorasTheorum(a,b);
        // Testing 1: a = 7.0 while b = 4.0 which gives output of 8.06225774829855 but I coded it to give output with 2 decimal place
        a = 3.0;
        b = 4.0;
        a2.pythagorasTheorum(a,b);
        // Testing 2: a = 3.0 while b = 4.0 which gives output of 5.0
        a = 7.0;
        b = 7.0;
        a2.pythagorasTheorum(a,b);
        // Testing 3: a = 7.0 while b = 7.0 which gives output of 9.899494936611665 but I coded it to give output with 2 decimal place

    }

    private void task1(){
        // code your task 1 here
        /* Task said to write and test a boolean expression that returns true if an integer variable “n“ is in the range 1 to 100 inclusive but not an even integer in the range 40 to 50 inclusive.
        So it means the integer variable "n" must be within the range 1-100 AND an odd integer that's WITHIN the range of 40-50 to get output of TRUE. */

        // Test-case 1
        int n = -77; // n is now -77
        boolean positiveEvenNum_range = (n % 2 != 0) && (n>=1) && (n<=100) && (n>= 40) && (n<=50);
        // If the number fulfill all the 5 conditions stated above, then the OUTPUT printed out will be true otherwise false will be printed out as OUTPUT
        System.out.println("n : " + n + " expect false get " + positiveEvenNum_range); // -77 is out of the range 1<=n<=100 so OUTPUT is false

        // Test-case 2
        n = 48; // n is now 48
        positiveEvenNum_range = (n % 2 != 0) && (n>=1) && (n<=100) && (n>= 40) && (n<=50);
        System.out.println("n : " + n + " expect false get " + positiveEvenNum_range); // 48 is within the range 1<=n<=100 and 40<=n<=50 but is odd so OUTPUT is false

        // Test-case 3
        n = 47; // n is now 47
        positiveEvenNum_range = (n % 2 != 0) && (n>=1) && (n<=100) && (n>= 40) && (n<=50);
        System.out.println("n : " + n + " expect true get " + positiveEvenNum_range); // 47 is within the range 1<=n<=100 and 40<=n<=50 and is even so OUTPUT is true

        // Test-case 4
        n = 77; // n is now 77
        positiveEvenNum_range = (n % 2 != 0) && (n>=1) && (n<=100) && (n>= 40) && (n<=50);
        System.out.println("n : " + n + " expect false get " + positiveEvenNum_range); // 77 is within range 1<=n<=100 but out of range for 40<=n<=50 so OUTPUT is false

        // Test-case 5
        n = 777; // n is now 777
        positiveEvenNum_range = (n % 2 != 0) && (n>=1) && (n<=100) && (n>= 40) && (n<=50);
        System.out.println("n : " + n + " expect false get " + positiveEvenNum_range); // 777 is out of the range 1<=n<=100 so OUTPUT is false

    }

    private void task2(){
        // code your task 2 here
        boolean meowIsCat = true; // Boolean variable 1
        boolean meowIsDog = false; // Boolean variable 2
        System.out.println("meowIsCat = " + meowIsCat + "; meowIsDog = " + meowIsDog);

        boolean temporaryVariableGoat = meowIsCat;
        // temporaryVariableGoat is a temporary variable to help prevent overload of values & to keep track of what was the value for another variable
        // In this task the temporary variable temporaryVariableGoat helps keep track of the value in variable meowIsCat
        meowIsCat = meowIsDog;
        // So when meowIsCat takes the boolean value of meowIsDog, the original value of meowIsCat is stored in the temporary variable
        meowIsDog = temporaryVariableGoat;
        // Hence, when the variable meowIsDog want to take up the boolean value of meowIsCat, it can take up the boolean value of meowIsCat that is temporarily stored in temporaryVariableGoat
        /* we cannot do :
           meowIsCat = meowIsDog and meowIsDog = meowIsCat in the following line as
           when meowIsCat = meowIsDog, meowIsCat would've already stored the value from meowIsDog so when meowIsDog = meowIsCat meowIsDog will still remain it's original value
           hence, swapping of values between the 2 variables will not succeed */
        System.out.println("meowIsCat = " + meowIsCat + "; meowIsDog = " + meowIsDog);
    }

    private void task3(){
        // code your task 3 here
        double angleAlpha = 53.13; // Angle from base of building B to top of building A
        double angleBeta = 41.00; // Angle from base of building A to diagonally top of building A of the opposite side
        double buildingHeight = 20.00; // Height for both buildings A and B
        // Convert angle from degrees to radians
        double angleAlphaInRadians = Math.toRadians(angleAlpha);
        double angleBetaInRadians = Math.toRadians(angleBeta);
        // Obtaining the length and width of land area
        double lengthOfLandArea = ( buildingHeight / Math.tan(angleBetaInRadians));
        double widthOfLandArea = ( buildingHeight / Math.tan(angleAlphaInRadians));
        System.out.println(String.format("Length of land area between the two buildings is %.2f m.", lengthOfLandArea));
        // String format to allow result shown to be in 2 decimal place
        System.out.println(String.format("Width of land area between the two buildings is %.2f m.", widthOfLandArea));
        // String format to allow result shown to be in 2 decimal place

        // Area of land area
        double areaOfLand = widthOfLandArea * lengthOfLandArea;
        System.out.println(String.format("Area of land between the two buildings is %.2f m².", areaOfLand));
        // String format to allow result shown to be in 2 decimal place

        // Number of stone slabs that's 1m*1m used
        double areaOfStoneSlabs_inMetres = 1.00*1.00; // Area of each stone slabs
        double stoneSlabsUsedToFillLandArea = areaOfLand / areaOfStoneSlabs_inMetres; // To count the number of stone slabs used
        double stoneSlabsUsed = Math.ceil(stoneSlabsUsedToFillLandArea); // To round up the number of stone slabs used
        System.out.println(String.format("Number of stone slabs used is %.0f.", stoneSlabsUsed));

    }

    private void task4(){
        // code your task 4 here
        // Firstly, import scanner outside of public class to be able to use scanner class here
        Scanner scanner = new Scanner(System.in); // This is typed to use scanner class
        System.out.println("Please enter value for integer x: "); // Prompt user to enter x value
        int x = scanner.nextInt();
        System.out.println("Please enter value for integer y: "); // Prompt user to enter y value
        int y = scanner.nextInt();
        int bitwiseAND = x & y; // Bitwise AND
        int bitwiseExclusiveOR = x ^ y; // Bitwise exclusive OR
        System.out.println("OUTPUT for bitwise AND: " + bitwiseAND); // Bitwise AND result
        System.out.println("OUTPUT for bitwise Exclusive OR: " + bitwiseExclusiveOR); // Bitwise exclusive OR result

    }

    // Code your task 5 method here
    public double pythagorasTheorum(double a, double b){
        // Method name is pythagorasTheorum
        double cValue = 0; // initialize cValue as 0
        cValue = Math.sqrt((a*a)+(b*b)); // Modified pythagoras equation to calculate the value of c
        System.out.println(String.format("Value of c equals to %.2f when a is %.2f and b is %.2f.", cValue, a, b)); // Give result output in 2 decimal place
        return cValue; // This is the return statement to return the result appropriately
    }

}

