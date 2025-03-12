package game.controllers;

import edu.monash.fit2099.engine.items.Item;
import game.player_item.RemembranceOfTheGrafted;
import game.trader.Purchasable;
import game.weapons.*;

import java.util.ArrayList;

/**
 * A class to manage trade.
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * Modified by:
 * Chew Xin Ning 32693974
 * @version 2.0.0
 */
public class TradeManager {

    /**
     * The single static instance of Trade Manager
     */
    private static TradeManager instance = null;

    /**
     * An arraylist containing all tradable weapons
     */
    private ArrayList<Purchasable> weaponItemsList;

    /**
     * An arraylist containing all tradable items
     */
    private ArrayList<Item> itemList;

    /**
     * Constructor for Trade Manager
     */
    private TradeManager(){
        weaponItemsList = new ArrayList<>();
        addWeaponItemsList();
        itemList = new ArrayList<>();
        addItemList();
    }

    /**
     * Construct a new Trade Manager instance if there is none.
     * @return a new Trade Manager instance
     */
    public static TradeManager getInstance(){
        if (instance == null){
            instance = new TradeManager();
        }
        return instance;
    }

    /**
     * Add tradable weapons to an arraylist
     */
    public void addWeaponItemsList(){
        weaponItemsList.add(new Club());
        weaponItemsList.add(new GreatKnife());
        weaponItemsList.add(new HeavyCrossbow());
        weaponItemsList.add(new Scimitar());
        weaponItemsList.add(new Uchigatana());
    }

    /**
     * Get an arraylist which contains all tradable weapons
     * @return an arraylist containing all tradable weapons
     */
    public ArrayList<Purchasable> getWeaponItemsList() {
        return weaponItemsList;
    }

    /**
     * Add tradable items to an arraylist
     */
    public void addItemList(){
        itemList.add(new RemembranceOfTheGrafted());
    }

    /**
     * Get an arraylist which contains all tradable items
     * @return an arraylist containing all tradable items
     */
    public ArrayList<Item> getItemList() {
        return itemList;
    }
}
