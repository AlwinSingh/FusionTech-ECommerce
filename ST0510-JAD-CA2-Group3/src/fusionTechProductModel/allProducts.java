package fusionTechProductModel;

import java.io.Serializable;

@SuppressWarnings("serial")
public class allProducts implements Serializable {
	private int productCode, categoryID, QtyInStock, isAvailable, productOrderID;
	private double buyPrice, sellPrice, originalSellPrice;
	private String productName, categoryName, supplier, briefDescription, pdtDescription, Image, currencySymbol;
	
	public void setProduct(String productName, int productCode, int categoryID, String categoryName, int QtyInStock, int isAvailable, double buyPrice, double sellPrice, String supplier, String briefDescription, String pdtDescription, String Image) {
		this.productName = productName;
		this.productCode = productCode;
		this.categoryID = categoryID;
		this.categoryName = categoryName;
		this.QtyInStock = QtyInStock;
		this.isAvailable = isAvailable;
		this.buyPrice = buyPrice;
		this.sellPrice = sellPrice;
		this.supplier = supplier;
		this.briefDescription = briefDescription;
		this.pdtDescription = pdtDescription;
		this.Image = Image;
	}
	
	/* Currency Related Methods */
	public String getProductCurrencySymbol() {
		return this.currencySymbol;
	}
	
	public void setProductCurrencySymbol(String currencySymbol) {
		this.currencySymbol = currencySymbol;
	}
	
	public double getProductSellPriceInSGD() {
		return this.originalSellPrice;
	}
	
	public void setProductOriginalSellPrice(double originalSellPrice) {
		this.originalSellPrice = originalSellPrice;
	}
	/* End of currency related methods */
	
	public String getProductName() {
		return this.productName;
	}
	
	public int getProductCode() {
		return this.productCode;
	}
	
	public int getProductCategoryID() {
		return this.categoryID;
	}
	
	public String getProductCategoryName() {
		return this.categoryName;
	}
	
	public int getProductQtyInStock() {
		return this.QtyInStock;
	}
	
	public int getProductisAvailable() {
		return this.isAvailable;
	}
	
	public double getProductBuyPrice() {
		return this.buyPrice;
	}
	
	public double getProductSellPrice() {
		return this.sellPrice;
	}
	
	public String getProductsupplier() {
		return this.supplier;
	}
	
	public String getProductbriefDesc() {
		return this.briefDescription;
	}
	
	public String getProductDesc() {
		return this.pdtDescription;
	}
	
	public String getProductImage() {
		return this.Image;
	}
	
	public void setProductName(String productName) {
		this.productName = productName;
	}
	
	public void setProductCode(int productCode) {
		this.productCode = productCode;
	}
	
	public void setProductCategoryID(int categoryID) {
		this.categoryID = categoryID;
	}
	
	public void setProductCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	public void setProductQtyInStock(int QtyInStock) {
		this.QtyInStock = QtyInStock;
	}
	
	public void setProductisAvailable(int isAvailable) {
		this.isAvailable = isAvailable;
	}
	
	public void setProductBuyPrice(double buyPrice) {
		this.buyPrice = buyPrice;
	}
	
	public void setProductSellPrice(double sellPrice) {
		this.sellPrice = sellPrice;
	}
	
	public void setProductsupplier(String supplier) {
		this.supplier = supplier;
	}
	
	public void setProductbriefDesc(String briefDescription) {
		this.briefDescription = briefDescription;
	}
	
	public void setProductDesc(String pdtDescription) {
		this.pdtDescription = pdtDescription;
	}
	
	public void setProductImage(String Image) {
		this.Image = Image;
	}
	
	//Below methods only applicable to retrieving a specific product for order
	public void setProductOrderID(int productOrderID) {
		this.productOrderID = productOrderID;
	}
	
	public int getProductOrderID() {
		return this.productOrderID;
	}
	
}
