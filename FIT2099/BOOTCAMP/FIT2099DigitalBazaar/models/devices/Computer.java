package FIT2099DigitalBazaar.models.devices;

import FIT2099DigitalBazaar.utils.Utils;

/**
 * A class that represents a computer, a subclass of Device.
 *
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 * @see Device
 */
public class Computer extends Device {
    // Attribute
    /**
     * The manufacturer of the computer.
     */
    private String computerManufacture;
    /**
     * The total number of computers.
     */
    private int computerCount;

    // Constructor
    /**
     * Construct a new Computer.
     *
     * @param deviceName The name of the device.
     * @param deviceDescription The description of the device.
     * @param computerManufacture The manufacturer of the computer.
     * @throws Exception If computer name, description and manufacturer is in incorrect format.
     */
    public Computer(String deviceName, String deviceDescription, String computerManufacture) throws Exception {
        super(deviceName, deviceDescription);
        if (!setComputerManufacture(computerManufacture) && !setDeviceName(deviceName) && !setDeviceDescription(deviceDescription)) {
            throw new Exception("Incorrect Computer's details ");
        }
    }

    // Setter
    /**
     * A setter for the manufacturer of the computer.
     *
     * @param computerManufacture The manufacturer of the computer.
     * @return true if the manufacturer of the computer is of the correct length format, false otherwise
     */
    public boolean setComputerManufacture(String computerManufacture) {
        boolean flag = false;
        // Computer manufacture: length in range 3..15
        if (3 <= computerManufacture.length() && computerManufacture.length() <= 15){
            this.computerManufacture = computerManufacture;
            flag = true;
        }
        return flag;
    }

    // Getter
    /**
     * A getter for the manufacturer of the computer.
     *
     * @return The manufacturer of the computer.
     */
    public String getComputerManufacture() {
        return computerManufacture;
    }

    // Method
    /**
     * Generate a random integer from 100000 to 9999999 as the id of the computer.
     *
     * @return A random integer from 100000 to 9999999 as the id of the computer.
     */
    @Override
    public int generateId() {
        return Utils.nextID(100000,9999999);
    }

    // toString
    /**
     * Print the computers available in a certain format.
     *
     * @return the print format of the list of computer.
     */
    @Override
    public String toString() {
        computerCount += 1;
        return "Computer ("+ computerCount +") ID:" + generateId() + " | name: " + getDeviceName() + " | description: " + getDeviceDescription() + " | manufacturer: " + getComputerManufacture();
    }
}
