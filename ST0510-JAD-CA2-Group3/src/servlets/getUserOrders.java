package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechProductModel.allProducts;
import fusionTechUserModel.UserAddresses;
import fusionTechUserModel.UserAddressesFromDB;
import fusionTechUserModel.UserDetails;
import fusionTechUserModel.UserOrdersFromDB;
import shoppingCart.orderDetails;

/**
 * Servlet implementation class getUserOrders
 */
@WebServlet("/getUserOrders")
public class getUserOrders extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public getUserOrders() {
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

		HttpSession session = request.getSession();
		ArrayList<orderDetails> ordersList = new ArrayList<orderDetails>();
		ArrayList<allProducts> orderItemsList = new ArrayList<allProducts>();
		ArrayList<UserAddresses> orderShippingInfoList = new ArrayList<UserAddresses>();
		UserDetails user = (UserDetails) session.getAttribute("userData");
		SQLString sqlStr = new SQLString();
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=notLoggedIn";

		/*
		 * try { customerId = user.getUserID(); } catch (Exception e) {
		 * response.sendRedirect(
		 * "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=notLoggedIn"
		 * ); return; }
		 */

		if (user != null) {
			try {
				// This defines the UserDetailsDB utility class
				// Essentially, what this utility does is ping the database and make use of the
				// setter methods to load the arraylist into the allCategories ('categoryList')
				// object.
				UserOrdersFromDB ordersFromDB = new UserOrdersFromDB();
				// Now we can load'categoryList' with the utility class that returns a
				// allCategories arraylist object with the set methods already used (E.g. the
				// values are alrdy loaded through the utility)
				ordersList = ordersFromDB.getOrdersFromDB(user.getUserID(), sqlStr.getSQLConnString());

				if (ordersList.size() > 0) {
					orderItemsList = ordersFromDB.getOrderItemsFromDB(user.getUserID(), sqlStr.getSQLConnString());
				}
				
				if (orderItemsList.size() > 0) {
					UserAddressesFromDB addressesFromDB = new UserAddressesFromDB();
					orderShippingInfoList = addressesFromDB.getAddressesListForOrdersFromDB(user.getUserID(), sqlStr.getSQLConnString());
				}

				session.setAttribute("ordersList", ordersList);
				session.setAttribute("orderItemsList", orderItemsList);
				session.setAttribute("orderShippingInfoList", orderShippingInfoList);
				
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/viewOrders.jsp";
			} catch (Exception e) {
				System.out.println("Orders Retrieval Error: " + e);
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/viewOrders.jsp?errCode=101";
			}
		} else {
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=notLoggedIn";
		}

		response.sendRedirect(redirectURL);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
