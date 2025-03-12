package game.weapons;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.weapons.WeaponItem;
import game.behaviours.SlamsAttackAreaBehaviour;

/**
 * A simple weapon used by Giant Crab to attack the enemy.
 * It deals 208 damage with 90% hit rate accuracy
 *
 * @author Foo Kai Yan
 * @version 2.0.0
 * Modified by: Chew Xin Ning 32693974
 */
public class GiantCrabPincer extends WeaponItem {

    /**
     * Constructor.
     */
    public GiantCrabPincer() {
        super("Giant Crab Pincer", 'V', 208, "slams", 90);
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
