package game.trader;

import edu.monash.fit2099.engine.actors.Actor;
import game.utils.ActorType;

/**
 * An abstract class representing a Trader.
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 1.0.1
 */
public abstract class Trader extends Actor {

    /**
     * Construct a new Trader.
     *
     * @param name The name of the Trader.
     * @param displayChar The displayed character that represents the Trader.
     */
    public Trader(String name, char displayChar) {
        super(name, displayChar, 0);
        addCapability(ActorType.FRIENDLY_ACTOR);
    }

}
