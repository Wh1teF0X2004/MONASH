package game.actors.skeletal;

import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.IntrinsicWeapon;
import game.actions.DespawnAction;
import game.actors.skeletal.SkeletonEnemy;
import game.weapons.Grossmesser;

/**
 * Heavy Skeletal Swordsman is an enemy with 153 hp and carries around a weapon called Grossmesser.
 * It is spawned in the west map of Graveyard.
 *
 * Created by:
 * @author Adrian Kristanto
 * Modified by: Chew Xin Ning 32693974
 *            : Ng Yu Mei 32423454
 *            : Foo Kai Yan 33085625
 * @version 3.1
 */
public class HeavySkeletalSwordsman extends SkeletonEnemy {

    /**
     * Constructor for Heavy Skeletal Swordsman.
     * @param map the game map
     */
    public HeavySkeletalSwordsman(GameMap map) {
        super("Heavy Skeletal Swordsman", 'q', 153, map);
        super.addWeaponToInventory(new Grossmesser());
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
    public IntrinsicWeapon getIntrinsicWeapon() {
        return new IntrinsicWeapon(77, "outreaching hands", 77);
    }

    /**
     * Heavy Skeletal Swordsman does not return runes after defeated as it can turn into a pile of bone.
     * @return Runes dropped by Heavy Skeletal Swordsman after defeated by player.
     */
    @Override
    public int getRune() {
        return 0;
    }
}
