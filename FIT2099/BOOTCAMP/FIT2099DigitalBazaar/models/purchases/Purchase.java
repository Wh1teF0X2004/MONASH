package FIT2099DigitalBazaar.models.purchases;

import FIT2099DigitalBazaar.utils.PurchaseType;
import FIT2099DigitalBazaar.utils.Utils;

/**
 * An abstract class representing a purchase.
 *
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 */
public abstract class Purchase {

    // Attributes
    /**
     * The id of the purchase.
     */
    private int purchaseId;
    /**
     * The id of the customer.
     */
    private int customerId;
    /**
     * The id of the device.
     */
    private int deviceId;
    /**
     * The date of purchase.
     */
    private String date;
    /**
     * The type of the purchase.
     */
    private PurchaseType purchaseType;

    // Constructor
    /**
     * Construct a new Purchase.
     *
     * @param purchaseId The id of the purchase.
     * @param customerId The id of the customer.
     * @param deviceId The id of the device.
     * @param date The date of purchase.
     * @throws Exception If date is in incorrect format.
     */
    public Purchase(int purchaseId, int customerId, int deviceId, String date) throws Exception{
        this.purchaseId = purchaseId;
        this.customerId = customerId;
        this.deviceId = deviceId;
        if (!setDate(date)) {
            throw new Exception("Incorrect Date format");
        }
    }

    // Setters
    /**
     * A setter for customerId.
     *
     * @param customerId The id of the customer.
     */
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    /**
     * A setter for deviceId.
     *
     * @param deviceId The id of the device.
     */
    public void setDeviceId(int deviceId) {
        this.deviceId = deviceId;
    }

    /**
     * A setter for the date of purchase.
     *
     * @param date The date of purchase.
     * @return true if date is of the correct length format, false otherwise
     */
    public boolean setDate(String date) {
        boolean flag = false;
        // Date input: length must be 8 (dd/mm/yy)
        if (date.length() == 8){
            this.date = date;
            flag = true;
        }
        return flag;
    }

    /**
     * A setter for the type of purchase.
     *
     * @param purchaseType The type of the purchase.
     */
    public void setPurchaseType(PurchaseType purchaseType) {
        this.purchaseType = purchaseType;
    }

    /**
     * A setter for purchaseId.
     *
     * @param purchaseId The id of the purchase.
     */
    public void setPurchaseId(int purchaseId) {
        this.purchaseId = purchaseId;
    }

    // Getters
    /**
     * A getter for purchaseId.
     *
     * @return The id of the purchase.
     */
    public int getPurchaseId() {
        return purchaseId;
    }

    /**
     * A getter for customerId.
     *
     * @return The id of the customer.
     */
    public int getCustomerId() {
        return customerId;
    }

    /**
     * A getter for deviceId.
     *
     * @return The id of the device.
     */
    public int getDeviceId() {
        return deviceId;
    }

    /**
     * A getter for the date of purchase.
     *
     * @return The date of purchase.
     */
    public String getDate() {
        return date;
    }

    /**
     * A getter for the type of purchase.
     *
     * @return The type of the purchase.
     */
    public PurchaseType getPurchaseType() {
        return purchaseType;
    }

    // Method
    /**
     * Generate random integer within the specified range of 100 to 999 as the purchaseId.
     */
    public void generatePurchaseId(){
        this.purchaseId =  Utils.nextID(100, 999);
    }

}
