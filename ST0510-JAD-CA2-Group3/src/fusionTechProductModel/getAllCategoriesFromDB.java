package fusionTechProductModel;

import java.io.Serializable;
import java.sql.*;
import java.util.ArrayList;

@SuppressWarnings("serial")
public class getAllCategoriesFromDB implements Serializable {
	public ArrayList<allCategories> retrieveCategories(String sqlConnUrl) {
		ArrayList<allCategories> categoryList = new ArrayList<allCategories>();
		
		
		ResultSet categories;

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
			String sqlStrCategories = "SELECT * FROM Category";
			categories = stmt.executeQuery(sqlStrCategories);
			// Step 6: Process Result
			while (categories.next()) {
				allCategories category = new allCategories();
				category.setCategoryCatID(categories.getInt("catID"));
				category.setCategoryName(categories.getString("CategoryName"));
				category.setCategoryDesc(categories.getString("Description"));
				category.setCategoryImage(categories.getString("Image"));
				categoryList.add(category);
			}
			// Step 7: Close connection
			conn.close();
			} catch (Exception e) {
				System.err.println("Error :" + e);
			}
	
		return categoryList;
	}
}
