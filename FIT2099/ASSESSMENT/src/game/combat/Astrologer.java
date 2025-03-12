package game.combat;

import game.weapons.GreatKnife;

/**
 * Astrologer combat archetype starts with 396 hit points,
 * with Great Knife as its starting weapon.
 * @author Chew Xin Ning 32693974
 * @version 1.0
 */
public class Astrologer extends CombatArchetypes{

    /**
     * Constructor for Astrologer.
     */
    public Astrologer() {
        super("Astrologer", new GreatKnife(), 396);
    }
}
