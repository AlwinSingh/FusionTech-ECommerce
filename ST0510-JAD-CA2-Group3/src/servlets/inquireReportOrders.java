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
 * Servlet implementation class inquireReportOrders
 */
@WebServlet("/inquireReportOrders")
public class inquireReportOrders extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public inquireReportOrders() {
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

		String filterValue = request.getParameter("filterInputValue");
		String tableType = request.getParameter("buttonValue");
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllOrders.jsp?errorCode=400";

		try {
			HttpSession session = request.getSession();
			SQLString sqlStr = new SQLString();
			UserDetails user = (UserDetails) session.getAttribute("userData");
			ArrayList<orderDetails> adminOrdersReportingList = null;
			ArrayList<allProducts> adminOrderItemsList = null;

			if (user != null && user.getUserType().contentEquals("admin")) {
				if (request.getParameter("buttonValue") == null) {
					tableType = "default";
				}
				if (tableType.equals("default")) {
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllOrders.jsp";
				} else {
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllOrders.jsp?inquireReport="
							+ tableType;
				}

				UserOrdersFromDB inquireReportOrders = new UserOrdersFromDB();
				adminOrdersReportingList = inquireReportOrders.adminOrderReportsFromDB(tableType, filterValue,
						sqlStr.getSQLConnString());

				if (adminOrdersReportingList.size() > 0) {
					adminOrderItemsList = inquireReportOrders.adminGetOrderItemsFromDB(sqlStr.getSQLConnString());
				}

				session.setAttribute("adminOrdersList", adminOrdersReportingList);
				session.setAttribute("adminOrderItemsList", adminOrderItemsList);
			} else {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=unauthorised";
			}
		} catch (Exception e) {
			System.out.println("[Servlet Inquire/Report Orders (Admin)]: " + e);
			System.out.println("[Servlet Inquire/Report Orders (Admin)]: " + e.getMessage());
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllOrders.jsp?errorCode=400";
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
