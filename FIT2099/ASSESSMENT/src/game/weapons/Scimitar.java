package game.weapons;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.behaviours.SlamsAttackAreaBehaviour;
import game.trader.Purchasable;
import game.trader.Sellable;

/**
 * A simple weapon that can be used to attack the enemy.
 * It deals 118 damage with 88% hit rate
 * @author Chew Xin Ning 32693974
 * Modified by: Foo Kai Yan 33085625
 * @version 1.0
 */
public class Scimitar extends WeaponItem implements Purchasable, Sellable {

    /**
     * Purchase price for Scimitar
     */
    private int purchasePrice = 600;

    /**
     * Selling price for Scimitar
     */
    private int sellPrice = 100;

    /**
     * Constructor for Scimitar.
     */
    public Scimitar() {
        super("Scimitar", 's', 118, "spin attacks", 88);
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
     * Getter for purchase price
     * @return purchase price for Scimitar
     */
    @Override
    public int getPurchasePrice() {
        return purchasePrice;
    }

    /**
     * Getter for selling price
     * @return selling price for Scimitar
     */
    @Override
    public int getSellPrice() {
        return sellPrice;
    }

}
