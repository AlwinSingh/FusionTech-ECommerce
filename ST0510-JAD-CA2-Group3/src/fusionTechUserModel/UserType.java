package fusionTechUserModel;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

@SuppressWarnings("serial")
public class UserType implements Serializable {
	public ArrayList<UserDetails> retrieveUserType(String sqlConnUrl) {
		ArrayList<UserDetails> userTypeList = new ArrayList<UserDetails>();

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
			String sqlStr = "SELECT * FROM userroles;";
			ResultSet getUserType = stmt.executeQuery(sqlStr);
			// Step 6: Process Result
			while (getUserType.next()) {
				UserDetails user = new UserDetails();
		
				//Sets the session time out, as defined in the Tomcat web.xml, it is a 30 minutes timeout
				//String useusersession = "true";				
				String userType = getUserType.getString("userRole");
				user.setUserType(userType);

				userTypeList.add(user);
			}
			// Step 7: Close connection
			conn.close();
			} catch (Exception e) {
				System.err.println("Error :" + e);
			}
	
		return userTypeList;
	}
}
