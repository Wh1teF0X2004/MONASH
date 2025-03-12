package game.trader;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.items.Item;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.weapons.AxeOfGodrick;
import game.weapons.GraftedDragon;

/**
 * A class for the action TradeAction.
 * TradeAction is used when something is traded.
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 2.0.0
 */
public class TradeAction extends Action {

    /**
     * Trader that is responsible for the trade
     */
    private Trader trader;

    /**
     * Player that is trading
     */
    private Actor actor;

    /**
     * Items intended to be traded
     */
    private Tradable itemToTrade;

    /**
     * Weapon player obtained through trade
     */
    private WeaponItem tradedWeapon;

    /**
     * Boolean to indicate whether the trade is successful
     */
    private boolean tradeSuccess;

    /**
     * The instance of Display class
     */
    private Display displayInstance;

    /**
     * Constructor for the Trade action.
     *
     * @param trader            Trader that handles for the trade
     * @param actor             Player that is performing the trade
     * @param itemToTrade       The item that is intended to be traded by player
     */
    public TradeAction(Trader trader, Actor actor, Tradable itemToTrade) {
        this.trader = trader;
        this.actor = actor;
        this.itemToTrade = itemToTrade;
        this.displayInstance = new Display();
    }

    /**
     * Function to perform the actual trade action after player providing Remembrance Of The Grafted to Enia.
     * @return boolean to indicate whether the trade is successful
     */
    public boolean makeTrade(Actor actor, int playerChoice){
        tradeSuccess = false;

        if (itemToTrade.canBeTraded()){
            tradeSuccess = true;
            if (Character.toLowerCase(playerChoice) == 'f'){
                tradedWeapon = new AxeOfGodrick();
                actor.addWeaponToInventory(new AxeOfGodrick());
            } else if (Character.toLowerCase(playerChoice) == 'k'){
                tradedWeapon = new GraftedDragon();
                actor.addWeaponToInventory(new GraftedDragon());
            }
        } else {
            tradeSuccess = false;
        }

        return tradeSuccess;
    }

    /**
     * Perform the Trading Action.
     *
     * @param actor The actor performing the action.
     * @param map   The map the actor is on.
     * @return a description of what happened that can be displayed to the user.
     */
    @Override
    public String execute(Actor actor, GameMap map) {
        int playerChoice;
        displayInstance.println("F: Trade for Axe of Godrick");
        displayInstance.println("K: Trade for Grafted Dragon");
        displayInstance.println("Enter Choice of trade:");
        playerChoice = displayInstance.readChar();

        makeTrade(actor, playerChoice);
        if (tradeSuccess){
            Item item = (Item) itemToTrade;
            actor.removeItemFromInventory(item);
        }
        return (tradeSuccess) ? actor + " trade " + itemToTrade + " for " + tradedWeapon :
                itemToTrade + " cannot be traded! ";
    }

    /**
     * Returns a descriptive string.
     *
     * @param actor The actor performing the action.
     * @return the text we put on the menu
     */
    @Override
    public String menuDescription(Actor actor) {
        return actor + " trade " + itemToTrade + " from " + trader;
    }
}
