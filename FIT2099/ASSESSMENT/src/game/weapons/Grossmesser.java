package game.weapons;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.behaviours.SlamsAttackAreaBehaviour;
import game.trader.Sellable;
import game.utils.Status;

/**
 * A simple weapon that can be used to attack the enemy.
 * It deals 115 damage with 85% hit rate
 * @author Chew Xin Ning 32693974
 * @version 1.0
 */
public class Grossmesser extends WeaponItem implements Sellable {

    /**
     * Selling price for Grossmesser
     */
    private int sellPrice = 100;

    /**
     * Constructor for Grossmesser.
     */
    public Grossmesser() {
        super("Grossmesser", '?', 115, "spinning hits", 85);
        addCapability(Status.CANNOT_BE_SOLD);
        addCapability(Status.HAS_UNIQUE_SKILL);
    }

    /**
     * Skill used when actor use this weapon to attack player.
     * @return the action used by actor
     */
    @Override
    public Action getSkill(Actor target, String direction){
        return new SlamsAttackAreaBehaviour();
    }

    /**
     * Getter for selling price
     * @return selling price for Grossmesser
     */
    @Override
    public int getSellPrice() {
        return sellPrice;
    }

    /**
     * Grossmesser cannot be sold to trader if player only has one Grossmesser in its inventory
     * @return false to indicate it cannot be sold if player only has one Grossmesser
     */
    @Override
    public boolean canBeSold(){
        return false;
    }
}
