package fusionTechProductModel;

import java.sql.Connection;
import java.sql.DriverManager;
import java.io.File;
import java.io.Serializable;
import java.sql.*;

@SuppressWarnings("serial")
public class deleteProductFromDB implements Serializable {
	public boolean deleteProduct(int productCode, String productImage, String sqlConnUrl) {
		boolean deleteStatus = false;
		imageUploadPath path = new imageUploadPath();

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
			String deleteStr = "DELETE FROM products WHERE ProductCode = ?";
			PreparedStatement pstmt = conn.prepareStatement(deleteStr);
			pstmt.setInt(1, productCode);
			int delete = pstmt.executeUpdate();

			if (delete > 0) {
				File f = new File(path + "" + productImage);
				f.delete();
				deleteStatus = true;
			} else {
				deleteStatus = false;
			}

			conn.close();
		} catch (SQLException e) {
			System.out.println("[DELETE PRODUCT FROM DB UTILITY]: " +e);
			System.out.println("[DELETE PRODUCT FROM DB UTILITY]: " +e.getMessage());
			deleteStatus = false;
		}
		return deleteStatus;
	}
}
