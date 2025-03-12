package game.actors.demigod;

import edu.monash.fit2099.engine.positions.GameMap;
import game.actions.DespawnAction;
import game.actors.demigod.DemigodProtector;
import game.weapons.GreatKnife;

/**
 * Godrick Soldier class, which is an inhabitant of the Stormveil Castle.
 * @author Chew Xin Ning 32693974
 * Modified by: Ng Yu Mei 32423454
 *            : Foo Kai Yan 33085625
 * @version 2.0
 */
public class GodrickSoldier extends DemigodProtector {

    /**
     * Constructor for Godrick Soldier.
     * @param map the game map
     */
    public GodrickSoldier(GameMap map) {
        super("Godrick Soldier", 'p', 198, map);
        addWeaponToInventory(new GreatKnife());
    }

    /**
     * Despawn enemy when the game is reset
     */
    @Override
    public void reset() {
        super.reset();
    }

    /**
     * Creates and returns Runes.
     * @return Runes dropped by Dog after defeated by player.
     */
    @Override
    public int getRune() {
        return super.generateRune(38, 70);
    }

}
