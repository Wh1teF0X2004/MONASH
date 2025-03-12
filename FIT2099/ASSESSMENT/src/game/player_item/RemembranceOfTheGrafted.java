package game.player_item;

import edu.monash.fit2099.engine.items.Item;
import game.trader.Sellable;
import game.trader.Tradable;
import game.utils.Status;

/**
 * An item dropped after Godrick the Grafted's defeat.
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 2.0.0
 */
public class RemembranceOfTheGrafted extends Item implements Sellable, Tradable {

    // REQ3A not implemented so only item exist

    /**
     * Selling price for Remembrance of the Grafted.
     */
    private int sellPrice = 20000;

    /**
     * Constructor for Remembrance of the Grafted.
     *
     * Remembrance of the Grafted is dropped after Godrick the Grafted's defeat.
     */
    public RemembranceOfTheGrafted() {
        super("Remembrance of the Grafted", 'O', true);
        addCapability(Status.TRADABLE);
    }

    /**
     * Get the selling price of Remembrance of the Grafted.
     * @return Selling price of Remembrance of the Grafted
     */
    @Override
    public int getSellPrice() {
        return sellPrice;
    }

    /**
     * Override this method for item that has exception to be traded
     * @return boolean representing whether the item can be traded
     */
    @Override
    public boolean canBeTraded() {
        return true;
    }
}
