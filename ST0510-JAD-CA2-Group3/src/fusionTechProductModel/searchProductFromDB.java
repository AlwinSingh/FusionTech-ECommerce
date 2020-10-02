package fusionTechProductModel;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

@SuppressWarnings("serial")
public class searchProductFromDB implements Serializable {	
	public ArrayList<allProducts> retrieveSearchedProduct(String searchValue, String sqlConnUrl) {
		ArrayList<allProducts> productsList = new ArrayList<allProducts>();

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
			String sqlStr = "SELECT productCode, Category, CategoryName, Name, Supplier, BriefDescription, PdtDescription, "
					+ "QtyInStock, BuyPrice, SellPrice, products.Image, isAvailable FROM Products "
					+ "INNER JOIN category ON category.catid = products.category WHERE Name LIKE ? ORDER BY productCode ASC;";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, "%" + searchValue + "%");
			
			System.out.println(sqlStr);
			
			ResultSet searchedProducts = pstmt.executeQuery();
			// Step 6: Process Result
			while (searchedProducts.next()) {
				allProducts getSearchedProduct = new allProducts();
				getSearchedProduct.setProduct(searchedProducts.getString("Name"),
						searchedProducts.getInt("productCode"), searchedProducts.getInt("Category"),
						searchedProducts.getString("CategoryName"), searchedProducts.getInt("QtyInStock"),
						searchedProducts.getInt("isAvailable"), searchedProducts.getDouble("buyprice"), searchedProducts.getDouble("sellPrice"),
						searchedProducts.getString("Supplier"), searchedProducts.getString("briefDescription"),
						searchedProducts.getString("pdtDescription"), searchedProducts.getString("Image"));

				productsList.add(getSearchedProduct);
			}
			// Step 7: Close connection
			conn.close();
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}

		return productsList;
	}
}
