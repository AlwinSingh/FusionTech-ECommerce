package servlets;

import java.util.ArrayList;
import shoppingCart.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechUserModel.UserDetails;

/**
 * Servlet implementation class addtoShoppingCart
 */
@WebServlet("/addtoShoppingCart")
public class addtoShoppingCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addtoShoppingCart() {
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
		
		//Defines the SQL Model where we can easily modify and retireve the SQL Connection String
		SQLString sqlStr = new SQLString();
		//Thhe default redirect URL that we can alter during the execution of the code below
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/shoppingCart.jsp";
		//Gets the product code and quantity from a hidden field from the view product page
		int productCode = Integer.parseInt(request.getParameter("getProductCode"));
		int getAddToCartQty = Integer.parseInt(request.getParameter("getAddToCartQty"));
		//Defines the http session
		HttpSession session=request.getSession(); 

		//The cartList is an arrayList that will be used to store the objects
		//They are stored as objects for easy retrieval with the help of the value bean (Get & Set methods)
		ArrayList<shoppingCart> cartList = new ArrayList<shoppingCart>();

		//We check if there is currently a shoppingCart attribute stored in Session
		//If there is, that would mean you have an existing shopping cart
		//So we do not want to overwrite it, hence we load the cartList with what is currently in the user's cart
		if (session.getAttribute("shoppingCart") != null) {
			cartList = (ArrayList<shoppingCart>) session.getAttribute("shoppingCart");
		}
		
		//However, if we load what is currently in the user's cart, we may face an issue of adding in duplicate products, etc
		//This is dealt in the addToShoppingCartDB() method which is explained in there
		verifyAddToShoppingCartDB verifyAddToCart = new verifyAddToShoppingCartDB();
		cartList = verifyAddToCart.addtoShoppingCart(sqlStr.getSQLConnString(), cartList, productCode, getAddToCartQty);
		
		//We then update the session attribute of "shoppingCart" with the cartList
		//However, what if our method has an error and returns an emptyArray or something worse?
		//Well we can check the size of the cartList returned, and also make use of the try catch that all of the code is encapsulated in
		//If the cartList returned is valid, we update the session, else we do not and we also notify the user
		if (cartList.size() > 0) {
			
			String currencySymbol = "SGD";
			double currencyRate = 1.0;
			
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
							//System.out.println(cookie.getName());
							if (cookie.getName().equals("currencySymbol")) {
								currencySymbol = cookie.getValue();
								//System.out.println(currencySymbol);
							} else if (cookie.getName().equals("currencyRate")) {
								currencyRate = Double.valueOf(cookie.getValue());
							}
						}
					}
				}
			} catch (Exception e) {
				System.out.println("[Servlet / Admin] Getting all products: Could not convert currency for shopping cart items....error!");
				System.out.println("[Servlet / Admin] Getting all products: " +e);
				System.out.println("[Servlet / Admin] Getting all products: " +e.getMessage());
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp";
				return;
			}
			
			for (int i = 0; i < cartList.size(); i++) {
				cartList.get(i).setProductSellPrice(Math.round(cartList.get(i).getProductSellPrice() * currencyRate * 100.0) / 100.0);
			}
			
			session.setAttribute("shoppingCart", cartList);
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/shoppingCart.jsp?addToCart=success";
		} else {
			//Do not update the session at all
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/shoppingCart.jsp?addToCart=failure";
		}
		response.sendRedirect(redirectURL);
	}

}
