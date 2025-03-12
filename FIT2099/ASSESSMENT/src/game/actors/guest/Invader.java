package game.actors.guest;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actions.ActionList;
import edu.monash.fit2099.engine.actions.DoNothingAction;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.positions.Exit;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.actions.AttackAction;
import game.actors.Enemy;
import game.behaviours.AttackBehaviour;
import game.behaviours.Behaviour;
import game.behaviours.FollowBehaviour;
import game.utils.ActorType;
import game.utils.Status;

/**
 * Invader has 50% chance to be spawned into the map when player summon on summon sign.
 * It starts with any available combat archetypes chosen randomly.
 * It attacks other hostile creatures, as well as the player.
 * @author Chew Xin Ning 32693974
 * Modified by: Foo Kai Yan 33085625
 * @version 2.0
 */
public class Invader extends Enemy {

    /**
     * Constructor for Invader.
     * @param hitPoints the starting hit points for different combat archetype chosen
     * @param map       the game map
     */
    public Invader(int hitPoints, GameMap map) {
        super("Invader", 'ඞ', hitPoints, map);
        addCapability(ActorType.GUEST);
    }

    /**
     * Create and return runes.
     * @return Runes dropped by Invader after defeated by player.
     */
    @Override
    public int getRune() {
        return super.generateRune(1358, 5578);
    }

    /**
     * set resetTriggered to true means that the game is reset
     */
    @Override
    public void reset() {
        super.reset();
    }

    /**
     * Invader can perform attack on other enemy and also Player.
     *
     * @param actions    collection of possible Actions for this Actor
     * @param lastAction The Action this Actor took last turn. Can do interesting things in conjunction with Action.getNextAction()
     * @param map        the map containing the Actor
     * @param display    the I/O object to which messages may be written
     * @return the valid action that can be performed in that iteration or null if no valid action is found
     */
    @Override
    public Action playTurn(ActionList actions, Action lastAction, GameMap map, Display display) {
        for (Exit exit : map.locationOf(this).getExits()){
            if (exit.getDestination().containsAnActor()){
                Actor target = map.getActorAt(exit.getDestination());
                if (!target.hasCapability(ActorType.GUEST) && !target.hasCapability(ActorType.FRIENDLY_ACTOR)){
                    behaviours.put(997, new AttackBehaviour(target, exit.getName(), getWeaponInventory().get(0)));
                    behaviours.put(998, new FollowBehaviour(target));
                }
            }
            else if (!exit.getDestination().containsAnActor()){
                behaviours.remove(998);
            }
        }
        for (Behaviour behaviour : behaviours.values()){
            Action action = behaviour.getAction(this, map);
            behaviours.remove(997);
            if (action != null){
                return action;
            }
        }
        return new DoNothingAction();
    }

    /**
     * Invader can attack by any other hostile actor.
     *
     * @param otherActor the Actor that might be performing attack
     * @param direction  String representing the direction of the other Actor
     * @param map        current GameMap
     * @return actions that can be performed by other actor to current actor
     */
    @Override
    public ActionList allowableActions(Actor otherActor, String direction, GameMap map) {

        ActionList actions = new ActionList();

        if (!otherActor.hasCapability(ActorType.GUEST)) {
            if (otherActor.getWeaponInventory().size() > 0) {
                WeaponItem weaponItem = otherActor.getWeaponInventory().get(0);
                // other actor attacks current actor using weapon's unique skill
                if (weaponItem.hasCapability(Status.HAS_UNIQUE_SKILL)) {
                    actions.add(weaponItem.getSkill(this, direction));
                } // attack using weapon's normal skill
                actions.add(new AttackAction(this, direction, otherActor.getWeaponInventory().get(0)));
            } else { // other actor attacks current actor using intrinsic weapon
                actions.add(new AttackAction(this, direction));
            }
        }
        return actions;
    }

}
