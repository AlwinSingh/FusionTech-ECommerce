package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechUserModel.UserAddresses;
import fusionTechUserModel.UserAddressesFromDB;
import fusionTechUserModel.UserDetails;

/**
 * Servlet implementation class getUserAddresses
 */
@WebServlet("/getUserAddresses")
public class getUserAddresses extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public getUserAddresses() {
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
		ArrayList<UserAddresses> addressList = new ArrayList<UserAddresses>();
		UserDetails user = (UserDetails) session.getAttribute("userData");
		SQLString sqlStr = new SQLString();
		String editCode = request.getParameter("editCode");
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/editUserAddresses.jsp?errCode=101";

		if (user != null) {
			try {
				// This defines the UserDetailsDB utility class
				// Essentially, what this utility does is ping the database and make use of the
				// setter methods to load the arraylist into the allCategories ('categoryList')
				// object.
				UserAddressesFromDB addressesFromDB = new UserAddressesFromDB();

				// Now we can load'categoryList' with the utility class that returns a
				// allCategories arraylist object with the set methods already used (E.g. the
				// values are alrdy loaded through the utility)
				addressList = addressesFromDB.getAddressesFromDB(user.getUserID(), sqlStr.getSQLConnString());

				session.setAttribute("addressList", addressList);

				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/editUserAddresses.jsp?editCode="
						+ editCode;

			} catch (Exception e) {
				System.out.println("Addresses Retrieval Error: " + e);
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/editUserAddresses.jsp?errCode=101";
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
