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
	import="java.util.*, java.sql.*, fusionTechProductModel.*, fusionTechUserModel.*, shoppingCart.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - Edit Profile</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="../../css/editProfile.css">
</head>

<%
	UserDetails user = new UserDetails();
	ArrayList<allProducts> orderItemsList = null;
	ArrayList<orderDetails> ordersList = null;
	ArrayList<UserAddresses> orderShippingInfoList = null;
	
	if (session.getAttribute("userData") != null) {
		user = (UserDetails) session.getAttribute("userData");
	} else {
		response.sendRedirect("HomePage.jsp?error=notLoggedIn");
		return;
	}
	
	if (session.getAttribute("ordersList") != null && session.getAttribute("orderItemsList") != null && session.getAttribute("orderShippingInfoList") != null) {
		ordersList = (ArrayList<orderDetails>) session.getAttribute("ordersList");
		orderItemsList = (ArrayList<allProducts>) session.getAttribute("orderItemsList");
		orderShippingInfoList = (ArrayList<UserAddresses>) session.getAttribute("orderShippingInfoList");
%>

<body>
	<%@ include file="../HTML/WebPageNavBar.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col-lg-4">
				<div class="profile-card-4 z-depth-3">
					<div class="card">
						<div class="card-body text-center primary-color-dark rounded-top">
							<div class="user-box">
								<img src="https://bootdey.com/img/Content/avatar/avatar7.png"
									alt="user avatar">
							</div>
							<h5 class="mb-1 text-white"><%= userName %></h5>
							<h6 class="text-light text-capitalize"><%= userRole %></h6>
							<p class="badge" id="editMsg"></p>
						</div>
						<div class="card-body">
							<ul class="list-group shadow-none">
								<li class="list-group-item">
									<div class="list-icon">
										<i class="fa fa-phone-square"></i>
									</div>
									<div class="list-details">
										<span style="display: none" class="userPhone"><%= user.getUserPhone() %></span>
										<small>Mobile Number</small>
									</div>
								</li>
								<li class="list-group-item">
									<div class="list-icon">
										<i class="fa fa-envelope"></i>
									</div>
									<div class="list-details">
										<span><%= user.getUserEmail() %></span> <small>Email
											Address</small>
									</div>
								</li>
								<li class="list-group-item primary-color-dark">
									<div class="list-icon text-light">
										<i class="fa fa-globe"></i>
									</div>
									<div class="list-details">
										<a class="text-light" href="./editProfile.jsp"> <span>Edit
												Profile</span> <small class="text-light">Return to editing
												your profile</small>
										</a>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-8">
				<div class="card z-depth-3">
					<div class="card-body">
						<ul class="nav nav-pills nav-pills-muted nav-justified mb-4">
							<li class="nav-item"><a data-target="#edit"
								data-toggle="pill"
								class="nav-link primary-color-dark text-white disabled"> <i
									class="icon-note"></i> <span class="hidden-xs">View
										Orders</span></a></li>
						</ul>
						<div class="tab-pane" id="edit">
							<form action="../../../../updateUserProfile" method="POST">
								<!-- <div class="row"> -->
								<%
								if (ordersList.size() > 0) {
									for (int i = 0; i < ordersList.size(); i++) {
								%>

								<!--Grid row-->
								<div class="row">

									<!--Grid column-->
									<div class="col-12 mb-4">

										<!-- Card -->
										<div class="card gradient-card">

											<div class="card-image"
												style="background-image: url(https://mdbootstrap.com/img/Photos/Others/images/31.jpg)">

												<!-- Content -->
												<a href="#" data-toggle="modal"
													data-target="#order<%= ordersList.get(i).getOrderID() %>">
													<div
														class="text-white d-flex h-100 mask blue-gradient-rgba">
														<div class="first-content align-self-center p-3">
															<h3 class="card-title">
																Order #<%= ordersList.get(i).getOrderID() %></h3>
															<p class="lead mb-0">Click to view details</p>
														</div>
														<div
															class="second-content align-self-center mx-auto text-center">
															<i class="far fa-money-bill-alt fa-3x"></i>
														</div>
													</div>
												</a>
											</div>

											<div class="card-body white">
												<!-- Data -->
												<div class="third-content ml-auto mr-4 mt-2 mb-1">
													<p class="text-uppercase text-muted text-right">Total</p>
													<h4 class="font-weight-bold float-right">
														<%= ordersList.get(i).getOrderCurrencySymbol() %> <%= ordersList.get(i).getPaymentAmount() %></h4>
												</div>

												<!--<div class="progress md-progress">
            <div class="progress-bar bg-primary" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
          </div>
          <p class="text-muted">Better than last week (25%)</p>-->
												<h4 class="text-uppercase font-weight-bold my-4">Details</h4>
												<p class="text-muted" align="justify">
													Order ID: #<%= ordersList.get(i).getOrderID() %><br>
													Order Date:
													<%= ordersList.get(i).getOrderDate() %><br> Status:
													<%= ordersList.get(i).getOrderStatus() %><br> Payment
													Method:
													<%= ordersList.get(i).getPaymentMethod() %><br>
													Arrival Date:
													<%= ordersList.get(i).getExpectedDate() %><br> Coupon
													Code:
													<%= ordersList.get(i).getCouponCode() %><br>
												</p>
											</div>

										</div>
										<!-- Card -->

									</div>
									<!--Grid column-->

								</div>


								<!-- Central Modal Small -->
								<div class="modal fade"
									id="order<%= ordersList.get(i).getOrderID() %>" tabindex="-1"
									role="dialog"
									aria-labelledby="order<%= ordersList.get(i).getOrderID() %>Label"
									aria-hidden="true">

									<!-- Change class .modal-sm to change the size of the modal -->
									<div class="modal-dialog modal-md" role="document">


										<div class="modal-content">
											<div class="modal-header">
												<h4 class="modal-title w-100" id="myModalLabel">
													Order #<%= ordersList.get(i).getOrderID() %></h4>
												<button type="button" class="close" data-dismiss="modal"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body">
												<%
												for (int x = 0; x < orderShippingInfoList.size(); x++) {
													if (orderShippingInfoList.get(x).getOrderID() == ordersList.get(i).getOrderID()) { %>
														<p>Shipping Address: <%= orderShippingInfoList.get(x).getAddressLine1() %>, 
														<%= orderShippingInfoList.get(x).getCountry() %>, <%= orderShippingInfoList.get(x).getPostalCode() %> </p>	
														<% if (orderShippingInfoList.get(x).getDeliveryType() == 'Y')  { %> 
														<p>Contactless Delivery: Yes</p>
														<% } else { %>
														<p>Contactless Delivery: No</p>
														<% } %>
												<%	}
												}
												%>
												<hr class="mx-2">
												<% for (int j = 0;  j < orderItemsList.size(); j++) {
													if (orderItemsList.get(j).getProductOrderID() == ordersList.get(i).getOrderID()) {
													 %>
													 <div class="row">
													 <div class="col-6">
													 <p>Product Code: <%= orderItemsList.get(j).getProductCode() %></p>
													 <p>Product Category: <%= orderItemsList.get(j).getProductCategoryName() %></p>
													 <p>Quantity: <%= orderItemsList.get(j).getProductQtyInStock() %></p>
													 <p>Product Supplier: <%= orderItemsList.get(j).getProductsupplier() %></p>
													 <p>Original Sell Price w/o GST (Per Qty): SGD <%= orderItemsList.get(j).getProductSellPriceInSGD() %></p>
													 <p>Currency Sell Price w/o GST (Per Qty): <%= ordersList.get(i).getOrderCurrencySymbol() %> <%= orderItemsList.get(j).getProductSellPrice() %></p>
													 </div>
													 
													 <div class="col-6">
													 <img src="../../Group3DIT2B21Resources/<%= orderItemsList.get(j).getProductImage() %>" class="img-fluid" alt="<%= orderItemsList.get(j).getProductCode() %>">
													 </div>
													 
													 </div>
													 <hr class="mx-2">
												<%	}
												   }
												%>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn primary-color-dark btn-md text-light"
													data-dismiss="modal">Close</button>
												<!--  <button type="button" class="btn btn-primary btn-sm">Save changes</button> -->
											</div>
										</div>
									</div>
								</div>
								<!-- Central Modal Small -->


								<%   } 
									} else { %>
								<p class="text-center">You do not have any orders</p>
								<% } 
									} %>
								<!-- </div> -->
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<%@ include file="../HTML/WebPageFooter.html"%>

