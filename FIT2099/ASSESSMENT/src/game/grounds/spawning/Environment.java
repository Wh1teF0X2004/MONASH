package game.grounds.spawning;

import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.positions.Ground;
import edu.monash.fit2099.engine.positions.Location;
import game.actions.DespawnAction;
import game.actions.SpawnAction;
import game.enemy_factory.EastMapEnemyFactory;
import game.actors.Enemy;
import game.enemy_factory.EnemyFactory;
import game.enemy_factory.WestMapEnemyFactory;
import game.utils.MapLocation;
import game.utils.RandomNumberGenerator;

/**
 * Environment class is a base class that provides common attributes and methods for generic terrain in the game.
 * @author Chew Xin Ning 32693974
 * Modified by:  Ng Yu Mei 32423454, Foo Kai Yan 33085625
 * @version 2.1
 */
public abstract class Environment extends Ground {

    /**
     * The game map currently used in the game
     */
    private GameMap map;

    /**
     * Enemy factory class responsible for spawning the enemy on the environment
     */
    protected EnemyFactory enemyFactory;

    /**
     * Location of the environment in the map
     */
    private Location location;

    /**
     * Getter to obtain the location of the environment
     * @return location of environment in the map
     */
    public Location getLocation() {
        return location;
    }

    /**
     * Setter to set the location of the environment
     * @param location location of environment in the map
     * @param map game map currently used in the game
     */
    public void setLocation(Location location, GameMap map) {
        this.location = location;
        this.map = map;
    }

    /**
     * Map Location to indicate which side of the map the environment is located on,
     * i.e. East, West
     */
    private MapLocation mapLocation;

    /**
     * Getter to obtain the map location of the environment,
     * it also initialises the Enemy Factory class responsible for spawning the enemy
     * @return the map location
     */
    public MapLocation getMapLocation(){
        if (location.x() < 37){
            mapLocation = MapLocation.WEST;
            enemyFactory = new WestMapEnemyFactory();
        }
        else {
            mapLocation = MapLocation.EAST;
            enemyFactory = new EastMapEnemyFactory();
        }
        return mapLocation;
    }

    /**
     * The name of the environment.
     */
    private final String name;

    /**
     * An integer of how many percent (as dividend/100) the environment to spawn an enemy on the east side of the map.
     */
    private int eastSpawnChance;

    /**
     * An integer of how many percent (as dividend/100) the environment to spawn an enemy on the west side of the map.
     */
    private int westSpawnChance;

    /**
     * An integer of how many percent (as dividend/100) the environment to despawn an enemy.
     */
    private int despawnChance;

    /**
     * Constructor for Environment.
     * @param name The name of the environment
     * @param displayChar character to display for this type of environment
     * @param eastSpawnChance The chance for the creature to be spawned from the environment on the east
     * @param westSpawnChance The chance for the creature to be spawned from the environment on the west
     * @param despawnChance The chance for the creature to be despawned from the environment
     */
    public Environment(String name, char displayChar, int eastSpawnChance, int westSpawnChance, int despawnChance){
        super(displayChar);
        this.name = name;
        this.eastSpawnChance = eastSpawnChance;
        this.westSpawnChance = westSpawnChance;
        this.despawnChance = despawnChance;
    }

    /**
     * Getter for environment spawn chance on the east map.
     * @return Integer representing the spawn chance.
     */
    public int getEastSpawnChance() {
        return eastSpawnChance;
    }

    /**
     * Getter for environment spawn chance on the west map.
     * @return Integer representing the spawn chance.
     */
    public int getWestSpawnChance() {
        return westSpawnChance;
    }

    /**
     * Getter for environment despawn chance.
     * @return Integer representing the despawn chance.
     */
    public int getDespawnChance() {
        return despawnChance;
    }

    /**
     * Spawn and despawn enemy on different side of map in each turn, by using Enemy Factory classes
     * @param location The location of the Environment
     */
    @Override
    public void tick(Location location){
        super.tick(location);
        int chance;
        if (getMapLocation() == MapLocation.EAST){
            chance = getEastSpawnChance();
        }
        else { // West
            chance = getWestSpawnChance();
        }

        // spawn enemy
        if (RandomNumberGenerator.getRandomInt(0, 100) < chance
                && !location.containsAnActor()) {
            SpawnAction spawnAction = new SpawnAction();
            spawnAction.setLocation(location);
            Enemy enemy = spawnEnemy(map);
            new Display().println(spawnAction.execute(enemy, map));
        }

        // despawn enemy
        if (location.containsAnActor()
                && RandomNumberGenerator.getRandomInt(0, 100) < this.getDespawnChance()) {
            DespawnAction despawnAction = new DespawnAction();
            new Display().println(despawnAction.execute(location.getActor(), map));
        }
    }

    /**
     * Method to spawn an enemy on the ground based on the map location (East/West) of the ground on the game map.
     * @param map the game map
     * @return the enemy to be spawned on the map
     */
    public abstract Enemy spawnEnemy(GameMap map);

}
