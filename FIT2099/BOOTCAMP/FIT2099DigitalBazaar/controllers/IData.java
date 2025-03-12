package FIT2099DigitalBazaar.controllers;

/**
 * The IData interface is an interface that represents the device availability.
 *
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 */
public interface IData {
    /**
     * isDeviceAvailable checks the availability of a device with a specific device id
     * @param id the device id of the device to be checked
     * @return true if the device is available, false otherwise
     */
    boolean isDeviceAvailable(int id);
}
