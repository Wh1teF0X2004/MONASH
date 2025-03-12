package game.controllers;

import edu.monash.fit2099.engine.displays.Display;

/**
 * CombatManager is a manager class to display the available combat archetype choices for player and
 * initialise the combat archetype using CombatMaker.
 * @author Chew Xin Ning
 * @version 2.0
 */
public class CombatManager {

    /**
     * The single instance of CombatManager
     */
    private static CombatManager instance = null;

    /**
     * Static method to ensure only one instance of CombatManager is created
     * @return the single static instance of CombatManager
     */
    public static CombatManager getInstance(){
        if (instance == null){
            instance = new CombatManager();
        }
        return instance;
    }

    /**
     * Method that prints the menu options for player to choose their starting class
     */
    public void menuItem(){
        Display display = new Display();
        display.println("Select your role: ");
        display.println("b: Bandit");
        display.println("s: Samurai");
        display.println("w: Wretch");
        display.println("a: Astrologer");
        CombatMaker.getInstance().createCombat(display.readChar());
    }
}
