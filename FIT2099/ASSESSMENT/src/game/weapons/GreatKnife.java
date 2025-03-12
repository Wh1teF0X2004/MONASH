package game.weapons;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.actions.QuickStepAction;
import game.utils.Status;
import game.trader.Purchasable;
import game.trader.Sellable;

/**
 * A simple weapon that is owned by Bandit that can be used to attack the enemy.
 * It deals 75 damage with 70% hit rate
 * @author Chew Xin Ning 32693974
 * @version 1.0
 */
public class GreatKnife extends WeaponItem implements Purchasable, Sellable {

    /**
     * Purchase price for Great Knife
     */
    private int purchasePrice = 3500;

    /**
     * Selling price for Great Knife
     */
    private int sellPrice = 350;

    /**
     * Constructor for GreatKnife.
     */
    public GreatKnife() {
        super("Great Knife", '/', 75, "rends", 70);
        addCapability(Status.HAS_UNIQUE_SKILL);
    }

    /**
     * Skill used when actor use this weapon to attack player.
     * @return the action used by actor
     */
    @Override
    public Action getSkill(Actor target, String direction){
        return new QuickStepAction(target, direction, this);
    }

    /**
     * Getter for purchase price
     * @return purchase price for great knife
     */
    @Override
    public int getPurchasePrice() {
        return purchasePrice;
    }

    /**
     * Getter for selling price
     * @return selling price for great knife
     */
    @Override
    public int getSellPrice() {
        return sellPrice;
    }
}
