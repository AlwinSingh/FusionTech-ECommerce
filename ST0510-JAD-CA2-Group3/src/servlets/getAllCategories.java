package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechProductModel.*;
import java.util.ArrayList;

/**
 * Servlet implementation class getAllCategories
 */
@WebServlet("/getAllCategories")
public class getAllCategories extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getAllCategories() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		HttpSession session=request.getSession();
		ArrayList<allCategories> categoryList = new ArrayList<allCategories>();
		SQLString sqlStr = new SQLString();
		
		try {
		//This defines the UserDetailsDB utility class
		//Essentially, what this utility does is ping the database and make use of the setter methods to load the arraylist into the allCategories ('categoryList') object.
		getAllCategoriesFromDB categoriesFromDB = new getAllCategoriesFromDB();
		//Now we can load'categoryList' with the utility class that returns a allCategories arraylist object with the set methods already used (E.g. the values are alrdy loaded through the utility)
		categoryList = categoriesFromDB.retrieveCategories(sqlStr.getSQLConnString());
		session.setAttribute("categoryList", categoryList);
		response.sendRedirect("/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/ProductCategory.jsp");
		} catch (Exception e) {
			System.out.println("Category Retrieval Error: " +e.getMessage());
			response.sendRedirect("/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?errCode=101");
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
