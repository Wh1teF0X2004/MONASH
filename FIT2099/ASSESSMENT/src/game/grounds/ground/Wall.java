package game.grounds.ground;

import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.Ground;

/**
 * Created by:
 * @author Riordan D. Alfredo
 * Modified by: Chew Xin Ning 32693974
 *
 */
public class Wall extends Ground {

	/**
	 * Constructor for Wall.
	 */
	public Wall() {
		super('#');
	}

	/**
	 * Wall cannot be entered by any actor.
	 * @param actor the Actor to check
	 * @return boolean to indicate whether the actor can enter the floor
	 */
	@Override
	public boolean canActorEnter(Actor actor) {
		return false;
	}

	/**
	 * Wall blocks thrown objects
	 * @return boolean to indicate whether this ground blocks thrown objects
	 */
	@Override
	public boolean blocksThrownObjects() {
		return true;
	}
}
