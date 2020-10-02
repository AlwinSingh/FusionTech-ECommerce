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
	import="java.sql.*, fusionTechProductModel.*, java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - View Products</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link href="../../css/AdminDash.css" rel="stylesheet">
<link href="../../css/AdminSearch.css" rel="stylesheet">

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
	<%@ include file="../JSPProcessing/sqlPassword.jsp"%>
	<%@include file="../HTML/WebPageNavBar.jsp"%>

	<div class="container-fluid pt-5 mt-5">
		<div class="row">

			<%@include file="../HTML/adminDashNavBar.jsp"%>

			<%
			String currentPage = request.getParameter("page");
			ArrayList<allProducts> productsList = null;

				//System.out.println(session.getAttribute("productsList"));
			if (session.getAttribute("productsList") != null) {
				//System.out.println("Exists....: " + session.getAttribute("productsList"));
				productsList = (ArrayList<allProducts>) session.getAttribute("productsList");
				//System.out.println("Loaded the arrayList... " + productsList.size());
			%>

			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 p-0">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 px-md-4 border-bottom">
					<h1 class="h2 displayMsg"></h1>
					<div class="wrap">
						<form action="../../../../searchProduct" method="get"
							name="searchProduct" class="needs-validation mt-3" novalidate>

							<div class="search input-group md-form form-sm form-1 pl-0 ">
								<div class="input-group-prepend">

									<button type="submit" onclick="validateFields()"
										class="input-group-text primary-color-dark lighten-3">
										<i class="fas fa-search text-white" aria-hidden="true"></i>
									</button>
								</div>
								<input type="text" name="searchProducts"
									class="form-control my-input" id="searchProducts"
									placeholder="Enter Product Name" required>
							</div>
						</form>
					</div>
				</div>



				<div
					class="table-wrapper-scroll-y fusionTech-scrollbar pb-2 px-md-4 mb-3 mt-3 table-responsive text-nowrap">
					<div style="min-height: 343px !important;">

						<form id="inquiryForm" action="../../../../adminGetAllProducts"
							class="row pb-2 px-md-4 mb-1 mt-2" method="get">

							<input type="hidden" id="servletPageNumber"
								name="servletPageNumber" value="" /> <input type="hidden"
								id="pageNumber" name="pageNumber"
								value="<%= Integer.parseInt(currentPage) + 1 %>" /> <input
								type="hidden" id="buttonValue" name="buttonValue" value="" /> <input
								type="hidden" id="filterInputValue" name="filterInputValue"
								value="" />
							<button type="submit"
								class="btn btn-md btn-primary text-light col font-weight-bold tableTypeBtn"
								value="BSP">
								<i class="fas fa-thumbs-up fa-lg mr-1"></i> Best Selling
								Products
							</button>
							<button type="submit"
								class="btn btn-md btn-primary text-light col font-weight-bold tableTypeBtn"
								value="WSP">
								<i class="fas fa-thumbs-down fa-lg mr-1"></i> Worst Selling
								Products
							</button>
							<button type="button" data-toggle="collapse"
								data-target="#inputStockThreshold"
								class="btn btn-md btn-primary text-light col font-weight-bold tableTypeBtn"
								value="PWLS">
								<i class="fas fa-exclamation-triangle fa-lg mr-1"></i> Products
								with Low Stocks
							</button>
							<button type="submit"
								class="btn btn-md primary-color-dark text-light col font-weight-bold tableTypeBtn"
								value="VAP">
								<i class="fas fa-table fa-lg mr-1"></i> Reset (View All
								Products)
							</button>
						</form>

						<div class="row pb-2 px-md-4 mb-1 mt-2 text-center">
							<div class="col-3 collapse multi-collapse"
								id="inputStockThreshold">
								<div class="input-group mb-3">
									<input type="number" class="form-control pwlsInput"
										placeholder="Enter stock threshold"
										aria-label="Stock threshold"
										aria-describedby="Stock threshold">
									<div class="input-group-append">
										<span class="input-group-text submitFormButton"
											data-filterType="PWLS">Submit</span>
									</div>
								</div>
							</div>
						</div>
						<%
							if (productsList.size() > 0) {
						%>
						<form action="./viewProduct.jsp" method="POST">
							<table
								class="table table-bordered table-hover table-sm text-center"
								id="tbl-content">
								<thead class="text-light" style="background-color: #0a224a;">
									<tr>
										<th scope="col">Code</th>
										<th scope="col">Name</th>
										<th scope="col">Supplier</th>
										<th scope="col">Category Name (ID)</th>
										<th scope="col" id="dynamicQuantity"></th>
										<th scope="col" id="dynamicPrice"></th>
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
									<td><%=productsList.get(i).getProductsupplier()%></td>
									<td><%=productsList.get(i).getProductCategoryName()%> (<%=productsList.get(i).getProductCategoryID()%>)</td>
									<td><%=productsList.get(i).getProductQtyInStock()%></td>
									<td><%=productsList.get(i).getProductSellPrice()%></td>
									<td>
										<button type="button"
											class="btn btn-sm btn-primary text-light btnDesc"
											data-toggle="modal" data-target="#pdtDescModal"
											data-custom-description="<%=productsList.get(i).getProductDesc()%>"
											data-custom-brief-description="<%=productsList.get(i).getProductbriefDesc()%>">
											View Description</button>
									</td>
									<td>
										<button type="button"
											class="btn btn-sm btn-primary text-light btnImage"
											data-toggle="modal" data-target="#pdtImageModal"
											data-image="<%=productsList.get(i).getProductImage()%>">
											View Image</button>
									</td>
									<td>
										<button type="submit"
											class="btn btn-sm btn-primary text-light viewBtnProcess"
											data-custom-value-name="<%=productsList.get(i).getProductName()%>"
											data-custom-value="<%=productsList.get(i).getProductCode()%>">
											View Product</button>
									</td>
									<%
										}
									%>
								
							</table>
							<input type="hidden" id="productInput" name="getProductCode"
								value=""> <input type="hidden" id="productNameInput"
								name="getProductName" value="">
						</form>
						<%
							} else {
						%>
						<p class="text-center">Oops! There aren't any product</p>
						<%
							}
						}
						%>
					</div>
				</div>

				<div class="ml-3" id="paginationDiv">
					<ul class="pagination">
						<% if (Integer.parseInt(currentPage) < 1) { %>
						<li class="page-item disabled opacity-50"><a
							class="page-link prevPage">Previous</a></li>
						<% } else { %>
						<li class="page-item"><a class="page-link prevPage">Previous</a></li>
						<% } %>
						<li class="page-item"><a class="page-link dynamicPageNumber">Page
								1</a></li>
						<% if (productsList.size() < 5) { %>
						<li class="page-item disabled opacity-50"><a
							class="page-link nextPage">Next</a></li>
						<% } else { %>
						<li class="page-item"><a class="page-link nextPage">Next</a></li>
						<% } %>
					</ul>
				</div>

				<%@ include file="../HTML/WebPageFooter.html"%>
			</main>
		</div>
	</div>

	<!--  Desc Modal -->
	<div class="modal fade" id="pdtDescModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Product
						Description</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<b>Full Description:</b>
					<p class="pdtFullDesc"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
					<br> <b>Brief Description:</b>
					<p class="pdtBriefDesc"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn primary-color-dark text-light"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Image Modal -->
	<div class="modal fade" id="pdtImageModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Product Image</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body imageModalBody text-center"></div>
				<div class="modal-footer">
					<button type="button" class="btn primary-color-dark text-light"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<!--  Error Modal -->
	<div class="modal" id="errModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Error!</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body customModalBodyText">
					<p></p>
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
<script src="../../js/AdminDashSearchBar.js"></script>

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
	var inquiryType = GetURLParameter("inquireReport");

	if (inquiryType) {
		$("#buttonValue").val(inquiryType);
	} else {
		$("#buttonValue").val("VAP");
		if (inquiryType == "VAP") {
			$(".displayMsg").val("Test");
		}
	}

	$(".tableTypeBtn").click(function() {
		var getTableType = $(this).val();
		var setTableType = $("#buttonValue").val(getTableType);
	});

	/*$(".page-link").click(function() {
		var page = $(this).attr('data-page');
		console.log("Page: " +page);
		$("#pageNumber").val(page);
		$("#inquiryForm").attr('action', '../../../../adminGetAllProducts');
		$("#inquiryForm").submit();
	});*/

	var currentPage = $("#pageNumber").val();
	var newPage = parseInt(currentPage);
	$(".dynamicPageNumber").text('Page ' + newPage);

	$(".nextPage").click(function() {
		var currentPage = $("#pageNumber").val();
		var newPage = parseInt(currentPage) + 1;
		console.log(newPage);
		;
		$(".dynamicPageNumber").text('Page ' + newPage);
		$("#pageNumber").val(newPage)
		$("#servletPageNumber").val(newPage);
		$("#inquiryForm").attr('action', '../../../../adminGetAllProducts');
		$("#inquiryForm").submit();
	});

	$(".prevPage").click(function() {
		var currentPage = $("#pageNumber").val();
		var newPage = parseInt(currentPage) - 1;
		console.log(newPage);
		$(".dynamicPageNumber").text('Page ' + newPage);
		$("#pageNumber").val(newPage);
		$("#servletPageNumber").val(newPage);
		$("#inquiryForm").attr('action', '../../../../adminGetAllProducts');
		$("#inquiryForm").submit();
	});

	$(".submitFormButton").click(
			function(event) {
				var currentPage = $("#pageNumber").val();
				var filterType = $(this).attr('data-filterType');

				if (filterType == "PWLS") {
					var stockValue = $(".pwlsInput").val();
					$("#filterInputValue").val(stockValue)
					console.log(stockValue);
				}

				if ($("#filterInputValue").val().length > 0) {
					var currentPage = parseInt($("#pageNumber").val()) + 1;
					$("#inquiryForm").attr(
							'action',
							'../../../../adminGetAllProducts?page='
									+ currentPage);
					$("#inquiryForm").submit();
				} else {
					alert('Invalid input!');
					event.preventDefault();
					return false;
				}
			})

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
						var imageName = $(this).attr('data-image');
						//It will get the imageName through a custom attribute value and pass it to the content that will be displayed in the Modal under the folder 'Group3DIT2B21Resources'
						$(".imageModalBody")
								.html(
										"<img class='img-fluid' style='max-height: 300px' src='../../Group3DIT2B21Resources/" + imageName + "' alt=" + imageName + ">");

					});

	$(".btnDesc").click(function() {
		//Upon clicking this button, it will alter the html elements below.
		//It will also display the modal through Bootstrap 4 modal toggle properties for button
		var description = $(this).attr('data-custom-description');
		var briefDescription = $(this).attr('data-custom-brief-description');

		$(".pdtFullDesc").text(description);
		$(".pdtBriefDesc").text(briefDescription);
	});

	function GetURLParameter(sParam) {
		var sPageURL = window.location.search.substring(1);
		var sURLVariables = sPageURL.split('&');
		for (var i = 0; i < sURLVariables.length; i++) {
			var sParameterName = sURLVariables[i].split('=');
			if (sParameterName[0] == sParam) {
				return sParameterName[1];
			}
		}
	}

	var tableType = GetURLParameter('inquireReport');
	var errCode = GetURLParameter('results');
	var searched = GetURLParameter('searchProducts');
	var textValue;

	// Error Msg
	if (errCode == "NoResults") {
		$(".customModalBodyText").text(searched + " does not exists!");
		$("#errModal").modal();
	}

	// For inquiry/reporting & search
	if (searched == undefined && tableType == undefined && errCode == undefined) {
		$(".displayMsg").text("Displaying All Products");
		$("#dynamicQuantity").text("Quantity");
		$("#dynamicPrice").text("Price");
	} else if (tableType == "BSP") {
		tableType = "Best Selling Product";
		$(".displayMsg").text("Viewing: " + tableType);
		$("#dynamicQuantity").text("Items Sold");
		$("#dynamicPrice").text("Revenue");
	} else if (tableType == "WSP") {
		tableType = "Worse Selling Product";
		$(".displayMsg").text("Viewing: " + tableType);
		$("#dynamicQuantity").text("Items Sold");
		$("#dynamicPrice").text("Revenue");
	} else if (tableType == "PWLS") {
		tableType = "Product with Low Stock";
		$(".displayMsg").text("Viewing: " + tableType);
		$("#dynamicQuantity").text("Quantity Left");
		$("#dynamicPrice").text("Revenue");
	} else if (searched != undefined) {
		$("#paginationDiv").css('display', 'none');
		$(".displayMsg").text("Displaying Result for: " + searched);
		$("#dynamicQuantity").text("Quantity");
		$("#dynamicPrice").text("Price");
	} else if (errCode == "noResults") {
		$("#paginationDiv").css('display', 'none');
		$(".displayMsg").text("Displaying Result for: " + searched);
		$("#dynamicQuantity").text("Quantity");
		$("#dynamicPrice").text("Price");
	}
</script>
</html>