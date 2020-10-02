package fusionTechProductModel;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@SuppressWarnings("serial")
public class deleteCategoryFromDB implements Serializable {
	public boolean deleteCat(int catCode, String sqlConnUrl) {
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
			String insertStr = "DELETE FROM Category WHERE catID = ?";
			//Prepared statement to prevent SQL Injection
			PreparedStatement pstmt = conn.prepareStatement(insertStr);
			//Value corresponds to the location of '?'
			pstmt.setInt(1, catCode);
			
			int delete = pstmt.executeUpdate();

		    
			if (delete > 0) {
				deleteStatus = true;
			} else {
				deleteStatus = false;
			}

			conn.close();
		} catch (SQLException e) {
			deleteStatus = false;
		}
		return deleteStatus;
	}
}
