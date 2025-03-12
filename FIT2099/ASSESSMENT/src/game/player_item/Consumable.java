package game.player_item;

import edu.monash.fit2099.engine.actors.Actor;

/**
 * Interface for all item that can be consumed.
 *
 * @author Ng Yu Mei 32423454
 * @version 1.0.0
 */
public interface Consumable {

    /**
     * Returns a String shows a number of uses the item has left
     *
     * @return Returns a String shows a number of uses the item has left.
     */
    String showItemUse();

    /**
     * Item will be consumed, the variable of actor will be affected
     *@param actor The actor who consume the item
     */
    void consumeBy(Actor actor);

    /**
     * Returns a integer shows a number of uses the item has left
     *
     * @return Returns a integer shows a number of uses the item has left.
     */
    int getMaximumUse();
}
