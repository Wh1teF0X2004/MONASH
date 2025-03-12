package game.trader;

/**
 * An interface on the specific trade of Players trading items or weapons to the Trader.
 *
 * @author Foo Kai Yan 33085625
 * @version 2.0.0
 */
public interface Tradable {

    /**
     * Override this method for item that has exception to be traded
     *
     * @return boolean representing whether the item can be traded
     */
    default boolean canBeTraded() {
        return true;
    }
}
