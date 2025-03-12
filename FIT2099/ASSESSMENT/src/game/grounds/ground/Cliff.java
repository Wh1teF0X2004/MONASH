package game.grounds.ground;

import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.Ground;
import game.utils.Status;

/**
 * A class that represent the location that will kill player.
 * @author Ng Yu Mei 32423454
 * @version 1.0
 */
public class Cliff extends Ground {

    /**
     * Constructor for Cliff.
     */
    public Cliff(){
        super('+');
    }

    /**
     * Method to check if an actor can enter this terrain
     *
     * @param actor the Actor to check
     * @return true if the actor is capable of RESTING, false otherwise
     */
    @Override
    public boolean canActorEnter(Actor actor) {
        return actor.hasCapability(Status.RESTING);
    }
}
