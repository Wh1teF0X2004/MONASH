package game.enemy_factory;


import edu.monash.fit2099.engine.positions.GameMap;
import game.actors.dog.DogEnemy;
import game.actors.dog.LoneWolf;
import game.actors.ocean.GiantCrab;
import game.actors.ocean.OceanEnemy;
import game.actors.skeletal.HeavySkeletalSwordsman;
import game.actors.skeletal.SkeletonEnemy;

/**
 * A factory class to spawn enemy on west side of the map.
 * @author Chew Xin Ning 32693974
 * @version 2.0
 */
public class WestMapEnemyFactory implements EnemyFactory {

    /**
     * Return Skeleton Enemy to be spawned
     * @return skeleton enemy to be spawn on west map
     */
    @Override
    public SkeletonEnemy spawnSkeletonEnemy(GameMap map) {
        return new HeavySkeletalSwordsman(map);
    }

    /**
     * Return Ocean Enemy to be spawned
     * @return ocean enemy to be spawn on west map
     */
    @Override
    public OceanEnemy spawnOceanEnemy(GameMap map) {
        return new GiantCrab(map);
    }

    /**
     * Return Dog Enemy to be spawned
     * @return dog enemy to be spawn on west map
     */
    @Override
    public DogEnemy spawnDogEnemy(GameMap map) {
        return new LoneWolf(map);
    }

}
