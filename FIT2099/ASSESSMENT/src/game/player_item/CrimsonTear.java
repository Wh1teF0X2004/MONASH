package game.player_item;

import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.items.Item;
import game.reset.ResetManager;
import game.reset.Resettable;

/**
 * A class for the player's item Flask of Crimson Tears.
 * ResetAction is used for resetting the game. ResetAction is triggered when the player rest on the Lost of Grace site and the player dies
 *
 * Created by:
 * @author Ng Yu Mei 32423454
 * @version 1.0
 */
public class CrimsonTear extends Item implements Consumable, Resettable {

    /**
     * the maximum use of item
     */
    private int maximumUse;

    /**
     * instance of CrimsonTear
     */
    private static CrimsonTear instance = null;

    /**
     * Constructor for Crimson Tears.
     */
    private CrimsonTear(){
        super("Flask of Crimson Tears", '.', false);
        this.maximumUse = 2;
        this.addAction(new ConsumeAction(this));
        ResetManager.resetManager().registerResettable(this);

    }

    /**
     * Function to return the instance of Crimson Tear, if the Crimson Tears has not been created yet in the game, the Crimson tears will be created in this method.
     * @return the instance of Crimson Tear
     */
    public static CrimsonTear getInstance(){
        if (instance == null){
            instance = new CrimsonTear();
        }
        return instance;
    }

    /**
     * Returns an integer shows a current number of uses the item has left
     *
     * @return An integer shows current number of uses the item has left.
     */
    @Override
    public int getMaximumUse(){
        return maximumUse;
    }

    /**
     * Set the maximum use of the Flask of Crimson Tears
     * @param maximumUse the maximum use of the Flask of Crimson Tears
     */
    public void setMaximumUse(int maximumUse) {
        this.maximumUse = maximumUse;
    }

    /**
     * Returns a string shows current number of uses the item has left
     *
     * @return Returns a string shows current number of uses the item has left.
     */
    @Override
    public String showItemUse() {
        // Modified as max number of Flask of Crimson Tears is not fixed to 2 (A3 Req5)
        return getMaximumUse() + " of Flask of Crimson Tears remains.";
    }

    /**
     * Item will be consumed, the actor will get healed by 250 points after consuming the item.
     * The number of uses the item has left will be deducted by one
     *@param actor The actor who consume the item
     */
    @Override
    public void consumeBy(Actor actor) {

            maximumUse = maximumUse - 1;
            actor.heal(250);
    }

    /**
     * The number of use of the item has left will be reset to the maximum number it can be use, which is 2 for Crimson Tears.
     */
    @Override
    public void reset() {
        this.maximumUse = 2;
    }
}