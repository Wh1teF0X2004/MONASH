package game.trader;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actions.ActionList;
import edu.monash.fit2099.engine.actions.DoNothingAction;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.items.Item;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.behaviours.SitAroundBehaviour;
import game.utils.Status;


/**
 * A specific Trader class representing a specific Trader named Finger Reader Enia.
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 2.0.0
 */
public class FingerReaderEnia extends Trader implements SitAroundBehaviour {

    /**
     * Construct a new Trader named Finger Reader Enia.
     * Finger Reader Enia is represented with 'E'.
     */
    public FingerReaderEnia() {
        super("Finger Reader Enia", 'E');
    }

    /**
     * Finger Reader Enia does nothing in the Roundtable Hold.
     *
     * @param actions    collection of possible Actions for this Actor
     * @param lastAction The Action this Actor took last turn. Can do interesting things in conjunction with Action.getNextAction()
     * @param map        the map containing the Actor
     * @param display    the I/O object to which messages may be written
     * @return DoNothingAction as Finger Reader Enia does nothing in the Roundtable Hold
     */
    @Override
    public Action playTurn(ActionList actions, Action lastAction, GameMap map, Display display) {
        sitAround();
        return new DoNothingAction();
    }

    /**
     * Finger Reader Enia does nothing in the Roundtable Hold.
     *
     * @return A String to show how Finger Reader Enia does nothing
     */
    @Override
    public String sitAround() {
        // According to the original game, FingerReaderEnia cannot move & Players cannot fight FingerReaderEnia
        return "Finger Reader Enia is in the room with the Two Fingers.";
    }

    /**
     * Shows the actions that Finger Reader Enia can do.
     *
     * @param otherActor the Actor that might be performing the trade
     * @param direction  String representing the direction of the other Actor
     * @param map        current GameMap
     * @return A list of Actions Finger Reader Enia can do.
     */
    @Override
    public ActionList allowableActions(Actor otherActor, String direction, GameMap map) {
        ActionList list = new ActionList();

        // Weapon that can sell to Finger Reader Enia
        if (otherActor.hasCapability(Status.HOSTILE_TO_ENEMY)) {
            if (otherActor.getWeaponInventory().size() > 0) {
                for (WeaponItem weaponItem : otherActor.getWeaponInventory()) {
                    list.add(new SellWeaponAction(this, otherActor, (Sellable) weaponItem));
                }
            }

        }

        // Enia accepts only Remembrance of the Grafted for trading
        if (otherActor.hasCapability(Status.HOSTILE_TO_ENEMY)) {
            if (otherActor.getItemInventory().size() > 0) {
                for (Item item : otherActor.getItemInventory()){
                    if (item.hasCapability(Status.TRADABLE)) {
                        // Trade RemembranceOfTheGrafted for other weapons
                        list.add(new TradeAction(this, otherActor, (Tradable) item));
                        // Sell RemembranceOfTheGrafted for runes
                        list.add(new SellItemAction(this, otherActor, (Sellable) item));
                    }
                }
            }

        }
        return list;
    }

}
