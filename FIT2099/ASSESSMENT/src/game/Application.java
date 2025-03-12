package game;

import java.util.Arrays;
import java.util.List;

import edu.monash.fit2099.engine.displays.Display;
import edu.monash.fit2099.engine.positions.FancyGroundFactory;
import edu.monash.fit2099.engine.positions.GameMap;
import edu.monash.fit2099.engine.positions.Location;
import edu.monash.fit2099.engine.positions.World;
import game.actors.*;
import game.actors.skeletal.SkeletalBandit;
import game.combat.CombatArchetypes;
import game.controllers.CombatMaker;
import game.controllers.CombatManager;
import game.grounds.ground.*;
import game.grounds.spawning.GustOfWind;
import game.player_item.CrimsonTear;
import game.player_item.GoldenSeed;
import game.reset.LostGraceSite;
import game.trader.FingerReaderEnia;
import game.trader.GoldenRune;
import game.trader.MerchantKale;
import game.utils.CreateMap;
import game.utils.FancyMessage;
import game.utils.RandomNumberGenerator;

/**
 * The main class to start the game.
 * Created by:
 * @author Adrian Kristanto
 * Modified by: Foo Kai Yan 33085625
 * 			  : Ng Yu Mei 32423454
 * 			  : Chew Xin Ning 32693974
 *
 */
public class Application {

