package game.utils;

import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.positions.Location;
import edu.monash.fit2099.engine.positions.NumberRange;
import game.grounds.spawning.Environment;
import game.grounds.spawning.Graveyard;
import game.grounds.spawning.GustOfWind;
import game.grounds.spawning.PuddleOfWater;

/**
 * A class for creating the map for different environment
 * @author Chew Xin Ning 32693974
 * Modified by:  Ng Yu Mei 32423454
 * @version 2.0
 */
public class CreateMap {
    /**
     * Method to initialise the main map for different environment.
     * @param gameMap The current map used in the game
     */
    public static void setMap(GameMap gameMap){
//        // west side
        makeMap(gameMap, new NumberRange(0, 2), new NumberRange(0, 1), new Graveyard(), gameMap);
        makeMap(gameMap, new NumberRange(0, 5), new NumberRange(9, 3), new PuddleOfWater(), gameMap);
        makeMap(gameMap, new NumberRange(18, 2), new NumberRange(18, 2), new GustOfWind(),gameMap);
//        // east side
        makeMap(gameMap, new NumberRange(58, 8), new NumberRange(0, 3), new PuddleOfWater(), gameMap);
        makeMap(gameMap, new NumberRange(58, 1), new NumberRange(12, 2), new Graveyard(),gameMap);
        makeMap(gameMap, new NumberRange(50, 2), new NumberRange(18, 2), new GustOfWind(),gameMap);
    }

    /**
     * Method to initialise the Stromveil Castle map for different environment.
     * @param gameMap The current map used in the game
     */
    public static void setStormveilCatelMap(GameMap gameMap){

        // west side
        makeMap(gameMap, new NumberRange(0, 2), new NumberRange(0, 1), new Graveyard(), gameMap);
        makeMap(gameMap, new NumberRange(0, 5), new NumberRange(10, 3), new PuddleOfWater(), gameMap);
        makeMap(gameMap, new NumberRange(19, 2), new NumberRange(16, 2), new GustOfWind(), gameMap);


        // east side
        makeMap(gameMap, new NumberRange(58, 8), new NumberRange(0, 3), new PuddleOfWater(), gameMap);
        makeMap(gameMap, new NumberRange(59, 1), new NumberRange(12, 2), new Graveyard(),gameMap);
        makeMap(gameMap, new NumberRange(50, 2), new NumberRange(17, 2), new GustOfWind(),gameMap);


    }

    /**
     * To set different environment.
     * @param gameMap       Current map used in game
     * @param map           the current map used in the game
     * @param width         width of the environment
     * @param height        height of the environment
     * @param environment   environment to be added to the map
     */
    private static void makeMap(GameMap gameMap, NumberRange width, NumberRange height, Environment environment, GameMap map){
        for (int x : width){
            for (int y : height){
                gameMap.at(x, y).setGround(environment);
                Location location = new Location(gameMap, x, y);
//                location.setGround(environment);
                environment.setLocation(location, map);
            }
        }
    }
}
