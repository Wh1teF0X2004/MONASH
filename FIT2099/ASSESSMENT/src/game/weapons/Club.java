package game.weapons;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.actions.AttackAction;
import game.trader.Purchasable;
import game.trader.Sellable;

/**
 * A simple weapon that can be used to attack the enemy.
 * It deals 103 damage with 80% hit rate
 * Created by:
 * @author Adrian Kristanto
 * Modified by: Chew Xin Ning 32693974
 * @version 1.0
 */

public class Club extends WeaponItem implements Purchasable, Sellable {

    /**
     * Purchase price for Club
     */
    private int purchasePrice = 600;

    /**
     * Selling price for Club
     */
    private int sellPrice = 100;

    /**
     * Constructor for Club.
     */
    public Club() {
        super("Club", '!', 103, "bonks", 80);
    }

    /**
     * Get an active skill action from the weapon.
     * @param target target actor
     * @return a special Action that can be performed by this weapon (perform special attack on the enemy, etc.)
     */
    @Override
    public Action getSkill(Actor target, String direction){
        return new AttackAction(target, direction, this);
    }

//    /**
//     * Ground can also experience the joy of time.
//     * @param currentLocation The location of the Ground
//     * @param actor the actor that is using this weapon
//     */
//    @Override
//    public void tick(Location currentLocation, Actor actor) {}

    /**
     * Getter to get purchase price
     * @return Club's purchase price
     */
    @Override
    public int getPurchasePrice() {
        return purchasePrice;
    }

    /**
     * Getter to get selling price
     * @return Club's selling price
     */
    @Override
    public int getSellPrice() {
        return sellPrice;
    }

}
