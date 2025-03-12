package game.actions;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.GameMap;

/**
 * Class to be used for Environment to despawn enemy at the respective environment.
 * @author Chew Xin Ning
 * @version 1.0
 */
public class DespawnAction extends Action {

    /**
     * Method to despawn an enemy at the given environment
     * @param actor the enemy to be despawned and remove from the map
     * @param map the current map used in the game
     * @return String describing the despawn action
     */
    public String execute(Actor actor, GameMap map) {
        map.removeActor(actor);
        return menuDescription(actor);
    }

    /**
     * A string describing the action suitable for displaying in the menu.
     * @param actor The actor performing the action.
     * @return Description representing the action performed.
     */
    @Override
    public String menuDescription(Actor actor) {
        return actor + " has been removed from the map. ";
    }

}

