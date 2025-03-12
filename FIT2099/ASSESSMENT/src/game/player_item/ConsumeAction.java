package game.player_item;

import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.positions.GameMap;
import game.utils.Status;

/**
 * A class for the action ConsumeAction.
 * ConsumeAction is used for consuming consumable item.
 *
 * Created by:
 * @author Ng Yu Mei 32423454
 * Modified by: Foo Kai Yan 33085625
 * @version 1.0
 */
public class ConsumeAction extends Action {

    /**
     * An item that can be consumed
     */
    private Consumable consumable;

    /**
     * Golden Seed which is consumable by players
     */
    private Consumable consumeGoldenSeed;

    /**
     * Flask of Crimson Tears which is consumable by players
     */
    private Consumable consumeCrimsonTear;

    /**
     * Constructor.
     *
     * @param item the item that can be consumed and implement Consumable interface
     */
    public ConsumeAction(Consumable item){
       this.consumable = item;
    }

    /**
     * When executed, the number of item has left is checked
     * if the number of item has left, it can be consumed, otherwise it cannot be consumed.
     *
     * @param actor The actor performing the consume action.
     * @param map The map the actor is on.
     * @return the result of the item consumed, e.g. whether the item is consumed, etc.
     */
    @Override
    public String execute(Actor actor, GameMap map) {
        if (consumable.getMaximumUse() == 0){
            return consumable + " is not consumed by " + actor + ", " + consumable + " has been used up!!!";
        }
        else{
            consumable.consumeBy(actor);
//            return consumable + " is consumed. " + actor + " is healed by 250 hp.";
            return consumable + " is consumed by " + actor + ". ";
        }
    }

    /**
     * Describes the number of item has left
     *
     * @param actor The actor performing the action.
     * @return a description used for the menu UI
     */
    @Override
    public String menuDescription(Actor actor) {
        if(actor.hasCapability(Status.RESTING)){
            return actor + " consumes " + consumable.toString() + " (" + consumable.showItemUse() + ")";
        }
        return null;
    }
}



