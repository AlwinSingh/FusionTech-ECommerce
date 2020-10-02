<!--
Name: Alwin Singh (p1935996)
Name: Choh Kaifeng (p1935590)
Class: DIT/2B/21
Group: 3
Subject: J2EE CA1 Assignment
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, fusionTechProductModel.*, java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - Products</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link rel="stylesheet" href="../../css/displayCategoryProducts.css">
</head>

<body>
	<%@ include file="../JSPProcessing/sqlPassword.jsp"%>
	<%@ include file="../JSPProcessing/JSPImageUploadPath.jsp"%>
	<%@ include file="../HTML/WebPageNavBar.jsp"%>
	
	<%
	String categoryName = request.getParameter("categoryName");
	String categoryID = request.getParameter("getProductLineID");
	%>

	<div class="jumbotron jumbotron-fluid"
		style="display: block; background-image: linear-gradient(to right, #0b2040, #0a224a) !important;">
		<div class="container">
			<h1 class="display-4 mt-3 text-light"><%=categoryName%></h1>
			<p class="text-light">
				You are currently viewing products under
				<%=categoryName%></p>
		</div>
	</div>

	<div class="container mt-5 mb-5">
		<form action="viewProduct.jsp" method="POST" class="col-12">
			<div class="row">
				<!-- Change to GET to prevent 'form re-submission' dialog. Still learning more about form methods. -->

				<%	
					ArrayList<allProducts> productList = new ArrayList<allProducts>();
					
					if (session.getAttribute("productList") != null) {
						//productList 
						//= (ArrayList<allProducts>) session.getAttribute("productList");
						
						// get application scoped attribute
				        productList = (ArrayList<allProducts>) session.getAttribute("productList");
					} else {
						System.out.println("Failed to retrieve products list! (Scope: Session Scope)");
						System.out.println("Loading products list now...");
						response.sendRedirect("../../../../getAllProducts?getProductLineID="+categoryID+"&getProductLineName="+categoryName);
					}
					
					for (int i = 0; i < productList.size(); i++) {
						
						if (productList.get(i).getProductCategoryName().equals(categoryName) && productList.get(i).getProductisAvailable() == 1) {
				%>

				<div class="col-4">
					<figure class="card card-product"
						style="min-height: 550px !important;">
						<div class="img-wrap">
							<img
								src="../../Group3DIT2B21Resources/<%= productList.get(i).getProductImage() %>">
						</div>
						<figcaption class="info-wrap text-center">
							<h6 class="title text-dots">
								<%
									if (productList.get(i).getProductQtyInStock() > 0) {
								%>
								<a href="#"><%= productList.get(i).getProductName() %></a>
								<%
									} else {
								%>
								<a href="#"><%= productList.get(i).getProductName() %> (Out of stock)</a>
								<%
									}
								%>
							</h6>
							<div class="action-wrap">
								<button type="submit"
									class="btn rounded text-white primary-color-dark btn-sm float-right productBtnProcess"
									data-custom-value-name="<%= productList.get(i).getProductName() %>"
									data-custom-value="<%= productList.get(i).getProductCode() %>"
									formaction="viewProduct.jsp?<%= productList.get(i).getProductName() %>">
									View Product</button>
								<div class="price-wrap h5 mt-2">
									<span class="price-new"><%= productList.get(i).getProductCurrencySymbol() %> <%= productList.get(i).getProductSellPrice() %></span>
								</div>
								<!-- price-wrap.// -->
							</div>
							<!-- action-wrap -->
						</figcaption>
						<hr>
						<p class="text-left text-muted pl-3">Brief Description:</p>
						<p class="text-left text-muted pl-3 pdtDescription"
							style="word-break: break-word; white-space: pre-wrap;"><%= productList.get(i).getProductbriefDesc() %></p>
					</figure>
					<!-- card // -->
				</div>
				<!-- col // -->

				<%
						}
					}
				%>

				<input type="hidden" id="productInput" name="getProductCode"
					value=""> <input type="hidden" id="productNameInput"
					name="getProductName" value="">
			</div>
		</form>
	</div>

	<%@ include file="../HTML/WebPageFooter.html"%>

</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="../../js/DynamicNavBar.js"></script>
<script src="../../js/animateNavBar.js"></script>
<script>
	$('.productBtnProcess').click(
			function() {
				var categoryName = $(this).attr('data-custom-value-name');
				var categoryID = $(this).attr('data-custom-value');
				var setHiddenInputName = $("#productNameInput").attr('value',
						categoryName)
				var setHiddenInputValue = $("#productInput").attr('value',
						categoryID)
			});
</script>

</html>