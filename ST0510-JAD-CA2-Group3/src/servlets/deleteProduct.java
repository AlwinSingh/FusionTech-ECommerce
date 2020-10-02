package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechProductModel.deleteProductFromDB;
import fusionTechUserModel.UserDetails;

/**
 * Servlet implementation class deleteProduct
 */
@WebServlet("/deleteProduct")
public class deleteProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public deleteProduct() {
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
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=unauthorised";

		try {
			HttpSession session = request.getSession();
			UserDetails user = (UserDetails) session.getAttribute("userData");

			if (user != null && user.getUserType().contentEquals("admin")) {
				int productCode = Integer.parseInt(request.getParameter("deleteHiddenField"));
				String productImage = request.getParameter("storeImageNameHiddenField");

				SQLString sqlConnUrl = new SQLString();
				deleteProductFromDB deleteProduct = new deleteProductFromDB();
				boolean deleteStatus = deleteProduct.deleteProduct(productCode, productImage,
						sqlConnUrl.getSQLConnString());

				if (deleteStatus) {
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminDeleteProduct.jsp?delCode=success";
				} else {
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminDeleteProduct.jsp?delCode=failure";
				}
			} else {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=unauthorised";
			}
		} catch (Exception e) {
			System.out.println("[Delete Customer Error]: " + e);
			System.out.println("[Delete Customer Error]: " + e.getMessage());
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminDeleteProduct.jsp?delCode=failure";
		}
		
		response.sendRedirect(redirectURL);
	}

}
