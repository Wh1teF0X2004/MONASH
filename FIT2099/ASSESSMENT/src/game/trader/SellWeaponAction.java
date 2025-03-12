package game.trader;

import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.actors.Player;
import game.controllers.RuneManager;
import game.utils.Status;

/**
 * A class for the action SellAction.
 * SellAction is used when a weapon is sold.
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 2.0
 * Modified by: Chew Xin Ning 32693974
 *            : Ng Yu Mei 32423454
 */
public class SellWeaponAction extends SellAction {

    /**
     * Constructor for the Sell action.
     * @param trader        Trader that handles for the trade
     * @param actor         Player that is performing the trade
     * @param weaponToSell  The weapon that is intended to be sold by player
     */
    public SellWeaponAction(Trader trader, Actor actor, Sellable weaponToSell){
        super(trader, actor, weaponToSell);
    }

    /**
     * Buy weapon from trader.
     * @param actor     The actor performing the action.
     * @param map       The map the actor is on.
     * @return a suitable description to display in the UI
     */
    @Override
    public String execute(Actor actor, GameMap map) {
        makeSell();
        if (sellSuccess){
            WeaponItem weaponItem = (WeaponItem) thingToSell;
            actor.removeWeaponFromInventory(weaponItem);
        }
        return (sellSuccess) ? actor + " sells " + thingToSell + " for " + thingToSell.getSellPrice() :
                thingToSell + " cannot be sold! ";
    }

    /**
     * Function to perform the actual sell action
     * @return boolean to indicate whether the transaction is successful
     */
    public boolean makeSell(){
        sellSuccess = false;
        if (thingToSell.canBeSold()){
            Player.setRuneValue(RuneManager.getInstance().earnRune(Player.getRuneValue(), thingToSell.getSellPrice()));
            sellSuccess = true;
        }
        else {
            int quantity = 0; // quantity of Grossmesser in player's inventory
            for (WeaponItem weaponItem : actor.getWeaponInventory()){
                if (weaponItem.hasCapability(Status.CANNOT_BE_SOLD)){
                    quantity++;
                }
            }
            // only sell Grossmesser when there is more than one Grossmesser in player's inventory
            if (quantity > 1){
                Player.setRuneValue(RuneManager.getInstance().earnRune(Player.getRuneValue(), thingToSell.getSellPrice()));
                sellSuccess = true;
            }
        }
        return sellSuccess;
    }
}
