package game.actors;

import edu.monash.fit2099.engine.actions.Action;
import edu.monash.fit2099.engine.actions.ActionList;
import edu.monash.fit2099.engine.actors.Actor;
import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.items.Item;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.displays.Menu;
import edu.monash.fit2099.engine.positions.Ground;
import edu.monash.fit2099.engine.positions.Location;
import edu.monash.fit2099.engine.weapons.IntrinsicWeapon;
import game.actions.DeathAction;
import game.actors.guest.Ally;
import game.player_item.RemembranceOfTheGrafted;
import game.reset.*;
import game.utils.Status;
import game.trader.Rune;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Class representing the Player. It implements the Resettable interface.
 * It carries around a club to attack a hostile creature in the Lands Between.
 *
 * Created by:
 * @author Adrian Kristanto
 *
 * Modified by:
 * Ng Yu Mei 32423454
 * Foo Kai Yan 33085625
 * Chew Xin Ning 32693974
 */
public class Player extends Actor implements Resettable {

	/**
	 * Create new instance of Menu
	 * @see Menu
	 */
	private final Menu menu = new Menu();

	/**
	 * Player's owned runes
	 */
	private static Rune playerRune;

	/**
	 * Player's runes amount
	 */
	private static int runeValue;

	/**
	 * Place where the player die and drop the runes
	 */
	private static Location runesDroppedLocation = null;

	/**
	 * Place where the player last location is
	 */
	private Location lastLocation = null;

	/**
	 * Hashmap of GameMap and actor who are Ally and Invader
	 */
	private static Map<GameMap, Actor> guest;

	/**
	 * Constructor for players.
	 *
	 * @param name        Name to call the player in the UI
	 * @param displayChar Character to represent the player in the UI
	 * @param hitPoints   Player's starting number of hitpoints
	 */
	public Player(String name, char displayChar, int hitPoints) {
		super(name, displayChar, hitPoints);
		this.addCapability(Status.HOSTILE_TO_ENEMY);
		this.addCapability(Status.RESTING);
		playerRune = new Rune(0);	// Player starts with no runes (0)
		ResetManager.resetManager().registerResettable(this); //register to become resettable
		this.addItemToInventory(playerRune);
		this.runeValue = playerRune.getRuneAmount();
		this.guest =  new HashMap<GameMap, Actor>();

		// RemembranceOfTheGrafted trading with Enia
		this.addItemToInventory(new RemembranceOfTheGrafted());
	}

	/**
	 * Getter of Rune of the player
	 *
	 * @return The rune hold by the player
	 */
	public static Rune getPlayerRune(){
		return playerRune;
	}

	/**
	 * Getter of rune amount of the player
	 *
	 * @return The amount of runes of the player
	 */
	public static int getRuneValue() {
		return runeValue;
	}

	/**
	 * Setter of rune amount of the player
	 *
	 * @param runeAmount The total of runes given to the player
	 */
	public static void setRuneValue(int runeAmount) {
		runeValue = runeAmount;
	}

	/**
	 * Setter of location of runes dropped of the player
	 *
	 * @param runesDroppedLocation Last location before the player died and drop the runes
	 */
	public static void setRunesDroppedLocation(Location runesDroppedLocation) {
		Player.runesDroppedLocation = runesDroppedLocation;
	}

	/**
	 * Add a map that guest spawned from and the guest who are Ally and Invader to the Hash Map.
	 *
	 * @param map A map that the guest on
	 * @param guest An actor who will be removed when the player dies
	 */
	public static void addGuest(GameMap map, Actor guest){
		Player.guest.put(map, guest);
	}



	/**
	 * Select and return an action for the player to perform on the current turn of the game
	 *
	 * @param actions    collection of possible Actions for this Actor
	 * @param lastAction The Action this Actor took last turn. Can do interesting things in conjunction with Action.getNextAction()
	 * @param map        the map containing the Actor
	 * @param display    the I/O object to which messages may be written
	 * @return the Action to be performed by the player
	 */
	@Override
	public Action playTurn(ActionList actions, Action lastAction, GameMap map, Display display) {
		// If the player fall off the cliff
		Ground currentGround = map.locationOf(this).getGround();
		if (currentGround != null && currentGround.getDisplayChar()=='+'){
			this.hurt(this.hitPoints);
			return new DeathAction(null);
		}

		//If the player is conscious, which means hitpoints > 0
		if (this.isConscious()){
			lastLocation = map.locationOf(this);
		}

		//If the player steps on the runes
		if (map.locationOf(this) == runesDroppedLocation){
			new RecoverRunesAction().execute(this, map);
		}

		// display current Health point and runes of the player
		display.println("Tarnished " + printHp() + "  Runes: " + getRuneValue());

		// Handle multi-turn Actions
		if (lastAction.getNextAction() != null) {
			return lastAction.getNextAction();
		}

		// return/print the console menu
		return menu.showMenu(this, actions, display);
	}

	/**
	 * Reset the health point of the player to maximum. If the player dies, runes will be dropped at the last location before the player died, Ally and Invader will be wiped from the map.
	 */
	@Override
	public void reset() {
		//If the player dies
		if(!(this.isConscious())) {
			//If there is already another runes dropped on the ground
			if (runesDroppedLocation != null) {
				//Remove the runes dropped at the last location of the player died
				runesDroppedLocation.removeItem(playerRune);
				Player.getPlayerRune().setRuneAmount(runeValue);
			}
			runesDroppedLocation = lastLocation;
			playerRune.togglePortability();
			playerRune.setRuneAmount(runeValue);
			runesDroppedLocation.addItem(playerRune);
			this.setRuneValue(0);

			//Remove Ally and Invader
			for(GameMap map: guest.keySet()){
				map.removeActor(guest.get(map));
			}
			//Make the hash map empty
			guest.clear();

		}
		//execute when the game is reset.
		this.resetMaxHp(this.getMaxHp());
	}

	/**
	 * Creates and returns an intrinsic weapon.
	 * @return a freshly-instantiated IntrinsicWeapon
	 */
	@Override
	public IntrinsicWeapon getIntrinsicWeapon() {
		return new IntrinsicWeapon(11, "punches");
	}
}
