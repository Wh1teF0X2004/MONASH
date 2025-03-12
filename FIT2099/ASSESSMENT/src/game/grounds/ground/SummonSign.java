package game.grounds.ground;


import edu.monash.fit2099.engine.actions.ActionList;
import edu.monash.fit2099.engine.actions.DoNothingAction;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.Ground;
import edu.monash.fit2099.engine.positions.Location;
import game.actions.SummonAction;
import game.utils.Status;

/**
 * Allies or Invaders could be summoned on Summon Sign.
 * There is a 50% chance that the player will spawn an Ally and a 50% chance that the player will spawn an Invader.
 * @author Chew Xin Ning 32693974
 * @version 1.0
 */
public class SummonSign extends Ground {

    /**
     * Constructor for Summon Sign.
     */
    public SummonSign() {
        super( '=');
    }

    /**
     * Only the Player can interact with Summon Sign to summon a guest from another realm.
     *
     * @param actor the Actor acting
     * @param location the current Location
     * @param direction the direction of the Ground from the Actor
     * @return
     */
    @Override
    public ActionList allowableActions(Actor actor, Location location, String direction) {

        ActionList actions = new ActionList();
        if (actor.hasCapability(Status.RESTING)){
            SummonAction summonAction = new SummonAction();
            summonAction.setLocation(location);
            actions.add(summonAction);
        }
        else {
            actions.add(new DoNothingAction());
        }
        return actions;
    }
}
