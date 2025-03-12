package game.grounds.ground;

import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.positions.Ground;
import edu.monash.fit2099.engine.positions.Location;
import game.actions.DespawnAction;
import game.actions.SpawnAction;
import game.actors.demigod.Dog;
import game.actors.Enemy;
import game.grounds.spawning.Environment;
import game.utils.RandomNumberGenerator;

/**
 * Cage is an environment in Stormveil Castle which has 37% chance to spawn a Dog demigod protector,
 * and 10% chance to despawn the actor.
 * @author Chew Xin Ning 32693974
 * @version 2.0
 */
public class Cage extends Ground {

    /**
     * Constructor for Cage.
     */
    public Cage() {
        super( '<');
    }

    /**
     * Spawn chance for spawning the enemy
     */
    private int spawnChance = 37;

    /**
     * Despawn chance for removing the enmy
     */
    private int despawnChance = 10;

    /**
     * Getter to obtain the spawn chance
     * @return integer representing the spawn chance
     */
    public int getSpawnChance() {
        return spawnChance;
    }

    /**
     * Getter to obtain the despawn chance
     * @return integer representing the despawn chance
     */
    public int getDespawnChance() {
        return despawnChance;
    }

    /**
     * Cage spawn and despawn enemy on each turn
     * @param location The location of the Ground
     */
    @Override
    public void tick(Location location) {
        // spawn enemy
        if (RandomNumberGenerator.getRandomInt(0, 100) < getSpawnChance()
                && !location.containsAnActor()) {
            SpawnAction spawnAction = new SpawnAction();
            spawnAction.setLocation(location);
            new Display().println(spawnAction.execute(new Dog(location.map()), location.map()));
        }

        // despawn enemy
        if (location.containsAnActor()
                && RandomNumberGenerator.getRandomInt(0, 100) < getDespawnChance()) {
            DespawnAction despawnAction = new DespawnAction();
            new Display().println(despawnAction.execute(location.getActor(), location.map()));
        }
        super.tick(location);
    }
}
