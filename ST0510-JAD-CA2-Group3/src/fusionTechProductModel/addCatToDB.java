package fusionTechProductModel;

import java.io.Serializable;
import java.sql.*;

@SuppressWarnings("serial")
public class addCatToDB implements Serializable {

	public boolean addCategory(int catID, String catName, String catDescription, String catImage, String sqlConnUrl) {

		boolean insertStatus = false;

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
			String insertStr = "INSERT INTO Category(catID, CategoryName, Description) values (?, ?, ?)";

			// Prepared Statement prevents SQL Injection
			PreparedStatement pstmt = conn.prepareStatement(insertStr);

			// The '?' corresponds to the input below
			pstmt.setInt(1, catID);
			pstmt.setString(2, catName);
			pstmt.setString(3, catDescription);

			int insert = pstmt.executeUpdate();

			if (insert > 0) {
				insertStatus = true;
			} else {
				insertStatus = false;
			}

			conn.close();
		} catch (SQLException e) {
			insertStatus = false;
		}

		return insertStatus;
	}
}
