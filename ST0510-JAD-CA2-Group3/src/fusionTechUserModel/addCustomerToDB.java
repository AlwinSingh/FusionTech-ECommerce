package fusionTechUserModel;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.Serializable;
import java.sql.*;

@SuppressWarnings("serial")
public class addCustomerToDB implements Serializable {
	public boolean addCustomer(String Email, String Password, String FirstName, String LastName, int userRole,
			int Phone, String Address1, String Address2, String City, String State, int PostalCode, String Country, String sqlConnUrl) {

		boolean insertStatus = false;
		int lastUserID = 0;

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
			// STEP 4: CREATE STATEMENT OBJECT
			Statement stmt = conn.createStatement();
			// STEP 5: EXECUTE SQL COMMAND
			String sqlStrGetLastUserID = "SELECT MAX(ID) 'LastUserID' FROM USERS;";
			ResultSet executelastUserID = stmt.executeQuery(sqlStrGetLastUserID);
			if (executelastUserID.next()) {
				 lastUserID = executelastUserID.getInt("LastUserID") + 1;
			}
			System.out.println("last id" + lastUserID);

			String insertStr = "INSERT INTO Users (ID, Email, Password, FirstName, LastName, UserType, Phone, Address1, Address2, City, State, PostalCode, Country) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			PreparedStatement pstmt = conn.prepareStatement(insertStr);
			pstmt.setInt(1, lastUserID);
			pstmt.setString(2, Email);
			pstmt.setString(3, Password);
			pstmt.setString(4, FirstName);
			pstmt.setString(5, LastName);
			pstmt.setInt(6, userRole);
			pstmt.setInt(7, Phone);
			pstmt.setString(8, Address1);
			pstmt.setString(9, Address2);
			pstmt.setString(10, City);
			pstmt.setString(11, State);
			pstmt.setInt(12, PostalCode);
			pstmt.setString(13, Country);

			int insert = pstmt.executeUpdate();

			if (insert > 0) {
				insertStatus = true;
			} else {
				insertStatus = false;
			}

			conn.close();
		} catch (SQLException e) {
			System.out.println("[Add Customer to DB Error]: " + e);
			System.out.println("[Add Customer to DB Error]: " + e.getMessage());
			insertStatus = false;
		}

		return insertStatus;
	}
}
