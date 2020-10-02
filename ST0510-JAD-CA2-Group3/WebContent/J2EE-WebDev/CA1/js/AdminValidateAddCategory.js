function validateFields() {
//Retrieves values of the HTML elements
var categoryName = $("#CatName").val();
var imageLink = $("#CatImage").val();
var categoryDesc = $("#CatDesc").val();
	
//Does a validation for each element, to see if the value matches the condition
//If it matches the condition, it alters the textContent and Color ('text-danger') of the label of the element

if (categoryName.length < 3 || !isNaN(categoryName)) {
	$(".catLabel").text("Category Name: (Must be 3 characters)").addClass("text-danger");
	//this is used to prevent form submission
	event.preventDefault();
} else {
	$(".catLabel").text("Category Name:").removeClass("text-danger");
}


if (imageLink.length < 3 || !isNaN(categoryName)) {
	$(".catImageLabel").text("Image Link: (Must be 3 characters)").addClass("text-danger");
	event.preventDefault();
} else {
	$(".catImageLabel").text("Image Link:").removeClass("text-danger");
}

if (categoryDesc.length < 10 || !isNaN(categoryDesc)) {
	$(".catDescLabel").text("Category Description: (Must be 10 characters)").addClass("text-danger");
	event.preventDefault();
} else {
	$(".catDescLabel").text("Category Description:").removeClass("text-danger");
}
}