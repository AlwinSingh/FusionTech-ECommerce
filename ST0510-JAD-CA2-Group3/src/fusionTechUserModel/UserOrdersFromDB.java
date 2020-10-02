package fusionTechUserModel;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import fusionTechProductModel.allProducts;
import shoppingCart.orderDetails;

@SuppressWarnings("serial")
public class UserOrdersFromDB implements Serializable {

	public ArrayList<orderDetails> adminOrderReportsFromDB(String tableType, String filterValue, String sqlConnUrl) {
		ArrayList<orderDetails> ordersList = new ArrayList<orderDetails>();

		String inquiryType = "ALL";
		String sqlStr = "";

		switch (tableType) {
		case "PFO":
			sqlStr = "SELECT DISTINCT OrderID, PaymentCurrency, SUM(Profit) OVER(PARTITION BY OrderID) 'Profit', CustomerID, OrderDate,\r\n"
					+ "ShippedDate, ExpectedDate, Status, PaymentMethod, PaymentAmt, CouponCode FROM (\r\n"
					+ "SELECT Orders.OrderID, PaymentCurrency, CustomerID, \r\n" + "Products.SellPrice, Products.BuyPrice,\r\n"
					+ "Products.SellPrice - Products.BuyPrice 'Profit',\r\n" + "OrderDate,\r\n"
					+ "CASE COALESCE(ShippedDate, 0) \r\n" + "WHEN 0 THEN 'Not Available'\r\n" + "ELSE ShippedDate\r\n"
					+ "END AS ShippedDate,\r\n"
					+ "ExpectedDate, Status, PaymentMethod, PaymentAmt, CASE WHEN CouponCode = 'N/A' THEN 'None Applied' \r\n"
					+ "END AS CouponCode, ShippingAddress,  BillingAddress, ProductCode, Category 'catID', CategoryName 'CategoryName' , Name, \r\n"
					+ "Supplier, Products.Image, Products.QtyInStock 'Quantity', isAvailable FROM Orders \r\n"
					+ "INNER JOIN OrderItems ON OrderItems.OrderID = Orders.OrderID \r\n"
					+ "INNER JOIN Products ON Products.ProductCode = OrderItems.ProductID\r\n"
					+ "INNER JOIN Category ON Category.catID = Category\r\n"
					+ "INNER JOIN Users ON Users.ID = Orders.CustomerID\r\n" + ") AS OrderRevenueData\r\n"
					+ "ORDER BY Profit DESC;";
			inquiryType = "PFO";
			break;
		case "OBI":
			sqlStr = "SELECT * FROM (\r\n" + 
					"SELECT DISTINCT OrderID, PaymentCurrency, SUM(Profit) OVER(PARTITION BY OrderID) 'Profit', CustomerID, \r\n" + 
					"OrderDate, ShippedDate, ExpectedDate, Status, PaymentMethod, PaymentAmt, CouponCode, \r\n" + 
					"COUNT(*) OVER(PARTITION BY OrderID) 'TotalItems' FROM (\r\n" + 
					"SELECT Orders.OrderID, PaymentCurrency, CustomerID, \r\n" + 
					"Products.SellPrice, Products.BuyPrice,\r\n" + 
					"Products.SellPrice - Products.BuyPrice 'Profit',\r\n" + 
					"OrderDate,\r\n" + 
					"CASE COALESCE(ShippedDate, 0) \r\n" + 
					"WHEN 0 THEN 'Not Available'\r\n" + 
					"ELSE ShippedDate\r\n" + 
					"END AS ShippedDate,\r\n" + 
					"ExpectedDate, Status, PaymentMethod, PaymentAmt, CASE WHEN CouponCode = 'N/A' THEN 'None Applied' \r\n" + 
					"END AS CouponCode, ShippingAddress,  BillingAddress, ProductCode, Category 'catID', CategoryName 'CategoryName' , Name, \r\n" + 
					"Supplier, Products.Image, Products.QtyInStock 'Quantity', isAvailable FROM Orders \r\n" + 
					"INNER JOIN OrderItems ON OrderItems.OrderID = Orders.OrderID \r\n" + 
					"INNER JOIN Products ON Products.ProductCode = OrderItems.ProductID\r\n" + 
					"INNER JOIN Category ON Category.catID = Category\r\n" + 
					"INNER JOIN Users ON Users.ID = Orders.CustomerID\r\n" + 
					") AS OrderRevenueData\r\n" + 
					") AS FinalData\r\n" + 
					"WHERE TotalItems >= ?\r\n" + 
					"ORDER BY TotalItems DESC, OrderID ASC;";
			inquiryType = "OBI";
			break;
		case "OBM":
			sqlStr = "SELECT * FROM (\r\n" + 
					 "SELECT DISTINCT OrderID, PaymentCurrency, SUM(Profit) OVER(PARTITION BY OrderID) 'Profit', CustomerID, OrderDate, \r\n" + 
					 "CASE MONTH(OrderDate) \r\n" + 
					 "WHEN 1 THEN 'January' \r\n" + 
					 "WHEN 2 THEN 'February'\r\n" + 
					 "WHEN 3 THEN 'March' \r\n" + 
					 "WHEN 4 THEN 'April' \r\n" + 
					 "WHEN 5 THEN 'May'\r\n" + 
					 "WHEN 6 THEN 'June' \r\n" + 
					 "WHEN 7 THEN 'July' \r\n" + 
					 "WHEN 8 THEN 'August'\r\n" + 
					 "WHEN 9 THEN 'September'\r\n" + 
					 "WHEN 10 THEN 'October' \r\n" + 
					 "WHEN 11 THEN 'November'\r\n" + 
					 "WHEN 12 THEN 'December' ELSE 'N/A' END AS 'OrderMonth',\r\n" + 
					 "YEAR(OrderDate) AS 'OrderYear',\r\n" + 
					 "ShippedDate, ExpectedDate, Status, PaymentMethod, PaymentAmt, CouponCode FROM (\r\n" + 
					 "SELECT Orders.OrderID, PaymentCurrency, CustomerID, Products.SellPrice, Products.BuyPrice,\r\n" + 
					 "Products.SellPrice - Products.BuyPrice 'Profit', OrderDate,\r\n" + 
					 "CASE COALESCE(ShippedDate, 0) WHEN 0 THEN 'Not Available' ELSE ShippedDate\r\n" + 
					 "END AS ShippedDate,\r\n" + 
					 "ExpectedDate, Status, PaymentMethod, PaymentAmt, CASE WHEN CouponCode = 'N/A' THEN 'None Applied'\r\n" + 
					 "END AS CouponCode, ShippingAddress,  BillingAddress, ProductCode, Category 'catID', CategoryName 'CategoryName' , Name,\r\n" + 
					 "Supplier, Products.Image, Products.QtyInStock 'Quantity', isAvailable FROM Orders\r\n" + 
					 "INNER JOIN OrderItems ON OrderItems.OrderID = Orders.OrderID\r\n" + 
					 "INNER JOIN Products ON Products.ProductCode = OrderItems.ProductID\r\n" + 
					 "INNER JOIN Category ON Category.catID = Category\r\n" + 
					 "INNER JOIN Users ON Users.ID = Orders.CustomerID) AS OrderRevenueData\r\n" + 
					 ") AS FinalData\r\n" + 
					 "WHERE OrderMonth = ?\r\n" + 
					 "ORDER BY OrderMonth ASC, OrderYear ASC;";
			inquiryType = "OBM";
			break;
		case "default":
		default:
			sqlStr = "SELECT DISTINCT OrderID, PaymentCurrency, SUM(Profit) OVER(PARTITION BY OrderID) 'Profit', CustomerID, OrderDate,\r\n"
					+ "ShippedDate, ExpectedDate, Status, PaymentMethod, PaymentAmt, CouponCode FROM (\r\n"
					+ "SELECT Orders.OrderID, PaymentCurrency, CustomerID, \r\n" + "Products.SellPrice, Products.BuyPrice,\r\n"
					+ "Products.SellPrice - Products.BuyPrice 'Profit',\r\n" + "OrderDate,\r\n"
					+ "CASE COALESCE(ShippedDate, 0) \r\n" + "WHEN 0 THEN 'Not Available'\r\n" + "ELSE ShippedDate\r\n"
					+ "END AS ShippedDate,\r\n"
					+ "ExpectedDate, Status, PaymentMethod, PaymentAmt, CASE WHEN CouponCode = 'N/A' THEN 'None Applied' \r\n"
					+ "END AS CouponCode, ShippingAddress,  BillingAddress, ProductCode, Category 'catID', CategoryName 'CategoryName' , Name, \r\n"
					+ "Supplier, Products.Image, Products.QtyInStock 'Quantity', isAvailable FROM Orders \r\n"
					+ "INNER JOIN OrderItems ON OrderItems.OrderID = Orders.OrderID \r\n"
					+ "INNER JOIN Products ON Products.ProductCode = OrderItems.ProductID\r\n"
					+ "INNER JOIN Category ON Category.catID = Category\r\n"
					+ "INNER JOIN Users ON Users.ID = Orders.CustomerID\r\n" + ") AS OrderRevenueData\r\n"
					+ "ORDER BY Profit DESC;";
			inquiryType = "ALL";
			break;
		}

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
			String selectStr = sqlStr;

			// Prepared Statement prevents SQL Injection
			PreparedStatement pstmt = conn.prepareStatement(selectStr);
			
			if (inquiryType.contentEquals("OBI")) {
				pstmt.setInt(1, Integer.parseInt(filterValue));
			} else if (inquiryType.contentEquals("OBM")) {
				pstmt.setString(1, filterValue);
			}

			ResultSet orders = pstmt.executeQuery();

			while (orders.next()) {
				orderDetails order = new orderDetails();
				order.setOrderDetails(orders.getInt("OrderID"), orders.getInt("CustomerID"),
						orders.getString("OrderDate"), orders.getString("ShippedDate"),
						orders.getString("ExpectedDate"), orders.getString("Status"), orders.getString("PaymentMethod"),
						orders.getString("PaymentAmt"), orders.getString("CouponCode"));
				order.setOrderCurrencySymbol(orders.getString("PaymentCurrency"));
				
				switch(inquiryType) {
				case "PFO": order.setOrderProfit(orders.getDouble("profit"));
					break;
				case "OBM": order.setOrderMonth(orders.getString("OrderMonth"));
					break;
				case "OBI": order.setOrderQuantity(orders.getInt("TotalItems"));
					break;
				case "default":
					break;
				}
				
				order.setInquiryType(inquiryType);
				ordersList.add(order);
			}

			conn.close();
		} catch (SQLException e) {
			System.out.println("[RETRIEVING ORDER REPORTS FROM DB] :" + e.getMessage());
		}

