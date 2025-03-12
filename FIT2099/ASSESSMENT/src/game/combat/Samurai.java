package game.combat;

import game.weapons.Uchigatana;

/**
 * Samurai starting class which has 455 starting hit point,
 * and they start with the Uchigatana in their weapon inventory.
 * @author Chew Xin Ning 32693974
 * @version 1.0
 */
public class Samurai extends CombatArchetypes {

    /**
     * Constructor for Samurai.
     */
    public Samurai() {
        super("Samurai", new Uchigatana(), 455);
    }
}
