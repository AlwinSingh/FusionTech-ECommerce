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
import fusionTechUserModel.UserType;
import fusionTechUserModel.getAllCustomersFromDB;

/**
 * Servlet implementation class getUserType
 */
@WebServlet("/getUserType")
public class getUserType extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getUserType() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminCreateCustomer.jsp?errorCode=400";
		
		try {
		HttpSession session=request.getSession();
		SQLString sqlStr = new SQLString();
		ArrayList<UserDetails> userTypeList = new ArrayList<UserDetails>();
		UserType getUserType = new UserType();
		userTypeList = getUserType.retrieveUserType(sqlStr.getSQLConnString());
		
		session.setAttribute("userTypeList", userTypeList);
		//RequestDispatcher rd = request.getRequestDispatcher("/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllCustomer.jsp");
		//rd.forward(request,  response);
		
		redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminCreateCustomer.jsp";
		} catch (Exception e) {
			System.out.println("[Servlet Create Customers (Admin)]: " +e);
			System.out.println("[Servlet Create Customers (Admin)]: " +e.getMessage());
			
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminCreateCustomer.jsp?errorCode=400";
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
