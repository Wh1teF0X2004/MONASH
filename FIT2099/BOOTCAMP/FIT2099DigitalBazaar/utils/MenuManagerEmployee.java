package FIT2099DigitalBazaar.utils;

import java.util.Scanner;

/**
 * A class that implements the IMenuManager interface and represents the menu manager for an employee user.
 *
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 * @see IMenuManager
 */
public class MenuManagerEmployee implements IMenuManager{

    // Attribute
    /**
     * The instance of MenuManagerEmployee
     */
    private static MenuManagerEmployee newMenuManagerEmployee;

    // getInstance()
    /**
     * Construct a new MenuManagerEmployee instance if there is none
     * @return the instance of MenuManagerEmployee
     */
    public static MenuManagerEmployee getInstance(){
        if (newMenuManagerEmployee == null){
            newMenuManagerEmployee = new MenuManagerEmployee();
        }
        return newMenuManagerEmployee;
    }

    // Method
    /**
     * Displays the menu options for an employee user while prompting the user to make a selection.
     * @return user's selection as an integer
     */
    @Override
    public int menuItem() {
        Scanner sel = new Scanner(System.in);

        System.out.println("1) New Computer");
        System.out.println("2) New Printer");
        System.out.println("3) New Purchase");
        System.out.println("4) Exit");

        int choice = Integer.parseInt(sel.nextLine());
        System.out.println("Your choice:"+choice);
        return choice;
    }
}
