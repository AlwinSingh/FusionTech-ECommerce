package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechUserModel.UserAddressesFromDB;
import fusionTechUserModel.UserDetails;

/**
 * Servlet implementation class manageUserAddresses
 */
@WebServlet("/UpdateUserAddresses")
public class UpdateUserAddresses extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateUserAddresses() {
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

		String formAction = request.getParameter("userAddressFormAction");
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/editUserAddresses.jsp?editCode=false";
		HttpSession session = request.getSession();
		UserAddressesFromDB updateUserAddress = new UserAddressesFromDB();
		SQLString sqlConnUrl = new SQLString();
		UserDetails user = (UserDetails) session.getAttribute("userData");

		// System.out.println("Form Action [User addresses]: " + formAction);

		if (user != null) {
			if (formAction.contentEquals("delete")) {
				try {
					int deleteCount = 0;
					int deliveryId = Integer.parseInt(request.getParameter("addressId"));
					deleteCount = updateUserAddress.deleteAddressFromDB(user.getUserID(), deliveryId,
							sqlConnUrl.getSQLConnString());

					if (deleteCount > 0) {
						redirectURL = "/ST0510-JAD-CA2-Group3/getUserAddresses?editCode=true";
					} else {
						redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/editUserAddresses.jsp?editCode=false";
					}

				} catch (Exception e) {
					System.out.println("[Delete User Address Servlet]: " + e);
				}

			} else if (formAction.contentEquals("update")) {
				boolean updateStatus = false;
				try {
					String firstName = request.getParameter("firstName");
					String lastName = request.getParameter("lastName");
					String addressLine1 = request.getParameter("Address1");
					String addressLine2 = request.getParameter("Address2");
					String Country = request.getParameter("Country");
					String State = request.getParameter("State");
					String PostalCode = request.getParameter("PostalCode");
					// String contactlessDelivery = request.getParameter("ContactlessDelivery");
					char contactlessDelivery = 'Y';
					int deliveryId = Integer.parseInt(request.getParameter("addressId"));

					updateStatus = updateUserAddress.updateUserAddressesToDB(sqlConnUrl.getSQLConnString(), firstName,
							lastName, addressLine1, addressLine2, Country, State, PostalCode, contactlessDelivery,
							deliveryId, user.getUserID());

					if (updateStatus) {
						// redirectURL =
						// "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/editUserAddresses.jsp?editCode=true";
						redirectURL = "/ST0510-JAD-CA2-Group3/getUserAddresses?editCode=true";
					} else {
						redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/editUserAddresses.jsp?editCode=false";
					}

				} catch (Exception e) {
					System.out.println("[Update User Address Servlet]: " + e);
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/editUserAddresses.jsp?editCode=false";
				}
			}
		} else {
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=notLoggedIn";
		}

		response.sendRedirect(redirectURL);
	}
}
