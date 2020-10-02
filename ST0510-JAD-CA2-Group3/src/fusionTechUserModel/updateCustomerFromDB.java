package fusionTechUserModel;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@SuppressWarnings("serial")
public class updateCustomerFromDB implements Serializable {
	public boolean updateCustomerCurrency(int userid, String currencyType, String sqlConnUrl) {
		boolean updateStatus = false;
		// Post to Database
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
					String updateStr = "UPDATE users SET UserCurrency = ? WHERE ID = ?";

					PreparedStatement pstmt = conn.prepareStatement(updateStr);

					pstmt.setString(1, currencyType);
					pstmt.setInt(2, userid);

					int update = pstmt.executeUpdate();

					if (update > 0) {
						updateStatus = true;
					} else {
						updateStatus = false;
					}

					conn.close();
				} catch (SQLException e) {
					System.out.println("[Update Customer currency to DB Error]: " + e);
					System.out.println("[Update Customer currency to DB Error]: " + e.getMessage());
					updateStatus = false;
				}

				return updateStatus;
	}
	
	public boolean updateCustomer(String currentEmail, String newEmail, String FirstName, String LastName, int userRole,
			String Phone, String Address1, String Address2, String City, String State, int PostalCode, String Country,
			String sqlConnUrl) {

		boolean updateStatus = false;

		// Post to Database
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
			String updateStr = "UPDATE users SET Email = ?, FirstName = ?, LastName = ?, UserType = ?, Phone = ?, Address1 = ?,Address2 = ?, City = ?, State = ?, PostalCode = ?, Country = ? WHERE Email = ?";
			System.out.println(updateStr);

			PreparedStatement pstmt = conn.prepareStatement(updateStr);

			pstmt.setString(1, newEmail);
			pstmt.setString(2, FirstName);
			pstmt.setString(3, LastName);
			pstmt.setInt(4, userRole);
			pstmt.setString(5, Phone);
			pstmt.setString(6, Address1);
			pstmt.setString(7, Address2);
			pstmt.setString(8, City);
			pstmt.setString(9, State);
			pstmt.setInt(10, PostalCode);
			pstmt.setString(11, Country);
			pstmt.setString(12, currentEmail);

			int update = pstmt.executeUpdate();

			if (update > 0) {
				updateStatus = true;
			} else {
				updateStatus = false;
			}

			conn.close();
		} catch (SQLException e) {
			System.out.println("[Add Customer to DB Error]: " + e);
			System.out.println("[Add Customer to DB Error]: " + e.getMessage());
			updateStatus = false;
		}

		return updateStatus;
	}
}
