/*
 * Week 03 Assessment Solution (3%)
 *
 * Copyright (c) 2022  Monash University
 *
 * Written by  Jonny Low
 *
 *
 */

public class Assessment1 {

    public static void main(String[] args){

        Assessment1 a1 = new Assessment1();

        // Instruction: To run your respective task, uncomment below individually
        a1.task1();
        a1.task2();
        a1.task3();
        a1.task4();
        a1.task5();

    }

    private void task1(){
        // code your task 1 here
        // Way #1 is to do the required task without using any variables
        System.out.println("5 \n8 \n4 \n2"); // \n means to display the 4 numbers individually on their own output line
        System.out.println(5+8+4+2); // This is the sum of the 4 numbers
        // Way #2 is to do the required task with 4 independent variables and another variables for their sum
        int a = 5;
        int b = 8;
        int c = 4;
        int d = 2; // a,b,c,d is the 4 independent variable for the 4 numbers
        int sum = a+b+c+d; // sum is the sum variable
        System.out.println(a);
        System.out.println(b);
        System.out.println(c);
        System.out.println(d); // Instruction in the task pdf file did not specify how many times the println() function can be used
        System.out.println(sum); // This is the sum of the 4 numbers
        // Way #3 is to do the required task by reusing 1 variable for the numbers and another variable for their sum
        int number = 5;
        int total = 0+number;
        System.out.println(number);
        number = 8; // value of the integer number has changed from 5 to 8
        total = total + number; // total is now 13
        System.out.println(number); // HENCE, 8 will be printed out instead of 5
        number = 4; // value of the integer number has changed from 8 to 4
        total = total + number; // total is now 17
        System.out.println(number); // HENCE, 4 will be printed out instead of 8
        number = 2; // value of the integer number has changed from 4 to 2
        total = total + number; // total is now 19
        System.out.println(number); // HENCE, 2 will be printed out instead of 4
        System.out.println(total);

    }

    private void task2(){
        // code your task 2 here
        // Q1: Your jogging speed in miles per hour (mph)
        float joggingSpeed = 6.7f;
        System.out.println("Your jogging speed: " + joggingSpeed + "mph.");
        // Q2: FIT1051 lecturer allocated to a workshop.
        float workshopTime = 2.30f;
        String workshopDay = "Thursday";
        System.out.println("FIT1051 lecturer allocated to a workshop: " + workshopTime + "pm on a " + workshopDay + ".");
        // Q3: The capacity of passengers in a train wagon.
        int passengersCapacity = 100;
        System.out.println("Passengers in a train wagon: " + passengersCapacity + ".");
        // Q4: The length of a desk in millimetres.
        int deskLength = 1778;
        System.out.println("Length of a desk: " + deskLength + "mm.");
        // Q5: The state of a light switch.
        boolean lightSwitchState = true ;
        System.out.println("State of a light switch: " + lightSwitchState + ".");
        // Q6: The number of books on a library shelf.
        int numberOfBook = 155;
        System.out.println("Number of books on a library shelf: " + numberOfBook + ".");
        // Q7: The amount of COVID vaccination a person can have so far.
        int numberOfVaccination = 3;
        System.out.println("The amount of COVID vaccination a person can have so far: " + numberOfVaccination + ".");
        // Q8: The current temperature of the day.
        int temperature = 32;
        System.out.println("Current temperature of the day: " + temperature + "°C.");
        // Q9: The number of Ace in a deck of cards.
        int numOfACE = 4;
        System.out.println("Number of Ace in a deck of cards: " + numOfACE + ".");
        // Q10: The memory size of a computer chip.
        int computerChipMemory = 32;
        System.out.println("Memory size of a computer chip: " + computerChipMemory + "GB/cm².");
        // Q11: The state of a traffic light, which can either “RED”, “YELLOW”, or “GREEN”. (Hint: data types need to be declared and initialise before use)
        String trafficLightState = "Red";
        System.out.println("The state of a traffic light, which can either be 'RED', 'YELLOW' or 'GREEN': " + trafficLightState + ".");
        // 3 COVID vaccination as in 2 doses of actual vaccination with a follow-up of 1 extra booster shot

    }

