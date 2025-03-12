package game.weapons;

import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.trader.Sellable;

/**
 * A simple weapon used by Godrick the Grafted during Phase 1 to attack player.
 * It deals 142 damage with 84% hit rate
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 */
public class AxeOfGodrick extends WeaponItem implements Sellable {

    // REQ3A not implemented so only weapon exist

    /**
     * Selling price for Axe Of Godrick.
     */
    private int sellPrice = 100;

    /**
     * Constructor for Axe Of Godrick.
     */
    public AxeOfGodrick() {
        super("Axe Of Godrick", 'T', 142, "Pionggg", 84);
    }

    /**
     * Get the selling price of Axe Of Godrick.
     * @return Selling price of Axe Of Godrick
     */
    @Override
    public int getSellPrice() {
        return sellPrice;
    }
}
