package fusionTechUserModel;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@SuppressWarnings("serial")
public class deleteCustomerFromDB implements Serializable {
	public boolean deleteCustomer(String userEmail, String sqlConnUrl) {
		boolean deleteStatus = false;

		try {
			// STEP 1: LOAD JDBC DRIVER
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// STEP 2: DEFINE CONNECTION URL
			String connURL = sqlConnUrl;
			// STEP 3: ESTABLISH CONNECTION TO URL
			Connection conn = DriverManager.getConnection(connURL);

			// STEP 5: EXECUTE SQL COMMAND
			String insertStr = "DELETE FROM Users WHERE Email = ?";
			//Prepared statement to prevent SQL Injection
			PreparedStatement pstmt = conn.prepareStatement(insertStr);
			//Value corresponds to the location of '?'
			pstmt.setString(1, userEmail);
			
			int delete = pstmt.executeUpdate();

			System.out.println(delete);

			if (delete > 0) {
				deleteStatus = true;
			} else {
				deleteStatus = false;
			}

			conn.close();
		} catch (SQLException e) {
			System.out.println("[Delete customer from DB Exception]: " +e);
			deleteStatus = false;
		}
		return deleteStatus;
	}
	

}
