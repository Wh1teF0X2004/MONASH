package game.weapons;

import edu.monash.fit2099.engine.weapons.WeaponItem;

/**
 * A weapon that can be used to shoot the enemy from 3 blocks away.
 * It deals 274 damage with 50% hit rate
 * @author Chew Xin Ning 32693974
 * @version 1.0
 */
public class AstrologerStaff extends WeaponItem {

    /**
     * Constructor for Astrologer's Staff.
     */
    public AstrologerStaff() {
        super("Astrologer's Staff", 'f', 274, "shoots", 50);
    }
}
