package FIT2099DigitalBazaar.models.purchases;

/**
 * A class that represents an InStorePurchase, a subclass of Purchase.
 *
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 * @see Purchase
 */
public class InStorePurchase extends Purchase {

    // Attributes
    /**
     * The address of the store.
     */
    private String storeAddress;

    // Constructor
    /**
     * Construct a new InStorePurchase.
     *
     * @param purchaseId The id of the purchase.
     * @param customerId The id of the customer.
     * @param deviceId The id of the device.
     * @param date The date of purchase.
     * @param storeAddress The address of the store.
     * @throws Exception If store address is in incorrect format.
     */
    public InStorePurchase(int purchaseId, int customerId, int deviceId, String date, String storeAddress) throws Exception{
        super(purchaseId, customerId, deviceId, date);
        if (!setStoreAddress(storeAddress)) {
            throw new Exception("Incorrect Store Address's details ");
        }
//        this.storeAddress = storeAddress;
    }

    // Setters
    /**
     * A setter for the store address.
     *
     * @param storeAddress The address of the store.
     * @return true if store address is of the correct length format, false otherwise
     */
    public boolean setStoreAddress(String storeAddress) {
        boolean flag = false;
        // Store Location: 3..10
        if (3 <= storeAddress.length() && storeAddress.length() <= 10){
            this.storeAddress = storeAddress;
            flag = true;
        }
        return flag;
    }

    // Getters
    /**
     * A getter for the address of the store.
     *
     * @return The address of the store.
     */
    public String getStoreAddress() {
        return storeAddress;
    }

    // Methods
    /**
     * A getter for the randomly generated integer within the specified range of 100 to 999 as the purchaseId.
     *
     * @return A randomly generated integer within the specified range of 100 to 999 as the purchaseId.
     */
    @Override
    public int getPurchaseId() {
        return super.getPurchaseId();
    }
}
