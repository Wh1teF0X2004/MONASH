package game.actions;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actions.ActionList;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.items.Item;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.positions.Location;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.Capable.Killable;
import game.actors.skeletal.BonePiles;
import game.actors.Player;
import game.reset.ResetAction;
import game.reset.RestAction;
import game.utils.FancyMessage;
import game.utils.Status;
import game.reset.LostGraceSite;

/**
 * An action executed if an actor is killed.
 * Created by:
 * @author Adrian Kristanto
 * Modified by: Ng Yu Mei 32423454, Chew Xin Ning 32693974
 *
 */
public class DeathAction extends Action {

    /**
     * Attacker that is performing the attack
     */
    private Actor attacker;

    /**
     * Constructor for death action.
     * @param actor actor that performs the attack
     */
    public DeathAction(Actor actor) {
        this.attacker = actor;
    }

    /**
     * When the target is killed, the items and weapons carried by target except the player
     * will be dropped to the location in the game map where the target was, the player will only drop runes
     *
     * @param target The actor performing the action.
     * @param map The map the actor is on.
     * @return result of the action to be displayed on the UI
     */
    @Override
    public String execute(Actor target, GameMap map) {
        String result = "";
        ActionList dropActions = new ActionList();

        // if the target is player, player will move to the lost of grace site the player last visited, the runes will be dropped. ResetAction will be called.
        if(target.hasCapability(Status.RESTING)){
            Location lostOfGraceSite = LostGraceSite.getGameMap().at(LostGraceSite.getLocation().x(), LostGraceSite.getLocation().y());
            new TravelAction(LostGraceSite.getGameMap(), "The First Map", lostOfGraceSite).execute(target, map);

            //print fancy "You Died" message
            for (String line : FancyMessage.YOU_DIED.split("\n")) {
                new Display().println(line);
                try {
                    Thread.sleep(200);
                } catch (Exception exception) {
                    exception.printStackTrace();
                }
            }
            return "You have dropped " + Player.getRuneValue() + " value of runes. \n"+new ResetAction().execute(target,LostGraceSite.getGameMap());
        }
        else{
            // for revivable enemy to turn into bone pile after defeated
            Location currentLocation = map.locationOf(target);
            if (target.hasCapability(Status.REVIVABLE)){
                map.removeActor(target);
                BonePiles bonePiles = new BonePiles(map);
                bonePiles.setTurnFrom(target);
                map.addActor(bonePiles, currentLocation);
                // pass the weapon to bone pile
                bonePiles.addWeaponToInventory(target.getWeaponInventory().get(0));
                return "\n" + target + " turns into a pile of bone!";
            }
            // for bone pile to revive if it is not hit after 3 turns
            if (target.hasCapability(Status.BONEPILES)){
                map.removeActor(target);
                // only the bone pile has the status of BONEPILES
                Actor actor = ((BonePiles)target).getTurnFrom();
                map.addActor(actor, currentLocation);
                return actor + " revives from a pile of bone";
            }

            else {
                // drop all items
                for (Item item : target.getItemInventory())
                    dropActions.add(item.getDropAction(target));
                for (WeaponItem weapon : target.getWeaponInventory())
                    dropActions.add(weapon.getDropAction(target));
                for (Action drop : dropActions)
                    drop.execute(target, map);

                // remove actor
                map.removeActor(target);
            }

            // if the attacker is player, player gains runes
            if (attacker.hasCapability(Status.HOSTILE_TO_ENEMY)) {
                Killable killable = (Killable) target;
                Player.setRuneValue(Player.getRuneValue() + killable.getRune());
            }
            result += System.lineSeparator() + menuDescription(target);
            return result;
        }

    }

    /**
     * Describes which target died
     *
     * @param actor The actor that died
     * @return a description used for the menu UI
     */
    @Override
    public String menuDescription(Actor actor) {
        return actor + " is killed. ";
    }
}
