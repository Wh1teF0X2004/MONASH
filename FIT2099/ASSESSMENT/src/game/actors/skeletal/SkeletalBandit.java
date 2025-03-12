package game.actors.skeletal;

import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.IntrinsicWeapon;
import game.actions.DespawnAction;
import game.actors.skeletal.SkeletonEnemy;
import game.weapons.Scimitar;

/**
 * Skeletal Bandit is an enemy with 184 hp and carries around a weapon called Scimitar.
 * It is spawned in the east map of Graveyard.
 *
 * Created by:
 * @author Chew Xin Ning 32693974
 * @version 2.0
 * Modified by: Foo Kai Yan 33085625
 *            : Ng Yu Mei 32423454
 */
public class SkeletalBandit extends SkeletonEnemy {

    /**
     * Constructor for SkeletalBandit.
     * @param map the game map
     */
    public SkeletalBandit(GameMap map) {
        super("Skeletal Bandit", 'b', 184, map);
        addWeaponToInventory(new Scimitar());
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
     * @return a Skeletal Bandit's IntrinsicWeapon
     */
    @Override
    public IntrinsicWeapon getIntrinsicWeapon() {
        return new IntrinsicWeapon(38, "boinks", 38);
    }

    /**
     * Creates and returns Runes.
     * @return Runes dropped by Skeletal Bandit after defeated by player.
     */
    @Override
    public int getRune() {
        return super.generateRune(35, 892);
    }
}
