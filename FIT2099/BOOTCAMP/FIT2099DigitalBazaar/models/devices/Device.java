package FIT2099DigitalBazaar.models.devices;

/**
 * An abstract class representing a device.
 *
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 */
public abstract class Device {

    // Attribute
    /**
     * The name of the device.
     */
    private String deviceName;
    /**
     * The description of the device.
     */
    private String deviceDescription;
    /**
     * The id of the device.
     */
    private int id;

    // 2-parameter constructor
    /**
     * Construct a new device.
     *
     * @param deviceName The name of the device.
     * @param deviceDescription The description of the device.
     * @throws Exception If device name and description is in incorrect format.
     */
    public Device(String deviceName, String deviceDescription) throws Exception{
        if (!setDeviceName(deviceName) && !setDeviceDescription(deviceDescription)) {
            throw new Exception("Incorrect Device's details ");
        }
    }

    // Getters
    /**
     * A getter for the name of the device.
     *
     * @return The name of the device.
     */
    public String getDeviceName() {
        return deviceName;
    }

    /**
     * A getter for the description of the device.
     *
     * @return The description of the device.
     */
    public String getDeviceDescription() {
        return deviceDescription;
    }

    /**
     * A getter for the id of the device.
     *
     * @return The id of the device.
     */
    public int getId() {
        return id;
    }

    // Setters
    /**
     * A setter for the name of the device.
     *
     * @param deviceName The name of the device.
     * @return true if the name of the device is of the correct length format, false otherwise
     */
    public boolean setDeviceName(String deviceName) {
        boolean flag = false;
        // Device Name: string with length in range 3..15
        if (3 <= deviceName.length() && deviceName.length() <= 15){
            this.deviceName = deviceName;
            flag = true;
        }
        return flag;
    }

    /**
     * A setter for the description of the device.
     *
     * @param deviceDescription The description of the device.
     * @return true if the description of the device is of the correct length format, false otherwise
     */
    public boolean setDeviceDescription(String deviceDescription) {
        boolean flag = false;
        // Device Description: length in range 5..20
        if (5 <= deviceDescription.length() && deviceDescription.length() <= 20){
            this.deviceDescription = deviceDescription;
            flag = true;
        }
        return flag;
    }

    /**
     * A setter for the id of the device.
     *
     * @param id The id of the device.
     */
    public void setId(int id) {
        this.id = id;
    }

    // Method
    /**
     * An abstract method that will generate a random integer from a specified range as the id of the device.
     *
     * @return A random integer from a specified range as the id of the device.
     */
    public abstract int generateId();

    // toString
    /**
     * Print the devices available in a certain format.
     *
     * @return the print format of the list of devices.
     */
    @Override
    public String toString() {
        return "| name: " + getDeviceName() + "| description: " + getDeviceDescription();
    }
}
