package game.actors.ocean;

import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.IntrinsicWeapon;
import game.actions.DespawnAction;
import game.utils.Status;
import game.weapons.GiantCrayFishPincer;

/**
 * Giant Cray Fish has 4803 hit points and slams other creatures with their giant pincer,
 * dealing 527 damage with 100% accuracy.
 * It spawns on the east side of puddle of water.
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 2.0
 * Modified by: Chew Xin Ning 32693974
 *            : Ng Yu Mei 32423454
 */
public class GiantCrayFish extends OceanEnemy {

    /**
     * Constructor for Giant Cray Fish.
     * @param map the game map
     */
    public GiantCrayFish(GameMap map) {
        super("Giant Cray Fish", 'R', 4803, map);
        addWeaponToInventory(new GiantCrayFishPincer());
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
     * @return a Giant Crayfish's IntrinsicWeapon
     */
    @Override
    public IntrinsicWeapon getIntrinsicWeapon(){
        return new IntrinsicWeapon(527, "slams", 100);
    }

    /**
     * Creates and returns Runes.
     * @return Runes dropped by Giant Crayfish after defeated by player.
     */
    @Override
    public int getRune() {
        return super.generateRune(500, 2374);
    }
}
