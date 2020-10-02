<!--
Name: Alwin Singh (p1935996)
Name: Choh Kaifeng (p1935590)
Class: DIT/2B/21
Group: 3
Subject: J2EE CA1 Assignment
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.*, fusionTechProductModel.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - View Products</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
</head>

<%
//Retrieves the productCode and productName that are hidden inputFields and passes them into the SQL below to retrieve the specific product
int productCode = Integer.parseInt(request.getParameter("getProductCode"));
String productName = request.getParameter("getProductName");
%>


<body aria-busy="true">
	<%@ include file="../HTML/WebPageNavBar.jsp"%>

	<!--Main layout-->
	<main class="mt-5 pt-4">
		<div class="container dark-grey-text mt-5">

			<!--Grid row-->
			<div class="row wow fadeIn">


				<%	
					ArrayList<allProducts> productList = new ArrayList<allProducts>();
					
					if (session.getAttribute("productList") != null) {
						//productList 
						//= (ArrayList<allProducts>) session.getAttribute("productList");
						
						// get application scoped attribute
				        productList = (ArrayList<allProducts>) session.getAttribute("productList");
					} else {
						System.out.println("Failed to retrieve products list for view product! (Scope: Session Scope)");
						System.out.println("Loading products list now...");
						response.sendRedirect("../../../../getAllProducts");
					}
					
					for (int i = 0; i < productList.size(); i++) {
						
						if (productList.get(i).getProductCode() == productCode) {
				%>
				<!--Grid column-->
				<div class="col-md-6 mb-4">

					<img
						src="../../Group3DIT2B21Resources/<%=productList.get(i).getProductImage()%>"
						class="img-fluid" alt="">

				</div>
				<!--Grid column-->

				<!--Grid column-->
				<div class="col-md-6 mb-4">

					<!--Content-->
					<div class="p-4">

						<div class="mb-3">
							<span class=""><%=productList.get(i).getProductName()%></span><br>
							<span class="">Category: <%=productList.get(i).getProductCategoryName()%></span><br>
							<%
								if (productList.get(i).getProductQtyInStock() > 0) {
							%>
							<span class="">Quantity: <%=productList.get(i).getProductQtyInStock()%></span>
							<%
								} else {
							%>
							<span class="text-danger">Quantity: Out of stock</span>
							<%
								}
							%>
						</div>

						<p class="lead">
							<span><%= productList.get(i).getProductCurrencySymbol() %>
								<%=productList.get(i).getProductSellPrice()%></span>
						</p>

						<p class="lead">
							<b>Description</b>
						</p>

						<p style="word-break: break-word; white-space: pre-wrap;"><%=productList.get(i).getProductDesc()%></p>

						<p class="lead">
							<b>Brief Description</b>
						</p>
						<p style="word-break: break-word; white-space: pre-wrap;"><%=productList.get(i).getProductbriefDesc()%></p>
						<br>

						<!-- Action: "../JSPProcessing/processCart.jsp" -->
						<form action="../../../../addtoShoppingCart" method="POST"
							class="d-flex justify-content-left">
							<!-- Default input -->
							<input type="number" name="getAddToCartQty" min="1" max="100"
								value="1" aria-label="Search" class="form-control"
								style="width: 100px; display: block;">

							<div id="cartBtn">
								<button
									class="cartButtonText btn btn-primary btn-md my-0 mx-5 p waves-effect waves-light"
									type="submit">Add to cart</button>
							</div>

							<!-- This hidden field will be used for the cart feature that we plan to implement -->
							<input type="hidden" name="getProductCode"
								value="<%=productList.get(i).getProductCode()%>"> <input
								type="hidden" name="getProductName" id="getProductName"
								value="<%=productList.get(i).getProductName()%>"> <input
								type="hidden" name="getProductImage" id="getProductImage"
								value="<%=productList.get(i).getProductImage()%>"> <input
								type="hidden" name="getProductCategory" id="getProductCategory"
								value="<%=productList.get(i).getProductCategoryName()%>">

							<input type="hidden" name="getProductQty" id="getProductQty"
								value="<%=productList.get(i).getProductQtyInStock()%>">

							<input type="hidden" name="getProductSellPrice"
								id="getProductSellPrice"
								value="<%=productList.get(i).getProductSellPrice()%>">

						</form>

					</div>
					<!--Content-->

					<% }
				    }%>

				</div>
				<!--Grid column-->

			</div>
			<!--Grid row-->

			<hr>

			<!--Grid row-->
			<div class="row d-flex justify-content-center wow fadeIn">

				<!--Grid column-->
				<div class="col-md-6 text-center">

					<h4 class="my-4 h4">Additional information</h4>

					<p>Check out other products!</p>

				</div>
				<!--Grid column-->

			</div>
			<!--Grid row-->

			<!--Grid row-->
			<div class="row wow fadeIn">

				<%@include file="displayHomePageProducts.jsp"%>

			</div>
			<!--Grid row-->

		</div>
	</main>
	<!--Main layout-->


	<%@ include file="../HTML/WebPageFooter.html"%>

</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="../../js/DynamicNavBar.js"></script>
<script src="../../js/DynamicCartBtn.js"></script>
<script src="../../js/animateNavBar.js"></script>
<script>
	/*$("#cartBtn").click(function() {
		alert('Cart is a work in progress');
		//On clicking the cart it alerts and prevents form submission
		event.preventDefault();
	});*/
</script>
</html>