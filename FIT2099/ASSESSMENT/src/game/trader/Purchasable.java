package game.trader;

/**
 * An interface on the specific trade of Players purchasing items like weapons from the Trader.
 *
 * @author Chew Xin Ning 32693974
 * @version 2.0
 */
public interface Purchasable {

    /**
     * A getter for the weapon purchase price
     * @return the purchase price of the item or weapon
     */
    int getPurchasePrice();
}
