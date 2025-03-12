import java.util.ArrayList; // Import to use ArrayList

public class UnitAssessment extends Unit{

    // Additional Instance Variables
    ArrayList<Assessment> assessmentList; // Arraylist named assessmentList
    private Assessment typeOfAssessment;

    // 4-parameter constructor that matches with superclass Unit and typeOfAssessment
    public UnitAssessment(String initUnitCode, int initCreditHour, String initOfferFaculty, Assessment initTypeOfAssessment) {
        super(initUnitCode, initCreditHour, initOfferFaculty);
        assessmentList = new ArrayList<Assessment>(10); // Arraylist named assessmentList that supports up to 10 types of assessment
        Assessment typeOfAssessment = initTypeOfAssessment;
    }

    // Getters
    public ArrayList<Assessment> getAssessmentList(){
        return assessmentList;
    }
    public Assessment getTypeOfAssessment(){
        return typeOfAssessment;
    }

    // A public method called addAssessment to add a new assessment to assessmentList ArrayList
    public boolean addAssessment(Assessment new_assessment){
        boolean returnValue = false;

        Assessment newAssessment = new_assessment;
        if (assessmentList.contains(new_assessment)){
            returnValue = true;
        }
        else {
            assessmentList.add(newAssessment);
            returnValue = true;
        }
        return returnValue;
    }

    public String toString(){
        String returnStringValue = ""; // Declare empty string named returnStringValue
        returnStringValue += "Assessment List: " + getAssessmentList() + "\n";
        returnStringValue += "Assessment Type: " + getTypeOfAssessment();
        return returnStringValue; // Return string named returnStringValue
    }
}
