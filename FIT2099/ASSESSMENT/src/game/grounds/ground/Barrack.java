package game.grounds.ground;

import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.positions.Ground;
import edu.monash.fit2099.engine.positions.Location;
import game.actions.DespawnAction;
import game.actions.SpawnAction;
import game.actors.Enemy;
import game.actors.demigod.Dog;
import game.actors.demigod.GodrickSoldier;
import game.grounds.spawning.Environment;
import game.utils.RandomNumberGenerator;

/**
 * Barrack is an environment in Stormveil Castle which has 45% chance to spawn a Godrick Soldiers demigod protector,
 * and 10% chance to despawn the actor.
 * @author Chew Xin Ning 32693974
 * @version 2.0
 */
public class Barrack extends Ground {

    /**
     * Constructor for Barrack.
     */
    public Barrack() {
        super('B');
    }

    /**
     * Spawn chance for spawning the enemy
     */
    private int spawnChance = 45;

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
     * Barrack spawn and despawn enemy on each turn
     * @param location The location of the Ground
     */
    @Override
    public void tick(Location location) {
        // spawn enemy
        if (RandomNumberGenerator.getRandomInt(0, 100) < getSpawnChance()
                && !location.containsAnActor()) {
            SpawnAction spawnAction = new SpawnAction();
            spawnAction.setLocation(location);
            new Display().println(spawnAction.execute(new GodrickSoldier(location.map()), location.map()));
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
