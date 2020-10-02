<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.sql.*, fusionTechProductModel.*, java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - View Product Result</title>
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
				System.out.println(session.getAttribute("productsList"));
			if (session.getAttribute("productsList") != null) {
				System.out.println("Exists....: " + session.getAttribute("productsList"));
				ArrayList<allProducts> productsList = (ArrayList<allProducts>) session.getAttribute("productsList");
				System.out.println("Loaded the arrayList... " + productsList.size());
			%>

			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 p-0">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 px-md-4 border-bottom">
					<h1 class="h2">Display All Customers</h1>
					<div class="wrap">
						<%@include file="../HTML/adminDashCatSearchBar.html"%>
					</div>
				</div>

				<div
					class="table-wrapper-scroll-y fusionTech-scrollbar pb-2 px-md-4 mb-3 mt-3 table-responsive text-nowrap">
					<div style="min-height: 343px !important;">
						<form action="./displayCategoryProducts.jsp" method="POST">
							<table
								class="table table-bordered table-hover table-sm text-center"
								id="tbl-content">
								<thead class="text-light" style="background-color: #0a224a;">
									<tr>
										<th scope="col">Code</th>
										<th scope="col">Name</th>
										<th scope="col">Supplier</th>
										<th scope="col">Category Name (ID)</th>
										<th scope="col">Quantity</th>
										<th scope="col">Price</th>
										<th scope="col">Description</th>
										<th scope="col">Image</th>
										<th scope="col">View</th>
									</tr>
								</thead>
								<%
									for (int i = 0; i < productsList.size(); i++) {
									//System.out.println(usersList.get(i).getUserEmail());
								%>
								<tr>
									<td><%=productsList.get(i).getProductCode()%></td>
									<td><%=productsList.get(i).getProductName()%></td>
									<td><%=productsList.get(i).getProductCategoryName()%> (<%=productsList.get(i).getProductCategoryID()%>)</td>
									<td><%=productsList.get(i).getProductQtyInStock()%></td>
									<td><%=productsList.get(i).getProductSellPrice()%></td>
									<td>
										<button type="button"
											class="btn btn-sm btn-primary text-light btnDesc"
											data-toggle="modal" data-target="#otherInfoModal"
											data-custom-description="<%=productsList.get(i).getProductDesc()%>"
											data-custom-brief-description="<%=productsList.get(i).getProductbriefDesc()%>">
											View Description</button>
									</td>
									<td>
										<button type="button"
											class="btn btn-sm btn-primary text-light btnImage"
											data-toggle="modal" data-target="#otherInfoModal"
											data-image="<%=productsList.get(i).getProductImage()%>">
											View Image</button>
									</td>
									<td>
										<button type="button"
											class="btn btn-sm btn-primary text-light viewBtnProcess"
											data-toggle="modal" data-target="#otherInfoModal"
											data-custom-value-name="<%=productsList.get(i).getProductName()%>"
											data-custom-value="<%=productsList.get(i).getProductCode()%>">
											View Product</button>
									</td>
									<%
										}
									}
									%>
								
							</table>

							<!-- <input type="hidden" id="ProductLineID" name="getProductLineID"
								value=""> <input type="hidden" id="ProductLineName"
								name="getProductLineName" value=""> -->
						</form>
					</div>
				</div>
				<%@ include file="../HTML/WebPageFooter.html"%>
			</main>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="otherInfoModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Other User
						Information</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<b class="font-weight-bold">User's Address 1:</b>
					<p class="address1"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
					<br> <b class="font-weight-bold">User's Address 2:</b>
					<p class="address2"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
					<br> <b class="font-weight-bold">Phone Number</b>
					<p class="phone"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
					<br> <b class="font-weight-bold">City:</b>
					<p class="city"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
					<br> <b class="font-weight-bold">State:</b>
					<p class="state"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
					<br> <b class="font-weight-bold">Postal Code:</b>
					<p class="postalCode"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
					<br> <b class="font-weight-bold">Country:</b>
					<p class="country"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
				</div>
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
	//Similar to the other view product button in other pages, it stores product name and id into the hidden field that will
	//be used by the viewProduct.jsp to display the appropriate product
	$('.viewBtnProcess').click(
			function() {
				//Retrieves the attribute name and passes it into the attribute 'value' of the variables
				var categoryName = $(this).attr('data-custom-value-name');
				var categoryID = $(this).attr('data-custom-value');
				var setHiddenInputName = $("#productNameInput").attr('value',
						categoryName)
				var setHiddenInputValue = $("#productInput").attr('value',
						categoryID)
			});

	$(".btnImage")
			.click(
					function() {
						//Upon clicking the view image button, it will alter the html elements below
						var imageName = $(this).attr('data-custom-value');
						//It will get the imageName through a custom attribute value and pass it to the content that will be displayed in the Modal under the folder 'Group3DIT2B21Resources'
						$(".imageModalBody")
								.html(
										"<img class='img-responsive' style='max-height: 300px' src='../../Group3DIT2B21Resources/" + imageName + "' alt=" + imageName + ">");

					});

	$(".btnDesc").click(function() {
		//Upon clicking this button, it will alter the html elements below.
		//It will also display the modal through Bootstrap 4 modal toggle properties for button
		var description = $(this).attr('data-custom-desc');
		var briefDescription = $(this).attr('data-custom-brief-desc');

		$(".pdtFullDesc").text(description);
		$(".pdtBriefDesc").text(briefDescription);
	});
</script>
</body>
</html>
