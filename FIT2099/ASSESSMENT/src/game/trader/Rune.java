package game.trader;

import edu.monash.fit2099.engine.items.Item;
import game.utils.RandomNumberGenerator;
import game.utils.Status;
import game.reset.ResetManager;
import game.reset.Resettable;

/**
 * A class for the in-game currency, Runes.
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 * Modified by: Ng Yu Mei 32423454
 */
public class Rune extends Item implements Resettable {

    /**
     * The amount of runes.
     */
    private int runeAmount;

    /**
     * Construct a new Rune amount for the holder.
     *Register to become object that can be reset
     * @param runeAmount The amount of runes.
     */
    public Rune(int runeAmount) {
        super("Rune", '$', false);
        this.runeAmount = runeAmount;
        ResetManager.resetManager().registerResettable(this);
        this.addCapability(Status.PLAYER_DROP_ITEM);
    }

    /**
     * A getter for runeAmount.
     *
     * @return The amount of runes.
     */
    public int getRuneAmount() {
        return runeAmount;
    }

    /**
     * A setter for runeAmount.
     *
     * @param runeAmount The amount of runes.
     */
    public void setRuneAmount(int runeAmount) {
        this.runeAmount = runeAmount;
    }

    /**
     * Print the runeAmount.
     */
    public String printRune(){
        return "Rune: " + runeAmount;
    }

    /**
     * To generate random amount of runes after golden rune is consumed
     * @return random amount of runes
     */
    public static int generateRune(int lowerBound, int upperBound) {
        return RandomNumberGenerator.getRandomInt(lowerBound, upperBound);
    }

    /**
     * Reset the runeAmount.
     */
    @Override
    public void reset() {}
}