		return ordersList;
	}

	public ArrayList<allProducts> getOrderItemsFromDB(int userId, String sqlConnUrl) {
		ArrayList<allProducts> orderItemsList = new ArrayList<allProducts>();

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
			String selectStr = "SELECT Orders.OrderID, ProductID, Products.Name, Supplier, \r\n"
					+ "Category.catID, Category.CategoryName, OrderItems.Quantity, \r\n"
					+ "Products.SellPrice, OrderItems.ProductPaidPrice 'PaidPrice', \r\n"
					+  "Products.Image FROM OrderItems\r\n"
					+ "INNER JOIN Orders ON Orders.OrderID = OrderItems.OrderId\r\n"
					+ "INNER JOIN Products on Products.productCode = Orderitems.ProductID\r\n"
					+ "INNER JOIN Category ON Category.catID = Products.Category\r\n" + "WHERE CustomerID = ?;";

			// Prepared Statement prevents SQL Injection
			PreparedStatement pstmt = conn.prepareStatement(selectStr);

			// The '?' corresponds to the input below
			pstmt.setInt(1, userId);

			ResultSet orderProducts = pstmt.executeQuery();

			while (orderProducts.next()) {
				allProducts orderItems = new allProducts();

				orderItems.setProductOrderID(orderProducts.getInt("OrderID"));
				orderItems.setProductCode(orderProducts.getInt("ProductID"));
				orderItems.setProductCategoryID(orderProducts.getInt("catID"));
				orderItems.setProductCategoryName(orderProducts.getString("categoryName"));
				orderItems.setProductsupplier(orderProducts.getString("Supplier"));
				orderItems.setProductQtyInStock(orderProducts.getInt("Quantity"));
				orderItems.setProductSellPrice(orderProducts.getDouble("PaidPrice"));
				orderItems.setProductImage(orderProducts.getString("Image"));
				orderItems.setProductOriginalSellPrice(orderProducts.getDouble("SellPrice"));

				orderItemsList.add(orderItems);
			}

			conn.close();
		} catch (SQLException e) {
			System.out.println("[RETRIEVING USER ORDER ITEMS FROM DB] :" + e);
			System.out.println("[RETRIEVING USER ORDER ITEMS FROM DB] :" + e.getMessage());
		}

		return orderItemsList;
	}

	public ArrayList<orderDetails> getOrdersFromDB(int userId, String sqlConnUrl) {
		ArrayList<orderDetails> ordersList = new ArrayList<orderDetails>();

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
			String selectStr = "SELECT Orders.OrderID, CustomerID, OrderDate," + "CASE COALESCE(ShippedDate, 0) \r\n"
					+ "WHEN 0 THEN 'Not Available'\r\n" + "ELSE ShippedDate\r\n" + "END AS ShippedDate,\r\n"
					+ "ExpectedDate, Status, PaymentMethod, PaymentAmt, PaymentCurrency, CASE WHEN CouponCode = 'N/A' THEN 'None Applied' END AS CouponCode\r\n"
					+ "FROM Orders WHERE CustomerID = ?;";

			// Prepared Statement prevents SQL Injection
			PreparedStatement pstmt = conn.prepareStatement(selectStr);

			// The '?' corresponds to the input below
			pstmt.setInt(1, userId);

			ResultSet orders = pstmt.executeQuery();

			while (orders.next()) {
				orderDetails order = new orderDetails();
				order.setOrderDetails(orders.getInt("OrderID"), orders.getInt("CustomerID"),
						orders.getString("OrderDate"), orders.getString("ShippedDate"),
						orders.getString("ExpectedDate"), orders.getString("Status"), orders.getString("PaymentMethod"),
						orders.getString("PaymentAmt"), orders.getString("CouponCode"));
				order.setOrderCurrencySymbol(orders.getString("PaymentCurrency"));
				ordersList.add(order);
			}

			conn.close();
		} catch (SQLException e) {
			System.out.println("[RETRIEVING USER ORDERS FROM DB] :" + e.getMessage());
		}

		return ordersList;

	}

	public ArrayList<orderDetails> adminGetAllOrdersFromDB(String sqlConnUrl) {
		ArrayList<orderDetails> adminOrdersList = new ArrayList<orderDetails>();

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
			String selectStr = "SELECT Orders.OrderID, CustomerID, PaymentCurrency, OrderDate, " + "CASE COALESCE(ShippedDate, 0) \r\n"
					+ "WHEN 0 THEN 'Not Available'\r\n" + "ELSE ShippedDate\r\n" + "END AS ShippedDate,\r\n"
					+ "ExpectedDate, Status, PaymentMethod, PaymentAmt, CASE WHEN CouponCode = 'N/A' THEN 'None Applied' END AS CouponCode FROM Orders";

			// Prepared Statement prevents SQL Injection
			PreparedStatement pstmt = conn.prepareStatement(selectStr);
			ResultSet orders = pstmt.executeQuery();

			while (orders.next()) {
				orderDetails order = new orderDetails();
				order.setOrderDetails(orders.getInt("OrderID"), orders.getInt("CustomerID"),
						orders.getString("OrderDate"), orders.getString("ShippedDate"),
						orders.getString("ExpectedDate"), orders.getString("Status"), orders.getString("PaymentMethod"),
						orders.getString("PaymentAmt"), orders.getString("CouponCode"));
				order.setOrderCurrencySymbol(orders.getString("PaymentCurrency"));
				adminOrdersList.add(order);
			}

			conn.close();
		} catch (SQLException e) {
			System.out.println("[RETRIEVING ADMIN ALL ORDERS FROM DB] :" + e.getMessage());
		}

		return adminOrdersList;

	}

	public ArrayList<allProducts> adminGetOrderItemsFromDB(String sqlConnUrl) {
		ArrayList<allProducts> orderItemsList = new ArrayList<allProducts>();

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
			String selectStr = "SELECT Orders.OrderID, CustomerID, OrderDate, " + "CASE COALESCE(ShippedDate, 0) \r\n"
					+ "WHEN 0 THEN 'Not Available'\r\n" + "ELSE ShippedDate\r\n" + "END AS ShippedDate,\r\n"
					+ "ExpectedDate, Status, \r\n"
					+ "PaymentMethod, PaymentAmt, CASE WHEN CouponCode = 'N/A' THEN 'None Applied' \r\n"
					+ "END AS CouponCode, ShippingAddress,  BillingAddress, ProductCode, Category 'catID', CategoryName 'CategoryName' , Name, \r\n"
					+ "Supplier, BriefDescription, PdtDescription, SellPrice, Products.Image, Products.QtyInStock 'Quantity', isAvailable FROM Orders \r\n"
					+ "INNER JOIN OrderItems ON OrderItems.OrderID = Orders.OrderID \r\n"
					+ "INNER JOIN Products ON Products.ProductCode = OrderItems.ProductID\r\n"
					+ "INNER JOIN Category ON Category.catID = Category;";

			// Prepared Statement prevents SQL Injection
			PreparedStatement pstmt = conn.prepareStatement(selectStr);

			ResultSet orderProducts = pstmt.executeQuery();

			while (orderProducts.next()) {
				allProducts orderItems = new allProducts();

				orderItems.setProductOrderID(orderProducts.getInt("OrderID"));
				orderItems.setProductCode(orderProducts.getInt("ProductCode"));
				orderItems.setProductCategoryID(orderProducts.getInt("catID"));
				orderItems.setProductCategoryName(orderProducts.getString("CategoryName"));
				orderItems.setProductsupplier(orderProducts.getString("Supplier"));
				orderItems.setProductQtyInStock(orderProducts.getInt("Quantity"));
				orderItems.setProductSellPrice(orderProducts.getDouble("SellPrice"));
				orderItems.setProductImage(orderProducts.getString("Image"));

				orderItemsList.add(orderItems);
			}

			conn.close();
		} catch (SQLException e) {
			System.out.println("[RETRIEVING USER ORDER ITEMS AS ADMIN FROM DB] :" + e);
			System.out.println("[RETRIEVING USER ORDER ITEMS AS ADMIN FROM DB] :" + e.getMessage());
		}

		return orderItemsList;
	}

}
