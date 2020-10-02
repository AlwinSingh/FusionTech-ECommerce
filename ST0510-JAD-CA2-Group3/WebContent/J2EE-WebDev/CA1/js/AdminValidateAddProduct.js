function validateFields() {
	//Retrieves values of the elements
	var productName = $("#productName").val();
	var productSupplier = $("#productSupplier").val();
	var productCode = $("#productCode").val();
	var productQty = $("#productQty").val();
	var productBuyPrice = $("#productBuyPrice").val();
	var productSellPrice = $("#productSellPrice").val();
	var pdtBriefDesc = $("#pdtBriefDesc").val();
	var pdtDesc = $("#pdtDesc").val();
	
	//Does a validation for each element, to see if the value matches the condition
	//If it matches the condition, it alters the textContent and Color ('text-danger') of the label of the element
	
	if (productName.length < 4 || !isNaN(parseInt(productName))) {
		$(".productNameLabel").addClass("text-danger");
		$(".productNameLabel").text("Product Name: (Must be 4 characters!)");
		//Prevents form submission
		event.preventDefault();
	} else {
		$(".productNameLabel").removeClass("text-danger");
		$(".productNameLabel").text("Product Name:");
	}
	
	if (productSupplier.length < 3 || !isNaN(parseInt(productSupplier))) {
		$(".productSupplierLabel").addClass("text-danger");
		$(".productSupplierLabel").text("Product Supplier: (Must be 3 characters!)");
		event.preventDefault();
	} else {
		$(".productSupplierLabel").removeClass("text-danger");
		$(".productSupplierLabel").text("Product Supplier:");
	}
	
	if ($("#imageUploadFile")[0].files.length == 0 ){
		console.log("NOOOO")
	    $(".imageUploadLabel").addClass("text-danger");
	    $(".imageUploadLabel").text("Image Link: (Must be upload an image!)");
	    event.preventDefault();
	} else {
		$(".imageUploadLabel").removeClass("text-danger");
		$(".imageUploadLabel").text("Product Supplier:");
	}
	
	/*if (parseInt(productCode) < 1 || isNaN(parseInt(productCode)) || productCode.length < 1) {
		$(".productCodeLabel").addClass("text-danger");
		$(".productCodeLabel").text("Product Code: (Invalid!)");
		event.preventDefault();
	} else {
		$(".productQtyLabel").removeClass("text-danger");
		$(".productQtyLabel").text("Product Quantity:");
	}*/
	
	
	if (parseInt(productQty) < 1 || isNaN(parseInt(productQty)) || productQty.length < 1) {
		$(".productQtyLabel").addClass("text-danger");
		$(".productQtyLabel").text("Product Quantity: (Invalid!)");
		event.preventDefault();
	} else {
		$(".productQtyLabel").removeClass("text-danger");
		$(".productQtyLabel").text("Product Quantity:");
	}
	
	if (parseInt(productBuyPrice) < 1 || productBuyPrice.length < 1) {
		$(".productBuyPriceLabel").addClass("text-danger");
		$(".productBuyPriceLabel").text("Buy Price: $ (Invalid Input)");
		event.preventDefault();
	} else {
		$(".productBuyPriceLabel").removeClass("text-danger");
		$(".productBuyPriceLabel").text("Buy Price: $");
	}
	
	if (parseInt(productSellPrice) < 1 || productSellPrice.length < 1) {
		$(".productSellPriceLabel").addClass("text-danger");
		$(".productSellPriceLabel").text("Sell Price: $ (Invalid Input)");
		event.preventDefault();
	} else {
		$(".productSellPriceLabel").removeClass("text-danger");
		$(".productSellPriceLabel").text("Sell Price: $");
	}
	
	
	if (pdtBriefDesc.length < 10 || !isNaN(parseInt(pdtBriefDesc))) {
		$(".pdtBriefDescLabel").addClass("text-danger");
		$(".pdtBriefDescLabel").text("Product Description: (Must be 10 characters!)");
		event.preventDefault();
	} else {
		$(".pdtBriefDescLabel").removeClass("text-danger");
		$(".pdtBriefDescLabel").text("Product Brief Description:");
	}
	
	if (pdtDesc.length < 30 || !isNaN(parseInt(pdtDesc))) {
		$(".pdtDescLabel").addClass("text-danger");
		$(".pdtDescLabel").text("Product Description: (Must be 30 characters!)");
		event.preventDefault();
	} else {
		$(".pdtDescLabel").removeClass("text-danger");
		$(".pdtDescLabel").text("Product Description:");
	}
	
	
}