package game.trader;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actions.ActionList;
import edu.monash.fit2099.engine.actions.DoNothingAction;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.behaviours.SitAroundBehaviour;
import game.controllers.TradeManager;
import game.utils.Status;

/**
 * A specific Trader class representing a specific Trader named Kale.
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 2.0.0
 * Modified by: Chew Xin Ning 32693974
 */
public class MerchantKale extends Trader implements SitAroundBehaviour {

    /**
     * Construct a new Trader named Merchant Kale.
     */
    public MerchantKale() {
        super("Merchant Kale", 'K');
    }

    /**
     * Merchant Kale does nothing.
     *
     * @param actions    collection of possible Actions for this Actor
     * @param lastAction The Action this Actor took last turn. Can do interesting things in conjunction with Action.getNextAction()
     * @param map        the map containing the Actor
     * @param display    the I/O object to which messages may be written
     * @return the valid action that can be performed in that iteration or null if no valid action is found
     */
    @Override
    public Action playTurn(ActionList actions, Action lastAction, GameMap map, Display display) {
        return new DoNothingAction();
    }

    /**
     * Merchant Kale cannot be attacked by any actor, and it can perform trade with player only.
     *
     * @param otherActor the Actor that in on the surrounding exits
     * @param direction  String representing the direction of the other Actor
     * @param map        current GameMap
     * @return actions that can be performed by other actor
     */
    @Override
    public ActionList allowableActions(Actor otherActor, String direction, GameMap map) {
        ActionList actions = new ActionList();
        // weapon that can be purchased from merchant kale
        for (Purchasable purchasable : TradeManager.getInstance().getWeaponItemsList()){
            actions.add(new PurchaseAction(this, otherActor, purchasable));
        }

        // weapon that can be sold to merchant kale
        if (otherActor.hasCapability(Status.HOSTILE_TO_ENEMY)) {
            if (otherActor.getWeaponInventory().size() > 0) {
                for (WeaponItem weaponItem : otherActor.getWeaponInventory()) {
                    actions.add(new SellWeaponAction(this, otherActor, (Sellable) weaponItem));
                }
            }

        }
        return actions;
    }

    /**
     * Merchant Kale sits around the building in the middle of the map.
     *
     * @return A String to show how Merchant Kale sits around
     */
    @Override
    public String sitAround() {
        return "Merchant Kale sits around the building in the middle of the map.";
    }
}
