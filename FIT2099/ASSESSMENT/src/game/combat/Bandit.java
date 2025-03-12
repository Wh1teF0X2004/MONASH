package game.combat;

import game.weapons.GreatKnife;

/**
 * Bandit starting class which has 414 starting hit point,
 * and they start with the Great Knife in their weapon inventory.
 * @author Chew Xin Ning 32693974
 * @version 1.0
 */
public class Bandit extends CombatArchetypes {

    /**
     * Constructor for Bandit.
     */
    public Bandit() {
        super("Bandit", new GreatKnife(), 414);
    }
}
