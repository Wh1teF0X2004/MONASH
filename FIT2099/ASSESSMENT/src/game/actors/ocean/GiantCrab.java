package game.actors.ocean;

import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.IntrinsicWeapon;
import game.actions.DespawnAction;
import game.utils.Status;
import game.weapons.GiantCrabPincer;

/**
 * Giant Crab is an enemy with 407 hp and slams other creatures, dealing 208 damage with 90 attack accuracy.
 * It is spawned in the west map of Puddle of Water.
 *
 * @author Chew Xin Ning 32693974
 * Modified by: Ng Yu Mei 32423454
 *              Foo Kai Yan 33085625
 * @version 3.1
 */
public class GiantCrab extends OceanEnemy {

    /**
     * Constructor for Giant Crab.
     * @param map the game map
     */
    public GiantCrab(GameMap map) {
        super("Giant Crab", 'C', 407, map);
        addWeaponToInventory(new GiantCrabPincer());
        addCapability(Status.ENEMY_SPECIAL_SKILL);
    }

    /**
     * Despawn enemy when the game is reset
     */
    @Override
    public void reset() {
        super.reset();
    }

    /**
     * Creates and returns an intrinsic weapon.
     * @return a freshly-instantiated IntrinsicWeapon
     */
    @Override
    public IntrinsicWeapon getIntrinsicWeapon(){
        return new IntrinsicWeapon(208, "slams", 90);
    }

    /**
     * Creates and returns Runes.
     * @return Runes dropped by Giant Crab after defeated by player.
     */
    @Override
    public int getRune() {
        return super.generateRune(318, 4961);
    }
}
