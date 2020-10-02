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
import fusionTechUserModel.updateCustomerFromDB;

/**
 * Servlet implementation class logoutUser
 */
@WebServlet("/logoutUser")
public class logoutUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public logoutUser() {
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

		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/Login.jsp";
		HttpSession session = request.getSession();
		
		try {
			boolean updateStatus = false;
			SQLString sqlConnUrl = new SQLString();
			UserDetails user = (UserDetails) session.getAttribute("userData");
			updateCustomerFromDB updateCustomer = new updateCustomerFromDB();
			updateStatus = updateCustomer.updateCustomerCurrency(user.getUserID(), user.getUserCurrency(),
					sqlConnUrl.getSQLConnString());

			if (updateStatus) {
				session.invalidate();
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/Login.jsp";
			} else {
				session.invalidate();
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/Login.jsp?code=615";
			}
		} catch (Exception e) {
			session.invalidate();
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/Login.jsp?code=615";
			System.out.println("Servlet logout error!");
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
