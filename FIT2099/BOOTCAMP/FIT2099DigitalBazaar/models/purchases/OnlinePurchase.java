package FIT2099DigitalBazaar.models.purchases;

/**
 * A class that represents an OnlinePurchase, a subclass of Purchase.
 *
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 * @see Purchase
 */
public class OnlinePurchase extends Purchase {

    // Attributes
    /**
     * The address to deliver the purchase to.
     */
    private String deliveryAddress;

    // Constructor
    /**
     * Construct a new OnlinePurchase.
     *
     * @param purchaseId The id of the purchase.
     * @param customerId The id of the customer.
     * @param deviceId The id of the device.
     * @param date The date of purchase.
     * @param deliveryAddress The address to deliver the purchase to.
     * @throws Exception If delivery address is in incorrect format.
     */
    public OnlinePurchase(int purchaseId, int customerId, int deviceId, String date, String deliveryAddress) throws Exception{
        super(purchaseId, customerId, deviceId, date);
        if (!setDeliveryAddress(deliveryAddress)) {
            throw new Exception("Incorrect Delivery Address's details ");
        }
    }

    // Setters
    /**
     * A setter for the address to deliver the purchase to.
     *
     * @param deliveryAddress The address to deliver the purchase to.
     * @return true if the address to deliver the purchase to is of the correct length format, false otherwise
     */
    public boolean setDeliveryAddress(String deliveryAddress) {
        boolean flag = false;
        // Delivery Address: 5..20
        if (5 <= deliveryAddress.length() && deliveryAddress.length() <= 20){
            this.deliveryAddress = deliveryAddress;
            flag = true;
        }
        return flag;
    }

    // Getters
    /**
     * A getter for the address to deliver the purchase to.
     *
     * @return The address to deliver the purchase to.
     */
    public String getDeliveryAddress() {
        return deliveryAddress;
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
