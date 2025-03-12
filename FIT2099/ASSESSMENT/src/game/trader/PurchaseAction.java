package game.trader;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.actors.Player;
import game.controllers.RuneManager;

/**
 * A class to perform purchase action.
 * PurchaseAction is used when a purchase is made.
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 2.0.0
 * Modified by: Chew Xin Ning 32693974
 *            : Ng Yu Mei 32423454
 */
public class PurchaseAction extends Action {

    /**
     * Trader that is responsible for the trade
     */
    private Trader trader;

    /**
     * Player that is purchasing
     */
    private Actor actor;

    /**
     * Weapon intended to be purchased
     */
    private Purchasable weaponToPurchase;

    /**
     * Boolean to indicate whether the purchase is successful
     */
    private boolean purchaseSuccess;

    /**
     * Constructor for purchase action.
     *
     * @param trader            Trader that handles for the trade
     * @param actor             Player that is performing the trade
     * @param weaponToPurchase  The weapon that is intended to be purchased by player
     */
    public PurchaseAction(Trader trader, Actor actor, Purchasable weaponToPurchase) {
        this.trader = trader;
        this.actor = actor;
        this.weaponToPurchase = weaponToPurchase;
    }

    /**
     * Purchase weapon from trader.
     *
     * @param actor     The actor performing the action.
     * @param map       The map the actor is on.
     * @return a suitable description to display in the UI
     */
    @Override
    public String execute(Actor actor, GameMap map) {
        makePurchase();
        if (purchaseSuccess){
            WeaponItem weaponItem = (WeaponItem) weaponToPurchase;
            actor.addWeaponToInventory(weaponItem);
        }
        return (purchaseSuccess) ? actor + " purchased " + weaponToPurchase + " for " + weaponToPurchase.getPurchasePrice() :
                actor + " has no enough runes to purchase " + weaponToPurchase;
    }

    /**
     * Function to perform the actual purchase action
     * @return boolean to indicate whether the transaction is successful
     */
    public boolean makePurchase() {
        purchaseSuccess = false;
        if (Player.getRuneValue() >= weaponToPurchase.getPurchasePrice()) {
           Player.setRuneValue(RuneManager.getInstance().spendRune(Player.getRuneValue(), weaponToPurchase.getPurchasePrice()));
            purchaseSuccess = true;
        }
        return purchaseSuccess;
    }

    /**
     * Returns a descriptive string
     *
     * @param actor The actor performing the action.
     * @return the text we put on the menu
     */
    @Override
    public String menuDescription(Actor actor) {
        return actor + " purchases " + weaponToPurchase + " from " + trader + " for " + weaponToPurchase.getPurchasePrice() + " runes";
    }
}
