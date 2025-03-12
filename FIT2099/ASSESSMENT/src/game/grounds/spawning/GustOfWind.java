package game.grounds.spawning;

import edu.monash.fit2099.engine.positions.GameMap;
import game.actors.dog.DogEnemy;


/**
 * GustOfWind is an environment which is occupied by dog type of enemies,
 * which has 33% chance to spawn an enemy on the west map,
 * 4% to spawn an enemy on the east map,
 * and 10% chance to despawn an enemy.
 * @author Chew Xin Ning 32693974
 * @version 3.0
 */
public class GustOfWind extends Environment {

    /**
     * Constructor for GustOfWind.
     */
    public GustOfWind() {
        super("Gust Of Wind", '&', 4, 33, 10);
    }

    /**
     * Method to spawn an enemy on the ground based on the map location (East/West) of the ground on the game map.
     * @return the enemy to be spawned on the map
     */
    @Override
    public DogEnemy spawnEnemy(GameMap map) {
        return enemyFactory.spawnDogEnemy(map);
    }
}
