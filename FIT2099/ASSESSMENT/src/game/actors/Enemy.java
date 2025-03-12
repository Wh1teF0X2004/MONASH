package game.actors;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actions.ActionList;
import edu.monash.fit2099.engine.actions.DoNothingAction;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.positions.Exit;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.Capable.Killable;
import game.actions.AttackAction;
import game.behaviours.*;
import game.utils.ActorType;
import game.utils.RandomNumberGenerator;
import game.utils.Status;
import game.actions.DespawnAction;
import game.reset.ResetManager;
import game.reset.Resettable;

import java.util.HashMap;
import java.util.Map;

/**
 * Enemy class is a base class that provides basic attributes and methods for generic enemies in the game.
 * @author Chew Xin Ning 32693974
 * @version 3.0
 */
public abstract class Enemy extends Actor implements Resettable, Killable {

    /**
     * Hashmap where it contains an integer (key) representing the priority of the behaviour (value)
     */
    protected Map<Integer, Behaviour> behaviours = new HashMap<>();

    /**
     * Instance of Game map
     */
    protected GameMap map;

    /**
     * Constructor for Enemy.
     * @param name              the name of the Enemy creature
     * @param displayChar       the character that will represent the enemy in the display
     * @param hitPoints         the Enemy's starting hit points
     * @param map               the game map
     */
    public Enemy(String name, char displayChar, int hitPoints, GameMap map) {
        super(name, displayChar, hitPoints);
        behaviours.put(999, new WanderBehaviour());
        this.addCapability(Status.RESPAWNABLE);
        ResetManager.resetManager().registerResettable(this);
        this.map = map;
    }

    /**
     * At each turn, select a valid action to perform.
     * @param actions    collection of possible Actions for this Actor
     * @param lastAction The Action this Actor took last turn. Can do interesting things in conjunction with Action.getNextAction()
     * @param map        the map containing the Actor
     * @param display    the I/O object to which messages may be written
     * @return the valid action that can be performed in that iteration or null if no valid action is found
     */
    @Override
    public Action playTurn(ActionList actions, Action lastAction, GameMap map, Display display) {
        // enemy can perform attack and follow behaviour on other actor
        for (Exit exit : map.locationOf(this).getExits()){
            if (exit.getDestination().containsAnActor()){
                Actor target = map.getActorAt(exit.getDestination());
                behaviours.put(997, new AttackBehaviour(target, exit.getName(),
                        this.getWeaponInventory().size() > 0 ? getWeaponInventory().get(0) : getIntrinsicWeapon()));
                behaviours.put(998, new FollowBehaviour(target));
            }
            else if (!exit.getDestination().containsAnActor()){
                behaviours.remove(998);
            }
        }

        // obtain the behaviour to be performed
        for (Behaviour behaviour : behaviours.values()) {
            Action action = behaviour.getAction(this, map);
            behaviours.remove(997);
            if(action != null)
                return action;
        }

        return new DoNothingAction();
    }

    /**
     * Select action that can be performed by other actor to the current actor.
     *
     * @param otherActor the Actor that might be performing attack
     * @param direction  String representing the direction of the other Actor
     * @param map        current GameMap
     * @return actions that can be performed by other actor to current actor
     */
    @Override
    public ActionList allowableActions(Actor otherActor, String direction, GameMap map) {

        ActionList actions = new ActionList();

        // HINT 1: The AttackAction above allows you to attak the enemy with your intrinsic weapon.
        if(otherActor.hasCapability(Status.HOSTILE_TO_ENEMY)){
            actions.add(new AttackAction(this, direction));

            // HINT 1: How would you attack the enemy with a weapon?
            if(otherActor.getWeaponInventory().size() > 0){
                for (WeaponItem weaponItem : otherActor.getWeaponInventory()){
                    actions.add(new AttackAction(this, direction, weaponItem));
                    if (weaponItem.hasCapability(Status.HAS_UNIQUE_SKILL)){
                        actions.add(weaponItem.getSkill(this, direction));
                    }
                }
            }
        }
        else { // first, check for the actor type
            if (otherActor.findCapabilitiesByType(ActorType.class) != this.findCapabilitiesByType(ActorType.class)){
                // other enemy attack current enemy using weapon item
                if (otherActor.getWeaponInventory().size() > 0){
                    WeaponItem weaponItem = otherActor.getWeaponInventory().get(0);
                    // other actor attacks current actor using weapon's unique skill
                    if (weaponItem.hasCapability(Status.HAS_UNIQUE_SKILL)){
                        actions.add(weaponItem.getSkill(this, direction));
                    } // attack using weapon's normal skill
                    actions.add(new AttackAction(this, direction, otherActor.getWeaponInventory().get(0)));
                }
                else { // other actor attacks current actor using intrinsic weapon
                    actions.add(new AttackAction(this, direction));
                }
            }
        }
        return actions;
    }

    /**
     * Getter for enemy's behaviours
     * @return Hashmap representing the priority of each behaviour
     */
    public Map<Integer, Behaviour> getBehaviours() {
        return behaviours;
    }

    /**
     * set resetTriggered to true means that the game is reset
     */
    @Override
    public void reset() {
        new DespawnAction().execute(this, map);
    }

    /**
     * To generate random amount of runes after enemy is defeated.
     * @param lowerBound upper bound of runes generated
     * @param upperBound lower bound of runes generated
     * @return random amount of runes
     */
    public int generateRune(int lowerBound, int upperBound) {
        return RandomNumberGenerator.getRandomInt(lowerBound, upperBound);
    }

    /**
     * Getter to get the random generated number of runes drop by enemy when defeated.
     * @return random number of runes
     */
    public abstract int getRune();

}
