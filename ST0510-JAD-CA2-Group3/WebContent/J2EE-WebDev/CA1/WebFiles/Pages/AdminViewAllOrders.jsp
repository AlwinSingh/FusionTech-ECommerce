<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.sql.*, shoppingCart.*, java.util.ArrayList, fusionTechProductModel.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - View Customer</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link href="../../css/AdminDash.css" rel="stylesheet">

<style>
.my-custom-scrollbar {
	position: relative;
	height: 200px;
	overflow: auto;
}

.table-wrapper-scroll-y {
	display: block;
}

.submitFormButton:hover {
	background-color: #0275d8 !important;
	cursor: pointer;
}
</style>
</head>
<body>
<body>
	<%@ include file="../JSPProcessing/sqlPassword.jsp"%>
	<%@include file="../HTML/WebPageNavBar.jsp"%>

	<div class="container-fluid pt-5 mt-5">
		<div class="row">

			<%@include file="../HTML/adminDashNavBar.jsp"%>

			<%	
			ArrayList<orderDetails> adminOrdersList = null;
			ArrayList<allProducts> adminOrderItemsList = null;

			if (session.getAttribute("adminOrdersList") != null) {
				adminOrdersList = (ArrayList<orderDetails>) session.getAttribute("adminOrdersList");
				adminOrderItemsList = (ArrayList<allProducts>) session.getAttribute("adminOrderItemsList");
			%>

			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 p-0">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 px-md-4 border-bottom">
					<h1 class="h2 displayHeader">Display All Orders</h1>
					<div class="wrap">
					</div>
				</div>

				<div
					class="table-wrapper-scroll-y fusionTech-scrollbar pb-2 px-md-4 mb-3 mt-3 table-responsive text-nowrap">
					<div style="min-height: 343px !important;">

						<form id="inquiryForm" action="../../../../inquireReportOrders"
							class="row pb-2 px-md-4 mb-1 mt-2" method="get">
							<input type="hidden" id="buttonValue" name="buttonValue" value="" />
							<input type="hidden" id="filterInputValue"
								name="filterInputValue" value="" />
							<button type="submit"
								class="btn btn-md btn-primary text-light col font-weight-bold tableTypeBtn"
								value="PFO">
								<i class="fas fa-money-bill-wave mr-1"></i> Most Profitable
								orders
							</button>
							<button type="button" data-toggle="collapse"
								data-target="#inputMonth"
								class="btn btn-md btn-primary text-light col font-weight-bold tableTypeBtn"
								value="OBM">
								<i class="fas fa-calendar-alt mr-1"></i> Filter by month
							</button>
							<button data-toggle="collapse" data-target="#inputItemsThreshold"
								type="button"
								class="btn btn-md btn-primary text-light col font-weight-bold tableTypeBtn"
								value="OBI">
								<i class="fas fa-box-open mr-1"></i> Order by number of items
								ordered
							</button>
							<button type="submit"
								class="btn btn-md primary-color-dark text-light col font-weight-bold"
								id="resetTableBtn">
								<i class="fas fa-exclamation-triangle mr-1"></i> Reset (View All
								Orders)
							</button>
						</form>

						<div class="row pb-2 px-md-4 mb-1 mt-2 text-center">
							<div class="col-3 collapse multi-collapse" id="inputMonth">
								<div class="input-group mb-3 mx-auto d-block">
									<select class="custom-select d-block w-100 form-control"
										id="orderByMonth" name="orderByMonth">
										<option value="">Select Month</option>
										<option value="January">January</option>
										<option value="February">February</option>
										<option value="March">March</option>
										<option value="April">April</option>
										<option value="May">May</option>
										<option value="June">June</option>
										<option value="July">July</option>
										<option value="August">August</option>
										<option value="September">September</option>
										<option value="October">October</option>
										<option value="November">November</option>
										<option value="December">December</option>
									</select>
									<button class="btn btn-sm btn-dark text-light rounded submitFormButton"
										data-filterType="OBM">Submit</button>
								</div>
							</div>

							<div class="col-3 collapse multi-collapse"
								id="inputItemsThreshold">
								<div class="input-group mb-3">
									<input type="number" class="form-control obiInput"
										placeholder="Enter number of items threshold"
										aria-label="Items threshold"
										aria-describedby="Items threshold">
									<div class="input-group-append">
										<span
											class="input-group-text submitFormButton text-light btn-dark"
											data-filterType="OBI">Submit</span>
									</div>
								</div>
							</div>
						</div>

						<!-- <form action="./displayCategoryProducts.jsp" method="POST"> -->
						<% if (adminOrdersList.size() > 0) { %>
						<table
							class="table table-bordered table-hover table-sm text-center"
							id="tbl-content">
							<thead class="text-light" style="background-color: #0a224a;">
								<tr>
									<th scope="col">Order ID</th>
									<th scope="col">View Details</th>
									<th scope="col">View Dates</th>
									<th scope="col">View Payment</th>
									<th scope="col" class="dynamicTableHeader">Status</th>
								</tr>
							</thead>
							<%
									for (int i = 0; i < adminOrdersList.size(); i++) {
									//System.out.println(adminOrdersList.get(i).getUserEmail());
								%>
							<tr>
								<td><%=adminOrdersList.get(i).getOrderID()%></td>
								<td>
									<button type="button"
										class="btn btn-sm btn-primary text-light btnViewOrderDetails"
										data-toggle="modal" data-target="#orderDescModal"
										data-order-id="<%= adminOrdersList.get(i).getOrderID() %>">View
										Details</button>
								</td>
								<td>
									<button type="button"
										class="btn btn-sm btn-primary text-light btnViewOrderDate"
										data-toggle="modal" data-target="#orderDescModal"
										data-order-date="<%= adminOrdersList.get(i).getOrderDate() %>"
										data-shipped-date="<%= adminOrdersList.get(i).getShippedDate() %>"
										data-expected-date="<%= adminOrdersList.get(i).getExpectedDate() %>">View
										Dates</button>
								</td>
								<td>
									<button type="button"
										class="btn btn-sm btn-primary text-light btnViewOrderPayment"
										data-toggle="modal" data-target="#orderDescModal"
										data-payment-method="<%= adminOrdersList.get(i).getPaymentMethod() %>"
										data-payment-amount="<%= adminOrdersList.get(i).getOrderCurrencySymbol() %> <%= adminOrdersList.get(i).getPaymentAmount() %>"
										data-coupon-code="<%= adminOrdersList.get(i).getCouponCode() %>">View
										Payment</button>
								</td>

								<% 
								if (adminOrdersList.get(i).getInquiryType() != null) {
								if ((adminOrdersList.get(i).getInquiryType()).equals("PFO")) { %>
								<td>$<%=adminOrdersList.get(i).getOrderProfit()%></td>
								<% } else if ((adminOrdersList.get(i).getInquiryType()).equals("OBM")) { %>
								<td><%=adminOrdersList.get(i).getOrderMonth()%></td>
								<% } else if ((adminOrdersList.get(i).getInquiryType()).equals("OBI")) { %>
								<td><%=adminOrdersList.get(i).getOrderQuantity()%></td>
								<% }
								} else { %>
								<td><%=adminOrdersList.get(i).getOrderStatus()%></td>
								<% } %>
							</tr>

							<%
								}
							 }
							%>

						</table>

						<% } else { %>
						<p class="text-center">Oops! There aren't any user orders</p>
						<% } 
						
						if (adminOrderItemsList == null) { %>
						<p class="text-center">Oops! There aren't any user orders</p>
						<% } %>

						<!-- <input type="hidden" id="ProductLineID" name="getProductLineID"
								value=""> <input type="hidden" id="ProductLineName"
								name="getProductLineName" value="">
						</form> -->
					</div>
				</div>

				<%@ include file="../HTML/WebPageFooter.html"%>
			</main>
		</div>
	</div>

	<% if (adminOrderItemsList != null) { 
	%>
	<div id="orderItemsListForm">
		<% for (int j = 0; j < adminOrderItemsList.size(); j++) { %>
		<input type="hidden"
			data-order-id="<%= adminOrderItemsList.get(j).getProductOrderID()%>"
			data-product-code="<%= adminOrderItemsList.get(j).getProductCode() %>"
			data-product-catname="<%= adminOrderItemsList.get(j).getProductCategoryName() %>"
			data-product-supplier="<%= adminOrderItemsList.get(j).getProductsupplier() %>"
			data-product-image="<%= adminOrderItemsList.get(j).getProductImage() %>">
		<% } %>
	</div>
	<% } %>

	<!-- Modal -->
	<div class="modal fade" id="orderDescModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title modalHeaderText" id="exampleModalLabel">Order</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn primary-color-dark text-light"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="../../js/DynamicNavBar.js"></script>
