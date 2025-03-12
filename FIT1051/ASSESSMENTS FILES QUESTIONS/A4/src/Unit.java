public class Unit {

    // Task 1: Instance Variables
    private String unitCode; // Unit code
    private String unitName; // Unit name
    private int creditHour; // Credit hour of unit
    private String offerFaculty; // Faculty that offered the unit
    private boolean offeredThisSemester; // Semester the unit is being offered
    // Although the task have inserted a ? behind and so the variable name will be offeredThisSemester? but it gives error so I took away the ?

    // Task 2: constructors
    // Constructor that takes in 3 parameters which are unit code, credit hour and offer faculty
    // "init" is added before each parameter name to give a new parameter name to protect the integrity of the instance variables in this class
    public Unit(String initUnitCode, int initCreditHour, String initOfferFaculty){
        setUnitCode(initUnitCode);
        setCreditHour(initCreditHour);
        setOfferFaculty(initOfferFaculty);
        setCreditHour(6);
        setUnitName("");
        setOfferedThisSemester(false);
    }

    // Task 3: Getter
    // Getter for the instance variable unitCode
    public String getUnitCode(){
        return unitCode;
    }
    // Getter for the instance variable unitName
    public String getUnitName(){
        return unitName;
    }
    // Getter for the instance variable creditHour
    public int getCreditHour(){
        return creditHour;
    }
    // Getter for the instance variable offerFaculty
    public String getOfferFaculty(){
        return offerFaculty;
    }
    // Getter for the instance variable offeredThisSemester
    public boolean getOfferedThisSemester(){
        return offeredThisSemester;
    }

    // Task 4: Setter
    // Setter for the instance variable unitCode
    public boolean setUnitCode(String newUnitCode){
        boolean returnValue = false;
        // Unit code have length of 7 characters (assuming all unit code is 7 characters long)
        if (newUnitCode.length() == 7){
            unitCode = newUnitCode;
            returnValue = true;
        }
        else {
            returnValue = false;
        }
        return returnValue;
    }
    // Setter for the instance variable unitName
    public boolean setUnitName(String newUnitName){
        boolean returnValue = false;
        // Unit name have length of maximum 40 characters
        if (newUnitName.length() <= 40){
            unitName = newUnitName;
            returnValue = true;
        }
        else {
            returnValue = false;
        }
        return returnValue;
    }
    // Setter for the instance variable creditHour
    public boolean setCreditHour(int newCreditHour){
        boolean returnValue = false;
        // Credit hour for all units is 6
        if (newCreditHour == 6){
            creditHour = newCreditHour;
            returnValue = true;
        }
        else {
            returnValue = false;
        }
        return returnValue;
    }
    // Setter for the instance variable offerFaculty
    public boolean setOfferFaculty(String newOfferFaculty){
        boolean returnValue = false;
        // Faculty name that offers the unit have length within 20 characters
        if (newOfferFaculty.length() > 0 && newOfferFaculty.length() <= 20){
            offerFaculty = newOfferFaculty;
            returnValue = true;
        }
        else {
            returnValue = false;
        }
        return returnValue;
    }
    // Setter for the instance variable offeredThisSemester
    public boolean setOfferedThisSemester(boolean newOfferedThisSemester){
        offeredThisSemester = newOfferedThisSemester;
        return offeredThisSemester;
    }

    // Task 5: toString method
    public String toString(){
        String returnStringValue = ""; // Declare empty string named returnStringValue
        // The 4 lines below is the output format shown in Task 5
        returnStringValue += "Unit Code: " + getUnitCode() + "\n";
        returnStringValue += "Offered Faculty: " + getOfferFaculty() + "\n";
        returnStringValue += "Credit Hour: " + getCreditHour() + "\n";
        returnStringValue += "Offered in this Semester? : " + getOfferedThisSemester();
        return returnStringValue; // Return string named returnStringValue
    }

    // Task 6: customCreditHour method
    public String customCreditHour(String unitCode_new, int creditHour_new){
        // Take in 2 parameters : Unit code and Credit hour
        String errorMessage = ""; // Declare errorMessage as an empty string
        if(unitCode_new.contains("FIT")){ // Check if unitCode have "FIT"
            if(creditHour_new == 6){ // Contains "FIT" and credit hour is 6, is accepted so print out empty string
                unitCode = unitCode_new;
                creditHour = creditHour_new;
                errorMessage = "";
            }
            else { // Contains "FIT" and credit hour is not 6, not accepted so print out errorMessage
                errorMessage = "Error. This is a FIT unit and the no of credit hours is 6 by default.";
            }
        }
        else { // Does not contain "FIT" in unitCode, so it is accepted
            unitCode = unitCode_new;
            creditHour = creditHour_new;
        }
        return errorMessage; // return errorMessage
    }
}
