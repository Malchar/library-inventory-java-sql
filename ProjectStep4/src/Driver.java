import java.util.Scanner;
import java.time.LocalDate;
import java.sql.*;

/**
 * This class is a driver for running and displaying queries from the
 * library_inventory_system database. If there are connection problems, then
 * please ensure that the correct database, user, and password are setup in the
 * connection string.
 * 
 * @author Paul Schmitz 2022-04-19
 *
 */
public class Driver {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		// Gather connection info
		final String databaseName = "library_inventory_system";
		System.out.print("Enter database username: "); // root
		final String mysqlUser = sc.nextLine();
		System.out.print("Enter database password: "); // ics311
		final String mysqlPassword = sc.nextLine();

		// Connect to the database
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager
					.getConnection("jdbc:mysql://localhost/"+databaseName+"?user="+mysqlUser+"&password="+mysqlPassword);
			System.out.println("Connection Object Created : " + con);

			// Utilities
			Statement st = con.createStatement();
			ResultSet rs;
			final String todayDate = LocalDate.now().toString();
			final String r = "%-4s%-25s%-20s%-20s%n";
			final String line = "-----------";

			/*
			 * REPORT 1
			 */
			System.out.println();
			System.out.println("Student Name: Paul Schmitz");
			System.out.println("Report 1");
			System.out.println("Today's date is " + todayDate);
			System.out.println();

			// Query
			rs = st.executeQuery("select * from book");

			// Output
			System.out.printf(r, "Id", "Title", "Author", "ISBN");
			System.out.printf(r, "--", line, line, line);

			while (rs.next()) {
				System.out.printf(r, rs.getString("bookId"), rs.getString("bookTitle"), rs.getString("bookAuthor"),
						rs.getString("bookISBN"));
			}
			rs.close();

			/*
			 * REPORT 2
			 */
			System.out.println();
			System.out.println("Student Name: Paul Schmitz");
			System.out.println("Report 2");
			System.out.println("Today's date is " + todayDate);
			System.out.println();

			// Query
			rs = st.executeQuery(
					"select * from book natural join category c left join category p on c.categoryParent = p.categoryId");

			// Output
			System.out.printf(r, "Id", "Title", "Category", "Parent Category");
			System.out.printf(r, "--", line, line, line);

			while (rs.next()) {
				System.out.printf(r, rs.getString("bookId"), rs.getString("bookTitle"),
						rs.getString("c.categoryName"), rs.getString("p.categoryName"));
			}
			rs.close();

			/*
			 * REPORT 3
			 */
			System.out.println();
			System.out.println("Student Name: Paul Schmitz");
			System.out.println("Report 3");
			System.out.println("Today's date is " + todayDate);
			System.out.println();

			// Get user input
			System.out.print("Input bookId: ");
			String userInput = sc.nextLine();

			// Cleanup user input
			int searchTerm = 1;
			try {
				searchTerm = Integer.parseInt(userInput);
			} catch (Exception e) {
				System.out.println(e);
				System.out.println("Only integer number input is accepted. Proceeding with default bookId: 1");
				searchTerm = 1;
			}
			System.out.println();

			// Query
			rs = st.executeQuery(
					"select * from book natural join category c left join category p on c.categoryParent = p.categoryId where bookId = "
							+ searchTerm);

			// Output
			System.out.printf(r, "Id", "Title", "Author", "Category");
			System.out.printf(r, "--", line, line, line);

			while (rs.next()) {
				System.out.printf(r, rs.getString("bookId"), rs.getString("bookTitle"), rs.getString("bookAuthor"),
						rs.getString("c.categoryName"));
			}
			rs.close();

			// Close resources
			st.close();

		} catch (Exception e) {
			System.out.println(e);
		}
		
		// Close resources
		sc.close();
	}

}
