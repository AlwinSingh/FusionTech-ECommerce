package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechProductModel.*;
import fusionTechUserModel.UserDetails;

/**
 * Servlet implementation class addNewCat
 */
@WebServlet("/addNewCat")
public class addNewCat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addNewCat() {
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
		
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminCreateCat.jsp?addCat=false";
		
		try {
		HttpSession session = request.getSession();
		UserDetails user = (UserDetails) session.getAttribute("userData");	
		
		if (user != null && user.getUserType().contentEquals("admin")) {
		
		int catID = Integer.parseInt(request.getParameter("CatID"));
		String catName = request.getParameter("CatName");
		String catDescription = request.getParameter("CatDesc");
		String catImage = request.getParameter("CatImage");
		
		
		SQLString sqlConnUrl = new SQLString();
		addCatToDB addCategory = new addCatToDB();
		boolean insertStatus = addCategory.addCategory(catID, catName, catDescription, catImage,
				sqlConnUrl.getSQLConnString());
		
		if (insertStatus) {
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminDashboard.jsp?addCat=true";
		} else {
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminCreateCat.jsp?addCat=false";
		}
		
		} else {
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=unauthorised";
		}
		
		} catch (Exception e) {
			System.out.println("[Servlet / Admin] Add New Category Error: " + e);
			System.out.println("[Servlet / Admin] Add New Category Error: " + e.getMessage());
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminCreateCat.jsp?addCat=false";
		} finally {
			response.sendRedirect(redirectURL);
		}
		
	}

}
