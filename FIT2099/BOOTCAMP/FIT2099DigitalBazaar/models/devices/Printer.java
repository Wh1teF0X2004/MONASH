package FIT2099DigitalBazaar.models.devices;

import FIT2099DigitalBazaar.models.devices.Device;
import FIT2099DigitalBazaar.utils.Utils;

/**
 * A class that represents a printer, a subclass of Device.
 *
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 * @see Device
 */
public class Printer extends Device {
    // Attributes
    /**
     * The pages per minute printed by the printer.
     */
    private int ppm;
    /**
     * The total number of printers.
     */
    private int printerCount;

    // Constructor
    /**
     * Construct a new Printer.
     *
     * @param deviceName The name of the device.
     * @param deviceDescription The description of the device.
     * @param ppm The pages per minute printed by the printer.
     * @throws Exception If printer name, description and pages per minute printed is in incorrect format.
     */
    public Printer(String deviceName, String deviceDescription, int ppm) throws Exception{
        super(deviceName, deviceDescription);
        if (!setPpm(ppm) && !setDeviceName(deviceName) && !setDeviceDescription(deviceDescription)) {
            // !setPpm(ppm) is same as setPpm(ppm) == false
            throw new Exception("Incorrect Printer's details ");
        }
    }

    // Getters
    /**
     * A getter for the pages per minute printed by the printer.
     *
     * @return The pages per minute printed by the printer.
     */
    public int getPpm() {
        return ppm;
    }

    // Setters
    /**
     * A setter for the pages per minute printed by the printer.
     *
     * @param ppm The pages per minute printed by the printer.
     * @return true if the pages per minute printed by the printer is of the correct integer range, false otherwise
     */
    public boolean setPpm(int ppm) {
        boolean flag = false;
        // ppm: range 1..50
        if (1 <= ppm && ppm <= 50){
            this.ppm = ppm;
            flag = true;
        }
        return flag;
    }

    // Method
    /**
     * Generate a random integer from 100 to 999 as the id of the printer.
     *
     * @return A random integer from 100 to 999 as the id of the printer.
     */
    @Override
    public int generateId() {
        return Utils.nextID(100,999);
    }

    // toString
    /**
     * Print the printers available in a certain format.
     *
     * @return the print format of the list of printers.
     */
    @Override
    public String toString() {
        printerCount += 1;
        return "Printer ("+ printerCount +") ID:" + generateId() + " | name: " + getDeviceName() + " | description: " + getDeviceDescription() + " | PPM: " + getPpm();
    }
}
