package game.grounds.spawning;

import edu.monash.fit2099.engine.positions.GameMap;
import game.actors.ocean.OceanEnemy;

/**
 * PuddleOfWater is an environment which is occupied by ocean type enemies,
 * which has 2% chance to spawn an enemy on the west map,
 * 1% chance to spawn an enemy on the east map,
 * and 10% chance to despawn an enemy.
 * @author Chew Xin Ning 32693974
 * @version 3.0
 */
public class PuddleOfWater extends Environment {

    /**
     * Constructor for PuddleOfWater.
     */
    public PuddleOfWater() {
        super("Puddle Of Water", '~', 1, 2, 10);
    }

    /**
     * Method to spawn an enemy on the ground based on the map location (East/West) of the ground on the game map.
     * @return the enemy to be spawned on the map
     */
    @Override
    public OceanEnemy spawnEnemy(GameMap map) {
        return enemyFactory.spawnOceanEnemy(map);
    }
}
