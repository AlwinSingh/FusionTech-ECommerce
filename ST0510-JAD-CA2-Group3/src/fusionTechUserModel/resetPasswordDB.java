package fusionTechUserModel;

import java.io.Serializable;
import java.sql.*;
import sendEmail.*;
import passEncryption.passEncryption;

@SuppressWarnings("serial")
public class resetPasswordDB implements Serializable {

	public boolean verifyResetPassword(String email, String sqlConnUrl) {
	sendEmail dispatchPasswordEmail = new sendEmail();
	passEncryption cryptPass = new passEncryption();
	final String secretKey = "ssshhhhhhhhhhh!!!!";
	String userLoginEmail = email;
	String newUserPassword = dispatchPasswordEmail.generatePassword();
	String newUserPasswordEncrypted = cryptPass.encrypt(newUserPassword, secretKey);
	boolean resetPassStatus = false;

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
		String updateStr = "UPDATE Users SET Password = ? WHERE Email = ?";
		PreparedStatement pstmt = conn.prepareStatement(updateStr);

		pstmt.setString(1, newUserPasswordEncrypted);
		pstmt.setString(2, userLoginEmail);

		int update = pstmt.executeUpdate();

		if (update > 0) {
			dispatchPasswordEmail.dispatchEmail(userLoginEmail, newUserPassword);
			resetPassStatus = true;
		} else {
			resetPassStatus = false;
		}

		//STEP 7
		conn.close();
	} catch (SQLException e) {
		resetPassStatus = false;
		System.out.println("ERROR: " + e);
	}

	return resetPassStatus;
	}
}
