package game.actions;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.positions.Location;

/**
 * Action to be used for Environment to spawn enemy at the respective environment.
 * @author Chew Xin Ning 32693974
 * @version 2.0
 */
public class SpawnAction extends Action {

    /**
     * The location to spawn an enemy
     */
    private Location location;

    /**
     * Setter to set the location to spawn a new enemy
     * @param location location in the map
     */
    public void setLocation(Location location){
        this.location = location;
    }

    /**
     * Method to spawn an enemy at the environment.
     * @param actor the enemy to be spawned and add into the map
     * @param map the current map used in the game
     * @return String representing the spawn action
     */
    public String execute(Actor actor, GameMap map) {
        map.at(location.x(), location.y()).addActor(actor);
        return menuDescription(actor);
    }

    /**
     * A string describing the action suitable for displaying in the menu.
     * @param actor The actor performing the action.
     * @return Description representing the action performed.
     */
    @Override
    public String menuDescription(Actor actor) {
        return actor + " has been added into the map. ";
    }
}
