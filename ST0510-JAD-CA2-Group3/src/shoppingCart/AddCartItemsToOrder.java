package shoppingCart;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@SuppressWarnings("serial")
public class AddCartItemsToOrder implements Serializable {
	
	public int getBillingIndex(int customerId, String addressLine1, String addressLine2, String country, String postalCode, String sqlConnUrl) {
		System.out.println(customerId);
		System.out.println(addressLine1);
		System.out.println(postalCode);
		int billingIndex = 0;

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
			// STEP 4: EXECUTE SQL COMMAND
			String selectStr = "SELECT ID FROM BillingAddress WHERE CustomerID = ? AND AddressLine1 = ? AND AddressLine2 = ? AND Country = ? AND PostalCode = ?;";

			// Prepared Statement prevents SQL Injection
			PreparedStatement pstmt = conn.prepareStatement(selectStr);

			// The '?' corresponds to the input below
			pstmt.setInt(1, customerId);
			pstmt.setString(2, addressLine1);
			pstmt.setString(3, addressLine2);
			pstmt.setString(4, country);
			pstmt.setString(5, postalCode);

			// ResultSet of the orders, this executes the SQL statement above. As multiple
			// rows will be return, it is a ResultSet that we can iterate through via a
			// while loop
			ResultSet billingInfo = pstmt.executeQuery();

			// This while loop iterates through the Result Set and retrieves the values by
			// column
			while (billingInfo.next()) {
				billingIndex = billingInfo.getInt("ID");
			}
			conn.close();
		} catch (SQLException e) {
			// Prints out any errors / exceptions
			billingIndex = 0;
			System.out.println("[GET SHIPPING INDEX]" + e.getMessage());
		}

