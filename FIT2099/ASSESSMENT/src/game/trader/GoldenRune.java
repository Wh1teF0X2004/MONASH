package game.trader;

import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.items.DropItemAction;
import edu.monash.fit2099.engine.items.Item;
import edu.monash.fit2099.engine.items.PickUpItemAction;
import edu.monash.fit2099.engine.positions.GameMap;

import game.player_item.Consumable;
import game.actors.Player;
import game.player_item.ConsumeAction;
import game.utils.Status;
import game.utils.RandomNumberGenerator;
import game.reset.ResetManager;
import game.reset.Resettable;

import static game.trader.Rune.generateRune;


/**
 * A class for Golden Runes.
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 3.0.0
 */
public class GoldenRune extends Item implements Consumable, Resettable {

    /**
     * The amount of golden runes.
     */
    private int goldenRuneAmount;

    /**
     * Instance of Rune
     */
    private Rune rune;

    /**
     * The single static instance of Golden Seed
     */
    private static GoldenRune instance = null;

    /**
     * Construct a new Golden Rune amount for the player.
     */
    public GoldenRune() {
        super("Golden Rune", '*', true);
        this.goldenRuneAmount = 1;
        this.addAction(new ConsumeAction(this));
        this.addAction(new PickUpItemAction(this));
        this.addAction(new DropItemAction(this));
        ResetManager.resetManager().registerResettable(this);
        this.addCapability(Status.PLAYER_DROP_ITEM); // Assuming player drops them when died
    }

    /**
     * Construct a new Golden Seed instance if there is none.
     * @return a new Golden Seed instance
     */
    public static GoldenRune getInstance(){
        if (instance == null){
            instance = new GoldenRune();
        }
        return instance;
    }

    /**
     * A getter for goldenRuneAmount.
     *
     * @return The amount of Golden Rune.
     */
    public int getGoldenRuneAmount() {
        return goldenRuneAmount;
    }

    /**
     * A setter for goldenRuneAmount.
     *
     * @param goldenRuneAmount The amount of golden runes.
     */
    public void setGoldenRuneAmount(int goldenRuneAmount) {
        this.goldenRuneAmount = goldenRuneAmount;
    }

    /**
     * Random x coordinate to drop golden runes
     *
     * @param gameMap The gameMap used for the game
     * @return the x coordinate for the golden rune to be dropped
     */
    public int randomXDropGoldenRune(GameMap gameMap){
        int xLocation = RandomNumberGenerator.getRandomInt(gameMap.getXRange().min(), gameMap.getXRange().max());
        return xLocation;
    }

    /**
     * Random y coordinate to drop golden runes
     *
     * @param gameMap The gameMap used for the game
     * @return the y coordinate for the golden rune to be dropped
     */
    public int randomYDropGoldenRune(GameMap gameMap){
        int yLocation = RandomNumberGenerator.getRandomInt(gameMap.getYRange().min(), gameMap.getYRange().max());
        return yLocation;
    }

    /**
     * Print the goldenRuneAmount.
     * @return String representing the leftover golden rune amount the player have
     */
    public String printGoldenRune(){
        return "Golden Rune: " + goldenRuneAmount;
    }

    /**
     * Reset the goldenRuneAmount.
     */
    @Override
    public void reset() {}

    /**
     * Returns a string shows current number of uses of the Golden Runes
     *
     * @return Returns a String describing the number of uses left for the Golden Runes
     */
    @Override
    public String showItemUse() {
        return "Golden Runes owned: " + goldenRuneAmount;
    }

    /**
     * Consume the Golden Rune for players to receive Runes
     * Random amount of runes are generated after golden rune is consumed
     * Generated runes will automatically be added to player's rune
     *
     * @param actor The actor who consume the item
     */
    @Override
    public void consumeBy(Actor actor) {
        actor.removeItemFromInventory(this);
        goldenRuneAmount -= 1;

        Player.setRuneValue(Player.getRuneValue() + generateRune(200, 10000));
    }

    /**
     * Shows the number of Golden Runes the player have left
     * @return an Integer describing the number of Golden Runes the player have left
     */
    @Override
    public int getMaximumUse() {
        return getGoldenRuneAmount();
    }
}
