public class UnitDriver {

    // Code Task 7 here
    public static void main(String[] args){
        System.out.println("=======Successful Attempt======="); // Print format required from question
        // Accepts 3 parameters: Unit code, Credit hour and Offered Faculty
        Unit u1 = new Unit("FIT1051",6,"Faculty of IT");
        u1.setUnitCode("FIT1051");
        u1.setOfferFaculty("Faculty of IT");
        u1.setCreditHour(6);
        u1.setOfferedThisSemester(true);
        // True to specify this unit is offered during this semester if not false will be returned
        System.out.println(u1.toString()); // Print format required from question

        System.out.println(" "); // Empty line spacing same as the format shown in the sample in the question

        System.out.println("=======Unsuccessful Attempt======="); // Print format required from question
        // Accepts 3 parameters: Unit code, Credit hour and Offered Faculty
        Unit u2 = new Unit("",0,"FIT");
        u2.setUnitCode("");
        u2.setOfferFaculty("FIT");
        u2.setCreditHour(0);
        u2.setOfferedThisSemester(false);
        System.out.println(u2.toString()); // Print format required from question

        System.out.println(" "); // Empty line spacing

        // Test-case for Task 6's customCreditHour
        Unit cch = new Unit("FIT1051",12,"Faculty of IT");
        System.out.println(cch.customCreditHour("FIT1051",12));
        // Return errorMessage as there's "FIT" in the unitCode with creditHour of not 6 and all FIT units has 6 creditHour by default
        System.out.println(cch.customCreditHour("FIT1051",6));
        // Return empty string as there's "FIT" in the unitCode with creditHour of 6 so the unitCode and creditHour is accepted
        System.out.println(cch.customCreditHour("BRO3838",12));
        // Return empty string as there's no "FIT" in the unitCode so the unitCode and creditHour is accepted
        System.out.println(cch.customCreditHour("OMO0666",6));
        // Return empty string as there's no "FIT" in the unitCode so the unitCode and creditHour is accepted
    }
}
