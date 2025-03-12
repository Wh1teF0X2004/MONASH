package game.grounds.spawning;

import edu.monash.fit2099.engine.positions.GameMap;
import game.actors.skeletal.SkeletonEnemy;


/**
 * Graveyard is an environment that is occupied by bone type enemies,
 * which has 27% chance to spawn an enemy on the west map, 27% chance to spawn an enemy on the east map,
 * and 10% chance to despawn an enemy.
 * @author Chew Xin Ning 32693974
 * @version 3.0
 */
public class Graveyard extends Environment {

    /**
     * Constructor for Graveyard.
     */
    public Graveyard() {
        super("Graveyard", 'n', 27, 27, 10);
    }

    /**
     * Method to spawn an enemy on the ground based on the map location (East/West) of the ground on the game map.
     * @return the enemy to be spawned on the map
     */
    @Override
    public SkeletonEnemy spawnEnemy(GameMap map) {
        return enemyFactory.spawnSkeletonEnemy(map);
    }
}
