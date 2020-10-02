package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fusionTechUserModel.resetPasswordDB;

/**
 * Servlet implementation class resetPassword
 */
@WebServlet("/resetPassword")
public class resetPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public resetPassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		SQLString sqlString = new SQLString();
		String userLoginEmail = (String) request.getParameter("inputUserEmail");
		resetPasswordDB resetPassword = new resetPasswordDB();
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/Login.jsp?resetPass=true";
		
		try {
		boolean resetPasswordStatus = resetPassword.verifyResetPassword(userLoginEmail, sqlString.getSQLConnString());
		
		if (!resetPasswordStatus) {
		  redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/resetPassword.jsp?recoverPwd=false";
		} else {
		  redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/Login.jsp?resetPass=true";
		}
		} catch (Exception e) {
		  System.out.println(e);
		  redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/resetPassword.jsp?recoverPwd=crash";
		}
		
		response.sendRedirect(redirectURL);
	}

}
