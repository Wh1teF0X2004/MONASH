package game.actions;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.utils.RandomNumberGenerator;

/**
 * Unsheathe action is a unique skill that deals 2x damage of the weapon to enemy.
 * @author Chew Xin Ning 32693974
 * @version 2.0
 */
public class UnsheatheAction extends Action {

    /**
     * The target actor of this action
     */
    private Actor target;

    /**
     * The direction of the attack deal
     */
    private String direction;

    /**
     * The weapon item used for this action
     */
    private WeaponItem weaponItem;

    /**
     * Constructor for unsheathe action.
     * @param target The actor that will be attacked
     * @param direction The direction of the attack
     * @param weaponItem The weapon item used to perform the attack
     */
    public UnsheatheAction(Actor target, String direction, WeaponItem weaponItem){
        this.target = target;
        this.direction = direction;
        this.weaponItem = weaponItem;
    }

    /**
     * Perform unsheathe action on target.
     * @param actor The actor performing the action.
     * @param map The map the actor is on.
     * @return String that describes what happened
     */
    @Override
    public String execute(Actor actor, GameMap map) {
        String ret = "";

        // deals 2x damage of the weapon
        int damage = weaponItem.damage() * 2;

        // if hit accurately, deal damage to target
        if (RandomNumberGenerator.getRandomInt(0, 100) < weaponItem.chanceToHit()){
            target.hurt(damage);
            ret += actor + " unsheathes " + weaponItem.toString() + " on " + target + " for " + damage + " damage";

            // if target is dead, display death description
            if (!target.isConscious()){
                ret += new DeathAction(actor).execute(target, map);
            }
        }
        // if actor missed the hit
        else {
            ret = actor + " missed " + target + "!";
        }

        return ret;
    }

    /**
     * A string describing the action suitable for displaying in the menu.
     * @param actor The actor performing the action.
     * @return Description representing the action performed.
     */
    @Override
    public String menuDescription(Actor actor) {
        return actor + " unsheathes " + weaponItem + " at " + direction + " on " + target;
    }
}