<script src="../../js/animateNavBar.js"></script>
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
	var reportCode = GetURLParameter('inquireReport');

	switch (reportCode) {
	case 'PFO':
		$(".displayHeader").text("Profitable Orders");
		$(".dynamicTableHeader").text("Profit");
		break;
	case 'OBM':
		$(".displayHeader").text("Orders by Date");
		$(".dynamicTableHeader").text("Month");
		break;
	case 'OBI':
		$(".displayHeader").text("Orders by Total Items");
		break;
	case 'default':
		$(".displayHeader").text("Display All Orders");
		break;
	}

	$("#orderByMonth").change(function() {
		var selectedMonth = $(this).children("option:selected").val();
	});

	$("#resetTableBtn").click(function() {
		$("#inquiryForm").attr('action', '../../../../adminGetAllOrders');
	});

	$(".tableTypeBtn").click(function() {
		var getTableType = $(this).val();
		$("#buttonValue").val(getTableType);
	});

	$(".submitFormButton").click(
			function(event) {
				var filterType = $(this).attr('data-filterType');

				if (filterType == "OBI") {
					var itemValue = $(".obiInput").val();
					$("#filterInputValue").val(itemValue)
				} else if (filterType == "OBM") {
					var monthValue = $("#orderByMonth").children(
							"option:selected").val();
					$("#filterInputValue").val(monthValue);
				}

				if ($("#filterInputValue").val().length > 0) {
					$("#inquiryForm").attr('action',
							'../../../../inquireReportOrders')
					$("#inquiryForm").submit();
				} else {
					alert('Invalid input!');
					event.preventDefault();
					return false;
				}
			});

	$(".btnViewOrderDetails")
			.click(
					function() {
						$(".modal-body").empty();
						var htmlBody = "";
						var orderID = $(this).attr('data-order-id');
						console.log("Button press order id: " + orderID);

						$("#orderItemsListForm input[type=hidden]")
								.each(
										function() {
											var inputOrderID = $(this).attr(
													'data-order-id');

											if (inputOrderID == orderID) {
												var productCode = $(this).attr(
														'data-product-code');
												var productCatName = $(this)
														.attr(
																'data-product-catname');
												var productSupplier = $(this)
														.attr(
																'data-product-supplier');
												var productImage = $(this)
														.attr(
																'data-product-image');

												$(".modalHeaderText").text(
														'Order Details');
												var htmlBody = "Product Code: "
														+ productCode
														+ "<br>"
														+ "Product Category: "
														+ productCatName
														+ "<br>"
														+ "Product Supplier: "
														+ productSupplier
														+ "<br>"
														+ "Product Image:<br> "
														+ "<img class='img-fluid' src=../../Group3DIT2B21Resources/" + productImage + ">";

												$(".modal-body")
														.append(
																htmlBody
																		+ "<br><br><hr>");
											}
											;
										});

					});

	$(".btnViewOrderDate").click(
			function() {
				var orderDate = $(this).attr('data-order-date');
				var shippedDate = $(this).attr('data-shipped-date');
				var expectedDate = $(this).attr('data-expected-date');
				$(".modalHeaderText").text('Order Dates Information');
				$(".modal-body").html(
						'Order Date: ' + orderDate + '<br><br> Shipped Date: '
								+ shippedDate + '<br><br> Expected Date: '
								+ expectedDate + '<br>');
			});

	$(".btnViewOrderPayment").click(
			function() {
				var paymentMethod = $(this).attr('data-payment-method');
				var paymentAmount = $(this).attr('data-payment-amount');
				var paymentCode = $(this).attr('data-coupon-code');
				$(".modalHeaderText").text('Order Payment Information');
				$(".modal-body").html(
						'Payment Method: ' + paymentMethod
								+ '<br><br> Payment Amount: ' + paymentAmount
								+ '<br><br> Payment Code: ' + paymentCode
								+ '<br>');
			});
</script>
</html>
