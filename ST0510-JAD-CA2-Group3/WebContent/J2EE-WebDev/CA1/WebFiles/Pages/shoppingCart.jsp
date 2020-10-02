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
<link rel="stylesheet" type="text/css" href="../../css/shoppingCart.css">
</head>

<body>
	<%@ include file="../JSPProcessing/sqlPassword.jsp"%>
	<%@ include file="../HTML/WebPageNavBar.jsp"%>

	<%
	String userType = userRole;
	
	// If the user is not logged in, userRole is null otherwise it has a value
	// If user is a guest then immediately redirect them to HomePage.jsp to prevent access to cart
	/*if (userType == null || userType.equals("guest")) {
		response.sendRedirect("../Pages/HomePage.jsp?msg=NotLoggedIn");
	}*/
	%>

	<div class="jumbotron jumbotron-fluid"
		style="display: block; background-image: linear-gradient(to right, #0b2040, #0a224a) !important;">
		<div class="container">
			<h1 class="display-4 mt-3 text-light">Shopping Cart</h1>
			<p class="text-light">Don't hesitate! Purchase now!</p>
		</div>
	</div>

	<div class="container cartContainer p-5">
		<div class="alert unauthoriseAlert alert-danger"
			style="display: none;">
			<a style="color: black" href="Login.jsp"><strong>You
					must be logged in to checkout! <u>Click here to register /
						login!</u> (Your cart will be reset!)
			</strong></a>
		</div>
		<a href="./viewAllProducts.jsp" class="text-muted small">Click
			here to add more products</a>
		<div class="row">
			<div class="col-9">
				<table class="table">
					<thead class="text-center bg-dark text-light">
						<tr>
							<th>Product</th>
							<th></th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Remove</th>
						</tr>
					</thead>

					<tbody class="text-center">
						<%
					shoppingCart shoppingCart = new shoppingCart();
					ArrayList<shoppingCart> cartList = new ArrayList<shoppingCart>();
					double shippingCost = 4.50;
					double totalPrice = 0;
					
					if (session.getAttribute("shoppingCart") != null) {
						cartList = (ArrayList<shoppingCart>) session.getAttribute("shoppingCart");
					
					for (int i = 0; i < cartList.size(); i++) {
						totalPrice += (cartList.get(i).getProductSellPrice() * cartList.get(i).getQtyInCart());
					%>
						<tr>
							<td class="productImage"><img
								src="../../Group3DIT2B21Resources/<%= cartList.get(i).getProductImage() %>"
								alt="<%= cartList.get(i).getProductName() %>" width="70"
								class="img-fluid rounded border shadow-sm"></td>
							<td class="text-left"><%= cartList.get(i).getProductName() %><p>
									<span class="text-muted small">Category: <%= cartList.get(i).getProductCategory() %></span>
								</p></td>
							<td><%= cartList.get(i).getProductSellPrice() %></td>

							<td class="rescaleInput" style="display: inline-block;">
								<form action="../../../../cartManagement" method="post">
									<input type="hidden" value="<%= i %>" name="getIndexToDelete">
									<input type="hidden" value="" name="managementAction"
										class="managementAction">
									<div class="number-input md-number-input">
										<button
											class="btn btn-lg shadow-none p-0 pr-2 btnManagementActionRemQty"
											data-action-value="remQty">
											<span><i class="fa fa-minus" aria-hidden="true"></i></span>
										</button>
										<input class="form-control qtyInput" min="0" name="quantity"
											value="<%= cartList.get(i).getQtyInCart() %>" type="number"
											readonly>
										<button
											class="btn btn-lg shadow-none p-0 pl-2 btnManagementActionAddQty"
											data-action-value="addQty">
											<span><i class="fa fa-plus" aria-hidden="true"></i></span>
										</button>
									</div>
								</form>
							</td>

							<td>
								<form action="../../../../cartManagement" method="post">
									<input type="hidden" value="<%= i %>" name="getIndexToDelete">
									<input type="hidden" value="" name="managementAction"
										class="managementAction">
									<button
										class="btn btn-lg shadow-none trashButton rounded-left btnManagementActionDelete"
										data-action-value="delete"
										style="margin-top: -10px !important">
										<span><i class="fa fa-trash" aria-hidden="true"></i></span>
									</button>
								</form>
							</td>
						</tr>
						<% }
							   } %>
					</tbody>
				</table>
			</div>

			<div class="col-3">
				<!-- Card -->
				<div class="card">

					<!-- Card image -->
					<div class="view overlay">
						<img class="card-img-top"
							src="https://mdbootstrap.com/img/Mockups/Lightbox/Thumbnail/img%20(67).jpg"
							alt="Card image cap"> <a href="#!">
							<div class="mask rgba-white-slight"></div>
						</a>
					</div>

					<!-- Card content -->
					<form action="checkoutCart.jsp" method="POST">
						<div class="card-body">

							<!-- Title -->
							<h4 class="card-title text-center">
								<b>TOTAL</b>
							</h4>
							<!-- Text -->
							<p class="card-text">
								<strong>Sub-Total: </strong>$<%= totalPrice %></p>
							<p class="card-text">
								Delivery <a href="#" class="infoAnchor" data-toggle="popover"
									title="Delivery"
									data-content="Standard fee of $<%=shippingCost%>, takes 2 to 4 working days.">
									<i class="fa fa-info-circle text-muted" aria-hidden="true"></i>
								</a>
							</p>
							<p class="card-text">
								<strong>Shipping: </strong>$<%= shippingCost %></p>
							<p class="card-text">
								<strong>Total: </strong>$<%= totalPrice + shippingCost %></p>
							<input type="hidden" name="shippingCost"
								value="<%= shippingCost %>" /> <input type="hidden"
								name="totalCost" value="<%= totalPrice + shippingCost %>" />
						</div>

						<div class="card-footer text-center">
							<!-- Button -->
							<button type="submit" class="btn blue-gradient rounded"
								style="display: inline-block;">CHECKOUT</button>
						</div>
					</form>

				</div>
				<!-- Card -->
			</div>

		</div>

		<% if (session.getAttribute("shoppingCart") == null || cartList.size() < 1) { %>
		<input type="hidden" value="0" id="cartItems" name="cartItems">
		<% } %>


	</div>

	<%@ include file="../HTML/WebPageFooter.html"%>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
