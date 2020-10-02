package fusionTechUserModel;

import java.io.Serializable;

@SuppressWarnings("serial")
public class UserAddresses implements Serializable {

	private int databaseIndex, customerID, orderID;
	private String firstName, lastName, addressLine1, addressLine2, Country, State, postalCode;
	private char contactlessDelivery;

	public void setDatabaseIndex(int databaseIndex) {
		this.databaseIndex = databaseIndex;
	}

	public void setCustomerID(int customerID) {
		this.customerID = customerID;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public void setAddressLine1(String addressLine1) {
		this.addressLine1 = addressLine1;
	}

	public void setAddressLine2(String addressLine2) {
		this.addressLine2 = addressLine2;
	}

	public void setCountry(String Country) {
		this.Country = Country;
	}

	public void setState(String State) {
		this.State = State;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}

	public void setDeliveryType(char contactlessDelivery) {
		this.contactlessDelivery = contactlessDelivery;
	}

	public int getDatabaseIndex() {
		return this.databaseIndex;
	}

	public int getCustomerID() {
		return this.customerID;
	}

	public String getFirstName() {
		return this.firstName;
	}

	public String getLastName() {
		return this.lastName;
	}

	public String getAddressLine1() {
		return this.addressLine1;
	}

	public String getAddressLine2() {
		return this.addressLine2;
	}

	public String getCountry() {
		return this.Country;
	}

	public String getState() {
		return this.State;
	}

	public String getPostalCode() {
		return this.postalCode;
	}

	public char getDeliveryType() {
		return this.contactlessDelivery;
	}

	/*
	 * (Optional) Method below is used to get the order id so we can link it with the user
	 * orders in the user's current session
	 */
	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}

	public int getOrderID() {
		return this.orderID;
	}
}
