<!--
Name: Alwin Singh (p1935996)
Name: Choh Kaifeng (p1935590)
Class: DIT/2B/21
Group: 3
Subject: J2EE CA1 Assignment
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="shoppingCart.*, java.util.ArrayList, java.util.List, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - Shopping Cart</title>


<!-- Bootstrap & FA core CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap"
	rel="stylesheet">
</head>

<body>
	<%@ include file="../HTML/WebPageNavBar.jsp"%>

	<%
	try {
	String userType = userRole;
	
	// If the user is not logged in, userRole is null otherwise it has a value
	// If user is a guest then immediately redirect them to HomePage.jsp to prevent access to cart
	if (userType == null || userType.equals("guest")) {
		response.sendRedirect("../Pages/shoppingCart.jsp?error=NotLoggedIn");
		return;
	}
	
	
	String shippingCost = request.getParameter("shippingCost");
    String totalCost = request.getParameter("totalCost");
    
    String shippingFirstName = "";
	String shippingLastName = "";
	String shippingAddressLine1 = "";
	String shippingAddressLine2 = "";
	String shippingPostalCode = "";
	String cardHolderName = "";
    
	if (session.getAttribute("shippingAddressLine1") != null) {
		shippingAddressLine1 = session.getAttribute("shippingAddressLine1").toString();
	}
	
	if (session.getAttribute("shippingAddressLine2") != null) {
		shippingAddressLine2 = session.getAttribute("shippingAddressLine2").toString();
	}
	
	if (session.getAttribute("shipperFirstName") != null) {
		shippingFirstName = session.getAttribute("shipperFirstName").toString();
	}
	
	if (session.getAttribute("shipperLastName") != null) {
		shippingLastName = shippingLastName = session.getAttribute("shipperLastName").toString();
	}
	
	if (session.getAttribute("shippingPostalCode") != null) {
		shippingPostalCode = session.getAttribute("shippingPostalCode").toString();
	}
	
	if (session.getAttribute("cardHolderName") != null) {
		cardHolderName = session.getAttribute("cardHolderName").toString();
	}
	%>

	<div class="jumbotron jumbotron-fluid"
		style="display: block; background-image: linear-gradient(to right, #0b2040, #0a224a) !important;">
		<div class="container">
			<h1 class="display-4 mt-3 text-light">Checkout</h1>
			<p class="text-light">You're almost there!</p>
		</div>
	</div>

	<div class="container">

		<div class="alert unauthoriseAlert alert-danger"
			style="display: none;">
			<a style="color: black" href="Login.jsp"></a>
		</div>

					<%
					shoppingCart shoppingCart = new shoppingCart();
					ArrayList<shoppingCart> cartList = new ArrayList<shoppingCart>();
					
					if (session.getAttribute("shoppingCart") != null) {
						cartList = (ArrayList<shoppingCart>) session.getAttribute("shoppingCart");
					%>

		<div class="row">
			<div class="col-md-4 order-md-2 mb-4">
				<h4 class="d-flex justify-content-between align-items-center mb-3">
					<span class="text-muted">Your cart</span> <span
						class="badge badge-primary badge-pill"><%= cartList.size() %></span>
				</h4>
				<ul class="list-group mb-3">

					<%
					for (int i = 0; i < cartList.size(); i++) {
					%>

					<li
						class="list-group-item d-flex justify-content-between lh-condensed">
						<div>
							<h6 class="my-0"><%= cartList.get(i).getProductName() %></h6>
							<small class="text-muted">Quantity: <%= cartList.get(i).getQtyInCart() %></small>
						</div> <span class="text-muted"><%= userData.getUserCurrency() %> <%= cartList.get(i).getProductSellPrice() %></span>
					</li>
					<% 	  
					}
			 		%>
					<li class="list-group-item d-flex justify-content-between bg-light">
						<div class="text-muted">
							<h6 class="my-0">Shipping Cost</h6>
							<small>Cost to deliver</small>
						</div> <span class="text-primary"><%= userData.getUserCurrency() %> <%= shippingCost %></span>
					</li>
					
					<li class="list-group-item d-flex justify-content-between bg-light">
						<div class="text-muted">
							<h6 class="my-0">GST</h6>
							<small>Goods & Services Tax</small>
						</div> <span class="text-primary">7% (<%= userData.getUserCurrency() %> <%= Math.round(((0.07 * Double.parseDouble(totalCost))) * 100.0) / 100.0 %>)</span>
					</li>
					
					<!-- <li class="list-group-item d-flex justify-content-between bg-light">
			          <div class="text-success">
			            <h6 class="my-0">Promo code</h6>
			            <small>EXAMPLECODE</small>
			          </div>
			          <span class="text-success">-$5</span>
			        </li> -->
			        
					<li class="list-group-item d-flex justify-content-between"><span>Total
							(Without GST)</span> <strong><%= userData.getUserCurrency() %> <%= totalCost %></strong></li>

					<li class="list-group-item d-flex justify-content-between"><span>Total
							(With GST)</span> <strong><%= userData.getUserCurrency() %> <%= Math.round((Double.parseDouble(totalCost) +  (0.07 * Double.parseDouble(totalCost))) * 100.0) / 100.0 %></strong>
						<input type="hidden" style="display: none;"
						class="paymentValueWithGst"
						value="<%= Math.round((Double.parseDouble(totalCost) +  (0.07 * Double.parseDouble(totalCost))) * 100.0) / 100.0 %>">
					</li>
				</ul>

				<!-- <form class="card p-2">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="Promo code">
						<div class="input-group-append">
							<button type="submit" class="btn btn-sm blue-gradient">Redeem</button>
						</div>
					</div>
				</form> -->
				
			</div>
			<div class="col-md-8 order-md-1">
				<h4 class="mb-3">Shipping Address</h4>
				<form method="POST" class="needs-validation"
					action="../../../../createCustomerOrder" novalidate>
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="firstName" id="shippingFirstNameLabel">First
								name</label> <input type="text" class="form-control"
								id="shippingFirstName" name="shippingFirstName" placeholder="First name"
								value="<%= shippingFirstName %>" required>
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>
						<div class="col-md-6 mb-3">
							<label for="lastName" id="shippingLastNameLabel">Last
								name</label> <input type="text" class="form-control"
								id="shippingLastName" name="shippingLastName" placeholder="Last name"
								value="<%= shippingLastName %>" required>
							<div class="invalid-feedback">Valid last name is required.
							</div>
						</div>
					</div>

					<div class="mb-3">
						<label for="address" id="shippingAddressLabel">Address</label> <input
							type="text" class="form-control" id="shippingAddress"
							name="shippingAddress" placeholder="1234 Main Street" value="<%= shippingAddressLine1 %>" required>
						<div class="invalid-feedback">Please enter your shipping
							address.</div>
					</div>

					<div class="mb-3">
						<label for="address2" id="shippingAddress2Label">Address 2
							<span class="text-muted">(Optional)</span>
						</label> <input type="text" class="form-control" id="shippingAddress2"
							name="shippingAddress2" placeholder="Apartment or suite" value="<%= shippingAddressLine2 %>">
					</div>

					<div class="row">

						<div class="col-md-5 mb-3">
							<label for="country" id="shippingCountryLabel">Country</label> <select
								class="countries custom-select d-block w-100" id="countryId"
								name="shippingCountry" required>
								<option value="">Select Country</option>
							</select>
							<div class="invalid-feedback">Please select a valid
								country.</div>
						</div>

						<div class="col-md-4 mb-3">
							<label for="state" id="shippingStateLabel">State</label> <select
								class="custom-select d-block w-100 states" id="stateId"
								name="shippingState" required>
								<option value="">Select State</option>
							</select>

							<div class="invalid-feedback">Please provide a valid state.
							</div>
						</div>

						<div class="col-md-3 mb-3">
							<label for="city" id="shippingCityLabel">City</label> <select
								class="cities custom-select d-block w-100" name="city"
								id="cityId">
								<option value="">Select City</option>
							</select>
						</div>

						<div class="col-md-12 mb-3">
							<label for="zip" id="shippingPostalCodeLabel">Zip</label> <input
								type="text" class="form-control" id="shippingPostalCode"
								name="shippingPostalCode" placeholder="Postal code" value="<%= shippingPostalCode %>" required>
							<div class="invalid-feedback">Zip code required.</div>
						</div>

					</div>
					<hr class="mb-4">
					
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input"
							id="contactless-delivery" name="contactless-delivery"
							data-custom-value="Y" checked required> <label
							class="custom-control-label" for="contactless-delivery">Contactless
							Delivery</label>
					</div>
							
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input"
							id="same-address" name="same-address" checked> <label
							class="custom-control-label" for="same-address">Shipping
							address is the same as my billing address</label>
					</div>
					<!-- <div class="custom-control custom-checkbox">
          <input type="checkbox" class="custom-control-input" id="save-info">
          <label class="custom-control-label" for="save-info">Save this information for next time</label>
        </div> -->
					<hr class="mb-4">


					<div id="shippingFormDetails" style="display: none;">
						<h4 class="mb-3">Billing Address</h4>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="firstName" id="billingFirstNameLabel">First
									name</label> <input type="text" class="form-control"
									id="billingFirstName" name="billingFirstName" placeholder="First name"
									value="" required>
								<div class="invalid-feedback">Valid first name is
									required.</div>
							</div>
							<div class="col-md-6 mb-3">
								<label for="lastName" id="billingLastNameLabel">Last
									name</label> <input type="text" class="form-control"
									id="billingLastName" name="billingLastName" placeholder="Last name"
									value="" required>
								<div class="invalid-feedback">Valid last name is required.
								</div>
							</div>
						</div>

						<div class="mb-3">
							<label for="address" id="billingAddressLabel">Address</label> <input
								type="text" class="form-control" id="billingAddress"
								name="billingAddress" placeholder="1234 Main St" required>
							<div class="invalid-feedback">Please enter your shipping
								address.</div>
						</div>

						<div class="mb-3">
							<label for="address2" id="billingAddress2Label">Address 2
								<span class="text-muted">(Optional)</span>
							</label> <input type="text" class="form-control" id="billingAddress2"
								name="billingAddress2" placeholder="Apartment or suite">
						</div>

						<div class="row">
							<div class="col-md-5 mb-3">
								<label for="country" id="billingCountryLabel">Country</label> 
								<input
									class="form-control d-block w-100" id="billingCountry"
									name="billingCountry" required>
								<div class="invalid-feedback">Please select a valid
									country.</div>
							</div>
							<div class="col-md-4 mb-3">
								<label for="state" id="billingStateLabel">State</label> 
								<input
									class="form-control d-block w-100" id="billingState"
									name="billingState" required>
								<div class="invalid-feedback">Please provide a valid
									state.</div>
							</div>
							<div class="col-md-3 mb-3">
								<label for="zip" id="billingPostalCodeLabel">Zip</label> <input
									type="text" class="form-control" id="billingPostalCode"
									name="billingPostalCode" placeholder="Postal code" required>
								<div class="invalid-feedback">Zip code required.</div>
							</div>

						</div>
						<hr class="mb-4">
					</div>



					<div class="accordion" id="accordionExample">
						<div class="card z-depth-0 bordered">
							<div class="card-header" id="headingOne">
								<h5 class="mb-0">
									<button class="btn btn-link" id="paymentButton" type="button"
										data-toggle="collapse" data-target="#collapseOne"
										aria-expanded="true" aria-controls="collapseOne">
										Step 2: Payment <i class="fa fa-arrow-circle-down pl-2"
											aria-hidden="true"></i>
									</button>
								</h5>
							</div>

							<div id="collapseOne" class="collapse"
								aria-labelledby="headingOne" data-parent="#accordionExample">
								<div class="card-body">
								
									<!-- <div class="d-block my-3">
										<div class="custom-control custom-radio">
											<input id="credit" name="paymentMethod" type="radio"
												class="custom-control-input" checked required> <label
												class="custom-control-label" for="credit">Credit
												card</label>
										</div>
										<div class="custom-control custom-radio">
											<input id="debit" name="paymentMethod" type="radio"
												class="custom-control-input" required> <label
												class="custom-control-label" for="debit">Debit card</label>
										</div>
										<div class="custom-control custom-radio">
											<input id="paypal" name="paymentMethod" type="radio"
												class="custom-control-input" required> <label
												class="custom-control-label" for="paypal">PayPal</label>
										</div>
									</div> -->
									
									<div class="row">
										<div class="col-md-6 mb-3">
											<label for="cc-name" id="cc-nameLabel">Name on card</label> <input type="text"
												class="form-control" id="cc-name" name="cc-name"
												placeholder="" value="<%= cardHolderName %>" required> <small class="text-muted">Full
												name as displayed on card</small>
											<div class="invalid-feedback">Name on card is required
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<label for="cc-number" id="cc-numberLabel">Credit card number</label> <input
												type="text" class="form-control" id="cc-number"
												name="cc-number" placeholder="" required>
											<div class="invalid-feedback">Credit card number is
												required</div>
										</div>
									</div>
									<div class="row">
									
										<div class="col-md-3 mb-3">
											<label for="cc-exp-year" id="cc-expYearLabel">Expiration Year</label> <input
												type="text" class="form-control" id="cc-exp-year"
												name="cc-exp-year" placeholder="" required>
											<div class="invalid-feedback">Expiration date required
											</div>
										</div>
										
										<div class="col-md-3 mb-3">
											<label for="cc-exp-month" id="cc-expMonthLabel">Expiration Month</label> 
										    <select
												class="custom-select d-block w-100 form-control" id="cc-exp-month" name="cc-exp-month"
												id="cityId">
												<option value="">Select Month</option>
												<option value="01">January</option>
												<option value="02">February</option>
												<option value="03">March</option>
												<option value="04">April</option>
												<option value="05">May</option>
												<option value="06">June</option>
												<option value="07">July</option>
												<option value="08">August</option>
												<option value="09">September</option>
												<option value="10">October</option>
												<option value="11">November</option>
												<option value="12">December</option>
											</select>
												
											<div class="invalid-feedback">Expiration date required
											</div>
										</div>
										
										<div class="col-md-3 mb-3">
											<label for="cc-cvv" id="cc-cvvLabel">CVV</label> <input type="text"
												class="form-control" id="cc-cvv" name="cc-cvv"
												placeholder="" required>
											<div class="invalid-feedback">Security code required</div>
										</div>
									</div>
								</div>
							</div>

						</div>
					</div>

					<hr class="mb-4">


					<button class="btn blue-gradient btn-lg btn-block rounded my-5"
						type="submit" id="checkoutBtn" onclick="verifyFormDetails(event)">Continue
						to checkout</button>

					<input type="hidden" name="getPaymentValue" id="getPaymentValue"
						value=""> <input type="hidden"
						name="getPaymentCardEncrypted" id="getPaymentCardEncrypted"
						value="">
				</form>
			</div>
		</div>
	</div>

	<% } else {
	//System.out.println("Shopping Cart Session: " +session.getAttribute("shoppingCart"));
	response.sendRedirect("./shoppingCart.jsp");
	return;
	} 
} catch (Exception e) {
	System.out.println("[REDIRECT TO CREATE CUSTOMER ORDER SERVLET ERROR]: " +e);
	response.sendRedirect("./shoppingCart.jsp?checkout=error");
	return;
}%>

	<%@ include file="../HTML/WebPageFooter.html"%>
</body>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="//geodata.solutions/includes/countrystatecity.js"></script>
<script src="../../js/DynamicNavBar.js"></script>
<script src="../../js/ValidateCheckoutForm.js"></script>
<script>
function GetURLParameter(sParam) {
	var sPageURL = window.location.search.substring(1);
	//As URL parameters are split via '&', it retrieves the parameter title (e.g. 'errCode')
	var sURLVariables = sPageURL.split('&');
	for (var i = 0; i < sURLVariables.length; i++) {
		var sParameterName = sURLVariables[i].split('=');
		if (sParameterName[0] == sParam) {
			return sParameterName[1];
		}
	}
}

//These variables retrieves the respective URL Parameters' value
var paymentCode = GetURLParameter('payment');

if (paymentCode) {
	if (paymentCode == 'invalid') {
		$(".unauthoriseAlert").text("Your card used was invalid for our E-Commerce Site! Please try again!");
		$(".unauthoriseAlert").css('display', 'block');
	}
}
</script>
</html>