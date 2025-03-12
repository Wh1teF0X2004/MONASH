package game.combat;

import game.weapons.Club;

/**
 * Wretch starting class which has 414 starting hit point,
 * and they start with the Club in their weapon inventory.
 * @author Chew Xin Ning 32693974
 * @version 1.0
 */
public class Wretch extends CombatArchetypes {

    /**
     * Constructor for Wretch.
     */
    public Wretch() {
        super("Wretch", new Club(), 414);
    }
}
