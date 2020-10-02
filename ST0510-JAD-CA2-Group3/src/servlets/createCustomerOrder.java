package servlets;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

//import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechUserModel.*;
import shoppingCart.AddCartItemsToOrder;
import shoppingCart.AddCustomerOrderInformationToDB;
import shoppingCart.orderDetails;
import shoppingCart.shoppingCart;

/**
 * Servlet implementation class createCustomerOrder
 */
@WebServlet("/createCustomerOrder")
public class createCustomerOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public createCustomerOrder() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);

		boolean cardVerification = false;
		String cardType = null;
		String cardNumber = request.getParameter("cc-number");
		String cardExpiryYear = request.getParameter("cc-exp-year");
		String cardExpiryMonth = request.getParameter("cc-exp-month");
		String cardHolderName = request.getParameter("cc-name");
		// String cardCVV = request.getParameter("cc-cvv");

		String shipperFirstName = request.getParameter("shippingFirstName");
		String shipperLastName = request.getParameter("shippingLastName");
		String shippingAddressLine1 = request.getParameter("shippingAddress");
		String shippingAddressLine2 = request.getParameter("shippingAddress2");
		String shippingCountry = request.getParameter("shippingCountry");
		String shippingState = request.getParameter("shippingState");
		// String shippingCountry = "Singapore";
		// String shippingState = "Singapore";
		String shippingPostalCode = request.getParameter("shippingPostalCode");
		String shippingdeliveryStatus = request.getParameter("contactless-delivery");
		char shippingdeliveryMode = 'N';

		if (shippingdeliveryStatus != null) {
			if (shippingdeliveryStatus != "") {
				if (shippingdeliveryStatus.contentEquals("on")) {
					shippingdeliveryMode = 'Y';
				} else {
					shippingdeliveryMode = 'N';
				}
			} else {
				shippingdeliveryMode = 'N';
			}
		}

		System.out.println(shippingdeliveryMode);

		HttpSession session = request.getSession();
		UserDetails user = (UserDetails) session.getAttribute("userData");
		AddCartItemsToOrder addToOrder = new AddCartItemsToOrder();

		if (user != null) {
			Date today = new Date();
			Calendar cal = Calendar.getInstance();
			cal.setTime(today);
			int currentMonth = cal.get(Calendar.MONTH) + 1;
			int currentYear = cal.get(Calendar.YEAR);

			if (Integer.parseInt(cardExpiryYear) < currentYear) {
				cardVerification = false;
			} else if (Integer.parseInt(cardExpiryYear) == currentYear) {

				if (Integer.parseInt(cardExpiryMonth) <= currentMonth) {
					cardVerification = false;
				} else {
					cardVerification = true;
				}

			} else {
				cardVerification = true;
			}

			if (cardVerification) {
				switch (cardNumber) {
				// Global Cards
				case "378282246310005":
					cardVerification = true;
					cardType = "American Express";
					break;

				case "371449635398431":
					cardVerification = true;
					cardType = "American Express";
					break;

				case "378734493671000":
					cardVerification = true;
					cardType = "American Express Corporate";
					break;

				case "5610591081018250":
					cardVerification = true;
					cardType = "Australian Bankcard";
					break;

				case "30569309025904":
					cardVerification = true;
					cardType = "Diners Club";
					break;

				case "38520000023237":
					cardVerification = true;
					cardType = "Diners Club";
					break;

				case "6011111111111117":
					cardVerification = true;
					cardType = "Discover";
					break;

				case "6011000990139424":
					cardVerification = true;
					cardType = "Discover";
					break;

				case "3530111333300000":
					cardVerification = true;
					cardType = "JCB";
					break;

				case "3566002020360505":
					cardVerification = true;
					cardType = "JCB";
					break;

				case "5555555555554444":
					cardVerification = true;
					cardType = "MasterCard";
					break;

				case "5105105105105100":
					cardVerification = true;
					cardType = "MasterCard";
					break;

				case "4111111111111111":
					cardVerification = true;
					cardType = "Visa";
					break;

				case "4012888888881881":
					cardVerification = true;
					cardType = "Visa";
					break;

				case "4222222222222":
					cardVerification = true;
					cardType = "Visa";
					break;

				// Processor Specific Cards
				case "76009244561":
					cardVerification = true;
					cardType = "Dankort (PBS)";
					break;

				case "5019717010103742":
					cardVerification = true;
					cardType = "Dankort (PBS)";
					break;

				case "6331101999990016":
					cardVerification = true;
					cardType = "Switch / Solo (Paymentech)";
					break;

				default:
					cardVerification = false;
					cardType = null;
					break;
				}
			} else {

				session.setAttribute("shipperFirstName", shipperFirstName);
				session.setAttribute("shipperLastName", shipperLastName);
				session.setAttribute("shippingAddressLine1", shippingAddressLine1);
				session.setAttribute("shippingAddressLine2", shippingAddressLine2);
				session.setAttribute("shippingPostalCode", shippingPostalCode);
				session.setAttribute("cardHolderName", cardHolderName);

				response.sendRedirect(
						"/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/shoppingCart.jsp?payment=invalid");
				return;
			}

			// System.out.println(cardVerification);

			if (cardVerification) {
				if (session.getAttribute("shoppingCart") != null) {
					ArrayList<shoppingCart> cartList = new ArrayList<shoppingCart>();
					cartList = (ArrayList<shoppingCart>) session.getAttribute("shoppingCart");

					SQLString sqlStr = new SQLString();
					double paymentAmount = Double.parseDouble(request.getParameter("getPaymentValue"));
					String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/ThankYou.jsp?checkout=true";
					String sameAddressValue = request.getParameter("same-address");
					// System.out.println("Same address: " +sameAddressValue);
					
					if (sameAddressValue != null) {
						if (sameAddressValue != "") {
							if (sameAddressValue.contentEquals("on")) {
								sameAddressValue = "on";
							}
						} else {
							sameAddressValue = "off";
						}
					} else {
						sameAddressValue = "off";
					}

					if (paymentAmount > 0) {
						boolean addOrderStatus = false;
						boolean addOrderShippingStatus = false;
						boolean addOrderBillingStatus = false;

						UserDetails userData = new UserDetails();
						userData = (UserDetails) session.getAttribute("userData");

						AddCustomerOrderInformationToDB addOrderToDB = new AddCustomerOrderInformationToDB();

						try {
							int billingId = 0, shippingId = 0;
							// System.out.println("Reaches here...");
							addOrderShippingStatus = addOrderToDB.addOrderShipping(userData.getUserID(),
									shipperFirstName, shipperLastName, shippingAddressLine1, shippingAddressLine2,
									shippingCountry, shippingState, shippingPostalCode, shippingdeliveryMode,
									sqlStr.getSQLConnString());
							//System.out.println("1. Reaches here...");

							if (addOrderShippingStatus) {
								//System.out.println("Same address value: " +sameAddressValue);
								if (sameAddressValue.equals("on")) {
									addOrderBillingStatus = addOrderToDB.addOrderBilling(userData.getUserID(),
											shipperFirstName, shipperLastName, shippingAddressLine1,
											shippingAddressLine2, shippingCountry, shippingState, shippingPostalCode,
											sqlStr.getSQLConnString());
									billingId = addToOrder.getBillingIndex(user.getUserID(), shippingAddressLine1,
											shippingAddressLine2, shippingCountry, shippingPostalCode,
											sqlStr.getSQLConnString());
									System.out.println("2. Reaches here...");
								} else {
									//System.out.println("handling billing");
									String billerFirstName = request.getParameter("billingFirstName");
									String billerLastName = request.getParameter("billingLastName");
									String billerAddressLine1 = request.getParameter("billingAddress");
									String billerAddressLine2 = request.getParameter("billingAddress2");
									String billerCountry = request.getParameter("billingCountry");
									String billerState = request.getParameter("billingState");
									// String billerCountry = "Singapore";
									// String billerState = "Singaporez";
									String billerPostalCode = request.getParameter("billingPostalCode");
									addOrderBillingStatus = addOrderToDB.addOrderBilling(userData.getUserID(),
											billerFirstName, billerLastName, billerAddressLine1, billerAddressLine2,
											billerCountry, billerState, billerPostalCode, sqlStr.getSQLConnString());
									billingId = addToOrder.getBillingIndex(user.getUserID(), billerAddressLine1,
											billerAddressLine2, billerCountry, billerPostalCode,
											sqlStr.getSQLConnString());
									 //System.out.println("3. Reaches here...");
								}
							}
							
							//System.out.println("Add billing: " +addOrderBillingStatus);

							if (addOrderBillingStatus) {
								shippingId = addToOrder.getShippingIndex(user.getUserID(), shippingAddressLine1,
										shippingAddressLine2, shippingCountry, shippingPostalCode,
										sqlStr.getSQLConnString());
								System.out.println("4. Reaches here...");
								addOrderStatus = addOrderToDB.addOrder(userData.getUserID(), cardType, paymentAmount,
										userData.getUserCurrency(), sqlStr.getSQLConnString(), shippingId, billingId);
							}

							if (addOrderStatus) {
								orderDetails orderDetail = addToOrder.getOrderDetails(userData.getUserID(),
										sqlStr.getSQLConnString());

								addOrderStatus = addToOrder.orderItemsToCart(orderDetail.getOrderID(), cartList,
										sqlStr.getSQLConnString());

								if (addOrderStatus) {
									//System.out.println("Order ID: " + orderDetail.getOrderID());
									session.setAttribute("successOrderID", orderDetail.getOrderID());
									session.setAttribute("orderDate", orderDetail.getOrderDate());
									session.setAttribute("paymentMethod", orderDetail.getPaymentMethod());
									session.setAttribute("couponCode", orderDetail.getCouponCode());
									session.setAttribute("orderStatus", orderDetail.getOrderStatus());
									// Redirect to the Thank You page and retrieve Cookies there
									redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/ThankYou.jsp?checkout=true";
								} else {
									redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/ThankYou.jsp?checkout=false";
								}
							}
						} catch (Exception e) {
							System.out.println("[Servlet / User] CREATE CUSTOMER ORDER: " + e);
							redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/ThankYou.jsp?checkout=false";
						}

						response.sendRedirect(redirectURL);
					} else {
						redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/ThankYou.jsp?checkout=false";
						response.sendRedirect(redirectURL);
					}
				} else {
					response.sendRedirect(
							"/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/shoppingCart.jsp?checkout=false&cart=empty");
					return;
				}

			} else {

				session.setAttribute("shipperFirstName", shipperFirstName);
				session.setAttribute("shipperLastName", shipperLastName);
				session.setAttribute("shippingAddressLine1", shippingAddressLine1);
				session.setAttribute("shippingAddressLine2", shippingAddressLine2);
				session.setAttribute("shippingPostalCode", shippingPostalCode);
				session.setAttribute("cardHolderName", cardHolderName);

				response.sendRedirect(
						"/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/shoppingCart.jsp?payment=invalid");
				return;
			}
		} else {
			response.sendRedirect(
					"/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=unauthorised");
		}
	}
}
