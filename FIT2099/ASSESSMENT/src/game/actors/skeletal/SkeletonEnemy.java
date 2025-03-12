package game.actors.skeletal;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actions.ActionList;
import edu.monash.fit2099.engine.actions.DoNothingAction;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.positions.Exit;
import edu.monash.fit2099.engine.positions.GameMap;
import game.actions.DespawnAction;
import game.actors.Enemy;
import game.behaviours.AttackBehaviour;
import game.behaviours.Behaviour;
import game.behaviours.SlamsAttackAreaBehaviour;
import game.utils.ActorType;
import game.utils.RandomNumberGenerator;
import game.utils.Status;

/**
 * Skeleton enemies are of type skeleton, they spawn on Graveyard.
 * @author Chew Xin Ning
 * Modified by: Foo Kai Yan 33085625
 * @version 2.0
 */
public abstract class SkeletonEnemy extends Enemy {

    /**
     * Constructor for Skeleton Enemy.
     *
     * @param name        the name of the Enemy creature
     * @param displayChar the character that will represent the enemy in the display
     * @param hitPoints   the Enemy's starting hit points
     * @param map         the game map
     */
    public SkeletonEnemy(String name, char displayChar, int hitPoints, GameMap map) {
        super(name, displayChar, hitPoints, map);
        addCapability(ActorType.BONE_TYPE);
        addCapability(Status.REVIVABLE); // has the ability to become a bone piles and revive if it's not hit after 3 rounds
    }

    /**
     * Skeletal Enemy has weapon to attack other actor, they can also perform slam attack area to their surrounding.
     *
     * @param actions    collection of possible Actions for this Actor
     * @param lastAction The Action this Actor took last turn. Can do interesting things in conjunction with Action.getNextAction()
     * @param map        the map containing the Actor
     * @param display    the I/O object to which messages may be written
     * @return the valid action that can be performed in that iteration or null if no valid action is found
     */
    @Override
    public Action playTurn(ActionList actions, Action lastAction, GameMap map, Display display) {
        // enemy can perform attack and follow behaviour on other actor
        for (Exit exit : map.locationOf(this).getExits()){
            if (exit.getDestination().containsAnActor()){
                Actor target = map.getActorAt(exit.getDestination());
                if (RandomNumberGenerator.getRandomInt(0, 100) < 50){
                    behaviours.put(997, new SlamsAttackAreaBehaviour()); // perform area attack to its surrounding
                }
                else {
                    if (!target.hasCapability(ActorType.BONE_TYPE) && !target.hasCapability(ActorType.FRIENDLY_ACTOR)){
                        behaviours.put(997, new AttackBehaviour(target, exit.getName(), getWeaponInventory().get(0)));
                    }
                }
            }
            else if (!exit.getDestination().containsAnActor()){
                behaviours.remove(998); // do not follow an actor if it is not on the surrounding exits
            }
        }

        // obtain the behaviour to be performed
        for (Behaviour behaviour : behaviours.values()) {
            Action action = behaviour.getAction(this, map);
            behaviours.remove(997);
            if(action != null)
                return action;
        }

        return new DoNothingAction();
    }

    /**
     * Despawn enemy when the game is reset
     */
    @Override
    public void reset() {
        super.reset();
    }
}
