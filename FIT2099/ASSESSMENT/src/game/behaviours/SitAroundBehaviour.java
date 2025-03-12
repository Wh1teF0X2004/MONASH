package game.behaviours;

/**
 * An interface on the specific behaviour of sitting around a specific location.
 * All classes that implemented this interface would have the behaviour of sitting around.
 *
 * Created by:
 * @author Foo Kai Yan 33085625
 * @version 1.0.0
 */
public interface SitAroundBehaviour{

    /**
     * Empty String method that shows that the class that implements this interface will sit around.
     *
     * @return null if the class that implements this interface and method does not provide extra implementation
     *         if extra implementation was done, will return a String
     */
    String sitAround();
}
