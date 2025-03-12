package game.behaviours;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.positions.Exit;
import edu.monash.fit2099.engine.positions.GameMap;
import game.actions.DeathAction;
import game.utils.RandomNumberGenerator;

/**
 * Slams Behaviour is the special skill of Giant Crab to slam all creatures in their surroundings.
 * @author Chew Xin Ning 32693974
 * @version 2.0
 */
public class SlamsAttackAreaBehaviour extends Action implements Behaviour {

    /**
     * Perform the Action.
     * @param actor The actor performing the action.
     * @param map The map the actor is on.
     * @return String description of what is performed.
     */
    @Override
    public String execute(Actor actor, GameMap map) {
        // current actor slams other actor (target) in its surrounding exit
        for (Exit exit : map.locationOf(actor).getExits()){
            // as the probability to hit actor A and actor B are different
            if (exit.getDestination().containsAnActor() &&
                    RandomNumberGenerator.getRandomInt(0, 100) < actor.getIntrinsicWeapon().chanceToHit()){
                // obtain the other actor's location and deal damage to it
                Actor target = map.getActorAt(exit.getDestination());

                // description to be returned
                String ret = actor + " " + actor.getIntrinsicWeapon().verb() + " " + target + " for " + actor.getIntrinsicWeapon().damage() + " damage.";
                // deal damage to target
                target.hurt(actor.getIntrinsicWeapon().damage());

                // if the target is dead after being attacked, display death description
                if (!target.isConscious()){
                    ret += new DeathAction(actor).execute(target, map);
                }
                new Display().println(ret);
            }
        }
        return "";
    }

    /**
     * Returns a descriptive string
     * @param actor The actor performing the action.
     * @return the text we put on the menu
     */
    @Override
    public String menuDescription(Actor actor) {
        return "";
    }

    /**
     * A factory for creating actions. Chaining these together can result in an actor performing more complex tasks.
     * @param actor the Actor acting
     * @param map the GameMap containing the Actor
     * @return an Action that actor can perform, or null if actor can't do this.
     */
    @Override
    public Action getAction(Actor actor, GameMap map) {
        // slams behaviour can always be performed
        return this;
    }
}
