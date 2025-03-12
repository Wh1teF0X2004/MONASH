package game.trader;

import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.items.Item;
import edu.monash.fit2099.engine.positions.GameMap;
import game.actors.Player;
import game.controllers.RuneManager;


/**
 * A class for the action SellAction.
 * SellAction is used when an item is sold.
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 3.0
 * Modified by: Chew Xin Ning 32693974
 */
public class SellItemAction extends SellAction {

    /**
     * Constructor for the Sell Item action.
     * @param trader        Trader that handles for the trade
     * @param actor         Player that is performing the trade
     * @param itemToSell    The item that is intended to be sold by player
     */
    public SellItemAction(Trader trader, Actor actor, Sellable itemToSell){
        super(trader, actor, itemToSell);
    }

    /**
     * Sell item to trader.
     *
     * @param actor     The actor performing the action.
     * @param map       The map the actor is on.
     * @return a suitable description to display in the UI
     */
    @Override
    public String execute(Actor actor, GameMap map) {
        makeSell();
        if (sellSuccess){
            Item item = (Item) thingToSell;
            actor.removeItemFromInventory(item);
        }
        return (sellSuccess) ? actor + " sells " + thingToSell + " for " + thingToSell.getSellPrice() :
                thingToSell + " cannot be sold! ";
    }

    /**
     * Function to perform the actual selling item action
     * @return boolean to indicate whether the transaction is successful
     */
    public boolean makeSell(){
        sellSuccess = false;
        if (thingToSell.canBeSold()){
            Player.setRuneValue(RuneManager.getInstance().earnRune(Player.getRuneValue(), thingToSell.getSellPrice()));
            sellSuccess = true;
        }
        return sellSuccess;
    }
}
