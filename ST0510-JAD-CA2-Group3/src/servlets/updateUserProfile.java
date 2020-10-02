package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechUserModel.*;

/**
 * Servlet implementation class updateUserProfile
 */
@WebServlet("/updateUserProfile")
public class updateUserProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public updateUserProfile() {
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

		HttpSession session = request.getSession();
		SQLString sqlStr = new SQLString();
		// UserDetails getUpdatedUser = null;
		UserDetails user = (UserDetails) session.getAttribute("userData");
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/editProfile.jsp?editCode=true";

		/*
		 * try { customerId = user.getUserID(); } catch (Exception e) { redirectURL =
		 * "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=notLoggedIn";
		 * response.sendRedirect(redirectURL); return; }
		 */

		//performs a check to see if the user exist, if the user session expire / does not exist it will not run the code in the try catch block below
		if (user != null) {
			try {
				//Request the parameter of the form input
				String currentEmail = user.getUserEmail();
				String newEmail = (request.getParameter("userNewEmail")).toLowerCase();
				String password = request.getParameter("userPass");
				String firstName = request.getParameter("userFirstName");
				String lastName = request.getParameter("userLastName");
				String phone = request.getParameter("userPhone");
				String Address1 = request.getParameter("userAddress");
				String Address2 = request.getParameter("userAddress2");
				String City = request.getParameter("userCity");
				String State = request.getParameter("userState");
				String postalCode = request.getParameter("userPostalCode");
				String Country = request.getParameter("userCountry");

				//Call the utility bean to update the details to the DB
				//It will return the user details object again without having to ping the DB via a SELECT statement
				processEditProfileDB processEditProfile = new processEditProfileDB();
				user = processEditProfile.updateUserToDB(user, newEmail, password, firstName, lastName, phone, Address1,
						Address2, City, State, postalCode, Country, currentEmail, sqlStr.getSQLConnString());
				
				//Update the session with the latest user object
				session.setAttribute("userData", user);
			} catch (Exception e) {
				//Catch any errors and print out for debugging + redirect to the appropriate page
				System.out.println("[Update User Profile Servlet]: " + e);
				redirectURL = "/ST0510-JAD-CA1-Group3/J2EE-WebDev/CA1/WebFiles/Pages/editProfile.jsp?editCode=false";
			}
		} else {
			//If the user object does not exist it means users' session expired, bugged or user not logged in and tried to access page via URL then redirect with error in parameter
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=notLoggedIn";
		}

		response.sendRedirect(redirectURL);
	}

}
