package game.weapons;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.behaviours.SlamsAttackAreaBehaviour;

/**
 * A simple weapon used by Giant Dog to attack the enemy.
 * It deals 314 damage with 90% hit rate accuracy
 *
 * @author Chew Xin Ning 32693974
 * @version 1.0
 */
public class GiantDogHead extends WeaponItem {

    /**
     * Constructor.
     */
    public GiantDogHead() {
        super("Giant Dog Head", 'G', 314, "slams", 90);
    }

    /**
     * Skill used when actor use this weapon to attack player.
     * @return the action used by actor
     */
    @Override
    public Action getSkill(Actor target, String direction){
        return new SlamsAttackAreaBehaviour();
    }
}
