package shoppingCart;

import java.io.Serializable;

@SuppressWarnings("serial")
public class shoppingCart implements Serializable {
	
	//Fields that are required in the SQL so we set them as it is
	//They are private because we do not want them to be accessible by others that could then manipulate this data
	//We also do not need to directly access the variables as we can make use of getter and setter methods
	private String productName, productImage, Category;
	private int productCode, QtyInStock, QtyInCart;
	private double SellPrice, OriginalSellPrice;
	
	//Add Products to cart setter method
	//You could also set them through the individual set methods but seeing as the products will require all these field(s) and we have ensured that the values are not able to be null or empty, we are assured that this multi setter method works
	public void addProductToCart(int productCode, String productName, String productImage, String Category, int QtyInStock, double SellPrice, double OriginalSellPrice) {
		this.productCode = productCode;
		this.productName = productName;
		this.productImage = productImage;
		this.Category = Category;
		this.QtyInStock = QtyInStock;
		this.SellPrice = SellPrice;
		this.OriginalSellPrice = OriginalSellPrice;
	}
	
	//Getter methods below
	public int getProductCode() {
		return this.productCode;
	}
	
	public String getProductName() {
		return this.productName;
	}
	
	public String getProductImage() {
		return this.productImage;
	}
	
	public String getProductCategory() {
		return this.Category;
	}
	
	public int getQtyInStock() {
		return this.QtyInStock;
	}
	
	public double getProductSellPrice() {
		return this.SellPrice;
	}
	
	public int getQtyInCart() {
		return this.QtyInCart;
	}
	
	public double getProductSellPriceInSGD() {
		return this.OriginalSellPrice;
	}
	
	public void setProductSellPrice(double SellPrice) {
		this.SellPrice = SellPrice;
	}
	
	//Updates the Quantity in the cart
	public void setQtyInCart(int updatedQty) {
		this.QtyInCart = updatedQty;
	}

}
