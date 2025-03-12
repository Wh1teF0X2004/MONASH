package game.trader;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.GameMap;

/**
 * A class for basic implementation of Sell Action.
 * @author Chew Xin Ning
 * @version 1.0
 */
public abstract class SellAction extends Action {

    /**
     * Trader that is responsible for the trade
     */
    protected Trader trader;

    /**
     * Player that is selling
     */
    protected Actor actor;

    /**
     * Thing intended to be sold
     */
    protected Sellable thingToSell;

    /**
     * Boolean to indicate whether the selling is successful
     */
    protected boolean sellSuccess;

    /**
     * Constructor for the Sell action.
     * @param trader        Trader that handles for the trade
     * @param actor         Player that is performing the trade
     * @param thingToSell   The thing that is intended to be sold by player
     */
    public SellAction(Trader trader, Actor actor, Sellable thingToSell){
        this.trader = trader;
        this.actor = actor;
        this.thingToSell = thingToSell;
    }

    /**
     * Function to perform the actual sell action.
     * @return boolean to indicate whether the transaction is successful
     */
    public abstract boolean makeSell();

    /**
     * Buy thing from trader.
     * @param actor     The actor performing the action.
     * @param map       The map the actor is on.
     * @return a suitable description to display in the UI
     */
    @Override
    public String execute(Actor actor, GameMap map) {
        return null;
    }

    /**
     * Returns a descriptive string.
     * @param actor The actor performing the action
     * @return the text we put on the menu
     */
    @Override
    public String menuDescription(Actor actor) {
        return actor + " sells " + thingToSell + " to " + trader + " for " + thingToSell.getSellPrice() + " runes";
    }
}
