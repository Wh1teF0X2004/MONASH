package game.actions;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.positions.Location;
import game.utils.Status;


/**
 * A class for implementation of travelling of player between map.
 * @author Ng Yu Mei 32423454
 * @version 1.0
 */
public class TravelAction extends Action {


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
     * Constructor for TravelAction.
     * @param toMap The map that the player move to
     * @param destinationName The name of the destination map
     * @param destinationDoorLocation The location of the map that player move to or the location of door that move player back to map they come from
     */
    public TravelAction(GameMap toMap, String destinationName, Location destinationDoorLocation){
        this.toMap = toMap;
        this.destinationName =destinationName;
        this.destinationDoorLocation =destinationDoorLocation;
    }


    /**
     * Move Player from current map to destination map.
     *
     * @param actor     The actor performing the action.
     * @param map       The map the actor is on.
     * @return a suitable description to display in the UI
     */
    @Override
    public String execute(Actor actor, GameMap map) {
        if(actor.hasCapability(Status.RESTING)){
            map.moveActor(actor, destinationDoorLocation);
        }
        return menuDescription(actor);
    }

    /**
     * Returns a descriptive string.
     * @param actor The actor performing the action
     * @return the text we put on the menu
     */
    @Override
    public String menuDescription(Actor actor) {
        return actor+" travels to "+destinationName;
    }
}
