package FIT2099DigitalBazaar.utils;

import java.util.Scanner;

/**
 * A class that implements the IMenuManager interface and represents the menu manager for an admin user.
 *
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 * @see IMenuManager
 */
public class MenuManagerAdmin implements IMenuManager{

    // Attribute
    /**
     * The instance of MenuManagerAdmin
     */
    private static MenuManagerAdmin newMenuManagerAdmin;

    // getInstance()
    /**
     * Construct a new MenuManagerAdmin instance if there is none
     * @return the instance of MenuManagerAdmin
     */
    public static MenuManagerAdmin getInstance(){
        if (newMenuManagerAdmin == null){
            newMenuManagerAdmin = new MenuManagerAdmin();
        }
        return newMenuManagerAdmin;
    }

    // Method
    /**
     * Displays the menu options for an admin user while prompting the user to make a selection.
     * @return user's selection as an integer
     */
    @Override
    public int menuItem() {
        Scanner sel = new Scanner(System.in);

        System.out.println("1) New Computer");
        System.out.println("2) New Printer");
        System.out.println("3) New Purchase");
        System.out.println("4) List Computers");
        System.out.println("5) List Printers");
        System.out.println("6) List Purchases");
        System.out.println("7) Exit");
        System.out.print("Select one:");
        int choice = Integer.parseInt(sel.nextLine());
        System.out.println("Your choice:"+choice);
        return choice;
    }
}
