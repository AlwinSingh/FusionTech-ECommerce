package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechUserModel.UserDetails;
import fusionTechUserModel.updateCustomerFromDB;

/**
 * Servlet implementation class updateCustomer
 */
@WebServlet("/updateCustomer")
public class updateCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public updateCustomer() {
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

		String redirectURL = "/ST0510-JAD-CA2-Group3/updateCustomerList";

		try {
			HttpSession session = request.getSession();
			UserDetails user = (UserDetails) session.getAttribute("userData");

			if (user != null && user.getUserType().contentEquals("admin")) {
				int userId = Integer.parseInt(request.getParameter("customerDatabaseId"));
				int userRole = Integer.parseInt(request.getParameter("userRole"));
				int PostalCode = Integer.parseInt(request.getParameter("postalCode"));

				String currentEmail = (request.getParameter("updateBtn").toString()).toLowerCase();
				String newEmail = (request.getParameter("customerEmail").toString()).toLowerCase();
				String FirstName = request.getParameter("firstName").toString();
				String LastName = request.getParameter("lastName").toString();
				String Address1 = request.getParameter("address1").toString();
				String Address2 = request.getParameter("address2").toString();
				String City = request.getParameter("city").toString();
				String State = request.getParameter("state").toString();
				String Country = request.getParameter("country").toString();
				String Phone = request.getParameter("phoneNumber");
				String userRoleName = request.getParameter("userRoleName");
				String originalUserRoleName = user.getUserType();

				SQLString sqlConnUrl = new SQLString();
				updateCustomerFromDB updateCustomer = new updateCustomerFromDB();
				boolean updateStatus = updateCustomer.updateCustomer(currentEmail, newEmail, FirstName, LastName,
						userRole, Phone, Address1, Address2, City, State, PostalCode, Country,
						sqlConnUrl.getSQLConnString());

				if (updateStatus) {
					if (userId == user.getUserID()) {
						user.setUserType(userRoleName);
						user.setUserEmail(newEmail);
						user.setUserFirstName(FirstName);
						user.setUserLastName(LastName);
						user.setUserAddress(Address1);
						user.setUserAddress2(Address2);
						user.setUserCity(City);
						user.setUserState(State);
						user.setUserCountry(Country);
						user.setUserPhone(Phone);

						if (originalUserRoleName == "admin") {
							if (!userRoleName.contentEquals("admin")) {
								redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?UpdateCustomer=true";
							}
						}

						session.setAttribute("userData", user);
					} else {
						redirectURL = "/ST0510-JAD-CA2-Group3/updateCustomerList?UpdateCustomer=true";
					}
				} else {
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminUpdateCustomer.jsp?UpdateCustomer=false";
				}

			} else {
			}
		} catch (Exception e) {
			System.out.println("[Update Customer Error]: " + e);
			System.out.println("[Update Customer Error]: " + e.getMessage());
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminUpdateCustomer.jsp?UpdateCustomer=false";
		} finally {
		response.sendRedirect(redirectURL);
		}
	}

}
