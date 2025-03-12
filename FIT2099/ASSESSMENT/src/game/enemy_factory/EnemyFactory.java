package game.enemy_factory;


import edu.monash.fit2099.engine.positions.GameMap;
import game.actors.dog.DogEnemy;
import game.actors.ocean.OceanEnemy;
import game.actors.skeletal.SkeletonEnemy;

/**
 * Interface for factory classes to spawn enemies on east and west map.
 * @author Chew Xin Ning 32693974
 * @version 3.0
 */
public interface EnemyFactory {

    /**
     * Return Skeletal Enemy to be spawned
     * @param MAP the game map
     * @return skeletal enemy to be spawn on west/east map
     */
    SkeletonEnemy spawnSkeletonEnemy(GameMap MAP);

    /**
     * Return Ocean Enemy to be spawned
     * @param map the game map
     * @return ocean enemy to be spawn on west/east map
     */
    OceanEnemy spawnOceanEnemy(GameMap map);

    /**
     * Return Dog Enemy to be spawned
     * @param map the game map
     * @return dog enemy to be spawn on west/east map
     */
    DogEnemy spawnDogEnemy(GameMap map);
}
