package game.reset;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.GameMap;
import game.actions.DeathAction;

/**
 * A class for the action ResetAction.
 * ResetAction is used for resetting the game. ResetAction is triggered when the player rest on the Lost of Grace site and the player dies
 *
 * Created by:
 * @author Ng Yu Mei 32423454
 * @version 1.0
 */
public class ResetAction extends Action{

    /**
     * Perform the Reset action. When executed, Reset Manager class will call its run method to iterate all registered resettable instance to invoke the reset method.
     * Then, the game is reset.
     *@param actor The actor performing the reset action.
     * @param map The map the actor is on.
     * @return A message show the game is reset. The whole game and resettable instance is being reset.
     * @see DeathAction
     */
    @Override
    public String execute(Actor actor, GameMap map) {
        //Run the method of ResetManager class that used to make all resettable class being reset.
        ResetManager.resetManager().run();

        return menuDescription(actor);
    }


    /**
     * Return a String on what was done when the action SellAction is used and how it is related to the Player.
     *
     * @param actor The actor performing the action
     */
    @Override
    public String menuDescription(Actor actor) {
        return "The game is reset. ";
    }
}
