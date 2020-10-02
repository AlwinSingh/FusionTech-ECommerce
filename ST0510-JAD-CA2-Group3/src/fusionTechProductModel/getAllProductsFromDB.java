package fusionTechProductModel;

import java.io.Serializable;
import java.sql.*;
import java.util.ArrayList;

@SuppressWarnings("serial")
public class getAllProductsFromDB implements Serializable {
	public ArrayList<allProducts> retrieveProducts(String sqlConnUrl) {
		
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
			String sqlStrCategories = "SELECT productCode, Category, CategoryName, Name, Supplier, BriefDescription, PdtDescription, "
					+ "QtyInStock, BuyPrice, SellPrice, products.Image, isAvailable FROM Products "
					+ "INNER JOIN category ON category.catid = products.category;";
			ResultSet products = stmt.executeQuery(sqlStrCategories);
			// Step 6: Process Result
			while (products.next()) {
				allProducts getProduct = new allProducts();
				getProduct.setProduct(products.getString("Name"), products.getInt("productCode"),products.getInt("Category"), products.getString("CategoryName"), products.getInt("QtyInStock"), products.getInt("isAvailable"), 
						products.getDouble("buyprice"), products.getDouble("sellPrice"), products.getString("Supplier"), 
						products.getString("briefDescription"), products.getString("pdtDescription"), products.getString("Image"));
				
				productsList.add(getProduct);
			}
			// Step 7: Close connection
			conn.close();
			} catch (Exception e) {
				System.err.println("Error :" + e);
			}
		
		return productsList;
	}
}
