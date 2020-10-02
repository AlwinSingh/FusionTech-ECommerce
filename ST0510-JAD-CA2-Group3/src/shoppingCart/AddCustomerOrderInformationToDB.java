package shoppingCart;

import java.io.Serializable;
import java.sql.*;

@SuppressWarnings("serial")
public class AddCustomerOrderInformationToDB implements Serializable {

	public boolean addOrder(int userId, String paymentMethod, double paymentAmt, String paymentCurrency, String sqlConnUrl, int shippingIndex, int billingIndex) {
		boolean addOrderStatus = false;

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
			String insertStr = "INSERT INTO Orders(CustomerID, PaymentMethod, PaymentAmt, PaymentCurrency, ShippingAddress, BillingAddress) VALUES (?, ?, ?, ?, ?, ?)";

			//Prepared Statement prevents SQL Injection
		    PreparedStatement pstmt = conn.prepareStatement(insertStr);
		    
			//The '?' corresponds to the input below
		    pstmt.setInt(1, userId);
		    pstmt.setString(2, paymentMethod);
		    pstmt.setDouble(3, paymentAmt);
		    pstmt.setString(4, paymentCurrency);
		    pstmt.setInt(5, shippingIndex);
		    pstmt.setInt(6,  billingIndex);
		    
		    int insert = pstmt.executeUpdate();
		    
		    if (insert > 0) {
		    	addOrderStatus = true;
		    } else {
		    	addOrderStatus = false;
		    }
		    
		conn.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			addOrderStatus = false;
		}
		
		return addOrderStatus;
		
	}
	
	
	public boolean addOrderShipping(int userId, String shipperFirstName, String shipperLastName, String AddressLine1, String AddressLine2, String Country, String State, String PostalCode, char deliveryMode, String sqlConnUrl) {
		boolean addOrderShippingInformation = false;
		int addOrderShippingInformationSQLCode = 0;

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
			String insertStr = "INSERT INTO ShippingAddress(CustomerID, FirstName, LastName, AddressLine1, AddressLine2, Country, State, PostalCode, ContactlessDelivery) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

			//Prepared Statement prevents SQL Injection
		    PreparedStatement pstmt = conn.prepareStatement(insertStr);
		    
			//The '?' corresponds to the input below
		    pstmt.setInt(1, userId);
		    pstmt.setString(2, shipperFirstName);
		    pstmt.setString(3, shipperLastName);
		    pstmt.setString(4, AddressLine1);
		    pstmt.setString(5, AddressLine2);
		    pstmt.setString(6, Country);
		    pstmt.setString(7, State);
		    pstmt.setString(8, PostalCode);
		    pstmt.setString(9, String.valueOf(deliveryMode));

		    
		    int insert = pstmt.executeUpdate();
		    
		    if (insert > 0) {
		    	addOrderShippingInformationSQLCode = 0;
		    } else {
		    	addOrderShippingInformationSQLCode = 404;
		    }
		    
		    System.out.println("[Shipping Info SQL Code]: " +addOrderShippingInformationSQLCode);
		    
		conn.close();
		} catch (SQLException e) {
			System.out.println("Add Shipping Info to DB Error: " +e);
			addOrderShippingInformationSQLCode = e.getErrorCode();
		}
		
		if (addOrderShippingInformationSQLCode == 0 || addOrderShippingInformationSQLCode == 2601 || addOrderShippingInformationSQLCode == 2627 || addOrderShippingInformationSQLCode == 1062) {
			addOrderShippingInformation = true;
		} else {
			addOrderShippingInformation = false;
		}
		
		return addOrderShippingInformation;
		
	}
	
	
	public boolean addOrderBilling(int userId, String shipperFirstName, String shipperLastName, String AddressLine1, String AddressLine2, String Country, String State, String PostalCode, String sqlConnUrl) {
		boolean addOrderBillingInformation = false;
		int addOrderBillingInformationSQLCode = 0;

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
			String insertStr = "INSERT INTO BillingAddress(CustomerID, FirstName, LastName, AddressLine1, AddressLine2, Country, State, PostalCode) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

			//Prepared Statement prevents SQL Injection
		    PreparedStatement pstmt = conn.prepareStatement(insertStr);
		    
			//The '?' corresponds to the input below
		    pstmt.setInt(1, userId);
		    pstmt.setString(2, shipperFirstName);
		    pstmt.setString(3, shipperLastName);
		    pstmt.setString(4, AddressLine1);
		    pstmt.setString(5, AddressLine2);
		    pstmt.setString(6, Country);
		    pstmt.setString(7, State);
		    pstmt.setString(8, PostalCode);

		    
		    int insert = pstmt.executeUpdate();
		    
		    if (insert > 0) {
		    	addOrderBillingInformationSQLCode = 0;
		    } else {
		    	addOrderBillingInformationSQLCode = 404;
		    }
		    
		    System.out.println("[Billing Info SQL Code]: " +addOrderBillingInformationSQLCode);
		    
		conn.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			addOrderBillingInformationSQLCode = e.getErrorCode();
		}
		
		if (addOrderBillingInformationSQLCode == 0 || addOrderBillingInformationSQLCode == 2601 || addOrderBillingInformationSQLCode == 2627 || addOrderBillingInformationSQLCode == 1062) {
			addOrderBillingInformation = true;
		} else {
			addOrderBillingInformation = false;
		}
		
		return addOrderBillingInformation;
		
	}
	
}
