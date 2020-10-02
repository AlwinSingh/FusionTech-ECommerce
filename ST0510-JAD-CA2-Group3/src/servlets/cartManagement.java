package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import shoppingCart.shoppingCart;

/**
 * Servlet implementation class cartManagement
 */
@WebServlet("/cartManagement")
public class cartManagement extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public cartManagement() {
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
		
		HttpSession session=request.getSession();
		shoppingCart shoppingCartItem = new shoppingCart();
		ArrayList<shoppingCart> cartList = new ArrayList<shoppingCart>();
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/shoppingCart.jsp?ok";

		
		String managementAction = request.getParameter("managementAction");
		
		int indexToDelete = Integer.parseInt(request.getParameter("getIndexToDelete"));

		if (session.getAttribute("shoppingCart") != null) {
			cartList = (ArrayList<shoppingCart>) session.getAttribute("shoppingCart");
		} else {
			redirectURL = "shoppingCart.jsp?action=failed";
		}
		
		//Delete Action
		if (managementAction.equals("delete")) {
			cartList.remove(indexToDelete);
	
			if (cartList.size() < 1) {
				session.removeAttribute("shoppingCart");
			}
		}
		
		//Quantity Increment Update Action
		if (managementAction.equals("addQty")) {
			int productQtyInStock = cartList.get(indexToDelete).getQtyInStock();
			int productQtyInCart = cartList.get(indexToDelete).getQtyInCart();
			
			if ((productQtyInCart+1) > productQtyInStock) {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/shoppingCart.jsp?action=failedIncrement";
			} else {
				cartList.get(indexToDelete).setQtyInCart(productQtyInCart+1);
			}
		}
		
		
		//Quantity Increment Update Action
				if (managementAction.equals("remQty")) {
					int productQtyInCart = cartList.get(indexToDelete).getQtyInCart();
					
					if ((productQtyInCart-1) <= 0) {
						redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/shoppingCart.jsp?action=failedDecrement";
					} else {
						cartList.get(indexToDelete).setQtyInCart(productQtyInCart-1);
					}
				}

		response.sendRedirect(redirectURL);
		
	}

}
