package fusionTechUserModel;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import passEncryption.passEncryption;

@SuppressWarnings("serial")
public class UserAddressesFromDB implements Serializable {
	public int deleteAddressFromDB(int userId, int deliveryId, String sqlConnUrl) {
		int deleteCount = 0;
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
			String deleteStr = "DELETE FROM ShippingAddress WHERE CustomerID = ? AND ID = ?";

			//Prepared Statement prevents SQL Injection
		    PreparedStatement pstmt = conn.prepareStatement(deleteStr);
		    
			//The '?' corresponds to the input below
		    pstmt.setInt(1, userId);
		    pstmt.setInt(2,  deliveryId);

		    
		    deleteCount = pstmt.executeUpdate();
		    
		    conn.close();
		} catch (SQLException e) {
			System.out.println("[DELETE USER ADDRESSES FROM DB] :" +e);
		}
		
		return deleteCount;
	}
	
	
	public ArrayList<UserAddresses> getAddressesListForOrdersFromDB(int userId, String sqlConnUrl) {
		ArrayList<UserAddresses> addressList = new ArrayList<UserAddresses>();

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
			String selectStr = "SELECT OrderID, ID, SA.CustomerID, SA.FirstName, SA.LastName, SA.AddressLine1, SA.AddressLine2, SA.Country, SA.State, SA.PostalCode, SA.ContactlessDelivery FROM shippingaddress SA\r\n" + 
					"INNER JOIN Orders on Orders.ShippingAddress = SA.ID\r\n" + 
					"WHERE SA.CustomerID = ?\r\n" + 
					"ORDER BY ID ASC;";

			//Prepared Statement prevents SQL Injection
		    PreparedStatement pstmt = conn.prepareStatement(selectStr);
		    
			//The '?' corresponds to the input below
		    pstmt.setInt(1, userId);

		    
		    ResultSet addresses = pstmt.executeQuery();
		    
		    while (addresses.next()) {
		    	UserAddresses userAddress = new UserAddresses();
		    	userAddress.setAddressLine1(addresses.getString("AddressLine1"));
		    	userAddress.setAddressLine2(addresses.getString("AddressLine2"));
		    	userAddress.setCountry(addresses.getString("Country"));
		    	userAddress.setCustomerID(addresses.getInt("CustomerID"));
		    	userAddress.setDatabaseIndex(addresses.getInt("ID"));
		    	userAddress.setDeliveryType((addresses.getString("ContactlessDelivery")).charAt(0));
		    	userAddress.setFirstName(addresses.getString("FirstName"));
		    	userAddress.setLastName(addresses.getString("LastName"));
		    	userAddress.setPostalCode(addresses.getString("PostalCode"));
		    	userAddress.setState(addresses.getString("State"));
		    	userAddress.setOrderID(addresses.getInt("OrderID"));
		    	addressList.add(userAddress);
		    }
		    
		conn.close();
		} catch (SQLException e) {
			System.out.println("[RETRIEVING USER ADDRESSES FOR ORDERS FROM DB] :" +e.getMessage());
		}

		return addressList;
		
	}
	
	public ArrayList<UserAddresses> getAddressesFromDB(int userId, String sqlConnUrl) {
		ArrayList<UserAddresses> addressList = new ArrayList<UserAddresses>();

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
			String selectStr = "SELECT * FROM ShippingAddress WHERE CustomerID = ? ORDER BY ID ASC";

			//Prepared Statement prevents SQL Injection
		    PreparedStatement pstmt = conn.prepareStatement(selectStr);
		    
			//The '?' corresponds to the input below
		    pstmt.setInt(1, userId);

		    
		    ResultSet addresses = pstmt.executeQuery();
		    
		    while (addresses.next()) {
		    	UserAddresses userAddress = new UserAddresses();
		    	userAddress.setAddressLine1(addresses.getString("AddressLine1"));
		    	userAddress.setAddressLine2(addresses.getString("AddressLine2"));
		    	userAddress.setCountry(addresses.getString("Country"));
		    	userAddress.setCustomerID(addresses.getInt("CustomerID"));
		    	userAddress.setDatabaseIndex(addresses.getInt("ID"));
		    	userAddress.setDeliveryType((addresses.getString("ContactlessDelivery")).charAt(0));
		    	userAddress.setFirstName(addresses.getString("FirstName"));
		    	userAddress.setLastName(addresses.getString("LastName"));
		    	userAddress.setPostalCode(addresses.getString("PostalCode"));
		    	userAddress.setState(addresses.getString("State"));
		    	addressList.add(userAddress);
		    }
		    
		conn.close();
		} catch (SQLException e) {
			System.out.println("[RETRIEVING USER ADDRESSES FROM DB] :" +e.getMessage());
		}
		
		return addressList;
		
	}
	
	
	public boolean updateUserAddressesToDB(String sqlConnUrl, String firstName, String lastName, String addressLine1, String addressLine2, String Country, String State, String PostalCode, char ContactlessDelivery, int addressId, int customerId) {
		boolean updateStatus = false;
		int insert = 0;

		try {
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String connURL = sqlConnUrl;
			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);
			// Step 5: Execute SQL Command
			String updateStr = "UPDATE ShippingAddress SET FirstName = ?, LastName = ?, AddressLine1 = ?, AddressLine2 = ?, Country = ?, State = ?, PostalCode = ?, ContactlessDelivery = ? WHERE ID = ? AND CustomerID = ?;";
			PreparedStatement pstmt = conn.prepareStatement(updateStr);

			pstmt.setString(1, firstName);
			pstmt.setString(2, lastName);
			pstmt.setString(3, addressLine1);
			pstmt.setString(4, addressLine2);
			pstmt.setString(5, Country);
			pstmt.setString(6, State);
			pstmt.setString(7, PostalCode);
			pstmt.setString(8, String.valueOf(ContactlessDelivery));
			pstmt.setInt(9, addressId);
			pstmt.setInt(10, customerId);
			
			insert = pstmt.executeUpdate();
			
			conn.close();
		} catch (SQLException e) {
			System.err.println("[Updating User Addresses Error]: " + e);
		}
		
		if (insert > 0) {
			updateStatus = true;
		} else {
			updateStatus = false;
		}
		
		return updateStatus;
	}

}
