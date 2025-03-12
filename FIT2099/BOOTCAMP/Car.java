public class Car {

    // Instance variables
    int carAge;
    int carManufacturedYear;
    String carBrand;
    String carColour;

    // Setters
    public void setCarBrand (String carBrand) {
        this.carBrand = carBrand;
    }

    public void setCarAge(int carAge) {
        this.carAge = carAge;
    }

    public void setCarColour(String carColour) {
        this.carColour = carColour;
    }

    public void setCarManufacturedYear(int carManufacturedYear) {
        if (carManufacturedYear >= 1900 && carManufacturedYear <= 2023) {
            this.carManufacturedYear = carManufacturedYear;
        } else {
            System.out.println("Invalid year, please enter again.");
        }
    }

    // Getters
    public String getCarBrand() {
        return carBrand;
    }

    public int getCarAge() {
        return carAge;
    }

    public String getCarColour() {
        return carColour;
    }

    public int getCarManufacturedYear() {
        return carManufacturedYear;
    }

    // toString method
    @Override
    public String toString() {
        return carColour + " " + carBrand + "\n" + "Manufacturing year: " + carManufacturedYear + "\n" + "Car Age: " + carAge;
    }

    // Main Methods
    public static void main(String[] args) {
        // Create car object
        Car newCar = new Car();
        newCar.carAge = 4;
        newCar.carManufacturedYear = 2019;
        newCar.carBrand = "Honda CRV";
        newCar.carColour = "Red";
        System.out.println(newCar);
    }
}
