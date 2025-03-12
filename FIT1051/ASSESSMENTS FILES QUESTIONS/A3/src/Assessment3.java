/*
 * Assessment 3
 *
 * Copyright (c) 2022  Monash University
 *
 * Written by  Jonny Low
 *
 *
 */
import java.util.Arrays; // Import this to be able to use arrays
import java.util.ArrayList; // Import this to be able to use Array List
import java.lang.Math; // Import this to be able to use Pi for task6
public class Assessment3 {

    public static void main(String[] args){

        Assessment3 a3 = new Assessment3();

        // Instruction: To run your respective task, uncomment below individually
//        a3.task1a();
//        a3.task2();
//        a3.task3();
//        a3.gradeScale("80");
//        a3.daysOfTheWeek("2");
//        a3.task6();
//        a3.task7();

    }


    private void task1a(){
        // code your task 1a (calling method) here
        double[] favNumArray = {0.7,7.7,7.77,77.7,777.77}; // Initialised with 5 sensible values
        double favNumber = 7.0;
        // Before: (no side effect yet)
        System.out.println("Value Type = " + favNumber);
        System.out.println("Reference Type = " + Arrays.toString(favNumArray));

        task1b(favNumArray,favNumArray[0]);
        // After: (it's the same copy as Before but this is used to see if any changes is made to the values due to side effect )
        System.out.println("Value Type = " + favNumber);
        System.out.println("Reference Type = " + Arrays.toString(favNumArray));

        /* Java pass objects by value and the value is the reference to the array so when favNumArray is passed to
        method task1b, the reference which is basically the objects, is copied there too. Address is passed as
        reference type. So when method task1b increment the one of the value in favNumArray, only the reference type
        is changed. Value type remain the same. */

    }

    private void task1b(double[] valueType, double referenceType){
        // code your task1b (called method) here
        referenceType++; // Incrementing reference type
        // Reference Type holds the memory location of where the real data is at
        valueType[2]++; // Incrementing value type ([2] means the third element in the favNumArray, 7.77, will be incremented by 1)
        // Value Type holds the data within it's own memory location

    }

    private void task2(){
        // code your task 2 here
        String one_ten_hundred_thousand = String.format("%5d\n%5d\n%5d\n%5d", 1, 10, 100, 1000);
        // \n to display 1, 10, 100 and 1000 on their own lines
        // %d is for integers (I used %f last assignment because it was used for floats)
        // %5d where the 5 is the specified width of 5 digits (The task didn't specify on how many digit width, so I used 5)
        System.out.println(one_ten_hundred_thousand);

    }

    private void task3(){
        // code your task 3 here
        // Array list named myList with the capacity of 10
        ArrayList<Integer> myList = new ArrayList<Integer>();
        // myList.add() to add the numbers 1, 7, 5, 3, 8 and 10 into the array list
        myList.add(1);
        myList.add(7);
        myList.add(5);
        myList.add(3);
        myList.add(8);
        myList.add(10);
        // Insert 11 between 5 and 3 which is at the 3rd index of the array list (It starts with 0)
        myList.add(3,11);
        // Print all the element in myList
        System.out.println(myList);
        // Delete 8 which is the 2nd last element in myList
        myList.remove(5);
        // True if myList contains 7; False otherwise
        // True should be printed out as 7 is still in myList
        if (myList.contains(7)){
            System.out.println("True");
        }
        else {
            System.out.println("False");
        }

    }