    private void task3(){
        // code your task 3 here
        float floatNumber = 7.00f;
        int ageOfPet = 3;
        String nameOfPet = "Fluff-a-ton";
        double heightOfPetInMetres = 0.60;
        boolean isASamoyed = true;

        // heightOfPetInMetres = ageOfPet; // 3.0 will be printed out
        // Double cannot be assigned to integer because it will cause lost of information
        // Q1: Narrowing. Information may be lost. Not performed automatically by JAVA.
        // Q2: Can be done by casting but precision of value may be lost.
        heightOfPetInMetres = floatNumber; // 7.0 will be printed out
        // Q1: Widening. Performed automatically by JAVA. No information is loss from this.
        // Q2: Casting is not needed.
        // heightOfPetInMetres = nameOfPet; this will give an error unless heightOfPetInMetres was initially a string or nameOfPet was initially a double
        // Q1: Not performed automatically by JAVA.
        // Q2: Casting is not needed as it can't be forcefully converted.
        // heightOfPetInMetres = isASamoyed; this will give an error unless heightOfPetInMetres was initially a boolean or isASamoyed was initially a double
        // Q1: Not performed automatically by JAVA as boolean can only be converted from boolean to boolean.
        // Q2: Can't be casted.

        // ageOfPet = heightOfPetInMetres;
        // TECHNICALLY, JAVA can convert from integer to double but I can't do this here as it gave me an error
        // Q1: Widening. Performed automatically by JAVA. No information is loss from this.
        // Q2: Casting is not needed.
        // ageOfPet = floatNumber; this will give an error if (int) was not inserted like : ageOfPet = (int) floatNumber;
        // Q1: Narrowing. Information may be lost. Not performed automatically by JAVA.
        // Q2: Can be done by casting but precision of value may be lost.
        // ageOfPet = nameOfPet; this will give an error unless ageOfPet was initially a string or nameOfPet was initially an integer
        // Q1: Not performed automatically by JAVA.
        // Q2: Casting is not needed as it can't be forcefully converted.
        // ageOfPet = isASamoyed; this will give an error unless ageOfPet was initially a boolean or isASamoyed was initially an integer
        // Q1: Not performed automatically by JAVA as boolean can only be converted from boolean to boolean.
        // Q2: Can't be casted.

        floatNumber = ageOfPet; // 3.0 will be printed out
        // Float can be assigned to integer but it will cause lost of information which is called narrowing
        // Q1: Widening. Performed automatically by JAVA. Information may be lost.
        // Q2: Can be done by casting but precision of value may be lost.
        // floatNumber = heightOfPetInMetres;
        // TECHNICALLY, JAVA can convert from float to double but I can't do this here as it gave me an error
        // Q1: Widening. Performed automatically by JAVA. No information is loss from this.
        // Q2: Casting is not needed.
        // floatNumber = nameOfPet; this will give an error unless floatNumber was initially a string or nameOfPet was initially a float
        // Q1: Not performed automatically by JAVA.
        // Q2: Casting is not needed as it can't be forcefully converted.
        // floatNumber = isASamoyed; this will give an error unless floatNumber was initially a boolean or isASamoyed was initially a float
        // Q1: Not performed automatically by JAVA as boolean can only be converted from boolean to boolean.
        // Q2: Can't be casted.

        // nameOfPet = floatNumber; this will give an error unless nameOfPet was initially a float or floatNumber was initially a string
        // Q1: Not performed automatically by JAVA as string value can't be converted to float.
        // Q2: Can't be casted.
        // nameOfPet = ageOfPet; this will give an error unless nameOfPet was initially an integer or ageOfPet was initially a string
        // Q1: Not performed automatically by JAVA as string value can't be converted to integer.
        // Q2: Can't be casted.
        // nameOfPet = heightOfPetInMetres; this will give an error unless nameOfPet was initially a double or heightOfPetInMetres was initially a string
        // Q1: Not performed automatically by JAVA as string value can't be converted to double.
        // Q2: Can't be casted.
        // nameOfPet = isASamoyed; this will give an error unless nameOfPet was initially a boolean or isASamoyed was initially a string
        // Q1: Not performed automatically by JAVA as boolean can only be converted from boolean to boolean.
        // Q2: Can't be casted.

        // isASamoyed = floatNumber; this will give an error unless isASamoyed was initially a float or floatNumber was initially a boolean
        // Q1: Not performed automatically by JAVA as boolean can only be converted from boolean to boolean.
        // Q2: Can't be casted.
        // isASamoyed = ageOfPet; this will give an error unless isASamoyed was initially an integer or ageOfPet was initially a boolean
        // Q1: Not performed automatically by JAVA as boolean can only be converted from boolean to boolean.
        // Q2: Can't be casted.
        // isASamoyed = nameOfPet; this will give an error unless isASamoyed was initially a string or nameOfPet was initially a boolean
        // Q1: Not performed automatically by JAVA as boolean can only be converted from boolean to boolean.
        // Q2: Can't be casted.
        // isASamoyed = heightOfPetInMetres; this will give an error unless isASamoyed was initially a double or heightOfPetInMetres was initially a boolean
        // Q1: Not performed automatically by JAVA as boolean can only be converted from boolean to boolean.
        // Q2: Can't be casted.

        /* Q1: Widening is done automatically in JAVA. It converts lower data type to higher data type.
         For example: byte -> short -> char -> int -> long -> float -> double.*/
        /* Q2: JAVA will perform Narrowing with a cast and this casting may result in loss of information and precision value loss from the code.*/
    }

    private void task4(){
        // code your task 4 here
        System.out.println("            @@@@@@@@@@@@@@@@@@@@           \n          @@@@@@@@@@@@@@@@@@@@@@@@         \n       @@@@@@@@@@@@@@@@@@@@@@@@@@@@@       \n     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     \n   @@@@@@@      @@@@@@@@@@@      @@@@@@@   \n  @@@@@@@        @@@@@@@@@        @@@@@@@  \n @@@@@@@@@      @@@@@@@@@@@      @@@@@@@@@ \n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \n   @@@@@@@@@@   @@@@@@@@@@@   @@@@@@@@@@   \n    @@@@@@@@@@  @@@@@@@@@@@  @@@@@@@@@@    \n     @@@@@@@@@@             @@@@@@@@@@     \n       @@@@@@@@@@@@@@@@@@@@@@@@@@@@@       \n          @@@@@@@@@@@@@@@@@@@@@@@@         \n            @@@@@@@@@@@@@@@@@@@@           ");
        // WIDTH of the smiley face is as long as 43 @s, HEIGHT of the smiley face is 15 lines
        // 14 \n have been used in between of the string to separate the @ to 15 different lines which is the HEIGHT of the smiley face
        // Only one line of System.out.println() have been used as per the question's requirement
    }

    private void task5(){
        // code your task 5 here
         // String s = null;
         // System.out.println(s.length());
        // Tried running but output given is = Exception in thread "main" java.lang.NullPointerException(create breakpoint): Cannot invoke "String.length()" because "s" is null

        // Q1: It is a runtime exception, these are problems that will cause during runtime and compilation process in JAVA
        // Q2: System.out.println(s.length()); calls for the length methods where the length of the string s will be obtained but since s is of a null value that is used in the method, when the code in Task5 was run, the code will give an output of NullPointerException.

    }

}