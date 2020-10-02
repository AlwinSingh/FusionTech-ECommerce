package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechProductModel.deleteCategoryFromDB;
import fusionTechUserModel.UserDetails;

/**
 * Servlet implementation class deleteCat
 */
@WebServlet("/deleteCat")
public class deleteCat extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public deleteCat() {
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

		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminDeleteCat.jsp?delCode=failure";

		try {
			HttpSession session = request.getSession();
			UserDetails user = (UserDetails) session.getAttribute("userData");

			if (user != null && user.getUserType().contentEquals("admin")) {
				int catCode = Integer.parseInt(request.getParameter("deleteHiddenField"));

				SQLString sqlConnUrl = new SQLString();
				deleteCategoryFromDB deleteCategory = new deleteCategoryFromDB();
				boolean deleteStatus = deleteCategory.deleteCat(catCode, sqlConnUrl.getSQLConnString());

				if (deleteStatus) {
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminDeleteCat.jsp?delCode=success";
				} else {
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminDeleteCat.jsp?delCode=failure";
				}
			} else {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=unauthorised";
			}
		} catch (Exception e) {
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminDeleteCat.jsp?delCode=failure";
			System.out.println("[Servlet / Admin] Delete Category: " + e);
			System.out.println("[Servlet / Admin] Delete Category: " + e.getMessage());
		} finally {
			response.sendRedirect(redirectURL);
		}

	}

}
