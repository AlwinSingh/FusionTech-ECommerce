package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechUserModel.UserDetails;
import fusionTechUserModel.getAllCustomersFromDB;

/**
 * Servlet implementation class deleteCustomerList
 */
@WebServlet("/deleteCustomerList")
public class deleteCustomerList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteCustomerList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String deleteCustomerStatus = "false";
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminDeleteCustomer.jsp?errorCode=400";

		try {
			deleteCustomerStatus = request.getParameter("delCustomer"); //If the customer update was a success, it will be true
			
			if (deleteCustomerStatus == null) {
				//System.out.println("Null changing values");
				deleteCustomerStatus = "false";
			}
			
		} catch (Exception e) {
			deleteCustomerStatus = "false";
		}
		
		try {
			HttpSession session = request.getSession();
			SQLString sqlStr = new SQLString();
			ArrayList<UserDetails> usersList = new ArrayList<UserDetails>();
			getAllCustomersFromDB getCustomers = new getAllCustomersFromDB();
			usersList = getCustomers.retrieveUsers(sqlStr.getSQLConnString());

			session.setAttribute("usersList", usersList);

			if (deleteCustomerStatus.equals("true")) {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminDeleteCustomer.jsp?delCustomer=true";
			} else {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminDeleteCustomer.jsp";
			}		
		} catch (Exception e) {
			System.out.println("[Servlet Delete Customers (Admin)]: " + e);
			System.out.println("[Servlet Delete Customers (Admin)]: " + e.getMessage());

			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminDeleteCustomer.jsp?errorCode=400";
		} finally {
			response.sendRedirect(redirectURL);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
