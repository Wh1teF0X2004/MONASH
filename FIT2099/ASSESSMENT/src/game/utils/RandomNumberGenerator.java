package game.utils;

import java.util.List;
import java.util.Random;

/**
 * A random number generator
 *
 * Created by:
 * @author Adrian Kristanto
 *
 * Modified by:
 * @author Foo Kai Yan 33085625, Chew Xin Ning 32693974
 *
 * @version 2.0.0
 */
public class RandomNumberGenerator {

    /**
     * Returns a random integer value between 0 (inclusive) and the specified bound (exclusive).
     *
     * @param bound The lower bound of the range
     * @return 0 if the specified bound is less than or equal to 0
     */
    public static int getRandomInt(int bound) {
        return bound > 0 ? new Random().nextInt(bound) : 0;
    }

    /**
     * Generates a random integer within a specified range provided.
     *
     * @param lowerBound The lower bound of the range
     * @param upperBound The upper bound of the range
     * @return A random integer within the specified range
     */
    public static int getRandomInt(int lowerBound, int upperBound) {
        int range = upperBound - lowerBound + 1;
        return new Random().nextInt(range) + lowerBound;
    }

    /**
     * Function to select a character element in a list of characters
     * @param list a list of characters
     * @return random character chosen from the list
     */
    public static char getRandomElement(List<Character> list)
    {
        Random rand = new Random();
        return list.get(rand.nextInt(list.size()));
    }
}
