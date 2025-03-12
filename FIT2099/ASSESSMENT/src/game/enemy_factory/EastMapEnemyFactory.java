package game.enemy_factory;


import edu.monash.fit2099.engine.positions.GameMap;
import game.actors.dog.DogEnemy;
import game.actors.dog.GiantDog;
import game.actors.ocean.GiantCrayFish;
import game.actors.ocean.OceanEnemy;
import game.actors.skeletal.SkeletalBandit;
import game.actors.skeletal.SkeletonEnemy;

/**
 * A factory class to spawn enemy on east side of the map.
 * @author Chew Xin Ning 32693974
 * @version 3.0
 */
public class EastMapEnemyFactory implements EnemyFactory {

    /**
     * Return Skeleton Enemy to be spawned
     * @return skeleton enemy to be spawn on east map
     */
    @Override
    public SkeletonEnemy spawnSkeletonEnemy(GameMap map) {
        return new SkeletalBandit(map);
    }

    /**
     * Return Ocean Enemy to be spawned
     * @return ocean enemy to be spawn on east map
     */
    @Override
    public OceanEnemy spawnOceanEnemy(GameMap map) {
        return new GiantCrayFish(map);
    }

    /**
     * Return Dog Enemy to be spawned
     * @return dog enemy to be spawn on east map
     */
    @Override
    public DogEnemy spawnDogEnemy(GameMap map) {
        return new GiantDog(map);
    }
}
