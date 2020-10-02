function validateFields() {
		//Retrieves values of the elements
		var customerEmail = $("#customerEmail").val();
		var firstName =  $("#firstName").val();
		var lastName =  $("#lastName").val();
		var phoneNumber =  $("#phoneNumber").val();
		var address1 =  $("#address1").val();
		var city =  $("#city").val();
		var state =  $("#state").val();
		var postalCode =  $("#postalCode").val();
		var country =  $("#country").val();
		
		//Does a validation for each element, to see if the value matches the condition
		//If it matches the condition, it alters the textContent and Color ('text-danger') of the label of the element
		var emailRegex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
		var nameRegex = /^[A-Za-z]+$/;
		var integerRegex = /^[1-9]+[0-9]*$/;

		if (emailRegex.test(customerEmail) == false) {
			$(".customerEmail").addClass("text-danger");
			$(".customerEmail").text("Product Name: (Enter a valid Email!)");
			console.log(customerEmail);
			//Prevents form submission
			event.preventDefault();
		} else {
			$(".customerEmail").removeClass("text-danger");
			$(".customerEmail").text("Product Name:");
		}
		
		if (nameRegex.test(firstName) == false) {
			$(".firstName").addClass("text-danger");
			$(".firstName").text("First Name: (Enter a valid first name!)");
			event.preventDefault();
		} else {
			$(".firstName").removeClass("text-danger");
			$(".firstName").text("First Name: ");
		}
		
		if (nameRegex.test(lastName) == false) {
			$(".lastName").addClass("text-danger");
			$(".lastName").text("Last Name: (Enter a valid last name!)");
			event.preventDefault();
		} else {
			$(".lastName").removeClass("text-danger");
			$(".lastName").text("Last Name: ");
		}
		
		if (integerRegex.test(phoneNumber) == false) {
			$(".phoneNumber").addClass("text-danger");
			$(".phoneNumber").text("Phone Number: (Invalid number!)");
			event.preventDefault();
		} else {
			$(".phoneNumber").removeClass("text-danger");
			$(".phoneNumber").text("Phone Number:");
		}
		
		if (address1.length < 5) {
			$(".address1").addClass("text-danger");
			$(".address1").text("Address 1: (Must be valid address!)");
			event.preventDefault();
		} else {
			$(".address1").removeClass("text-danger");
			$(".address1").text("Address 1: ");
		}
		
		if (city.length < 2 || city.length == 0 || !isNaN(city)) {
			$(".city").addClass("text-danger");
			$(".city").text("City: (Must be valid city!)");
			event.preventDefault();
		} else {
			$(".city").removeClass("text-danger");
			$(".city").text("City:");
		}
		
		if (state.length < 2 || state.length == 0 || !isNaN(state)) {
			$(".state").addClass("text-danger");
			$(".state").text("State: (Must be valid state!)");
			event.preventDefault();
		} else {
			$(".state").removeClass("text-danger");
			$(".state").text("State:");
		}
		
		if (integerRegex.test(postalCode) == false) {
			$(".postalCode").addClass("text-danger");
			$(".postalCode").text("Postal Code: (Invalid postal code!)");
			event.preventDefault();
		} else {
			$(".postalCode").removeClass("text-danger");
			$(".postalCode").text("Postal Code:");
		}
		
		if (country.length < 2 || country.length == 0 || !isNaN(country)) {
			$(".country").addClass("text-danger");
			$(".country").text("Country: (Must be valid country!)");
			event.preventDefault();
		} else {
			$(".country").removeClass("text-danger");
			$(".country").text("Country:");
		}
		


		
		
	}