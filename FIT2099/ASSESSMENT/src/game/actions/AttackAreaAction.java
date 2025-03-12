package game.actions;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.Weapon;

import java.util.Random;

/**
 * An attack that will deal attack to enemies near its surrounding
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 */
public class AttackAreaAction extends Action {

    /**
     * The target actor of this action
     */
    private Actor target;

    /**
     * The weapon item used for this action
     */
    private Weapon weapon;

    /**
     * The direction of the attack deal
     */
    private String direction;

    /**
     * Random number generator
     */
    private Random rand = new Random();

    /**
     * When executed, the chance to hit of the weapon that the Actor used is computed to
     * determine whether the actor will hit the target.
     * If so, deal damage to the target and determine whether the target is killed.
     *
     * @param actor     The actor performing the Spinning Attack action.
     * @param map       The map the actor is on.
     * @return the result of the attack, e.g. whether the target is killed, etc.
     * @see DeathAction
     */
    @Override
    public String execute(Actor actor, GameMap map) {
        if (!(rand.nextInt(100) <= weapon.chanceToHit())) {
            return actor + " misses " + target + ".";
        }

        int damage = weapon.damage();
        String result = actor + " " + weapon.verb() + " " + target + " for " + damage + " damage.";
        target.hurt(damage);
        if (!target.isConscious()) {
            result += new DeathAction(actor).execute(target, map);
        }

        return result;
    }

    /**
     * Describes which target the actor is attacking with the weapon
     *
     * @param actor The actor performing the action.
     * @return a description used for the menu UI
     */
    @Override
    public String menuDescription(Actor actor) {
        return actor + " attacks " + target + " at " + direction + " with " + weapon;
    }
}
