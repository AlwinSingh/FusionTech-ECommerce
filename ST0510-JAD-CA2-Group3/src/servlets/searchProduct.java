package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechProductModel.allProducts;
import fusionTechProductModel.searchProductFromDB;
import fusionTechUserModel.UserDetails;
import fusionTechUserModel.getAllCustomersFromDB;

/**
 * Servlet implementation class searchProduct
 */
@WebServlet("/searchProduct")
public class searchProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public searchProduct() {
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

		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllProducts.jsp?errorCode=400";
		String searchValue = request.getParameter("searchProducts");

		try {
			HttpSession session = request.getSession();
			SQLString sqlStr = new SQLString();
			UserDetails user = (UserDetails) session.getAttribute("userData");

			if (user != null && user.getUserType().contentEquals("admin")) {

				ArrayList<allProducts> productsList = new ArrayList<allProducts>();
				searchProductFromDB retrieveSearchedProduct = new searchProductFromDB();
				productsList = retrieveSearchedProduct.retrieveSearchedProduct(searchValue, sqlStr.getSQLConnString());

				session.setAttribute("productsList", productsList);
				// RequestDispatcher rd =
				// request.getRequestDispatcher("/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllCustomer.jsp");
				// rd.forward(request, response);

				if (productsList.size() == 0) {
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllProducts.jsp?page=0&results=NoResults&searchProducts="
							+ searchValue;
				} else {
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllProducts.jsp?page=0&searchProducts="
							+ searchValue;
				}
			} else {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=unauthorised";
			}
		} catch (Exception e) {

			System.out.println("[Servlet Get Searched Products (Admin)]: " + e);
			System.out.println("[Servlet Get Searched Products (Admin)]: " + e.getMessage());

			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllProducts.jsp?errorCode=400";
		} finally {
			response.sendRedirect(redirectURL);
		}
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
