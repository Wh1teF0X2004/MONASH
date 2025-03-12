package game.grounds.ground;

import edu.monash.fit2099.engine.actions.ActionList;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.positions.Ground;
import edu.monash.fit2099.engine.positions.Location;
import game.actions.TravelAction;
import game.utils.Status;

/**
 * A class that represent the location that will move player from current map to another map
 * @author Ng Yu Mei 32423454
 * @version 1.0
 */
public class GoldenFogDoor extends Ground {

    /**
     * A map where the destination locate
     */
    private GameMap toMap;

    /**
     * Name of destination
     */
    private String destinationName;

    /**
     * The location of the door in map and where the player come in to destination map from another map
     */
    private Location destinationDoorLocation;

    /**
     * Constructor for GoldenFogDoor
     * @param toMap The map that the player move to
     * @param destinationName The name of the destination map
     * @param destinationDoorLocation The location of the map that player move to or the location of door that move player back to map they come from
     */
    public GoldenFogDoor(GameMap toMap, String destinationName, Location destinationDoorLocation){
        super('D');
        this.toMap =toMap;
        this.destinationName = destinationName;
        this.destinationDoorLocation = destinationDoorLocation;
    }

    /**
     * GoldenFogDoor cannot be entered by any other actor except for Player
     * @param actor the Actor to check
     * @return boolean to indicate whether the actor can enter the GoldenFogDoor
     */
    @Override
    public boolean canActorEnter(Actor actor) {
        return actor.hasCapability(Status.RESTING);
    }

    /**
     * Only the Player can interact with GoldenFogDoor to move player from current map to another map
     *
     * @param actor the Actor acting
     * @param location the current Location
     * @param direction the direction of the Ground from the Actor
     * @return actions that can be performed by the golden fog door
     */
    @Override
    public ActionList allowableActions(Actor actor, Location location, String direction) {
        if(canActorEnter(actor)){
            return new ActionList(new TravelAction(toMap, destinationName, destinationDoorLocation));
        }
        return super.allowableActions(actor, location, direction);
    }
}
