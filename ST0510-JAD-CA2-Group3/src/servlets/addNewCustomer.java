package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;
import java.io.*;
import java.security.*;
import passEncryption.*;
import fusionTechUserModel.UserDetails;
import fusionTechUserModel.addCustomerToDB;

/**
 * Servlet implementation class addNewCustomer
 */
@WebServlet("/addNewCustomer")
public class addNewCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public addNewCustomer() {
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
		final String secretKey = "ssshhhhhhhhhhh!!!!";
		passEncryption cryptPass = new passEncryption();
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminCreateCustomer.jsp?addCustomer=false";

		try {
			HttpSession session = request.getSession();
			UserDetails user = (UserDetails) session.getAttribute("userData");

			if (user != null && user.getUserType().contentEquals("admin")) {
				String Email = (request.getParameter("customerEmail").toString()).toLowerCase();
				String Password = request.getParameter("password").toString();
				Password = cryptPass.encrypt(Password, secretKey);
				String FirstName = request.getParameter("firstName").toString();
				String LastName = request.getParameter("lastName").toString();
				int userRole = Integer.parseInt(request.getParameter("userRole"));
				int Phone = Integer.parseInt(request.getParameter("phoneNumber").toString());
				String Address1 = request.getParameter("address1").toString();
				String Address2 = request.getParameter("address2").toString();
				String City = request.getParameter("city").toString();
				String State = request.getParameter("state").toString();
				int PostalCode = Integer.parseInt(request.getParameter("postalCode"));
				String Country = request.getParameter("country").toString();

				SQLString sqlConnUrl = new SQLString();
				addCustomerToDB addCustomer = new addCustomerToDB();
				boolean insertStatus = addCustomer.addCustomer(Email, Password, FirstName, LastName, userRole, Phone,
						Address1, Address2, City, State, PostalCode, Country, sqlConnUrl.getSQLConnString());

				if (insertStatus) {
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminDashboard.jsp?addCustomer=true";
				} else {
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminCreateCustomer.jsp?addCustomer=false";
				}
			} else {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=unauthorised";
			}
		} catch (Exception e) {
			System.out.println("[Servlet / Admin] Add New Customer Error: " + e);
			System.out.println("[Servlet / Admin] Add New Customer Error: " + e.getMessage());
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminCreateCustomer.jsp?addCustomer=false";
		} finally {
			response.sendRedirect(redirectURL);
		}
	}
}
