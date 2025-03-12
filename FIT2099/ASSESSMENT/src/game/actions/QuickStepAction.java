package game.actions;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.Exit;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.utils.RandomNumberGenerator;

/**
 * QuickStep action is a unique skill that deals normal damage to the weapon to the enemy.
 * User move to a new location after performing the attack.
 * @author Chew Xin Ning 32693974
 * @version 2.0
 */
public class QuickStepAction extends Action {

    /**
     * The target actor of this action
     */
    private Actor target;

    /**
     * The weapon item used for this action
     */
    private WeaponItem weaponItem;

    /**
     * Boolean to indicate whether the attack is successful
     */
    private boolean attackAccurately;

    /**
     * The direction of the attack deal
     */
    private String direction;

    /**
     * Constructor for quick step action.
     * @param target The actor that will be attacked
     * @param direction The direction of the attack
     * @param weaponItem The weapon item used to perform the attack
     */
    public QuickStepAction(Actor target, String direction, WeaponItem weaponItem){
        this.target = target;
        this.direction = direction;
        this.weaponItem = weaponItem;
    }

    /**
     * Perform quick step action on target and move the current actor to a new location.
     * @param actor The actor performing the action.
     * @param map The map the actor is on.
     * @return String that describes what happened
     */
    @Override
    public String execute(Actor actor, GameMap map) {
        String ret = "";
        attackAccurately = false;
        // deal damage if attacked accurately
        if (RandomNumberGenerator.getRandomInt(0, 100) < weaponItem.chanceToHit()){
            target.hurt(weaponItem.damage());
            ret += actor + " quicksteps " + weaponItem.toString() + " on " + target + " for " + weaponItem.damage() + " damage. ";
            attackAccurately = true;

            if (!target.isConscious()){
                ret += new DeathAction(actor).execute(target, map);
            }
        }
        else {
            ret += actor + " missed " + target + "!";
        }

        // find a location with no actor on it and move current actor to the new location
        for (Exit exit : map.locationOf(actor).getExits()){
            if (!exit.getDestination().containsAnActor()){
                map.moveActor(actor, exit.getDestination());
            }
        }
        ret += "\n" + actor + " moves to " + "(" + map.locationOf(actor).x() + ", " + map.locationOf(actor).y() + ")";

        return ret;
    }

    /**
     * A string describing the action suitable for displaying in the menu.
     * @param actor The actor performing the action.
     * @return Description representing the action performed.
     */
    @Override
    public String menuDescription(Actor actor) {
        return actor + " quicksteps " + weaponItem + " at " + direction + " on " + target;
    }
}
