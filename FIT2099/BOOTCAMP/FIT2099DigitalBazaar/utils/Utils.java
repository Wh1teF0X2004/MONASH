package FIT2099DigitalBazaar.utils;

import java.util.Random;

/**
 * A class containing useful methods used throughout the program.
 *
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 */
public class Utils {

    /**
     * Generates a random integer within a specified range provided.
     *
     * @param low The lower bound of the range
     * @param high The upper bound of the range
     * @return A random integer within the specified range
     */
    public static int nextID(int low, int high) {
        Random r = new Random();
        return (r.nextInt(high - low) + low);
    }

    /**
     * A boolean method to check if an integer is within a specified range
     *
     * @param intInput The integer to be checked
     * @return true if the integer is in range, false otherwise
     */
    public static boolean intRange(int intInput){
        // ppm: range 1..50
        // Date input: length must be 8 (dd/mm/yy)
        boolean flag = false;
        if (1 <= intInput && intInput <= 50){
            flag = true;
        }
        return flag;
    }

    /**
     * A boolean method to check if a string is within a specified range
     *
     * @param strInput The string to be checked
     * @return true if the string is in range, false otherwise
     */
    public static boolean strRange(String strInput){
        // Device Name: string with length in range 3..15
        // Device Description: length in range 5..20
        // Computer manufacture: length in range 3..15
        // Store Location: 3..10
        // Delivery Address: 5..20
        boolean flag = false;
        if (3 <= strInput.length() && strInput.length() <= 20){
            flag = true;
        }
        return flag;
    }
}