	public static void main(String[] args) {
		World world = new World(new Display());

		FancyGroundFactory groundFactory = new FancyGroundFactory(new Dirt(), new Wall(), new Floor(), new Cliff(), new Barrack(), new Cage());

		List<String> map = Arrays.asList(
				"......................#.............#..........................+++.........",
				"......................#.............#.......................+++++..........",
				"......................#..___....____#.........................+++++........",
				"......................#...........__#............................++........",
				"......................#_____........#.............................+++......",
				"......................#............_#..............................+++.....",
				"......................######...######......................................",
				"...........................................................................",
				"...........................................................................",
				"........++++......................###___###................................",
				"........+++++++...................________#................................",
				"..........+++.....................#________................................",
				"............+++...................#_______#................................",
				".............+....................###___###................................",
				"............++......................#___#..................................",
				"..............+............................................................",
				"..............++...........................................................",
				"..............................................++...........................",
				"..................++++......................+++...............######..##...",
				"#####___######....++...........................+++............#....____....",
				"_____________#.....++++..........................+..............__.....#...",
				"_____________#.....+....++........................++.........._.....__.#...",
				"_____________#.........+..+.....................+++...........###..__###...",
				"_____________#.............++..............................................");

		GameMap gameMap = new GameMap(groundFactory, map);

		//Lost of Grace Site Created and added to the map.
		LostGraceSite lostGraceSite = new LostGraceSite("The First Step" ,gameMap.at(38,11), gameMap);
		gameMap.at(38, 11).setGround(lostGraceSite);
		gameMap.at(30, 10).setGround(new SummonSign());

		//Add Floor to surround the Lost of Grace Site
		int[] floorGraceX = {0, 1, 1,1, 0, -1, -1, -1};
		int[] floorGraceY = {-1, -1, 0,1, 1, 1, 0, -1};
		for(int i=0; i< floorGraceX.length; i++){
			int x =lostGraceSite.getLocation().x();
			x = x+ floorGraceX[i];
			int y = lostGraceSite.getLocation().y();
			y = y+floorGraceY[i];
			gameMap.at(x,y).setGround(new Floor());
		}
		world.addGameMap(gameMap);

		// BEHOLD, ELDEN RING
		for (String line : FancyMessage.ELDEN_RING.split("\n")) {
			new Display().println(line);
			try {
				Thread.sleep(200);
			} catch (Exception exception) {
				exception.printStackTrace();
			}
		}

		// HINT: what does it mean to prefer composition to inheritance?

//		gameMap.at(30, 12).addActor(new HeavySkeletalSwordsman());

//		gameMap.at(38, 15).addActor(new LoneWolf());

		// Trader added to Limgrave map
		gameMap.at(38, 12).addActor(new MerchantKale());

		// Random number of Golden Rune added to Limgrave map
		int goldRuneMaxDrop;
		for (goldRuneMaxDrop = RandomNumberGenerator.getRandomInt(1,10); goldRuneMaxDrop >= 0; goldRuneMaxDrop--) {
			gameMap.at(GoldenRune.getInstance().randomXDropGoldenRune(gameMap), GoldenRune.getInstance().randomYDropGoldenRune(gameMap)).addItem(new GoldenRune());
		}

		// 5 Golden Seed added to Limgrave map
		int goldSeedMaxDrop;
        for (goldSeedMaxDrop = 5; goldSeedMaxDrop >= 0; goldSeedMaxDrop--) {
			gameMap.at(GoldenSeed.getInstance().randomXDropGoldenSeed(gameMap), GoldenSeed.getInstance().randomYDropGoldenSeed(gameMap)).addItem(new GoldenSeed());
		}

		// initialise player's starting class
		CombatManager combatManager = CombatManager.getInstance();
		combatManager.menuItem();
		CombatMaker combatMaker = CombatMaker.getInstance();
		CombatArchetypes startingClass = combatMaker.getCombatArchetype();

		// add player into the game with starting weapon and Flask of Crimson Tears
		Player player = new Player("Tarnished", '@', startingClass.getStartingHp());
		player.addWeaponToInventory(startingClass.getWeaponItem());
		player.addItemToInventory(CrimsonTear.getInstance());
		world.addPlayer(player, gameMap.at(38, 10));

		// KaiYan: Testing to search Enia shortcut whahahahah
//		world.addPlayer(player, gameMap.at(6, 23));

		// set different environments to the map
		CreateMap.setMap(gameMap);

		//Roundtable Hold map is created and added to world.
		List<String> roundtableHold = Arrays.asList(
				"##################",
				"#________________#",
				"#________________#",
				"#________________#",
				"#________________#",
				"#________________#",
				"#________________#",
				"#________________#",
				"#________________#",
				"#________________#",
				"########___#######");
		GameMap roundtableHoldMap = new GameMap(groundFactory,roundtableHold);
		world.addGameMap(roundtableHoldMap);

		//Set location of door that move Player from Limgrave map to Roundtable Hold map.
		Location limgraveToRoundtableHold = gameMap.at(6,23);
		//Set location of door that move Player from Roundtable Hold map to Limgrave map.
		Location rountableHoldToLimgrave = roundtableHoldMap.at(9, 10);

		//Set Ground, Golden Fog door that move player from Limgrave map to Roundtable Hold map at corresponding location.
		limgraveToRoundtableHold.setGround(new GoldenFogDoor( roundtableHoldMap, "Roundtable Hold", rountableHoldToLimgrave));
		//Set Ground, Golden Fog door that move player from Roundtable Hold map to RLimgrave map at corresponding location.
		rountableHoldToLimgrave.setGround(new GoldenFogDoor( gameMap, "Limgrave", limgraveToRoundtableHold));


		//Stormveil Castle map is created and added to world.
		List<String> stormveilCastle = Arrays.asList(
				"...........................................................................",
				"..................<...............<........................................",
				"...........................................................................",
				"##############################################...##########################",
				"............................#................#.......B..............B......",
				".....B...............B......#................#.............................",
				"...............................<.........<.................................",
				".....B...............B......#................#.......B..............B......",
				"............................#................#.............................",
				"#####################..#############...############.####..#########...#####",
				"...............#++++++++++++#................#++++++++++++#................",
				"...............#++++++++++++...<.........<...#++++++++++++#................",
				"...............#++++++++++++..................++++++++++++#................",
				"...............#++++++++++++#................#++++++++++++#................",
				"#####...##########.....#############...#############..#############...#####",
				".._______........................B......B........................B.....B...",
				"_____..._..____..............<..............<..............................",
				".........____..............................................................",
				"...._______..................<..............<....................<.....<...",
				"#####....##...###..#####...##########___###############......##.....####...",
				"+++++++++++++++++++++++++++#...................#+++++++++++++++++++++++++++",
				"+++++++++++++++++++++++++++....................#+++++++++++++++++++++++++++",
				"+++++++++++++++++++++++++++#....................+++++++++++++++++++++++++++",
				"+++++++++++++++++++++++++++#...................#+++++++++++++++++++++++++++");

		GameMap stormveilCastleMap = new GameMap(groundFactory,stormveilCastle);
		world.addGameMap(stormveilCastleMap);

		//Set location of door that move Player from Limgrave map to Stormveil Castle map.
		Location limgraveToStormveilCastle = gameMap.at(29,0);
		//Set location of door that move Player from Stormveil Castle map to Limgrave map.
		Location stormveilCastleToLimgrave = stormveilCastleMap.at(38,23);

		//Set Ground, Golden Fog door that move player from Limgrave map to Stormveil Castle map at corresponding location.
		limgraveToStormveilCastle.setGround(new GoldenFogDoor(stormveilCastleMap, "StormveilCastle", stormveilCastleToLimgrave));
		//Set Ground, Golden Fog door that move player from Stormveil Castle map to Limgrave map at corresponding location.
		stormveilCastleToLimgrave.setGround(new GoldenFogDoor(gameMap, "Limgrave", limgraveToStormveilCastle));

		// set different environments to the Stormveil Castle map.
		CreateMap.setStormveilCatelMap(stormveilCastleMap);

		//Boss Room map is created and added to world.
		List<String> bossRoom = Arrays.asList(
				"+++++++++++++++++++++++++",
				".........................",
				".........................",
				".........................",
				".........................",
				".........................",
				".........................",
				".........................",
				"+++++++++++++++++++++++++");
		GameMap bossRoomMap = new GameMap(groundFactory, bossRoom);
		world.addGameMap(bossRoomMap);

		//Set given location in the Stormveil Castle map for Summon Sign.
		bossRoomMap.at(2, 2).setGround(new SummonSign());

		//Set location of door that move Player from Stormveil Castle map to Boss Room map.
		Location stormveilCastleToBossRoom = stormveilCastleMap.at(5, 0);
		//Set location of door when the player moved to the Boss Room at first from Stormveil Castle map.
		Location bossRoomLocation = bossRoomMap.at(0,4);

		//Set Ground, Golden Fog door that move player from Stormveil Castle map to Boss Room map at corresponding location.
		stormveilCastleToBossRoom.setGround(new GoldenFogDoor(bossRoomMap, "Boss Room", bossRoomLocation));

		// Trader added to Stormveil Castle map
		roundtableHoldMap.at(5, 9).addActor(new FingerReaderEnia());

		// Random number of Golden Rune added to Stormveil Castle map
		for (goldRuneMaxDrop = RandomNumberGenerator.getRandomInt(1,10); goldRuneMaxDrop >= 0; goldRuneMaxDrop--) {
			stormveilCastleMap.at(GoldenRune.getInstance().randomXDropGoldenRune(gameMap), GoldenRune.getInstance().randomYDropGoldenRune(gameMap)).addItem(new GoldenRune());
		}

		// 3 Golden Seed added to Stormveil Castle map
		for (goldSeedMaxDrop = 5; goldSeedMaxDrop >= 0; goldSeedMaxDrop--) {
			stormveilCastleMap.at(GoldenSeed.getInstance().randomXDropGoldenSeed(gameMap), GoldenSeed.getInstance().randomYDropGoldenSeed(gameMap)).addItem(new GoldenSeed());
		}

		world.run();
	}
}
