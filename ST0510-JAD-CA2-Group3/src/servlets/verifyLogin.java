package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
//import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechProductModel.allProducts;
import fusionTechProductModel.getAllProductsFromDB;
import fusionTechUserModel.*;

/**
 * Servlet implementation class verifyLogin
 */
@WebServlet("/verifyLogin")
public class verifyLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public verifyLogin() {
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
		UserDetails verifyUserLogin = null;
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/Login.jsp?errCode=invalidLogin";
		boolean loginStatus = false;

		try {
			// This retrieves the form input parameter of 'inputUserEmail' and 'inputUserPass'
			String userLoginEmail = (request.getParameter("inputUserEmail")).toLowerCase();
			String userLoginPass = request.getParameter("inputUserPass");
			
			// This defines the VerifyUserLoginDB Utility Bean, allows us to access the methods we defined in it.
			// It will primarily be used for the retrieval of DB data
			VerifyUserLoginDB verifyLoginByDB = new VerifyUserLoginDB();
			
			// As our method we call bellw ('verifyUserLoginFromDB') returns a UserDetails object, we pass it into 'verifyUserLogin' that is a User Details object
			verifyUserLogin = verifyLoginByDB.verifyUserLoginFromDB(userLoginEmail, userLoginPass,
					sqlStr.getSQLConnString());

			
			//We perform a check to see if it is null / invalid, if it isn't run the code below else it will redirect with an error
			if (verifyUserLogin != null) {
				//If login successful, reset cart
				session.removeAttribute("shoppingCart");
				
				//Sets the session if successful login
				session.setAttribute("userData", verifyUserLogin);

				//Specifies the redirect path
				redirectURL = "CurrencyConverter?convertTo=" +verifyUserLogin.getUserCurrency();
				
				loginStatus = true;
			
			} else {
				//Specifies the redirect path
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/Login.jsp?errCode=invalidLogin";
				loginStatus = false;
			}
		} catch (Exception e) {
			//Any errors, it will catch it rather than crash the application and redirect to a appropriate page with the error
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/Login.jsp?errCode=invalidLogin";
			
			//Print out the error for debugging
			System.out.println("[Verifying Login Servlet]: " + e);
			loginStatus = false;
		}
		
		if (loginStatus) {
			RequestDispatcher rd = request.getRequestDispatcher("/CurrencyConverter?convertTo=" +verifyUserLogin.getUserCurrency());
			rd.forward(request, response);
		} else {
			response.sendRedirect(redirectURL);
		}
		
	}

}
