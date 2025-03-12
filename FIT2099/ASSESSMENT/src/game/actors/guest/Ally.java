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
import game.actors.Player;
import game.behaviours.AttackBehaviour;
import game.behaviours.Behaviour;
import game.behaviours.FollowBehaviour;
import game.behaviours.WanderBehaviour;
import game.reset.ResetManager;
import game.reset.Resettable;
import game.utils.ActorType;
import game.utils.Status;

import java.util.HashMap;
import java.util.Map;

/**
 * Ally has 50% chance to be spawned into the map when player summon on summon sign.
 * It starts with any available combat archetypes chosen randomly,
 * which can help the player defeat enemies or Invaders.
 * @author Chew Xin Ning 32693974
 * @version 2.0
 * Modified by: Ng Yu Mei 32423454
 */
public class Ally extends Actor {

    /**
     * Hashmap where it contains an integer (key) representing the priority of the behaviour (value)
     */
    private Map<Integer, Behaviour> behaviours = new HashMap<>();

    /**
     * Constructor for Ally.
     * @param hitPoints the starting hit points for different combat archetype chosen
     */
    public Ally(int hitPoints) {
        super("Ally", 'A', hitPoints);
        behaviours.put(999, new WanderBehaviour());
        addCapability(Status.HOSTILE_TO_ENEMY);
    }

    /**
     * Ally can only perform attack on other enemy.
     * It does not carry out trading with traders, pick up weapons, fast travel and retrieve runes.
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
                if (!target.hasCapability(Status.HOSTILE_TO_ENEMY) && !target.hasCapability(ActorType.FRIENDLY_ACTOR)){
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
     * Ally can attack by any other hostile actor except for Player.
     *
     * @param otherActor the Actor that might be performing attack
     * @param direction  String representing the direction of the other Actor
     * @param map        current GameMap
     * @return actions that can be performed by other actor to current actor
     */
    @Override
    public ActionList allowableActions(Actor otherActor, String direction, GameMap map) {

        ActionList actions = new ActionList();

        if(!otherActor.hasCapability(Status.HOSTILE_TO_ENEMY)){
            WeaponItem weaponItem = this.getWeaponInventory().get(0);
            actions.add(new AttackAction(this, direction, weaponItem));
            if (weaponItem.hasCapability(Status.HAS_UNIQUE_SKILL)){
                actions.add(weaponItem.getSkill(this, direction));
            }
        }
        return actions;
    }

}
