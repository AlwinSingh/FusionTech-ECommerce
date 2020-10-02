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
import fusionTechUserModel.UserDetails;
import fusionTechUserModel.UserOrdersFromDB;
import shoppingCart.orderDetails;

/**
 * Servlet implementation class adminGetAllOrders
 */
@WebServlet("/adminGetAllOrders")
public class adminGetAllOrders extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public adminGetAllOrders() {
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

		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllOrders.jsp?errCode=101";

		try {
			HttpSession session = request.getSession();
			ArrayList<orderDetails> adminOrdersList = null;
			ArrayList<allProducts> adminOrderItemsList = null;
			SQLString sqlStr = new SQLString();
			UserDetails user = (UserDetails) session.getAttribute("userData");
			// This defines the UserDetailsDB utility class
			// Essentially, what this utility does is ping the database and make use of the
			// setter methods to load the arraylist into the allCategories ('categoryList')
			// object.
			
			if (user != null && user.getUserType().contentEquals("admin")) {
			UserOrdersFromDB ordersFromDB = new UserOrdersFromDB();
			// Now we can load'categoryList' with the utility class that returns a
			// allCategories arraylist object with the set methods already used (E.g. the
			// values are alrdy loaded through the utility)
			adminOrdersList = ordersFromDB.adminGetAllOrdersFromDB(sqlStr.getSQLConnString());

			if (adminOrdersList.size() > 0) {
				adminOrderItemsList = ordersFromDB.adminGetOrderItemsFromDB(sqlStr.getSQLConnString());
			}

			session.setAttribute("adminOrdersList", adminOrdersList);
			session.setAttribute("adminOrderItemsList", adminOrderItemsList);
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllOrders.jsp";
			} else {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=unauthorised";
			}
		} catch (Exception e) {
			System.out.println("[Servlet / Admin] Orders Retrieval Error: " + e);
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllOrders.jsp?errCode=101";
		} finally {
			response.sendRedirect(redirectURL);
		}
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
