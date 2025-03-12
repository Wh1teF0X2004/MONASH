package game.behaviours;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.Weapon;
import game.actions.AttackAction;

/**
 * Attack Behaviour is the behaviour to attack on other creatures in the actor's surrounding.
 * @author Chew Xin Ning 32693974
 * @version 1.0
 */
public class AttackBehaviour implements Behaviour{

    /**
     * The target actor to attack
     */
    private final Actor target;

    /**
     * Direction of attack
     */
    private String direction;

    /**
     * Weapon used to perform attack
     */
    private Weapon weapon;

    /**
     * Constructor for AttackBehaviour.
     * @param target the target to be attacked
     * @param direction the direction to attack
     * @param weapon the weapon used to perform attack
     */
    public AttackBehaviour(Actor target, String direction, Weapon weapon){
        this.target = target;
        this.direction = direction;
        this.weapon = weapon;
    }

    /**
     * Returns a AttackAction to attack the target with weapon.
     * @param actor the Actor acting
     * @param map the GameMap containing the Actor
     * @return attack action using weapon
     */
    @Override
    public Action getAction(Actor actor, GameMap map) {
        return new AttackAction(target, direction, weapon);
    }

}
