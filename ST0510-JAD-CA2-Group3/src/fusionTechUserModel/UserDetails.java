package fusionTechUserModel;

import java.io.Serializable;

@SuppressWarnings("serial")
public class UserDetails implements Serializable {
	
	String userType, userEmail, userFirstName, userLastName, userPass, userPhone, userAddress, userAddress2, userCity, userState, userCountry, userPostalCode, userCurrency;
	int userId;
	
	
	public void setUser(String userType, String userEmail, int userId, String userFirstName, String userLastName, String userPass, String userPhone, String userAddress, String userAddress2, String userCity, String userState, String userCountry, String userPostalCode) {
		this.userType = userType;
		this.userEmail = userEmail;
		this.userFirstName = userFirstName;
		this.userLastName = userLastName;
		this.userPass = userPass;
		this.userPhone = userPhone;
		this.userAddress = userAddress;
		this.userAddress2 = userAddress2;
		this.userCity = userCity;
		this.userState = userState;
		this.userCountry = userCountry;
		this.userPostalCode = userPostalCode;
		this.userId = userId;
	}
	
	/* User Currency methods */
	public void setUserCurrency(String userCurrency) {
		this.userCurrency = userCurrency;
	}
	
	public String getUserCurrency() {
		return this.userCurrency;
	}
	/* end of user currency methods */
	
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public void setUserType(String userType) {
		this.userType = userType;
	}
	
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	
	public void setUserFirstName(String userFirstName) {
		this.userFirstName = userFirstName;
	}
	
	public void setUserLastName(String userLastName) {
		this.userLastName = userLastName;
	}
	
	public void setUserPassword(String userPassword) {
		this.userPass = userPassword;
	}
	
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	
	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}
	
	public void setUserAddress2(String userAddress2) {
		this.userAddress2 = userAddress2;
	}
	
	public void setUserCity(String userCity) {
		this.userCity = userCity;
	}
	
	public void setUserState(String userState) {
		this.userState = userState;
	}
	
	public void setUserCountry(String userCountry) {
		this.userCountry = userCountry;
	}
	
	public void setUserPostalCode(String userPostalCode) {
		this.userPostalCode = userPostalCode;
	}
	
	public int getUserID() {
		return this.userId;
	}
	
	public String getUserType() {
		return this.userType;
	}
	
	public String getUserEmail() {
		return this.userEmail;
	}
	
	public String getUserFirstName() {
		return this.userFirstName;
	}
	
	public String getUserLastName() {
		return this.userLastName;
	}
	
	public String getUserPass() {
		return this.userPass;
	}
	
	public String getUserPhone() {
		return this.userPhone;
	}
	
	public String getUserAddress() {
		return this.userAddress;
	}
	
	public String getUserAddress2() {
		return this.userAddress2;
	}
	
	public String getUserCity() {
		return this.userCity;
	}
	
	public String getUserState() {
		return this.userState;
	}
	
	public String getUserCountry() {
		return this.userCountry;
	}
	
	public String getUserPostalCode() { 
		return this.userPostalCode;
	}
	
}
