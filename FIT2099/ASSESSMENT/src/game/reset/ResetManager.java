package game.reset;

import java.util.ArrayList;
import java.util.List;

/**
 * A ResetManager class that manages a list of resettables.
 * Created by:
 * @author Adrian Kristanto
 * Modified by: Ng Yu Mei 32423454
 *@version 1.0
 */
public class ResetManager {

    /**
     * A list of actor or item that can be reset
     */
    private List<Resettable> resettables;

    /**
     * The instance of ResetManager
     */
    private static ResetManager instance;


    /**
     * Constructor for Reset Manager.
     */
    private ResetManager() {
        this.resettables = new ArrayList<>();
    }

    /**
     * Function to return the instance of ResetManager, if the ResetManager has not been created yet in the game, the ResetManager will be created in this method.
     * @return the instance of ResetManager
     */
    public static ResetManager resetManager(){

        if(instance == null){
            instance = new ResetManager();
        }
        return instance;
    }

    /**
     * Loop through all the resettable and invoke the reset method of each resettable.
     */
    public void run() {
        for(Resettable r1 : resettables){
            r1.reset();

        }
    }

    /**
     * Make the actor or item that can be reset added to the list of resettable.
     * @param resettable actor or item that implements Resettable interface
     */
    public void registerResettable(Resettable resettable) {
        resettables.add(resettable);
    }

    /**
     * Remove the actor or item that can be reset from the list of resettable.
     * @param resettable actor or item that implements Resettable interface
     */
    public void removeResettable(Resettable resettable) {
        resettables.remove(resettable);
    }
}
