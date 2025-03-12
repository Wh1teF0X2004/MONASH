package game.trader;

/**
 * An interface on the specific trade of Players selling weapons to the Trader.
 *
 * @author Chew Xin Ning 32693974
 * @version 2.0.0
 */
public interface Sellable {

    /**
     * A getter for the weapon selling price
     * @return the selling price of the item or weapon
     */
    int getSellPrice();

    /**
     * Override this method for weapon that has exception to sell
     * (eg: Grossmesser cannot be sold if player only has one Grossmesser)
     *
     * @return boolean representing whether the weapon can be sold
     */
    default boolean canBeSold() {
        return true;
    }
}
