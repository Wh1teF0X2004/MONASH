package game.actions;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.Exit;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.positions.Location;
import game.actors.Player;
import game.actors.guest.Ally;
import game.actors.guest.Invader;
import game.combat.CombatArchetypes;
import game.controllers.CombatMaker;
import game.utils.RandomNumberGenerator;

/**
 * An action to summon a guest ( Invader / Ally ) to the game.
 * @author Chew Xin Ning 32693974
 * @version 2.0
 */
public class SummonAction extends Action {

    /**
     * The location to summon the guest
     */
    private Location location;

    /**
     * Setter to set the location for summoning the guest
     * @param location location in the map
     */
    public void setLocation(Location location){
        this.location = location;
    }

    /**
     * Method to summon a guest on Summon Sign.
     * @param actor the enemy to be summoned and added into the map
     * @param map the current map used in the game
     * @return String representing the summon action
     */
    @Override
    public String execute(Actor actor, GameMap map) {

        SpawnAction spawnAction = new SpawnAction();

        for (Exit exit : location.getExits()){
            // to find an empty spot within the surrounding of summon sign to spawn the guest
            if (!exit.getDestination().containsAnActor()) {
                spawnAction.setLocation(exit.getDestination());
            }
        }

        Actor guest;

        // to choose a random combat archetype for the guest
        CombatMaker.getInstance().makeRandomCombat();
        CombatArchetypes startingClass = CombatMaker.getInstance().getCombatArchetype();

        // 50% chance to summon Ally, 50% chance to summon Invader
        if (RandomNumberGenerator.getRandomInt(0, 100) < 50){
            Actor ally = new Ally(startingClass.getStartingHp());
            ally.addWeaponToInventory(startingClass.getWeaponItem());
            guest = ally;
        }
        else {
            Actor invader = new Invader(startingClass.getStartingHp(), map);
            invader.addWeaponToInventory(startingClass.getWeaponItem());
            guest = invader;
        }
        spawnAction.execute(guest, map);
        Player.addGuest(map, guest);
        return guest + " has been summoned to the game as " + startingClass.getName() + "!";
    }

    /**
     * A string describing the action suitable for displaying in the menu.
     * @param actor The actor performing the action.
     * @return Description representing the action performed.
     */
    @Override
    public String menuDescription(Actor actor) {
        return actor + " summons a guest from another realm";
    }

}