</body>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="../../js/DynamicNavBar.js"></script>

<script>
	/*$(".viewAddressBtn").click(function() {
		//console.log(event.target);
		if ($(".columnSpacing").hasClass("col-lg-12")) {
			$(".columnSpacing").removeClass("col-lg-12").addClass("col-lg-4");
		} else if ($(".columnSpacing").hasClass("col-lg-4")) {
			$(".columnSpacing").removeClass("col-lg-4").addClass("col-lg-12");
		}
	});*/

	$(document)
			.ready(
					function() {
						var userPhone = $(".userPhone").text();
						var hideUserPhone = userPhone.substring(0,
								(userPhone.length / 2));
						var censorText = "";

						for (var i = 0; i < userPhone.length / 2; i++) {
							censorText += "X";
						}

						$(".userPhone").text(hideUserPhone + censorText).css(
								'display', 'block');

						$('.modalViewPassBtn')
								.click(
										function() {
											var inputPassword = $(
													"#confirmInputPass").val();
											var originalPassword = $(
													"#hiddenOriginalUserPass")
													.attr('value');

											if (inputPassword == originalPassword) {
												$("#cfmPassErr").removeClass(
														'text-danger').text("");
												$("#userPass").attr('type',
														'text');
												$("#confirmInputPass").val("");
												$(".modal").modal("hide");

												setTimeout(function() {
													$("#userPass").attr('type',
															'password');
												}, 10000);

											} else {
												$("#cfmPassErr")
														.addClass('text-danger')
														.text(
																"Input doesn't match your current password!");
												$("#confirmInputPass").val("");
											}
										});

						$("#viewPassBtn").click(function() {
							$(".modal").modal();
						})

						$(".editProfileResetBtn").click(function() {
							$("#userPass").attr('type', 'password');
						})
					});

	function GetURLParameter(sParam) {
		var sPageURL = window.location.search.substring(1);
		var sURLVariables = sPageURL.split('&');
		for (var i = 0; i < sURLVariables.length; i++) {
			var sParameterName = sURLVariables[i].split('=');
			if (sParameterName[0] == sParam) {
				//Once it locates the value passed into the function, it retrieves the next Index [1] which is the value of the URL Parameter
				//It then returns the value which is then stored in a variable 'editCode' down below which is used to match it against conditions
				return sParameterName[1];
			}
		}
	}

	//Retrieves the URL Parameter
	var editCode = GetURLParameter('editCode');

	//Checks the URL Parameter value to see which condition is met and appends the HTML element accordingly
	if (editCode == "true") {
		$("#editMsg").text("Succesfully updated your profile!");
	} else if (editCode == 1062) {
		$("#editMsg").text(
				"Profile update failed! Phone Number / Email already taken!");
	} else if (!isNaN(editCode) && editCode.length > 0) {
		$("#editMsg").text(
				"Profile update failed! Please contact system admin!");
	} else {
		$("#editMsg").empty().hide();
	}
</script>

</html>