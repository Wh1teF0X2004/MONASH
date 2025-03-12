package game.weapons;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.trader.Purchasable;
import game.trader.Sellable;

/**
 * A weapon that is owned by Godrick Soldier that attacks any other actor except for demigod protector.
 * It deals 64 damage with 57% hit rate.
 * @author Chew Xin Ning 32693974
 * @version 1.0
 */
public class HeavyCrossbow extends WeaponItem implements Purchasable, Sellable {

    /**
     * Purchase price for Heavy Crossbow
     */
    private int purchasePrice = 1500;

    /**
     * Selling price for Heavy Crossbow
     */
    private int sellPrice = 100;

    /**
     * Constructor.
     */
    public HeavyCrossbow() {
        super("Heavy Crossbow", '}', 64, "shoots", 57);
    }

    /**
     * This weapon is a ranged weapon that allows the holder to shoot an enemy 2 blocks away from the holder.
     * @return the weapon skill
     */
    @Override
    public Action getSkill(Actor target, String direction){

        return null;
    }

    /**
     * Getter for purchase price
     * @return purchase price for Heavy Crossbow
     */
    @Override
    public int getPurchasePrice() {
        return purchasePrice;
    }

    /**
     * Getter for selling price
     * @return selling price for Heavy Crossbow
     */
    @Override
    public int getSellPrice() {
        return sellPrice;
    }

}
