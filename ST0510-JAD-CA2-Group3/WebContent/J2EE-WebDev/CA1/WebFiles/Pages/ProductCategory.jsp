<!--
Name: Alwin Singh (p1935996)
Name: Choh Kaifeng (p1935590)
Class: DIT/2B/21
Group: 3
Subject: J2EE CA1 Assignment
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.ArrayList"%>
<%@ page import = "fusionTechProductModel.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - Product Category</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap"
	rel="stylesheet">
</head>

<style>
.categoryBtnProcess {
	transition: transform .5s ease;
	transform: scale(1.0);
}

.categoryBtnProcess:hover {
	transition: transform .5s ease;
	transform: scale(1.2);
}

.viewAllPdtBtnProcess {
	transition: transform .5s ease;
	transform: scale(1.0);
}

.viewAllPdtBtnProcess:hover {
	transition: transform .5s ease;
	transform: scale(1.2);
}
</style>
<body>

	<%@ include file="../JSPProcessing/sqlPassword.jsp"%>
	<%@ include file="../HTML/WebPageNavBar.jsp"%>


	<div class="jumbotron jumbotron-fluid mb-0 z-depth-2"
		style="display: block; background-image: linear-gradient(to right, #0b2040, #0a224a) !important;">
		<div class="container">
			<h1 class="display-4 mt-3 text-light">Categories</h1>
			<p class="text-light">Choose the category to view the specific
				products.</p>
		</div>
	</div>

	<div class="container pt-4 mt-5 mb-5 pb-4" style="min-height: 380px;">
		<form action="../../../../getAllProducts" method="GET">
			<div class="card bg-light mb-3">
				<div class="card-header bg-dark text-white text-uppercase">
					<i class="fa fa-list"></i> Categories
				</div>
				<ul class="list-group category_block">

					<!-- <li class="list-group-item"><a href=""
						class="viewAllPdtBtnProcess btn text-dark"
						style="border-radius: 20px; box-shadow: none;"><i
							class="fas fa-paper-plane pr-3"></i>View All Products </a></li> -->
					
					<li class="list-group-item">
						<button class="categoryBtnProcess btn"
							style="border-radius: 20px; box-shadow: none;"
							data-custom-value="0"
							data-custom-value-name="All Products">
							<i class="fas fa-paper-plane pr-3"></i>View All Products
						</button>
					</li>
					

					<%
					ArrayList<allCategories> categoryList = new ArrayList<allCategories>();
					
					if (session.getAttribute("categoryList") != null) {
						categoryList = (ArrayList<allCategories>) session.getAttribute("categoryList");
					
					for (int i = 0; i < categoryList.size(); i++) {
					%>

					<li class="list-group-item">
						<button class="categoryBtnProcess btn"
							style="border-radius: 20px; box-shadow: none;"
							data-custom-value=<%= categoryList.get(i).getCategoryCatID() %>
							data-custom-value-name=<%= categoryList.get(i).getCategoryName() %>>
							<i class="fas fa-paper-plane pr-3"></i><%= categoryList.get(i).getCategoryName() %>
						</button>
					</li>


					<%
						}
					} else {
						System.out.println("Category List does not exist....redirecting to servlet");
						response.sendRedirect("../../../../getAllCategories");
					}
					%>
				</ul>
			</div>

			<input type="hidden" id="categoryInput" name="getProductLineID"
				value=""> <input type="hidden" id="categoryNameInput"
				name="getProductLineName" value="">

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
	$('.categoryBtnProcess').click(
			function() {
				var categoryName = $(this).attr('data-custom-value-name');
				var categoryID = $(this).attr('data-custom-value');
				//var setHiddenInputName = $( "#categoryInput" ).attr('name', categoryName)
				var setHiddenInputValue = $("#categoryInput").attr('value',
						categoryID)
				var setHiddenInputValue = $("#categoryNameInput").attr('value',
						categoryName)
			});
</script>

</html>