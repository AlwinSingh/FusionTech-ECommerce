package fusionTechUserModel;

import passEncryption.*;

import java.io.Serializable;
import java.sql.*;

@SuppressWarnings("serial")
public class processEditProfileDB implements Serializable {
	public UserDetails updateUserToDB(UserDetails userData, String newEmail, String password, String firstName, String lastName, String phone, String Address1, String Address2, String City, String State, String postalCode, String Country, String currentEmail, String sqlConnUrl) {
		UserDetails user = null;
		passEncryption cryptPass = new passEncryption();
		final String secretKey = "ssshhhhhhhhhhh!!!!";
		
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
			String updateStr = "UPDATE Users SET Email = ?, Password = ?, FirstName = ?, LastName = ?, Phone = ?, Address1 = ?, Address2 = ?, City = ?, State = ?, PostalCode = ?, Country = ? WHERE Email = ?;";
			PreparedStatement pstmt = conn.prepareStatement(updateStr);

			pstmt.setString(1, newEmail);
			pstmt.setString(2, cryptPass.encrypt(password, secretKey));
			pstmt.setString(3, firstName);
			pstmt.setString(4, lastName);
			pstmt.setString(5, phone);
			pstmt.setString(6, Address1);
			pstmt.setString(7, Address2);
			pstmt.setString(8, City);
			pstmt.setString(9, State);
			pstmt.setString(10, postalCode);
			pstmt.setString(11, Country);
			pstmt.setString(12, currentEmail);

			insert = pstmt.executeUpdate();
			
			conn.close();
		} catch (SQLException e) {
			System.err.println("Error :" + e);
		}
		
		if (insert > 0) {
			user = userData;
			user.setUserEmail(newEmail);
			user.setUserPassword(cryptPass.decrypt(password, secretKey));
			user.setUserFirstName(firstName);
			user.setUserLastName(lastName);
			user.setUserPhone(phone);
			user.setUserAddress(Address1);
			user.setUserAddress2(Address2);
			user.setUserCity(City);
			user.setUserState(State);
			user.setUserPostalCode(postalCode);
			user.setUserCountry(Country);
			return user;
		} else {
			return userData;
		}
	}
}
