package FIT2099DigitalBazaar.controllers;

import FIT2099DigitalBazaar.models.purchases.Purchase;

import java.util.ArrayList;

/**
 * PurchaseManager class manager purchases made through the Store class.
 *
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 * @see Purchase
 * @see Store
 * @see IData
 */
public class PurchaseManager {

    // Attributes
    /**
     * An ArrayList containing of all the purchases made.
     */
    public ArrayList<Purchase> purchaseList = new ArrayList<>();
    /**
     * The instance of PurchaseManager.
     */
    private static PurchaseManager newPurchaseManager;

    // Constructor
    /**
     * Construct a new private PurchasesManager instance.
     */
    private PurchaseManager() {
        newPurchaseManager = new PurchaseManager();
    }

    /**
     * Construct a new PurchaseManager instance if there is none.
     * @return the instance of PurchaseManager
     */
    public static PurchaseManager getInstance(){
        if (newPurchaseManager == null){
            newPurchaseManager = new PurchaseManager();
        }
        return newPurchaseManager;
    }

    // Getter
    /**
     * A getter for the purchaseList.
     * @return the purchaseList as an ArrayList
     */
    public ArrayList<Purchase> getPurchaseList() {
        return purchaseList;
    }

    // Setter
    /**
     * A setter for the purchaseList.
     * @param purchaseList an ArrayList containing all the purchases made
     */
    public void setPurchaseList(ArrayList<Purchase> purchaseList) {
        this.purchaseList = purchaseList;
    }

    // Method
    /**
     * Makes a purchase and add it to the purchaseList only if the device is available.
     * @param devices information of the availability of device
     * @param data information of the device that was purchased
     */
    public void makePurchase(IData devices, Purchase data){
        if (devices.isDeviceAvailable(data.getDeviceId())){
            purchaseList.add(data);
        }
    }

    /**
     * Prints the list of purchases from purchaseList.
     */
    public void printPurchases(){
        String leftAlignFormat = "| %-5d | %-5d | %-5d | %-10s | %-8s |%n";
        String leftAlignFormatHeader = "| %-5s | %-5s | %-5s | %-10s | %-8s |%n";

        String header=String.format(leftAlignFormatHeader, "P-ID","C-ID","D-ID","Date","Type");
        int headerLen=header.length()-1; // -1 to ignore the return key
        String border = String.format("%" + headerLen + "s", " ").replace(' ', '-');
        System.out.format("%s\n", border);

        System.out.format(leftAlignFormatHeader, "P-ID","C-ID","D-ID","Date","Type");
        System.out.format("%s\n", border);

        for (Purchase eachPurchase: getPurchaseList()){
            System.out.format(leftAlignFormat, eachPurchase.getPurchaseId(), eachPurchase.getCustomerId(), eachPurchase.getDeviceId(), eachPurchase.getDate(), eachPurchase.getPurchaseType());
        }

        System.out.format("%s\n", border);
    }
}
