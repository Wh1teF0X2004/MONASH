package game.actions;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.WeaponItem;

/**
 * Range Attack Action is a skill that shoots an enemy from a specified number of blocks away from the holder.
 * @author Chew Xin Ning 32693974
 * @version 1.0
 */
public class RangeAttackAction extends Action {

    /**
     * The target actor of this action
     */
    private Actor target;

    /**
     * The weapon item used for this action
     */
    private WeaponItem weaponItem;

    /**
     * The direction of the attack deal
     */
    private String direction;

    /**
     * Holder can perform this action if there is enemy in this number of block away from the holder
     */
    private int numOfBlockAway;

    /**
     * Constructor for RangeAttackAction.
     * @param target the target for this action
     * @param direction direction of the action performed
     * @param weaponItem weapon item used to perform this action
     * @param numOfBlockAway the number of block range that allows the holder to perform this action.
     */
    public RangeAttackAction(Actor target, String direction, WeaponItem weaponItem, int numOfBlockAway){
        this.target = target;
        this.weaponItem = weaponItem;
        this.direction = direction;
        this.numOfBlockAway = numOfBlockAway;

    }

    /**
     * Holder shoots an enemy that is within the "attack-able" block range.
     * @param actor The actor performing the action.
     * @param map The map the actor is on.
     * @return result of the action to be displayed on the UI
     */
    @Override
    public String execute(Actor actor, GameMap map) {
        return null;
    }

    /**
     * Describes the action that is being performed.
     *
     * @param actor The actor that is performing the action
     * @return a description used for the menu UI
     */
    @Override
    public String menuDescription(Actor actor) {
        return null;
    }
}
