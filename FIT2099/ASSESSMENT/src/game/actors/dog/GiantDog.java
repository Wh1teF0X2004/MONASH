package game.actors.dog;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actions.ActionList;
import edu.monash.fit2099.engine.actions.DoNothingAction;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.positions.Exit;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.weapons.IntrinsicWeapon;
import game.actions.DespawnAction;
import game.actors.dog.DogEnemy;
import game.behaviours.AttackBehaviour;
import game.behaviours.Behaviour;
import game.behaviours.FollowBehaviour;
import game.behaviours.SlamsAttackAreaBehaviour;
import game.utils.ActorType;
import game.utils.RandomNumberGenerator;
import game.utils.Status;
import game.weapons.GiantDogHead;

/**
 * Giant Dog has 693 hit points and slams other creatures (single target attack), including the player,
 * with their head, dealing 314 damage with 90% accuracy.
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 2.0
 * Modified by: Chew Xin Ning 32693974
 *             Ng Yu Mei 32423454
 */
public class GiantDog extends DogEnemy {

    /**
     * Constructor for GiantDog.
     * @param map the game map
     */
    public GiantDog(GameMap map) {
        super("Giant Dog", 'G', 693, map);
        addWeaponToInventory(new GiantDogHead());
        addCapability(Status.ENEMY_SPECIAL_SKILL);
    }

    /**
     * Despawn enemy when the game is reset
     */
    @Override
    public void reset() {
        super.reset();
    }

    /**
     * Creates and returns an intrinsic weapon.
     * @return a Giant Dog's IntrinsicWeapon
     */
    @Override
    public IntrinsicWeapon getIntrinsicWeapon(){
        return new IntrinsicWeapon(314, "slams", 90);
    }

    /**
     * Creates and returns Runes.
     * @return Runes dropped by Giant Dog after defeated by player.
     */
    @Override
    public int getRune() {
        return super.generateRune(313, 1808);
    }
}
