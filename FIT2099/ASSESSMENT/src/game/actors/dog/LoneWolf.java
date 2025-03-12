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
import game.behaviours.AttackBehaviour;
import game.behaviours.Behaviour;
import game.behaviours.FollowBehaviour;
import game.utils.ActorType;

/**
 * BEHOLD, DOG!
 * LoneWolf class, which is an enemy spawned in the west.
 *
 * Created by:
 * @author Adrian Kristanto
 * Modified by: Chew Xin Ning 32693974
 *             : Ng Yu Mei 32423454
 *             : Foo Kai Yan 33085625
 * @version 3.0
 */
public class LoneWolf extends DogEnemy {

    /**
     * Constructor for LoneWolf.
     * @param map the game map
     */
    public LoneWolf(GameMap map) {
        super("Lone Wolf", 'h', 102, map);
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
     * @return a freshly-instantiated IntrinsicWeapon
     */
    @Override
    public IntrinsicWeapon getIntrinsicWeapon(){
        return new IntrinsicWeapon(97, "bites", 95);
    }

    /**
     * Creates and returns Runes.
     * @return Runes dropped by Lone Wolf after defeated by player.
     */
    @Override
    public int getRune() {
        return super.generateRune(55, 1470);
    }
}
