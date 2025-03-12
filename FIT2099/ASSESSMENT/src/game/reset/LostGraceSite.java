package game.reset;

import edu.monash.fit2099.engine.actions.ActionList;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.positions.Ground;
import edu.monash.fit2099.engine.positions.Location;
import game.utils.Status;

/**
 * A class for the player resting and reset the game.
 * When the player step on the lost of grace site, the player can decide to rest or reset the game.
 *
 * Created by:
 * @author Ng Yu Mei 32423454
 * @version 2.1
 */
public class LostGraceSite extends Ground  {

    /**
     * The name of the lost of grace site
     */
    private String siteName;

    /**
     * The location where the lost of grace site at
     */
    private static Location location;


    /**
     * Static instance of the Game Map
     */
    private static GameMap gameMap;

    /**
     * Constructor for Lost of grace site.
     *
     * @param siteName The name of Lost of Grace site
     * @param location The location of Lost of Grace Site
     * @param map The map that the Lost of Grace site at
     */
    public LostGraceSite(String siteName, Location location, GameMap map){
        super('U');
        this.siteName = siteName;
        this.addCapability(Status.RESETTABLE);
        this.addCapability(Status.RESTING);
        this.location = location;
        this.gameMap =map;
    }


    /**
     * Getter for the game map
     * @return the game map
     */
    public static GameMap getGameMap(){
        return gameMap;
    }

    /**
     * Getter for the location of the Lost of Grace Site
     * @return The location of the Lost of Grace Site
     */
    public static Location getLocation(){
        return location;
    }


    /**
     * Determine which actor is allowed to enter the location. Only Player can enter and rest at the Lost of Grace site.
     *
     * @param actor Actor that step on the lost of grace site
     * @return Returns a true if actor is allowed enter the location, while false when actor is allowed to enter the location
     */
    @Override
    public boolean canActorEnter(Actor actor) {
       return actor.hasCapability(Status.RESTING);
    }

    /**
     * Shows the actions that Lost Grace of Site can do.
     *
     * @param actor     the Actor acting
     * @param location  the current Location
     * @param direction the direction of the Ground from the Actor
     * @return actions that can be performed by the Lost Grace of Site
     */
    @Override
    public ActionList allowableActions(Actor actor, Location location, String direction) {

        if(canActorEnter(actor)){
            return new ActionList(new RestAction());
        }
        return super.allowableActions(actor, location, direction);
    }
}
