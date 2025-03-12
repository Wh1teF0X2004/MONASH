package game.actors.demigod;

import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.IntrinsicWeapon;
import game.actions.DespawnAction;
import game.actors.demigod.DemigodProtector;

/**
 * Dog is a demigod protector of the Stormveil Castle,
 * which has 104 hp, and deal 101 damage with 93% attack accuracy.
 * @author Chew Xin Ning 32693974
 * Modified by: Ng Yu Mei 3242345425
 *            : Foo Kai Yan 33085625
 * @version 2.1
 */
public class Dog extends DemigodProtector {

    /**
     * Constructor for Dog.
     * @param map the game map
     */
    public Dog(GameMap map) {
        super("Dog", 'a', 104, map);

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
        return new IntrinsicWeapon(101, "bites", 93);
    }

    /**
     * Creates and returns Runes.
     * @return Runes dropped by Dog after defeated by player.
     */
    @Override
    public int getRune() {
        return super.generateRune(52, 1390);
    }

}
