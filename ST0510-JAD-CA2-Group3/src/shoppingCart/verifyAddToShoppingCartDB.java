package shoppingCart;

import java.util.ArrayList;
import java.io.Serializable;
import java.sql.*;

@SuppressWarnings("serial")
public class verifyAddToShoppingCartDB implements Serializable {
	
	public ArrayList<shoppingCart> addtoShoppingCart(String sqlConnUrl, ArrayList<shoppingCart> cartList, int productCode, int getAddToCartQty) {
		try {
			// Step1: Load JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");
			// Step 2: Define Connection URL
			String connURL = sqlConnUrl;
			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);
			// Step 4: Execute SQL Command
			String sqlStrCategories = "SELECT *, categoryName FROM Products INNER JOIN Category ON Category.catID = Products.Category WHERE Products.ProductCode = ?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStrCategories);
			pstmt.setInt(1, productCode);
			//The above corresponds to the '?' in the SQL Query
			ResultSet products = pstmt.executeQuery();
			//The above executes the prepared statement
			// Step 5: Process Result
			while (products.next()) {	
				//products.getInt("ProductCode");
				
				//The duplicate found acts as a 'checker' to verify if there are any duplicate products. If there are, it increments. So anything above 0 means there are duplicate products
				int duplicateProductFound = 0;
				//We define the shopping cart item object which is our value bean
				//This value bean helps to store all the necessary values through getter and setter methods
				shoppingCart shoppingCartItem = new shoppingCart();
				//We then call the addProductToCart setter method that essentially sets all the neccesary information of a product
				//We also have individual setter methods in case certain values are only available later on or we want to append certain values
				shoppingCartItem.addProductToCart(productCode, products.getString("Name"), products.getString("Image"), products.getString("categoryName"), products.getInt("QtyInStock"), products.getDouble("SellPrice"), products.getDouble("SellPrice"));
				
					//The for loop iterates through the cartList
					for (int i = 0; i < cartList.size(); i++) {
						//Remember the 'duplicateProductFound' above?
						//So if a product code currently in the cartList matches a product code that we plan to add, it increments the quantity but it does verifications before that
						if (cartList.get(i).getProductCode() == productCode) {
							//Increment duplicate product found as a duplicate product is found, this is used in if statement later on
							duplicateProductFound++;
							//It gets the current quantity of the product in cart
							int getCurrentQty = cartList.get(i).getQtyInCart();
							
							//If the overall sum that is planned to be added is more than how much is in stock, it will only allow the user to add the maximum number of products in cart
							if ((getCurrentQty + getAddToCartQty) > cartList.get(i).getQtyInStock()) {
								cartList.get(i).setQtyInCart(cartList.get(i).getQtyInStock());
								System.out.println("Not enough stock.....you want: " + (getCurrentQty + getAddToCartQty));
								System.out.println("Only have: " +cartList.get(i).getQtyInStock());
								System.out.println("--------------------");
								//redirectURL = "../Pages/shoppingCart.jsp?cartErr=055";
							} else {
								//If overall sum does not exceed the products quantity in stock, then allow the desired amount to be added to the cart
								System.out.println("Enough stock.....you want: " + (getCurrentQty + getAddToCartQty));
								System.out.println("Only have: " +cartList.get(i).getQtyInStock());
								System.out.println("--------------------");
								cartList.get(i).setQtyInCart(getCurrentQty + getAddToCartQty);
							}
							//If a duplicate product is found, no need to keep iterating through, break out of the loop
							break;
						}
					}
					
					//If no duplicate products are found, we have to cater for the ehcks to ensure it does not exceed quantity in stock
					if (duplicateProductFound == 0) {
						//If quantity exceeds, give them the customers the most they can get
						if (getAddToCartQty > shoppingCartItem.getQtyInStock()) {
							shoppingCartItem.setQtyInCart(shoppingCartItem.getQtyInStock());
							//redirectURL = "../Pages/shoppingCart.jsp?cartErr=055";
						} else {
							//If quantity does not exceed, give them the desired amount
							shoppingCartItem.setQtyInCart(getAddToCartQty);
						}
						//Add the object to the arrayList
						cartList.add(shoppingCartItem);
						break;
					}
				
				
			} // Step 7: Close connection
			conn.close();
			} catch (Exception e) {
				//Print out any exceptions
				System.err.println("[Verify add to shopping cart DB] :" + e);
		}
		
		//return the arraylist that contains the shopping cart objects
		return cartList;
	}

}