    // code your task 4 here. You should create your own method shell.
    private String gradeScale(String mark){ // This method takes in a parameter mark as a String
        Double markInDouble = Double.parseDouble(mark); // Double.parseDouble(mark) to convert String to Double data type
        // I used If-else selection control structure as it allows me to give multiple selections which allows multiple different conditions
        String grade; // Declaring the variable grade as a String
        if ((markInDouble >= 80.00) && (markInDouble <= 100.00)){ // Condition for HD which is 80-100
            grade = "High Distinction";
            System.out.println(grade);
        }
        else if ((markInDouble >= 70.00) && (markInDouble <= 79.00)){ // Condition for D which is 70-79
            grade = "Distinction";
            System.out.println(grade);
        }
        else if ((markInDouble >= 60.00) && (markInDouble <= 69.00)){ // Condition for C which is 60-69
            grade = "Credit";
            System.out.println(grade);
        }
        else if ((markInDouble >= 50.00) && (markInDouble <= 59.00)){ // Condition for P which is 50-59
            grade = "Pass";
            System.out.println(grade);
        }
        else if ((markInDouble >= 0.00) && (markInDouble <= 49.00)){ // Condition for N which is 0-49
            grade = "Fail";
            System.out.println(grade);
        }
        else { // Condition when parameter does not match any if-else selection control structure conditions
            grade = "Invalid Mark";
            System.out.println(grade);
        }
        return grade; // This is the return statement to return the result appropriately
    }

    // code your task 5 here. You should create your own method shell.
    private String daysOfTheWeek(String day) { // This method takes in a parameter day as a String
        String dayName; // Declaring the variable dayName as a String
        switch (day) { // This switch-case start count from Monday as first day of the week
            case "1": // 1 = First day of the week
                dayName = "Monday";
                System.out.println(dayName);
                break;
            case "2": // 2 = Second day of the week
                dayName = "Tuesday";
                System.out.println(dayName);
                break;
            case "3": // 3 = Third day of the week
                dayName = "Wednesday";
                System.out.println(dayName);
                break;
            case "4": // 4 = Fourth day of the week
                dayName = "Thursday";
                System.out.println(dayName);
                break;
            case "5": // 5 = Fifth day of the week
                dayName = "Friday";
                System.out.println(dayName);
                break;
            case "6": // 6 = Sixth day of the week
                dayName = "Saturday";
                System.out.println(dayName);
                break;
            case "7": // 7 = Seventh day of the week
                dayName = "Sunday";
                System.out.println(dayName);
                break;
            default: // default = default output when the parameter does not match any case
                dayName = "Invalid Day";
                System.out.println(dayName);
        }
        return dayName; // This is the return statement to return the result appropriately
    }

    private void task6(){
        // code your task 6 here
        double pI = Math.PI; // Pi to be used in the equation for area and circumference of circle
        int radius = 1; // Integer radius starting with 1
        double circumferenceOfCircle = 2*pI*radius; // Circumference of circle formula = 2πr
        double areaOfCircle = pI*radius*radius; // Area of circle formula = πr²
        double ratioAreaToCircumference = (areaOfCircle / circumferenceOfCircle); // Ratio of circle where Area / Circumference
        // For loop is used to allow me to give the loop to run at a specific conditions where ratio<30
        for (radius = 1; (ratioAreaToCircumference=((pI*radius*radius)/(2*pI*radius))) < 30; radius++){
            System.out.println("Circle radius = "+ radius + "; Circle ratio (area to circumference) = " + ratioAreaToCircumference);
        }
        
    }


    private void task7(){
        // code your task 7 here
        int size = 7; // If size = 7, I would have height = 7 and width = 7
        int height = 1; // Initialize height as 0
        int width = 1; // Initialize width as 0
        for (height = 1; height <= size; height++){ // Loop starts from when height = 1 to 7 which is my size
            for (width = 1; width <= size; width++){ // Loop starts from when width = 1 to 7 which is my size
                if (height == width){ // First case where * is printed out is when height = width
                    System.out.print("*");
                }
                else if (height + width == (size + 1)){ // Second case where * is printed out which is also when size = (height + width) - 1
                    System.out.print("*");
                }
                else { // or else space " " will be printed out
                    System.out.print(" ");
                }
            }
            System.out.println(""); // Go to next line after each height
        }


    }

}