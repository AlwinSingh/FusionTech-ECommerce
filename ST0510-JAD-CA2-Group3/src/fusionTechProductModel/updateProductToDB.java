package fusionTechProductModel;

import java.io.Serializable;
import java.sql.*;

@SuppressWarnings("serial")
public class updateProductToDB implements Serializable {
	public boolean updateProductNoImage(int productCode, int productCat, String productName, String productSupplier,
			String productBriefDescription, String productDescription, int productQty, double productBuyPrice,
			double productSellPrice, int isAvailable, String productImage, String sqlConnUrl) {
		
		boolean updateStatus = false;

		try {
			// STEP 1: LOAD JDBC DRIVER
			Class.forName("com.mysql.jdbc.Driver");
			// STEP 2: DEFINE CONNECTION URL
			String connURL = sqlConnUrl;
			// STEP 3: ESTABLISH CONNECTION TO URL
			Connection conn = DriverManager.getConnection(connURL);
			// STEP 4: CREATE STATEMENT OBJECT
			Statement stmt = conn.createStatement();
			// STEP 5: EXECUTE SQL COMMAND
			String updateStr = "UPDATE products SET Category = ?,Name = ?, Supplier = ?, BriefDescription = ?, PdtDescription = ?,QtyInStock = ?,BuyPrice = ?, SellPrice = ?, Image = ?, isAvailable = ? WHERE ProductCode = ?";
		    PreparedStatement pstmt = conn.prepareStatement(updateStr);
		    
		    pstmt.setInt(1, productCat);
		    pstmt.setString(2, productName);
		    pstmt.setString(3, productSupplier);
		    pstmt.setString(4, productBriefDescription);
		    pstmt.setString(5, productDescription);
		    pstmt.setInt(6, productQty);
		    pstmt.setDouble(7, productBuyPrice);
		    pstmt.setDouble(8, productSellPrice);
		    pstmt.setString(9, productImage);
		    pstmt.setInt(10, isAvailable);
		    pstmt.setInt(11, productCode);
		    
		    int insert = pstmt.executeUpdate();
		    
		    if (insert > 0) {
		    	updateStatus = true;
		    } else {
		    	updateStatus = false;
		    }
			
		//STEP 7
		conn.close();
		} catch (Exception e) {
			updateStatus = false;
			System.out.println("Update product w/image to db error: " + e);
			System.out.println("Update product w/image to db error: " + e.getMessage());
		}
		
		return updateStatus;
	}

	public boolean updateProduct(int productCode, int productCat, String productName, String productSupplier,
			String productBriefDescription, String productDescription, int productQty, double productBuyPrice,
			double productSellPrice, int isAvailable, String fileName, String sqlConnUrl) {

		boolean updateStatus = false;

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
			String updateStr = "UPDATE products SET Category = ?,Name = ?, Supplier = ?, BriefDescription = ?, PdtDescription = ?,QtyInStock = ?,BuyPrice = ?, SellPrice = ?, Image = ?, isAvailable = ? WHERE ProductCode = ?";
		    PreparedStatement pstmt = conn.prepareStatement(updateStr);
		    
		    pstmt.setInt(1, productCat);
		    pstmt.setString(2, productName);
		    pstmt.setString(3, productSupplier);
		    pstmt.setString(4, productBriefDescription);
		    pstmt.setString(5, productDescription);
		    pstmt.setInt(6, productQty);
		    pstmt.setDouble(7, productBuyPrice);
		    pstmt.setDouble(8, productSellPrice);
		    pstmt.setString(9, fileName);
		    pstmt.setInt(10, isAvailable);
		    pstmt.setInt(11, productCode);
		    
		    int insert = pstmt.executeUpdate();
		    
		    if (insert > 0) {
		    	updateStatus = true;
		    } else {
		    	updateStatus = false;
		    }
			
		//STEP 7
		conn.close();
		} catch (SQLException e) {
			updateStatus = false;
			System.out.println("Update product w/image to db error: " + e);
			System.out.println("Update product w/image to db error: " + e.getMessage());
		}
		
		return updateStatus;
	}
}
