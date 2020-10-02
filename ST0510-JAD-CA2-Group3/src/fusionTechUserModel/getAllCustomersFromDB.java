package fusionTechUserModel;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

@SuppressWarnings("serial")
public class getAllCustomersFromDB implements Serializable {
	
	public ArrayList<UserDetails> retrieveUsers(String sqlConnUrl) {
	ArrayList<UserDetails> usersList = new ArrayList<UserDetails>();

		try {
			// Step1: Load JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");
			// Step 2: Define Connection URL
			String connURL = sqlConnUrl;
			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);
			// Step 4: Create Statement object
			Statement stmt = conn.createStatement();
			// Step 5: Execute SQL Command
			String sqlStrUsers = "SELECT * FROM Users\r\n" + 
					"INNER JOIN userroles ON userroles.ID = UserType;";
			ResultSet users = stmt.executeQuery(sqlStrUsers);
			// Step 6: Process Result
			while (users.next()) {
				UserDetails user = new UserDetails();
		
				//Sets the session time out, as defined in the Tomcat web.xml, it is a 30 minutes timeout
				//String useusersession = "true";				
				int userID = users.getInt("ID");
				String userEmail = users.getString("Email");
				String firstName = users.getString("FirstName");
				String lastName = users.getString("LastName");
				String userPhone = users.getString("Phone");
				String userAddress = users.getString("Address1");
				String userAddress2 = users.getString("Address2");
				String userCity = users.getString("City");
				String userState = users.getString("State");
				String userCountry = users.getString("Country");
				String userPostalCode = users.getString("PostalCode");
				String userType = users.getString("userRole");

				user.setUserId(userID);
				user.setUserEmail(userEmail);
				user.setUserFirstName(firstName);
				user.setUserLastName(lastName);
				user.setUserPhone(userPhone);
				user.setUserAddress(userAddress);
				user.setUserAddress2(userAddress2);
				user.setUserCity(userCity);
				user.setUserState(userState);
				user.setUserCountry(userCountry);
				user.setUserPostalCode(userPostalCode);
				user.setUserType(userType);

				usersList.add(user);
			}
			// Step 7: Close connection
			conn.close();
			} catch (Exception e) {
				System.err.println("Error :" + e);
			}
	
		return usersList;
	}

}
