package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSession;

import fusionTechProductModel.*;
import fusionTechUserModel.UserDetails;

/**
 * Servlet implementation class getAllProducts
 */
@WebServlet("/getAllProducts")
public class getAllProducts extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public getAllProducts() {
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

		String currencySymbol = "SGD";
		double currencyRate = 1;

		int categoryID = 0;
		String categoryName = "";
		String redirectURL = "";

		try {
			categoryID = Integer.parseInt(request.getParameter("getProductLineID"));
			categoryName = request.getParameter("getProductLineName");
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/viewAllProducts.jsp";
		} catch (Exception e) {
			response.sendRedirect("/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp");
			return;
		}

		if (categoryID > 0) {
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/displayCategoryProducts.jsp?categoryName="
					+ categoryName;
		}

		HttpSession session = request.getSession();
		ArrayList<allProducts> productList = new ArrayList<allProducts>();
		SQLString sqlStr = new SQLString();

		try {
			/* Retrieving Currency Stuff */
			if (session.getAttribute("userData") != null && session.getAttribute("currencyRate") != null) {
				// System.out.println("Session Exists...");
				UserDetails user = (UserDetails) session.getAttribute("userData");
				currencySymbol = user.getUserCurrency();
				currencyRate = Double.parseDouble(String.valueOf(session.getAttribute("currencyRate")));
				// System.out.println("OBJ UC:" +user.getUserCurrency());
				// System.out.println(currencyRate);
			} else {
				Cookie[] cookies = request.getCookies();

				if (cookies != null) {
					for (Cookie cookie : cookies) {
						if (cookie.getName().equals("currencySymbol")) {
							currencySymbol = cookie.getValue();
							System.out.println(currencySymbol);
						} else if (cookie.getName().equals("currencyRate")) {
							currencyRate = Double.valueOf(cookie.getValue());
						}
					}
				}
			}
		} catch (Exception e) {
			System.out.println("[Getting all products]: Currency not loaded....error!");
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp";
			return;
		}

		// System.out.println(currencySymbol);
		// System.out.println(currencyRate);

		try {
			// This defines the UserDetailsDB utility class
			// Essentially, what this utility does is ping the database and make use of the
			// setter methods to load the arraylist into the allProducts ('categoryList')
			// object.
			getAllProductsFromDB productsFromDB = new getAllProductsFromDB();
			// Now we can load'categoryList' with the utility class that returns a
			// allProducts arraylist object with the set methods already used (E.g. the
			// values are alrdy loaded through the utility)
			productList = productsFromDB.retrieveProducts(sqlStr.getSQLConnString());

			for (int i = 0; i < productList.size(); i++) {
				productList.get(i).setProductCurrencySymbol(currencySymbol);
				productList.get(i).setProductBuyPrice(
						Math.round((productList.get(i).getProductBuyPrice() * currencyRate) * 100.0) / 100.0);
				productList.get(i).setProductSellPrice(
						Math.round((productList.get(i).getProductSellPrice() * currencyRate) * 100.0) / 100.0);
			}

			session.setAttribute("productList", productList);
			// request.getServletContext().setAttribute("productListAppScope", productList);
			// request.getRequestDispatcher("/J2EE-WebDev/CA1/WebFiles/Pages/viewAllProducts.jsp").forward(request,
			// response);
			response.sendRedirect(redirectURL);
		} catch (Exception e) {
			System.out.println("All Products Retrieval Error: " + e.getMessage());
			response.sendRedirect(
					"/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/ProductCategory.jsp?errCode=400");
			return;
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
