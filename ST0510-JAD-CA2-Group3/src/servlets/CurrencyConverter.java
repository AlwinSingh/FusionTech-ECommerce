package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.*;
import javax.ws.rs.core.*;

import org.json.JSONObject;

import fusionTechProductModel.allProducts;
import fusionTechProductModel.getAllProductsFromDB;
import fusionTechUserModel.UserDetails;
import shoppingCart.shoppingCart;

/**
 * Servlet implementation class convertFtoCServlet
 */
@WebServlet("/CurrencyConverter")
public class CurrencyConverter extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CurrencyConverter() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		boolean convertStatus = false;
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp";
		String convertTo = request.getParameter("convertTo");
		SQLString sqlStr = new SQLString();
		HttpSession session = request.getSession();
		UserDetails currentUserObject = (UserDetails) session.getAttribute("userData");
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());

		// Main entry point to the client API used to bootstrap Client instances.
		// Creates a new client instance
		Client client = ClientBuilder.newClient();

		// A resource target identified by the resource URI.
		// path appends a path to the uri of the target, queryParam configures a query
		// parameter on the URI
		WebTarget target = client.target("http://localhost:8080/Pract7REST/jadca2/currencyconverter/")
				.path("changeusercurrency").queryParam("convertTo", convertTo);

		// Builds a HTTP GET response with the JSON response type
		Invocation.Builder invokeBuilder = target.request(MediaType.APPLICATION_JSON);
		Response resp = invokeBuilder.get();

		// Debugging Purposes, retrieves the http response code
		System.out.println("[CURRENCY CONVERTER | SERVLET] HTTP STATUS: " + resp.getStatus());

		// Checks the http response code against the response success status code
		// In this case, success would return a code of '200'
		if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
			// The readentity reads the message entity input stream with help of a message
			// body reader that maps the entity into the requested application response type
			// As we are returning JSON but in String format, the message body reader
			// (generictype<String>) inits a String datatype
			String result = resp.readEntity(new GenericType<String>() {
			});

			// String str =
			// "[{\"No\":\"1\",\"Name\":\"Adithya\"},{\"No\":\"2\",\"Name\":\"Jai\"},
			// {\"No\":\"3\",\"Name\":\"Raja\"}]";
			try {
				// String str =
				// "{\"sgd\":\"12445.666\",\"rate\":\"1.37\",\"usd\":\"9060.32\",\"currency\":\"USD\"}";
				// System.out.println(result);
				JSONObject json = new JSONObject(result);
				System.out.println(json.toString());
				String userCurrency = json.getString("userCurrency");
				String currencyRate = json.getString("currencyRate");
				// String currentCurrencySymbol = json.getString("currencySymbol");
				// System.out.println(sgdCurrency);
				System.out.println(userCurrency);
				System.out.println(currencyRate);
				// System.out.println(usdCurrency);
				// System.out.println(currentCurrencySymbol);

				if (currentUserObject != null) {
					// System.out.println("Session exist...");
					currentUserObject.setUserCurrency(userCurrency);
					// System.out.println("Updated user currency");
					session.setAttribute("userData", currentUserObject);
					// System.out.println("Update user object");
					session.setAttribute("currencyRate", currencyRate);
					// System.out.println("Update currency rate");

					if (currentUserObject.getUserType().contentEquals("admin")) {
						getAllProductsFromDB productsFromDB = new getAllProductsFromDB();
						ArrayList<allProducts> productList = new ArrayList<allProducts>();
						productList = productsFromDB.retrieveProducts(sqlStr.getSQLConnString());
						session.setAttribute("productList", productList);

						for (int i = 0; i < productList.size(); i++) {
							productList.get(i).setProductCurrencySymbol(userCurrency);
							productList.get(i).setProductBuyPrice(Math.round(
									(productList.get(i).getProductBuyPrice() * Double.valueOf(currencyRate)) * 100.0)
									/ 100.0);
							productList.get(i).setProductSellPrice(Math.round(
									(productList.get(i).getProductSellPrice() * Double.valueOf(currencyRate)) * 100.0)
									/ 100.0);
						}
					}

					convertStatus = true;
				} else {
					// System.out.println("Session does not exist...");
					// setting name and value of cookies
					Cookie currencySymbol = new Cookie("currencySymbol", userCurrency);
					Cookie currencyConversionRate = new Cookie("currencyRate", currencyRate);
					currencySymbol.setMaxAge(7200);
					currencyConversionRate.setMaxAge(7200);
					response.addCookie(currencySymbol);
					response.addCookie(currencyConversionRate);
					convertStatus = true;
				}

				if (session.getAttribute("shoppingCart") != null) {
					ArrayList<shoppingCart> cartList = (ArrayList<shoppingCart>) session.getAttribute("shoppingCart");

					for (int i = 0; i < cartList.size(); i++) {
						cartList.get(i).setProductSellPrice(Math.round(
								cartList.get(i).getProductSellPriceInSGD() * Double.valueOf(currencyRate) * 100.0)
								/ 100.0);
					}

				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println("[Currency Converter Servet Error]" + e);
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?currencyConvert=false";
				convertStatus = false;
			}

			// Debugging purposes, checks the result
			// System.out.println("[CURRENCY CONVERTER | SERVLET] RESULT: " +result);
		}

		if (convertStatus) {
			response.sendRedirect(
					"/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?currencyConvert=true");
		} else {
			response.sendRedirect(
					"/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?currencyConvert=false");
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
