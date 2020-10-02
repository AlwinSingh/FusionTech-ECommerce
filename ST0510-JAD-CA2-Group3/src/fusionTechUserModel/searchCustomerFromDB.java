package fusionTechUserModel;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import fusionTechProductModel.allProducts;

@SuppressWarnings("serial")
public class searchCustomerFromDB implements Serializable {
	public ArrayList<UserDetails> retrieveSearchedCustomer(String searchValue, String sqlConnUrl) {
		ArrayList<UserDetails> customersList = new ArrayList<UserDetails>();
System.out.println(searchValue);
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
			String sqlStr = "SELECT * FROM Users\r\n"
					+ "INNER JOIN userroles ON userroles.ID = UserType WHERE Email LIKE ?;";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, "%" + searchValue + "%");

			System.out.println(sqlStr);

			ResultSet searchedCustomers = pstmt.executeQuery();
			// Step 6: Process Result
			while (searchedCustomers.next()) {
				UserDetails user = new UserDetails();
		
				//Sets the session time out, as defined in the Tomcat web.xml, it is a 30 minutes timeout
				//String useusersession = "true";				
				int userID = searchedCustomers.getInt("ID");
				String userEmail = searchedCustomers.getString("Email");
				String firstName = searchedCustomers.getString("FirstName");
				String lastName = searchedCustomers.getString("LastName");
				String userPhone = searchedCustomers.getString("Phone");
				String userAddress = searchedCustomers.getString("Address1");
				String userAddress2 = searchedCustomers.getString("Address2");
				String userCity = searchedCustomers.getString("City");
				String userState = searchedCustomers.getString("State");
				String userCountry = searchedCustomers.getString("Country");
				String userPostalCode = searchedCustomers.getString("PostalCode");
				String userType = searchedCustomers.getString("userRole");

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

				customersList.add(user);
			}
			// Step 7: Close connection
			conn.close();
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}

		return customersList;
	}
}
