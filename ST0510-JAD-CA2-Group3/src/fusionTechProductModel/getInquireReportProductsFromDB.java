package fusionTechProductModel;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

@SuppressWarnings("serial")
public class getInquireReportProductsFromDB implements Serializable {
	public ArrayList<allProducts> inquireProducts(int pageSize, int offset, String tableType, String filterValue, String sqlConnUrl) {
		System.out.println("Page Size: " +pageSize);
		System.out.println("Offset: " +offset);

		String inquiryType = "";
		ArrayList<allProducts> productsList = new ArrayList<allProducts>();

		try {
			// Step1: Load JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");
			// Step 2: Define Connection URL
			String connURL = sqlConnUrl;
			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);
			// Step 5: Execute SQL Command
			// BSP = BEST SELLING PRODUCT; WSP = WORST SELLING PRODUCT; PWLS = PRODUCT WITH
			// LOW STOCKS
			String sqlStr = "";

			switch (tableType) {
			case "BSP":
				sqlStr = "SELECT\r\n" + "ProductID 'ProductCode', Name, Supplier, Category, CategoryName,\r\n"
						+ "SellPrice, SUM(Quantity) 'QtySold', (SUM(Quantity) * SellPrice) 'Revenue',\r\n"
						+ "PdtDescription, BriefDescription, Products.Image\r\n" + "FROM OrderItems\r\n"
						+ "INNER JOIN Products ON Products.ProductCode = ProductID\r\n"
						+ "INNER JOIN Category ON Category.catID = Products.Category\r\n" + "GROUP BY ProductID\r\n"
						+ "ORDER BY 7 DESC\r\n" + "LIMIT ? OFFSET ?;";
				inquiryType = "BSP";
				break;
			case "WSP":
				sqlStr = "SELECT\r\n" + "ProductID 'ProductCode', Name, Supplier, Category, CategoryName,\r\n"
						+ "SellPrice, SUM(Quantity) 'QtySold', (SUM(Quantity) * SellPrice) 'Revenue',\r\n"
						+ "PdtDescription, BriefDescription, Products.Image\r\n" + "FROM OrderItems\r\n"
						+ "INNER JOIN Products ON Products.ProductCode = ProductID\r\n"
						+ "INNER JOIN Category ON Category.catID = Products.Category\r\n" + "GROUP BY ProductID\r\n"
						+ "ORDER BY 7 ASC\r\n" + "LIMIT ? OFFSET ?;";
				inquiryType = "WSP";
				break;
			case "PWLS":
				sqlStr = "SELECT productCode, Category, CategoryName, Name, Supplier, BriefDescription, PdtDescription, QtyInStock, BuyPrice, SellPrice, products.Image, isAvailable\r\n"
						+ " FROM Products INNER JOIN category ON category.catid = products.category WHERE QtyInStock < ? ORDER BY productCode ASC LIMIT ? OFFSET ?;";
				inquiryType = "PWLS";
				break;
			case "default":
			default:
				sqlStr = "SELECT productCode, Category, CategoryName, Name, Supplier, BriefDescription, PdtDescription, QtyInStock, BuyPrice, SellPrice, products.Image, isAvailable\r\n"
						+ " FROM Products INNER JOIN category ON category.catid = products.category ORDER BY productCode ASC LIMIT ? OFFSET ?;";
				inquiryType = "ALL";
				break;
			}

			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			
			if (inquiryType.contentEquals("PWLS")) {
				pstmt.setInt(1, Integer.parseInt(filterValue));
				pstmt.setInt(2, pageSize);
				pstmt.setInt(3, offset);
				//System.out.println(sqlStr);
			} else if (inquiryType.contentEquals("ALL")) {
				pstmt.setInt(1, pageSize);
				pstmt.setInt(2, offset);
				//System.out.println(sqlStr);
			} else if (inquiryType.contentEquals("BSP") || inquiryType.contentEquals("WSP")) {
				pstmt.setInt(1, pageSize);
				pstmt.setInt(2, offset);
				//System.out.println(sqlStr);
			}
			
			System.out.println(sqlStr);

			ResultSet products = pstmt.executeQuery();

			// Step 6: Process Result
			while (products.next()) {
				allProducts getProduct = new allProducts();
				if (inquiryType.contentEquals("BSP") || inquiryType.contentEquals("WSP")) {
					getProduct.setProductName(products.getString("Name"));
					getProduct.setProductCode(products.getInt("productCode"));
					getProduct.setProductCategoryID(products.getInt("Category"));
					getProduct.setProductCategoryName(products.getString("CategoryName"));
					getProduct.setProductQtyInStock(products.getInt("QtySold"));
					getProduct.setProductSellPrice(products.getDouble("Revenue"));
					getProduct.setProductsupplier(products.getString("Supplier"));
					getProduct.setProductbriefDesc(products.getString("briefDescription"));
					getProduct.setProductDesc(products.getString("pdtDescription"));
					getProduct.setProductImage(products.getString("Image"));
				} else {
					getProduct.setProduct(products.getString("Name"), products.getInt("productCode"),
							products.getInt("Category"), products.getString("CategoryName"),
							products.getInt("QtyInStock"), products.getInt("isAvailable"),
							products.getDouble("buyprice"), products.getDouble("sellPrice"),
							products.getString("Supplier"), products.getString("briefDescription"),
							products.getString("pdtDescription"), products.getString("Image"));
				}

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
