public class Assessment {

    // Task 1(a): Code the class shell and instance variables called Assessment
    // Instance Variables
    private String assessmentName; // assessmentName
    private double assessmentValue; // assessmentValue

    // Task 1(b): Code the getter/accessor methods for all the instance variables
    // Getters
    // Getter for the instance variable assessmentName
    public String getAssessmentName(){
        return assessmentName;
    }
    // Getter for the instance variable assessmentValue
    public double getAssessmentValue(){
        return assessmentValue;
    }

    // Constructor for AssessmentDriver
    public Assessment(String new_assessmentName, double new_assessmentValue){
        setAssessmentName(new_assessmentName);
        setAssessmentValue(new_assessmentValue);
    }

    // Task 1(c): Code the setter/mutator methods for all the instance variables
    // Setters
    // Setter for the instance variable assessmentName
    public boolean setAssessmentName(String newAssessmentName){
        boolean returnValue = false;
        // assessmentName have length of 20 characters max
        if (newAssessmentName.length() > 0 && newAssessmentName.length() <= 20){
            assessmentName = newAssessmentName;
            returnValue = true;
        }
        else {
            returnValue = false;
        }
        return returnValue;
    }
    // Setter for the instance variable assessmentValue
    public boolean setAssessmentValue(double newAssessmentValue){
        boolean returnValue = false;
        // assessmentValue have a range of value that must be 0 to 100% inclusive
        if (newAssessmentValue >= 0.00 && newAssessmentValue <= 100.00){
            assessmentValue = newAssessmentValue;
            returnValue = true;
        }
        else {
            returnValue = false;
        }
        return returnValue;
    }

    public String toString(){
        String returnStringValue = ""; // Declare empty string named returnStringValue
        returnStringValue += "Assessment Name: " + getAssessmentName() + "\n";
        returnStringValue += "Assessment Value: " + getAssessmentValue() + "%";
        return returnStringValue; // Return string named returnStringValue
    }
}
