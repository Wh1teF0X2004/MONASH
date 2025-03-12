package game.reset;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.items.Item;
import edu.monash.fit2099.engine.positions.GameMap;
import game.actors.Player;
import game.utils.Status;

import java.util.Scanner;

/**
 * A class for the action RecoverRunesAction
 * RecoverRunesAction is used for recover the rune of the player when the player step on the ground where the runes dropped
 *
 * Created by:
 * @author Ng Yu Mei 32423454
 * @version 1.0
 */
public class RecoverRunesAction extends Action {

    /**
     * An instance of Display class
     */
    private Display display;

    /**
     * Constructor for RecoverRunesAction.
     */
    public RecoverRunesAction(){
        this.display = new Display();
    }

    /**
     * When executed, the player will be asked if the want to recover the rune.
     * If the player want to recover the rune, the current rune that the player hold will be added by the runes value that the player pick, otherwise
     * the player will drop the rune again since the rune is automatically picked up when the player steps on the location where the runes dropped.
     *
     * @param actor     The actor performing the recover rune action.
     * @param map       The map the actor is on.
     * @return The result of the item picked up, e.g. whether the item is picked up, etc.
     */
    @Override
    public String execute(Actor actor, GameMap map) {
        Scanner sel = new Scanner(System.in); // this can remove?
        int total = 0;
        int runesPicked = 0;
        for (Item item : actor.getItemInventory()){
            //if the item is runes
            if(item.hasCapability(Status.PLAYER_DROP_ITEM)){
                display.println("Do you wanna pick up the runes?");
                display.println("Y : Yes");
                display.println("N: No");
                char choice = display.readChar();
                //If player want to pick up the runes
                if(Character.toLowerCase(choice) == 'y') {
                    runesPicked = Player.getPlayerRune().getRuneAmount();
                    total = runesPicked+Player.getRuneValue();
                    Player.getPlayerRune().setRuneAmount(total);
                    Player.setRuneValue(total);
                    item.togglePortability();
                    Player.setRunesDroppedLocation(null);
                    map.locationOf(actor).removeItem(item);
                    return menuDescription(actor)+" (value: "+runesPicked+" )";
                }
                else{
                    // if the item is rejected to pick, the item will be dropped again since the item will be automatically picked
                    item.getDropAction(actor).execute(actor, map);
                    return "You reject to retrieve runes";
                }
            }
        }
        return null;
    }

    /**
     * Describes who retrieves the rune.
     *
     * @param actor The actor performing the action.
     * @return A description used for the menu UI
     */
    @Override
    public String menuDescription(Actor actor) {
        return actor+" retrieves Runes";
    }
}
