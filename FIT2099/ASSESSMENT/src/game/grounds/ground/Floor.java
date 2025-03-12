package game.grounds.ground;

import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.positions.Ground;
import game.utils.Status;

/**
 * A class that represents the floor inside a building.
 * Created by:
 * @author Riordan D. Alfredo
 * Modified by: Chew Xin Ning 32693974
 *
 */
public class Floor extends Ground {

	/**
	 * Constructor for Floor.
	 */
	public Floor() {
		super('_');
	}

	/**
	 * Floor cannot be entered by any other actor except for Actor that is HOSTILE_TO_ENEMY
	 * @param actor the Actor to check
	 * @return boolean to indicate whether the actor can enter the floor
	 */
	@Override
	public boolean canActorEnter(Actor actor) {
		return actor.hasCapability(Status.HOSTILE_TO_ENEMY);
	}
}