<script src="../../js/DynamicNavBar.js"></script>
<script src="../../js/cartManagement.js"></script>
<script>
	$(".btnManagementActionRemQty").click(function() {
		var actionValue = $(this).attr('data-action-value');
		console.log("Action Value:" + actionValue);
		$(".managementAction").val(actionValue);
		console.log($(".managementAction").val());
	});

	$(".btnManagementActionAddQty").click(function() {
		var actionValue = $(this).attr('data-action-value');
		console.log("Action Value:" + actionValue);
		$(".managementAction").val(actionValue);
		console.log($(".managementAction").val());
	});

	$(".btnManagementActionDelete").click(function() {
		var actionValue = $(this).attr('data-action-value');
		console.log("Action Value:" + actionValue);
		$(".managementAction").val(actionValue);
		console.log($(".managementAction").val());
	});

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
	var errCode = GetURLParameter('error');
	var actionCode = GetURLParameter('action');
	var paymentCode = GetURLParameter('payment');

	//If the value matches either of the conditions below, it updates the text content of the html element

	if (paymentCode) {
		if (paymentCode == 'invalid') {
			$(".unauthoriseAlert")
					.text(
							"Your card used was invalid for our E-Commerce Site! Please try again!");
			$(".unauthoriseAlert").css('display', 'block');
		}
	} else {

		if (errCode) {
			if (errCode == 'NotLoggedIn') {
				$(".unauthoriseAlert")
						.html(
								"<strong>You must be logged in to checkout! <u>Click here to register / login!</u> (Your cart will be reset!)</strong>");
				$(".unauthoriseAlert").css('display', 'block');
				$(".unauthoriseAlert").fadeIn();
			}
		} else {
			$(".unauthoriseAlert").css('display', 'none');

			if (actionCode) {
				if (actionCode == 'failedIncrement') {
					$(".unauthoriseAlert").text("Minimum quantity of 1.");
					$(".unauthoriseAlert").css('display', 'block');
					$(".unauthoriseAlert").fadeIn();
				} else if (actionCode == 'failedDecrement') {
					$(".unauthoriseAlert").text(
							"Product's maximum quantity reached.");
					$(".unauthoriseAlert").css('display', 'block');
					$(".unauthoriseAlert").fadeIn();
				}
			} else {
				$(".unauthoriseAlert").css('display', 'none');
			}
		}
	}
</script>
</html>