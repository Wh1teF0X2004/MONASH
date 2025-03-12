package game.controllers;

import game.actors.Player;
import game.trader.Rune;

/**
 * A class to manager transaction done with the in-game currency, Runes.
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 2.0
 * Modified by: Chew Xin Ning 32693974
 */
public class RuneManager {

    /**
     * Instance of Rune
     */
    private Rune rune;

    /**
     * Static instance of Rune
     */
    private static RuneManager instance = null;

    /**
     * Rune Manager constructor
     */
    private RuneManager(){
        rune = new Rune(Player.getRuneValue());
    }

    /**
     * Construct a new Rune Manager instance if there is none.
     * @return a new Rune Manager instance
     */
    public static RuneManager getInstance(){
        if (instance == null){
            instance = new RuneManager();
        }
        return instance;
    }

    /**
     * A method to get their new amount of runes held due to earning more runes.
     * eg. Defeating monsters earn runes
     *     Selling weapons to Traders
     *
     * @param originalAmount    The original amount of runes held.
     * @param increasedAmount   The amount of runes to be increased.
     * @return The new rune amount which will be their new currently held runes.
     */
    public int earnRune(int originalAmount, int increasedAmount){
        Rune initialRunes = new Rune(originalAmount);
        Rune earnedRunes = new Rune(increasedAmount);
        rune.setRuneAmount(initialRunes.getRuneAmount() + earnedRunes.getRuneAmount());
        return rune.getRuneAmount();
    }

    /**
     * A method to get their new amount of runes held due to the spending of runes.
     * eg. Buying weapons from Traders
     *
     * @param originalAmount    The original amount of runes held.
     * @param decreasedAmount   The amount of runes to be decreased.
     * @return The new rune amount which will be their new currently held runes.
     */
    public int spendRune(int originalAmount, int decreasedAmount){
        Rune initialRune = new Rune(originalAmount);
        Rune spentRunes = new Rune(decreasedAmount);
        rune.setRuneAmount(initialRune.getRuneAmount() - spentRunes.getRuneAmount());
        return rune.getRuneAmount();
    }
}
