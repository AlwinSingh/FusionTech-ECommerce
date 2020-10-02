package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechUserModel.*;

/**
 * Servlet implementation class viewAllCustomer
 */
@WebServlet("/getAllCustomers")
public class getAllCustomers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getAllCustomers() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String tableType = request.getParameter("buttonValue");
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminInquireReportCustomers.jsp?errorCode=400";

		try {
			if(request.getParameter("buttonValue") == null) {
				tableType = "default";
			}

			if (tableType.equals("VAC") || tableType.equals("default") ) {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllCustomers.jsp";
			} else {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllCustomers.jsp?inquireReport="
						+ tableType;
			}

			HttpSession session = request.getSession();
			SQLString sqlStr = new SQLString();
			ArrayList<UserDetails> customersList = new ArrayList<UserDetails>();
			getInquireReportCustomersFromDB inquireReportCustomers = new getInquireReportCustomersFromDB();
			customersList = inquireReportCustomers.inquireCustomers(tableType, sqlStr.getSQLConnString());

			
			session.setAttribute("customersList", customersList);
			// RequestDispatcher rd =
			// request.getRequestDispatcher("/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllCustomer.jsp");
			// rd.forward(request, response);

		} catch (Exception e) {
			System.out.println("[Servlet Inquire/Report Customers (Admin)]: " + e);
			System.out.println("[Servlet Inquire/Report Customers (Admin)]: " + e.getMessage());

			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllCustomers.jsp?errorCode=400";
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
