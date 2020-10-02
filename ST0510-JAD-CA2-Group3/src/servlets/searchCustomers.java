package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechUserModel.*;

/**
 * Servlet implementation class searchCustomers
 */
@WebServlet("/searchCustomers")
public class searchCustomers extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public searchCustomers() {
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
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllProducts.jsp?errorCode=400";
		String searchValue = request.getParameter("searchCustomers");

		try {
			HttpSession session = request.getSession();
			UserDetails user = (UserDetails) session.getAttribute("userData");
			SQLString sqlStr = new SQLString();

			if (user != null && user.getUserType().contentEquals("admin")) {
				ArrayList<UserDetails> customersList = new ArrayList<UserDetails>();
				searchCustomerFromDB retrieveSearchedCustomer = new searchCustomerFromDB();
				customersList = retrieveSearchedCustomer.retrieveSearchedCustomer(searchValue,
						sqlStr.getSQLConnString());

				session.setAttribute("customersList", customersList);
				// RequestDispatcher rd =
				// request.getRequestDispatcher("/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllCustomer.jsp");
				// rd.forward(request, response);

				if (customersList.size() == 0) {
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllCustomers.jsp?results=NoResults&searchedCustomers="
							+ searchValue;
				} else {
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllCustomers.jsp?searchedCustomers="
							+ searchValue;
				}
			} else {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=unauthorised";
			}
		} catch (Exception e) {

			System.out.println("[Servlet / Admin] Get Searched Customers: " + e);
			System.out.println("[Servlet / Admin] Get Searched Customers: " + e.getMessage());

			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllCustomers.jsp?errorCode=400";
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
