package game.controllers;

import game.combat.*;
import game.utils.RandomNumberGenerator;

import java.util.ArrayList;

/**
 * CombatMaker class initialises the starting class, hp and weapon of the actor.
 * @author Chew Xin Ning 32693974
 * @version 2.0
 */
public class CombatMaker {

    /**
     * The single instance of combat maker
     */
    private static CombatMaker instance = null;

    /**
     * The combat archetypes that will be made
     */
    private CombatArchetypes combatArchetypes;

    /**
     * Character to represent Bandit
     */
    private static final char MAKE_BANDIT = 'b';

    /**
     * Character to represent Samurai
     */
    private static final char MAKE_SAMURAI = 's';

    /**
     * Character to represent Wretch
     */
    private static final char MAKE_WRETCH = 'w';

    /**
     * Character to represent Astrologer
     */
    private static final char MAKE_ASTROLOGER = 'a';

    /**
     * Static method to ensure only one instance of CombatMaker is created at all times.
     * @return the single static instance of CombatMaker
     */
    public static CombatMaker getInstance(){
        if (instance == null){
            instance = new CombatMaker();
        }
        return instance;
    }

    /**
     * Private constructor which is only accessible by getInstance() method to prevent any external code
     * from creating a new instance of CombatMaker class using public constructor
     */
    private CombatMaker(){}

    /**
     * Method to create the corresponding combat archetype based on player choice
     * @param selection the player's selected option
     */
    public void createCombat(char selection){
        switch (selection) {
            case MAKE_BANDIT:
                createBandit();
                break;
            case MAKE_SAMURAI:
                createSamurai();
                break;
            case MAKE_WRETCH:
                createWretch();
                break;
            case MAKE_ASTROLOGER:
                createAstrologer();
                break;
        }
    }

    /**
     * Create new instance of Bandit
     */
    public void createBandit(){
        combatArchetypes = new Bandit();
    }

    /**
     * Create new instance of Samurai
     */
    public void createSamurai(){
        combatArchetypes = new Samurai();
    }

    /**
     * Create new instance of Wretch
     */
    public void createWretch(){
        combatArchetypes = new Wretch();
    }

    /**
     * Create new instance of Astrologer
     */
    public void createAstrologer(){
        combatArchetypes = new Astrologer();
    }

    /**
     * Getter to obtain the combat archetype
     * @return combat archetype created
     */
    public CombatArchetypes getCombatArchetype(){
        return combatArchetypes;
    }

    /**
     * Method to create a random combat archetype
     */
    public void makeRandomCombat(){
        ArrayList<Character> combatChar = new ArrayList<>();
        combatChar.add(MAKE_ASTROLOGER);
        combatChar.add(MAKE_BANDIT);
        combatChar.add(MAKE_SAMURAI);
        combatChar.add(MAKE_WRETCH);
        // randomly select the combat character
        char selection = RandomNumberGenerator.getRandomElement(combatChar);
        createCombat(selection);
    }
}
