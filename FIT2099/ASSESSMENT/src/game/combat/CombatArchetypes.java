package game.combat;

import edu.monash.fit2099.engine.weapons.WeaponItem;

/**
 * CombatArchetypes is an abstract class which provides the basic implementation of the starting class chosen by player.
 * @author Chew Xin Ning 32693974
 * @version 1.0
 */
public abstract class CombatArchetypes {

    /**
     * The name of the combat archetype
     */
    private String name;

    /**
     * The starting weapon carried by the combat archetype
     */
    private WeaponItem weaponItem;

    /**
     * The starting hp for the combat archetype
     */
    private int startingHp;

    /**
     * Constructor.
     * @param name The name of the combat archetype
     * @param weaponItem The starting weapon carried by the combat archetype
     * @param startingHp The starting hp for the combat archetype
     */
    public CombatArchetypes(String name, WeaponItem weaponItem, int startingHp){
        this.name = name;
        this.weaponItem = weaponItem;
        this.startingHp = startingHp;
    }

    /**
     * Getter for name
     * @return name of combat archetype
     */
    public String getName() {
        return name;
    }

    /**
     * Getter for starting hp
     * @return integer representing the starting hp
     */
    public int getStartingHp(){
        return startingHp;
    }

    /**
     * Getter for the starting weapon item
     * @return the starting weapon item
     */
    public WeaponItem getWeaponItem() {
        return weaponItem;
    }
}
