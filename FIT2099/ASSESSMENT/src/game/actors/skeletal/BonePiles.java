package game.actors.skeletal;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actions.ActionList;
import edu.monash.fit2099.engine.actions.DoNothingAction;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.positions.Exit;
import edu.monash.fit2099.engine.positions.GameMap;
import game.actions.DeathAction;
import game.actions.DespawnAction;
import game.actors.Enemy;
import game.behaviours.Behaviour;
import game.behaviours.FollowBehaviour;
import game.utils.ActorType;
import game.utils.Status;

/**
 * Skeletal Enemy has the ability to turn into Bone Piles after defeated,
 * and could possibly revive with full health if Bone Piles is not hit within the three turns.
 * It does not attack other actor, and it immediately dies once it is hit.
 *
 * @author Chew Xin Ning 32693974
 * Modified by: Ng Yu Mei 32423454
 *              Foo Kai Yan 33085625
 * @version 3.1
 */
public class BonePiles extends Enemy {

    /**
     * Integer to keep track of the game round.
     */
    private int tickRound = 0;

    /**
     * Actor that the bone pile reincarnates from
     */
    private Actor turnFrom;

    /**
     * Getter to get the actor that the bone pile reincarnates from
     * @return the actor that turns into bone pile
     */
    public Actor getTurnFrom() {
        return turnFrom;
    }

    /**
     * Setter to set the actor that the bone pile reincarnates from
     * @param turnFrom actor that is defeated and turns into bone pile
     */
    public void setTurnFrom(Actor turnFrom) {
        this.turnFrom = turnFrom;
    }

    /**
     * Constructor for Bone Piles.
     * @param map the game map
     */
    public BonePiles(GameMap map) {
        super("Bone Piles", 'X', 1, map);
        // only with 1 hit point so that it immediately die after being hit
    }

    /**
     * Bone Pile does not perform attack on other actor, it only follows actor that is of the other type.
     * If bone pile is not hit within three turns, it revives to the enemy that it is reincarnated from.
     *
     * @param actions    collection of possible Actions for this Actor
     * @param lastAction The Action this Actor took last turn. Can do interesting things in conjunction with Action.getNextAction()
     * @param map        the map containing the Actor
     * @param display    the I/O object to which messages may be written
     * @return the valid action that can be performed in that iteration or null if no valid action is found
     */
    @Override
    public Action playTurn(ActionList actions, Action lastAction, GameMap map, Display display) {
        tickRound ++;

        // Bone Pile revives after 3 rounds
        if (tickRound == 3){
            addCapability(Status.BONEPILES);
            return new DeathAction(this); // to remove Bone Piles from the map
        }

        for (Exit exit : map.locationOf(this).getExits()){
            if (exit.getDestination().containsAnActor()){
                Actor target = map.getActorAt(exit.getDestination());
                if (!target.hasCapability(ActorType.BONE_TYPE) && !target.hasCapability(ActorType.FRIENDLY_ACTOR)){
                    behaviours.put(998, new FollowBehaviour(target));
                }
            }
        }

        // obtain the behaviour to be performed
        for (Behaviour behaviour : behaviours.values()) {
            Action action = behaviour.getAction(this, map);
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

    /**
     * Creates and returns Runes.
     * Skeletal enemy will only drop runes to player when the bone piles is hit.
     * @return Runes dropped by Bone Piles after defeated by player.
     */
    @Override
    public int getRune() {
        return super.generateRune(35, 892);
    }
}
