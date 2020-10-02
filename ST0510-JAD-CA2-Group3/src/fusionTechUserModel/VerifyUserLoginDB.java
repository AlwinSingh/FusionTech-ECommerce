package fusionTechUserModel;
import passEncryption.passEncryption;

import java.io.Serializable;
import java.sql.*;

@SuppressWarnings("serial")
public class VerifyUserLoginDB implements Serializable {

	public UserDetails verifyUserLoginFromDB(String retrievedUserLoginEmail, String retrievedUserLoginPassword, String sqlConnUrl) {
		UserDetails verifyUserLogin = null;
		
		//Defines the Java 'object' for the passEncryption file to allow usage of its methods
	passEncryption cryptPass = new passEncryption();
	final String secretKey = "ssshhhhhhhhhhh!!!!";

	String userLoginEmail = retrievedUserLoginEmail;
	String userLoginPass = retrievedUserLoginPassword;
	
	String dbEmail = "";
	String dbPass = "";

	try {
		// Step1: Load JDBC Driver
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// Step 2: Define Connection URL
		String connURL = sqlConnUrl;
		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);
		// Step 4: Create Statement object
		Statement stmt = conn.createStatement();
		// Step 5: Execute SQL Command
		String sqlStr = "SELECT * FROM Users";
		ResultSet rs = stmt.executeQuery(sqlStr);
		// Step 6: Process Result
		while (rs.next()) {
			dbEmail = rs.getString("Email");
			//Decrypts the password using AES 256
			dbPass = cryptPass.decrypt(rs.getString("Password"), secretKey);
			//dbPass = rs.getString("Password");
			String dbFirstName = rs.getString("FirstName");
			String dbLastName = rs.getString("LastName");
			int dbUserType = rs.getInt("UserType");

			if (dbEmail.equals(userLoginEmail) && dbPass.equals(userLoginPass)) {
					verifyUserLogin = new UserDetails();
					
					String userType = "";
			
					if (dbUserType == 1) {
						userType = "registered";
					} else if (dbUserType == 2) {
						userType = "admin";
					} else {
						userType = "guest";
					}
			
					//Sets the session time out, as defined in the Tomcat web.xml, it is a 30 minutes timeout
					//String userSession = "true";
					String userPhone = rs.getString("Phone");
					String userAddress = rs.getString("Address1");
					String userAddress2 = rs.getString("Address2");
					String userCity = rs.getString("City");
					String userState = rs.getString("State");
					String userCountry = rs.getString("Country");
					String userPostalCode = rs.getString("PostalCode");
					String userID = rs.getString("ID");
					String userCurrency = rs.getString("UserCurrency");
					
					System.out.println("UC: " +userCurrency);
					
					verifyUserLogin.setUser(userType, dbEmail, Integer.parseInt(userID), dbFirstName, dbLastName, dbPass, userPhone, userAddress, userAddress2, userCity, userState, userCountry, userPostalCode);
					verifyUserLogin.setUserCurrency(userCurrency);
		break;
			}
		}

		// Step 7: Close connection
		conn.close();
	} catch (SQLException e) {
		//If there is an SQL Error, it checks and handles it
		System.err.println("Error :" + e);
	}
		
		return verifyUserLogin;
	}
	
}
