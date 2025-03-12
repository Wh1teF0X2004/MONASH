package game.reset;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.positions.GameMap;
import game.player_item.GoldenSeed;
import java.util.Scanner;

/**
 * A class for the action RestAction
 * RestAction is used when player step on the lost of grace site or respawned after the player dies
 *
 * Created by:
 * @author Ng Yu Mei 32423454
 * Modified by:
 * Foo Kai Yan 33085625
 * @version 2.0.0
 */

public class RestAction extends Action{

    /**
     * The instance of Display class
     */
    private Display display;

    /**
     * Constructor for Rest Action.
     */
    public RestAction(){
       this.display = new Display();
    }

    /**
     * When executed, the player will be asked if the player want to use Golden See or Reset the game.
     *
     * If player want to use Golden Seed, it will be used and proceed to ask player if they want to reset the game.
     *
     * If the player want to reset the game, the reset action will be invoked,
     * otherwise the player will just rest at the lost of grace site.
     *
     * @param actor     The actor performing the rest action.
     * @param map       The map the actor is on.
     * @return the result of the game is reset, e.g. whether the game is reset, etc.
     */
    @Override
    public String execute(Actor actor, GameMap map) {
        Scanner sel = new Scanner(System.in);
            display.println("Do you want to consume Golden Seed?");
            display.println("Y: Yes");
            display.println("N: No");
            char choice = display.readChar();
            if (Character.toLowerCase(choice) == 'y') {
                for (int i = 0; i >= actor.getItemInventory().size(); i++){
                    if (actor.getItemInventory().get(i).getDisplayChar() == '꒰'){
                        GoldenSeed.getInstance().consumeBy(actor);
                    } else {
                        display.println("Insufficient Golden Seed amount.");
                    }
                    return GoldenSeed.getInstance().showItemUse();
                }
            }
            display.println("Do you wanna reset the game: ");
            display.println("Y: Yes");
            display.println("N: No");
            choice = display.readChar();
            //If Player want to reset the game, ResetAction is called, else PLayer just rest on the Lost of Grace Site.
            if (Character.toLowerCase(choice) == 'y') {
                return new ResetAction().execute(actor, map);
            } else {
                return menuDescription(actor);
            }

    }

    /**
     * Describes who is resting
     *
     * @param actor The actor performing the action.
     * @return a description used for the menu UI
     */
    @Override
    public String menuDescription(Actor actor) {
        return actor.toString() + " is resting";
    }
}
