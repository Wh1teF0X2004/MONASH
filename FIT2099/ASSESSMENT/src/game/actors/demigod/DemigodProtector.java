package game.actors.demigod;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actions.ActionList;
import edu.monash.fit2099.engine.actions.DoNothingAction;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.positions.Exit;
import edu.monash.fit2099.engine.positions.GameMap;
import game.actions.DespawnAction;
import game.actions.SpawnAction;
import game.actors.Enemy;
import game.behaviours.AttackBehaviour;
import game.behaviours.Behaviour;
import game.behaviours.FollowBehaviour;
import game.utils.ActorType;

/**
 * Hordes of inhabitant in Stormveil Castle to protect their demigod, Godrick the Grafted.
 * Demigod protector will attempt to stop the player from progressing through the map and defeating the demigod ruling Limgrave.
 * @author Chew Xin Ning
 * @version 2.0
 */
public abstract class DemigodProtector extends Enemy {

    /**
     * Constructor for Demigod Protector.
     *
     * @param name        the name of the creature
     * @param displayChar the character that will represent the creature in the display
     * @param hitPoints   the creature's starting hit points
     * @param map         the game map
     */
    public DemigodProtector(String name, char displayChar, int hitPoints, GameMap map) {
        super(name, displayChar, hitPoints, map);
        addCapability(ActorType.DEMIGOD_PROTECTOR);
    }

    /**
     * Demigod Protector attacks all other actors accept for actor that has the same type.
     *
     * @param actions    collection of possible Actions for this Actor
     * @param lastAction The Action this Actor took last turn. Can do interesting things in conjunction with Action.getNextAction()
     * @param map        the map containing the Actor
     * @param display    the I/O object to which messages may be written
     * @return the valid action that can be performed in that iteration or null if no valid action is found
     */
    @Override
    public Action playTurn(ActionList actions, Action lastAction, GameMap map, Display display) {
        // perform attack and follow behaviour on other actor
        for (Exit exit : map.locationOf(this).getExits()){
            if (exit.getDestination().containsAnActor()){
                Actor target = map.getActorAt(exit.getDestination());
                if (!target.hasCapability(ActorType.DEMIGOD_PROTECTOR) && !target.hasCapability(ActorType.FRIENDLY_ACTOR)){
                    behaviours.put(997, new AttackBehaviour(target, exit.getName(), getIntrinsicWeapon()));
                    behaviours.put(998, new FollowBehaviour(target));
                }
            }
            else if (!exit.getDestination().containsAnActor()){
                behaviours.remove(998);
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
