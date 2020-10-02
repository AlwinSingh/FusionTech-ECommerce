<!--
Name: Alwin Singh (p1935996)
Name: Choh Kaifeng (p1935590)
Class: DIT/2B/21
Group: 3
Subject: J2EE CA1 Assignment
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - Homepage</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../../css/HomePage.css">
</head>
<body>
	<%@ include file="../HTML/WebPageNavBar.jsp"%>
  
	<!-- Masthead -->
	<header class="masthead text-white text-center z-depth-2">
		<div class="overlay"></div>
		<div class="container">
			<div class="row">
				<div class="col-xl-9 mx-auto">
				<div class="alert unauthoriseAlert alert-danger" style="display: none;">
				  <strong>Oops!</strong> You tried to access a unauthorised page!
				</div>
					<h3 class="mb-5" style="text-shadow: 3px 3px 8px #000000;">
						Welcome to Fusion Tech,
						<%= userName %></h3>
					<p class="mb-5" id="fusionTechWelcomeHeader"
						style="text-shadow: 3px 3px 8px #000000;"></p>
					<p style="display: none" class="mb-5"
						id="fusionTechWelcomeHeaderTwo"
						style="text-shadow: 3px 3px 8px #000000;"></p>
					<p style="text-shadow: 3px 3px 8px #000000;">Explore the
						exciting products we have just for you!</p>
					<a
						class="viewProductBtn
            btn blue-gradient btn-rounded mt-3 border-light"
						style="border-radius: 20px !important; font-weight: bold; text-shadow: 0px 0px 6px #000000;"
						href="ProductCategory.jsp" role="button">View Products</a>
				</div>
			</div>
		</div>
	</header>

	<div class="background" style="background-color: white;">
		<div class="container py-3">
			<h2 class="py-4" style="text-align: center">From Fusion
				Technologies Online Store to your house</h2>

			<div class="row text-center" style="justify-content: center">
				<!-- Team item-->
				<div class="col mb-2">
					<div class="bg-white py-4 px-4" style="min-height: 300px">
						<i class="far fa-credit-card fa-5x pb-3"></i>
						<h5 class="mb-3">Payment</h5>
						<span>We make it simple for you to make payment. Choose to
							pay with your debit & credit cards. T&C Applies.</span>
					</div>
				</div>
				<!-- End-->

				<!-- Team item-->
				<div class="col mb-2">
					<div class="bg-white py-4 px-4" style="min-height: 300px">
						<i class="fas fa-truck fa-5x pb-3"></i>
						<h5 class="mb-3">Free Delivery</h5>
						<span>Enjoy our free delivery services when you purchase
							with from our online store</span>
					</div>
				</div>
				<!-- End-->

				<!-- Team item-->
				<div class="col mb-2">
					<div class="bg-white py-4 px-4" style="min-height: 300px">
						<i class="fas fa-headset fa-5x pb-3"></i>
						<h5 class="mb-3">Support</h5>
						<span>Need help to decide what's best for you? Contact us
							or drop us an email!</span>
					</div>
				</div>
				<!-- End-->


			</div>
		</div>
	</div>



	<div class="background" style="background-color: #e6e6e6">
		<div class="container py-3">
			<h2 class="py-4" style="text-align: center">A glance of our
				products!</h2>

			<div class="row text-center" style="justify-content: center">

				<a href="ProductCategory.jsp" class="text-dark"
					style="text-align: center; font-weight: bold; font-size: 14px; text-decoration: underline;">
					Click here to view our products via categories!</a>

				<%@include file="displayHomePageProducts.jsp"%>

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
<script src="../../js/HomePage.js"></script>
<script src="../../js/animateNavBar.js"></script>
</html>