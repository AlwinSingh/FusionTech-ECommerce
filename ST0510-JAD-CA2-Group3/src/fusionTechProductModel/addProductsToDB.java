package fusionTechProductModel;

import java.io.Serializable;
import java.sql.*;

@SuppressWarnings("serial")
public class addProductsToDB implements Serializable {

	public boolean addProducts(int productCode, int productCat, String productName, String productSupplier,
			String productBriefDescription, String productDescription, int productQty, double productBuyPrice,
			double productSellPrice, String fileName, String sqlConnUrl) {
		
		boolean insertStatus = false;

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
			String insertStr = "INSERT INTO products(ProductCode,Category,Name,Supplier,BriefDescription,PdtDescription,QtyInStock,BuyPrice,SellPrice,Image) values (?,?, ?, ?, ?, ?, ?, ?, ?, ?)";

		    PreparedStatement pstmt = conn.prepareStatement(insertStr);
		    
		    pstmt.setInt(1, productCode);
		    pstmt.setInt(2, productCat);
		    pstmt.setString(3, productName);
		    pstmt.setString(4, productSupplier);
		    pstmt.setString(5, productBriefDescription);
		    pstmt.setString(6, productDescription);
		    pstmt.setInt(7, productQty);
		    pstmt.setDouble(8, productBuyPrice);
		    pstmt.setDouble(9, productSellPrice);
		    pstmt.setString(10, fileName);
		    
		    int insert = pstmt.executeUpdate();
		    
		    if (insert > 0) {
		    	insertStatus = true;
		    } else  {
		    	insertStatus = false;
		    }
		    
		conn.close();
		} catch (SQLException e) {
			insertStatus = false;
		}	
		
		return insertStatus;
	}
}
