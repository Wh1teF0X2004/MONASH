package FIT2099DigitalBazaar;

import FIT2099DigitalBazaar.controllers.PurchaseManager;
import FIT2099DigitalBazaar.controllers.Store;
import FIT2099DigitalBazaar.utils.IMenuManager;
import FIT2099DigitalBazaar.utils.MenuManagerAdmin;
import FIT2099DigitalBazaar.utils.MenuManagerEmployee;

/**
 * <h1> Bazaar Driver Class </h1>
 * The Bazaar Driver Class program implements an application that can make, purchase and show devices of a store.
 * <p>
 *     This class is responsible for creating the instances of the Store class,
 *     PurchaseManager class, MenuManagerAdmin class and MenuManagerEmployee class.
 *
 *     It also contains a loop that is used to display the menu items and perform the necessary actions.
 * </p>
 *
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 * @see PurchaseManager
 * @see MenuManagerAdmin
 * @see MenuManagerEmployee
 * @see Store
 */
public class BazaarDriverClass {
    public static void main(String[] args) throws Exception {

        PurchaseManager newPurchaseManager = PurchaseManager.getInstance();
        MenuManagerAdmin newMenuManager = MenuManagerAdmin.getInstance();
        MenuManagerEmployee newMenuManagerEmployee = MenuManagerEmployee.getInstance();
        Store newStore = Store.getInstance(newPurchaseManager, newMenuManager);

        int selection;
        do {
            selection = newMenuManager.menuItem();
            switch (selection) {
                case 1:
                    newStore.createComputers();
                    break;
                case 2:
                    newStore.createPrinters();
                    break;
                case 3:
                    newStore.createPurchases();
                    break;
                case 4:
                    newStore.printComputers();
                    break;
                case 5:
                    newStore.printPrinters();
                    break;
                case 6:
                    newStore.printPurchases();
                    break;
                case 7:
                    System.exit(0);
            }
        } while (selection != 5);
    }
}
