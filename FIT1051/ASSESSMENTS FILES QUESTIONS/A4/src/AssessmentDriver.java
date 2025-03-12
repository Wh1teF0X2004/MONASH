public class AssessmentDriver {
    // Testing Assessment Class
    public static void main(String[] args){
        System.out.println("=======Successful Attempt=======");
        Assessment a1 = new Assessment("Assignment 3", 77.70);
        a1.setAssessmentName("Assignment 3");
        a1.setAssessmentValue(77.7);
        System.out.println(a1.toString()); // Should print Assignment 3 and 77.7

        System.out.println(" "); // Empty line spacing

        System.out.println("=======Unsuccessful Attempt=======");
        Assessment a2 = new Assessment("", 777.70);
        a2.setAssessmentName("");
        a2.setAssessmentValue(777.7);
        System.out.println(a2.toString()); // Should print null and 0.0
    }
}
