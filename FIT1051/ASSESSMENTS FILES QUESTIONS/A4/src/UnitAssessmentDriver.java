public class UnitAssessmentDriver {
    // Testing UnitAssessment Class
    public static void main(String[] args){

        Assessment a1 = new Assessment("Assignment 3", 77.70);
        a1.setAssessmentName("Assignment 3");
        a1.setAssessmentValue(77.7);

        UnitAssessment ua1 = new UnitAssessment("FIT 1051", 6, "Faculty of IT", a1);
        // To show it should be empty because no new assessment was added
        ua1.getTypeOfAssessment();
        ua1.getAssessmentList();
        System.out.println(ua1.toString());
        UnitAssessment aa = new UnitAssessment("FIT 1051", 6, "Faculty of IT", a1);
        // To show a1 is added as a new assessment
        System.out.println(aa.addAssessment(a1)); // Show it give me true after adding new assessment
        System.out.println(aa.getAssessmentList()); // Show the newly updated ArrayList AssessmentList which have now a1 added
    }
}
