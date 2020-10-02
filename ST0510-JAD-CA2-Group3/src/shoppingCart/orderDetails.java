package shoppingCart;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.Locale;

@SuppressWarnings("serial")
public class orderDetails implements Serializable {
	
	private int OrderID, CustomerID, orderQty;
	private double OrderProfit;
	private String OrderDate, ShippedDate, ExpectedDate, Status, PaymentMethod, PaymentAmount, CouponCode, currencySymbol, inquiryType, orderMonth;
	
	public void setOrderDetails(int OrderID, int CustomerID, String OrderDate, String ShippedDate, String ExpectedDate, String Status, String PaymentMethod, String PaymentAmount, String CouponCode) {
		this.OrderID = OrderID;
		this.CustomerID = CustomerID;
		this.OrderDate = OrderDate;
		this.ShippedDate = ShippedDate;
		this.ExpectedDate = ExpectedDate;
		this.Status = Status;
		this.PaymentMethod = PaymentMethod;
		this.PaymentAmount = PaymentAmount;
		this.CouponCode = CouponCode;
	}
	
	public String getInquiryType() {
		return this.inquiryType;
	}
	
	public void setInquiryType(String inquiryType) {
		 this.inquiryType = inquiryType;
	}
	
	public String getOrderCurrencySymbol() {
		return this.currencySymbol;
	}
	
	public void setOrderCurrencySymbol(String currencySymbol) {
		this.currencySymbol = currencySymbol;
	}
	
	public int getOrderID() {
		return this.OrderID;
	}
	
	public int getCustomerID() {
		return this.CustomerID;
	}
	
	public String getOrderMonth() {
		return this.orderMonth;
	}
	
	public String getOrderDate() {
		return this.OrderDate;
	}
	
	public String getShippedDate() {
		return this.ShippedDate;
	}
	
	public String getExpectedDate() {
		return this.ExpectedDate;
	}
	
	public String getPaymentMethod() {
		return this.PaymentMethod;
	}
	
	public String getPaymentAmount() {
		return this.PaymentAmount;
	}
	
	public String getCouponCode() {
		return this.CouponCode;
	}
	
	public String getOrderStatus() {
		return this.Status;
	}
	
	//Below methods are used for analytical queries for Orders Reporting
	public void setOrderProfit(double OrderProfit) {
		this.OrderProfit = OrderProfit;
	}
	
	public double getOrderProfit() {
		return this.OrderProfit;
	}

	public void setOrderMonth(String orderMonth) {
		this.orderMonth = orderMonth;
	}
	
	public void setOrderQuantity(int orderQty) {
		this.orderQty = orderQty;
	}
	
	public int getOrderQuantity() {
		return this.orderQty;
	}
}