		// Returns the orderDetails object
		return billingIndex;
	}

	public int getShippingIndex(int customerId, String addressLine1, String addressLine2, String country, String postalCode, String sqlConnUrl) {
		int shippingIndex = 0;

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
			// STEP 4: EXECUTE SQL COMMAND
			String selectStr = "SELECT ID FROM ShippingAddress WHERE CustomerID = ? AND AddressLine1 = ? AND AddressLine2 = ? AND Country = ? AND PostalCode = ?;";

			// Prepared Statement prevents SQL Injection
			PreparedStatement pstmt = conn.prepareStatement(selectStr);

			// The '?' corresponds to the input below
			pstmt.setInt(1, customerId);
			pstmt.setString(2, addressLine1);
			pstmt.setString(3, addressLine2);
			pstmt.setString(4, country);
			pstmt.setString(5, postalCode);

			// ResultSet of the orders, this executes the SQL statement above. As multiple
			// rows will be return, it is a ResultSet that we can iterate through via a
			// while loop
			ResultSet shippingInfo = pstmt.executeQuery();

			// This while loop iterates through the Result Set and retrieves the values by
			// column
			while (shippingInfo.next()) {
				shippingIndex = shippingInfo.getInt("ID");
			}
			conn.close();
		} catch (SQLException e) {
			// Prints out any errors / exceptions
			shippingIndex = 0;
			System.out.println("[GET SHIPPING INDEX]" + e.getMessage());
		}

		// Returns the orderDetails object
		return shippingIndex;
	}

	public orderDetails getOrderDetails(int customerId, String sqlConnUrl) {
		orderDetails order = new orderDetails();

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
			// STEP 4: EXECUTE SQL COMMAND
			String insertStr = "SELECT *, CASE WHEN CouponCode = 'N/A' THEN 'None Applied' END AS CouponCode FROM Orders WHERE CustomerID = ? ORDER BY OrderDate DESC LIMIT 1;";

			// Prepared Statement prevents SQL Injection
			PreparedStatement pstmt = conn.prepareStatement(insertStr);

			// The '?' corresponds to the input below
			pstmt.setInt(1, customerId);

			// ResultSet of the orders, this executes the SQL statement above. As multiple
			// rows will be return, it is a ResultSet that we can iterate through via a
			// while loop
			ResultSet latestOrder = pstmt.executeQuery();

			// This while loop iterates through the Result Set and retrieves the values by
			// column
			while (latestOrder.next()) {
				// We define a order detail object above which is a value bean, allows us to
				// store the order information easily
				// This is a multi setter method that allows the setting of multiple variables
				// at once
				// We also have individual setter methods that can be used
				order.setOrderDetails(latestOrder.getInt("orderID"), latestOrder.getInt("CustomerID"),
						latestOrder.getString("OrderDate"), latestOrder.getString("ShippedDate"),
						latestOrder.getString("ExpectedDate"), latestOrder.getString("Status"),
						latestOrder.getString("PaymentMethod"), latestOrder.getString("PaymentAmt"),
						latestOrder.getString("CouponCode"));
			}
			conn.close();
		} catch (SQLException e) {
			// Prints out any errors / exceptions
			System.out.println("[GET ORDER DETAILS]" + e.getMessage());
		}

		// Returns the orderDetails object
		return order;
	}

	public boolean orderItemsToCart(int orderId, ArrayList<shoppingCart> cartItems, String sqlConnUrl) {
		// System.out.println("Order ID: " +orderId);
		boolean addOrderItemsStatus = false;

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
			// STEP 4: EXECUTE SQL COMMAND
			String insertStr = "INSERT INTO OrderItems(OrderID, ProductID, Quantity, ProductPaidPrice) VALUES (?, ?, ?, ?);";
			String updateStr = "UPDATE Products SET QtyInStock = GREATEST(0, QtyInStock - ?) WHERE ProductCode = ?";

			// Prepared Statement prevents SQL Injection
			PreparedStatement pstmt = conn.prepareStatement(insertStr);
			PreparedStatement updatedstmt = conn.prepareStatement(updateStr);

			// The '?' corresponds to the input below
			// As we can have multiple items in a single order (E.g. 5 iPhone 11, 1 Laptop
			// in a single order), we need to be able to execute this all together
			// We could iterate them through individually but that would drain performance
			// and not be efficient as compared to a batch insert
			for (int i = 0; i < cartItems.size(); i++) {
				// As it iterates through the cartItems array list which contains the
				// shoppingCart objects, it sets the productCode and Quantity
				// These are the only information we need for the orderitems table, if we want
				// the product details, we can get them via a INNER JOIN SQL Query
				pstmt.setInt(1, orderId);
				pstmt.setInt(2, cartItems.get(i).getProductCode());
				pstmt.setInt(3, cartItems.get(i).getQtyInCart());
				pstmt.setDouble(4, cartItems.get(i).getProductSellPrice());
				// At the end of the loop, add it to the batch
				// So a single batch would consist of setting 3 fields at once, the OrderID,
				// productCode and Quantity in Cart

				// Batch to update QtyInStock
				updatedstmt.setInt(1, cartItems.get(i).getQtyInCart());
				updatedstmt.setInt(2, cartItems.get(i).getProductCode());

				// Add to batch
				pstmt.addBatch();
				updatedstmt.addBatch();
			}

			// The above adds the batch together, the values to be inserted are all 'on
			// hold'
			// Once the .executeBatch() is executed, all the values will be inserted
			/*
			 * This works pretty much like a multi insert in SQL INSERT INTO
			 * TABLE_NAME(COL1, COL2, COL3) VALUES (A, B, C), (B, C, A), (C, A, B), (B, A,
			 * C);
			 */
			int[] count = pstmt.executeBatch();
			// The executeBatch is stored in an Integer array because it returns a Integer
			// per insertion of a batch row

			int[] updateCount = updatedstmt.executeBatch();

			// Iterate through the integer array to check the values
			for (int i = 0; i < count.length; i++) {
				// System.out.println("Batch: " +count[i]);

				// If the integer returned for that batch row is not -3 or 0, it means the
				// insertion is successful
				// Usually -1 is what is returned for success but as we can ascertain that -3
				// and 0 are the error codes, anything apart from that is a success
				if (count[i] == -3 || count[i] == 0) {
					// Update the boolean value of status
					addOrderItemsStatus = false;
					break;
				} else {
					// Update the boolean value of status
					addOrderItemsStatus = true;
				}

			}

			// Iterate through the integer array to check the values
			for (int i = 0; i < updateCount.length; i++) {
				// System.out.println("Batch: " +count[i]);

				// If the integer returned for that batch row is not -3 or 0, it means the
				// insertion is successful
				// Usually -1 is what is returned for success but as we can ascertain that -3
				// and 0 are the error codes, anything apart from that is a success
				if (updateCount[i] == -3 || updateCount[i] == 0) {
					// Update the boolean value of status
					addOrderItemsStatus = false;
					break;
				} else {
					// Update the boolean value of status
					addOrderItemsStatus = true;
				}

			}

			conn.close();
		} catch (SQLException e) {
			// Prints out any error messages
			System.out.println("[ADD CART ITEMS TO ORDER] EXCEPTION: " + e.getMessage());
			// If there is an error, set the add order items to false
			addOrderItemsStatus = false;
		}

		// Return the orderDetails object
		return addOrderItemsStatus;
	}

}
