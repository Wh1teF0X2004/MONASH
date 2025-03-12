package game.weapons;

import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.trader.Sellable;

/**
 * A simple weapon used by Godrick the Grafted during Phase 2 to attack player.
 * It deals 89 damage with 90% hit rate
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 */
public class GraftedDragon extends WeaponItem implements Sellable {

    // REQ3A not implemented so only weapon exist

    /**
     * Selling price for Grafted Dragon.
     */
    private int sellPrice = 200;

    /**
     * Constructor for Grafted Dragon.
     */
    public GraftedDragon() {
        super("Grafted Dragon", 'N', 89, "Piakkk", 90);
    }

    /**
     * Get the selling price of Grafted Dragon.
     * @return Selling price of Grafted Dragon
     */
    @Override
    public int getSellPrice() {
        return sellPrice;
    }
}
