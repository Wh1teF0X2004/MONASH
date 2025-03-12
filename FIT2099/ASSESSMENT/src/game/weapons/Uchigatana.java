package game.weapons;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.actions.UnsheatheAction;
import game.utils.Status;
import game.trader.Purchasable;
import game.trader.Sellable;

/**
 * A simple weapon that can be used to attack the enemy.
 * It deals 115 damage with 80% hit rate
 * @author Chew Xin Ning 32693974
 * @version 1.0
 */
public class Uchigatana extends WeaponItem implements Purchasable, Sellable {

    /**
     * Purchase price for Uchigatana
     */
    private int purchasePrice = 5000;

    /**
     * Selling price for Uchigatana
     */
    private int sellPrice = 500;

    /**
     * Constructor for Uchigatana.
     */
    public Uchigatana() {
        super("Uchigatana", ')', 115, "slashes", 80);
        addCapability(Status.HAS_UNIQUE_SKILL);
    }

    /**
     * Skill used when actor use this weapon to attack player.
     * @return the action used by actor
     */
    @Override
    public Action getSkill(Actor target, String direction){
        return new UnsheatheAction(target, direction,this);
    }

    /**
     * Getter for purchase price
     * @return purchase price for Uchigatana
     */
    @Override
    public int getPurchasePrice() {
        return purchasePrice;
    }

    /**
     * Getter for selling price
     * @return selling price for Uchigatana
     */
    @Override
    public int getSellPrice() {
        return sellPrice;
    }

}
