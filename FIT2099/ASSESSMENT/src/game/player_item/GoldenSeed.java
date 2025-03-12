package game.player_item;

import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.items.DropItemAction;
import edu.monash.fit2099.engine.items.Item;
import edu.monash.fit2099.engine.items.PickUpItemAction;
import edu.monash.fit2099.engine.positions.GameMap;
import game.reset.Resettable;
import game.utils.RandomNumberGenerator;
import game.utils.Status;

/**
 * Golden Seed is an item that is consumable by players.
 * Player starts with no Golden Seed in hand.
 *
 * Players will have their Flask of Crimson Tear’s number of uses increased once consumed.
 * E.g. 1 Golden Seed = 6 Flask of Crimson Tears
 *      2 Golden Seed = 8 Flask of Crimson Tears
 *      3 Golden Seed = 10 Flask of Crimson Tears
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 3.0.0
 */
public class GoldenSeed extends Item implements Consumable, Resettable {

    /**
     * The amount of golden seeds.
     */
    private int goldenSeedAmount;

    /**
     * The single static instance of Golden Seed
     */
    private static GoldenSeed instance = null;

    /**
     * Constructor for Golden Seed
     */
    public GoldenSeed() {
        super("Golden Seed", '꒰', true);
        this.goldenSeedAmount = 1;
        this.addAction(new ConsumeAction(this));
        this.addAction(new PickUpItemAction(this));
        this.addAction(new DropItemAction(this));
        this.addCapability(Status.PLAYER_DROP_ITEM); // Assuming player drops them when died
    }

    /**
     * Construct a new Golden Seed instance if there is none.
     * @return a new Golden Seed instance
     */
    public static GoldenSeed getInstance(){
        if (instance == null){
            instance = new GoldenSeed();
        }
        return instance;
    }

    /**
     * Number of Golden Seeds left to be consumed by player shown as a String
     * @return A string to show the number of Golden Seeds left to be consumed by player
     */
    @Override
    public String showItemUse() {
        return getMaximumUse() + " of Golden Seed remains";
    }

    /**
     * Player consume Golden Seed to increase maximum use of Flask of Crimson Tears
     * Each Golden Seed consumed is equivalent to 2 additional Flask of Crimson Tears added
     *
     * @param actor The actor who consume the item
     */
    @Override
    public void consumeBy(Actor actor) {
        actor.removeItemFromInventory(this);
        goldenSeedAmount -= 1;

        CrimsonTear.getInstance().setMaximumUse(CrimsonTear.getInstance().getMaximumUse() + 2);
    }

    /**
     * Obtain the number of Golden Seeds left to be consumed by player
     * @return An integer containing the number of Golden Seeds left to be consumed by player
     */
    @Override
    public int getMaximumUse() {
        return goldenSeedAmount;
    }

    /**
     * Set the number of Golden Seeds remaining for the Player to use
     *
     * @param goldenSeedAmount the number of Golden Seeds remaining for the Player to use
     */
    public void setGoldenSeedAmount(int goldenSeedAmount) {
        this.goldenSeedAmount = goldenSeedAmount;
    }

    /**
     * Random x coordinate to drop Golden Seed
     *
     * @param gameMap The gameMap used for the game
     * @return the x coordinate for the golden seed to be dropped
     */
    public int randomXDropGoldenSeed(GameMap gameMap){
        int xLocation = RandomNumberGenerator.getRandomInt(gameMap.getXRange().min(), gameMap.getXRange().max());
        return xLocation;
    }

    /**
     * Random y coordinate to drop Golden Seed
     *
     * @param gameMap The gameMap used for the game
     * @return the y coordinate for the golden seed to be dropped
     */
    public int randomYDropGoldenSeed(GameMap gameMap){
        int yLocation = RandomNumberGenerator.getRandomInt(gameMap.getYRange().min(), gameMap.getYRange().max());
        return yLocation;
    }

    /**
     * The number of use of Golden Seed has left will be reset to 0
     * Golden Seeds can only be obtained from picking up from the GameMap
     */
    @Override
    public void reset() {
        this.goldenSeedAmount = 0;
    }
}
