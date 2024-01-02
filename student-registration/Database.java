import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Class Name: LoadDriver
 * represents connection to mysql driver
 * directly.
 * 
 * @author Mehreen Akmal and Jen Bushey
 * @version 1.0
 * @since October 13, 2023
 *
 */
class LoadDriver {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}

/**
 * Class Name: Database
 * represents connection to mySQL database
 * called STUDENT_REGISTRATION_SYSTEM.
 * Performs three queries to output.
 * all three tables in the database.
 * 
 * @author Mehreen Akmal and Jen Bushey
 * @version 1.0
 * @since October 13, 2023
 *
 */
public class Database {
    /**
     * Connection string information used to access
     * the database
     */
    private static String jdbcUrl = "jdbc:mysql://127.0.0.1:3306/STUDENT_REGISTRATION_SYSTEM";
    private static String username = "username";
    private static String password = "password";

    /**
     * SQL query statement used
     * to access specific data
     * from database.
     */
    private static String query;

    /**
     * Create a Statement object
     * that allows a query to
     * be executed.
     */
    private static Statement stmt;

    /**
     * Create a Result set object
     * to output query results.
     */
    private static ResultSet rset;

    /**
     * Main method
     * 
     * @param args : command line
     */
    public static void main(String[] args) {

        try {
            // Establish a connection to the database
            Connection connection = DriverManager.getConnection(jdbcUrl, username, password);

            if (connection != null) {
                System.out.println("Connected to the database!");

                stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);

                query = "SELECT * FROM STUDENT ORDER BY StudentID";
                System.out.println("\nExecuting query: " + query + "\n");
                System.out.printf("%-9s | %-12s |  %-12s | %s\n", "StudentID", "FirstName", "LastName", "Location");

                rset = stmt.executeQuery(query);

                while (rset.next()) {
                    System.out.printf("%-9s | %-12s |  %-12s | %s\n",
                            rset.getInt(1),
                            rset.getString(2),
                            rset.getString(3),
                            rset.getString(4));
                }

                String query2 = "SELECT * FROM COURSE ORDER BY CourseID\n";
                System.out.println("\nExecuting query: " + query2);
                System.out.printf("%-9s | %-12s | %s\n", "CourseID", "CourseName", "CourseTitle");
                ResultSet rset2 = stmt.executeQuery(query2);

                while (rset2.next()) {
                    System.out.printf("%-9s | %-12s | %s\n",
                            rset2.getInt(1),
                            rset2.getString(2),
                            rset2.getString(3));
                }

                String query3 = "SELECT * FROM REGISTRATION ORDER BY RegistrationID\n";
                System.out.println("\nExecuting query: " + query3);
                System.out.printf("%-12s | %-14s | %s\n", "RegistrationID", "CourseID", "StudentID");
                ResultSet rset3 = stmt.executeQuery(query3);

                while (rset3.next()) {
                    System.out.printf("%-14s | %-14s | %s\n",
                            rset3.getInt(1),
                            rset3.getString(2),
                            rset3.getString(3));
                }

                // Close Result Set object, statement object and connection.
                rset.close();
                rset2.close();
                rset3.close();
                stmt.close();
                connection.close();
            }
        } catch (SQLException ex) {
            System.err.println("Connection failed.");
            ex.printStackTrace();
        }
    }
}
