package FIT2099DigitalBazaar.controllers;

import FIT2099DigitalBazaar.models.devices.Computer;
import FIT2099DigitalBazaar.models.devices.Printer;
import FIT2099DigitalBazaar.models.purchases.InStorePurchase;
import FIT2099DigitalBazaar.models.purchases.OnlinePurchase;
import FIT2099DigitalBazaar.utils.*;

import java.util.ArrayList;
import java.util.Scanner;

/**
 * Store class perform purchases made.
 *
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 * @see IData
 * @see PurchaseManager
 * @see MenuManagerAdmin
 * @see Computer
 * @see Printer
 * @see OnlinePurchase
 * @see InStorePurchase
 */
public class Store implements IData{

    // Attributes
    /**
     * An ArrayList containing all computers made.
     */
    private ArrayList<Computer> computers;
    /**
     * An ArrayList containing all printers made.
     */
    private ArrayList<Printer> printers;
    /**
     * A PurchaseManager that managed all the purchases made.
     */
    private PurchaseManager newPurchaseManager;
    /**
     * A MenuManagerAdmin that contains all the administrative tasks and questions.
     */
    private MenuManagerAdmin newMenuManager;
    /**
     * The instance of Store.
     */
    private static Store newStore;

    // Constructor
    /**
     * Construct a new private Store instance and declare new ArrayLists for computers and printers.
     *
     * @param newPurchaseManager handles the purchases made
     * @param newMenuManager handles the questions and tasks
     */
    private Store(PurchaseManager newPurchaseManager, MenuManagerAdmin newMenuManager) {
        this.newPurchaseManager = newPurchaseManager;
        this.newMenuManager = newMenuManager;
        computers = new ArrayList<>();
        printers = new ArrayList<>();
    }

    /**
     * Construct a new Store instance if there is none.
     *
     * @param newPurchaseManager handles the purchases made
     * @param newMenuManager handles the questions and tasks
     * @return the instance of Store
     */
    public static Store getInstance(PurchaseManager newPurchaseManager, MenuManagerAdmin newMenuManager){
        if (newStore == null) {
            newStore = new Store(newPurchaseManager, newMenuManager);
        }
        return newStore;
    }

    // Methods
    /**
     * Creates a new purchase with the provided details and passes it to the PurchaseManager object to handle.
     *
     * @throws Exception If any error occurs during the purchase creation process
     */
    public void createPurchases() throws Exception {
        String date = "", deliveryAdd = "", storeAdd = "";
        int deviceId = 0, customerId = 0, purchaseType = 0;
        Scanner sel = new Scanner(System.in);
        while (true) {
            try {
                System.out.print("Enter CustomerID:");
                customerId = Integer.parseInt(sel.next());
                break;
            } catch (NumberFormatException e) {
                System.out.println("Wrong CustomerID. Please enter again.");
                System.out.println(e.getMessage());
                createPurchases();
            }

            try {
                System.out.print("Enter DeviceID:");
                deviceId = Integer.parseInt(sel.next());
                break;
            } catch (NumberFormatException e) {
                System.out.println("Wrong DeviceID. Please enter again.");
                System.out.println(e.getMessage());
                createPurchases();
            }

            System.out.print("Enter Date:");
            date = sel.next();

            try {
                System.out.print("Enter Type (0 online) OR (1 in-store):");
                purchaseType = Integer.parseInt(sel.next());
                break;
            } catch (NumberFormatException e) {
                System.out.println("Wrong Purchase Type. Please enter again.");
                System.out.println(e.getMessage());
                createPurchases();
            }
        }

        if (purchaseType == 0) {
            System.out.print("Enter Delivery Address:");
            deliveryAdd = sel.next();

            OnlinePurchase newOnlinePurchase = new OnlinePurchase(0, customerId, deviceId, date, deliveryAdd);
            newOnlinePurchase.generatePurchaseId();
            newOnlinePurchase.setPurchaseId(newOnlinePurchase.getPurchaseId());
            newOnlinePurchase.setPurchaseType(PurchaseType.ONLINE_PURCHASE);

            newPurchaseManager.makePurchase(this, newOnlinePurchase);
        } else {
            System.out.print("Enter Store Address:");
            storeAdd = sel.next();

            InStorePurchase newInStorePurchase = new InStorePurchase(0, customerId, deviceId, date, storeAdd);
            newInStorePurchase.generatePurchaseId();
            newInStorePurchase.setPurchaseId(newInStorePurchase.getPurchaseId());
            newInStorePurchase.setPurchaseType(PurchaseType.INSTORE_PURCHASE);

            newPurchaseManager.makePurchase(this, newInStorePurchase);
            System.out.print("Please head to the selected store to collect your purchase. \nThank you.\n");
        }

    }

    /**
     * Creates a new computer with the provided details and add to the computer ArrayList.
     *
     * @throws Exception If any error occurs during the computer creation process
     */
    public void createComputers() throws Exception {
        String name, description, manufacture;
        Scanner sel = new Scanner(System.in);
        System.out.print("Enter Device Name: ");
        name = sel.nextLine();
        System.out.print("Enter Device Description: ");
        description = sel.nextLine();
        System.out.print("Enter Computer Manufacture: ");
        manufacture = sel.next();
        Computer aComputer = new Computer(name, description, manufacture);
        computers.add(aComputer);
    }

    /**
     * Creates a new printer with the provided details and add to the printer ArrayList.
     *
     * @throws Exception If any error occurs during the printer creation process
     */
    public void createPrinters() throws Exception {
        String name, description;
        int ppm;
        Scanner sel = new Scanner(System.in);
        System.out.print("Enter Device Name: ");
        name = sel.nextLine();
        System.out.print("Enter Device Description: ");
        description = sel.nextLine();
        System.out.print("Enter ppm: ");
        ppm = Integer.parseInt(sel.next());
        Printer aPrinter = new Printer(name, description, ppm);
        printers.add(aPrinter);
    }

    /**
     * Iterate computer ArrayList and print each computer.
     */
    public void printComputers(){
        for(int i = 0; i<computers.size(); i++) {
            System.out.println(computers);
        }
    }

    /**
     * Iterate printer ArrayList and print each printer.
     */
    public void printPrinters(){
        for(int i = 0; i<printers.size(); i++) {
            System.out.println(printers);
        }
    }

    /**
     * Call the PurchaseManager object to handle the printing of purchases.
     */
    public void printPurchases(){
        newPurchaseManager.printPurchases();
    }

    /**
     * Search for the availability of the devices from printer and computer ArrayList.
     * @param id the device id of the device to be checked
     * @return true if device is found, false otherwise
     */
    @Override
    public boolean isDeviceAvailable(int id) {
        boolean flag = false;
        for (int j = 0; j< printers.size(); j++){
            if (printers.get(j).getId() == id){
                flag = true;
                break;
            }
        }
        for (int i = 0; i< printers.size(); i++){
            if (computers.get(i).getId() == id) {
                flag = true;
                break;
            }
        }
        return flag;
    }
}
