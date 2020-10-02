package fusionTechProductModel;

import java.io.Serializable;

@SuppressWarnings("serial")
public class allCategories implements Serializable {
	private int catID;
	private String categoryName, Description, Image;
	
	public void setCategoryCatID(int catID) {
		this.catID = catID;
	}
	
	public void setCategoryName(String catName) {
		this.categoryName = catName;
	}
	
	public void setCategoryDesc(String catDesc) {
		this.Description = catDesc;
	}
	
	public void setCategoryImage(String catImage) {
		this.Image = catImage;
	}
	
	public int getCategoryCatID() {
		return this.catID;
	}
	
	public String getCategoryName() {
		return this.categoryName;
	}
	
	public String getCategoryDesc() {
		return this.Description;
	}
	
	public String getCategoryImage() {
		return this.Image;
	}
	
}
