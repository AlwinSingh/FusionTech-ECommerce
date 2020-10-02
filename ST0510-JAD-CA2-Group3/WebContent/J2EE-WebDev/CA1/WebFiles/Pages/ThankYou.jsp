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
</head>
<body>
	<%@ include file="../HTML/WebPageNavBar.jsp"%>

	<%
	String userType = userRole;
	
	if (userType == null || userType.equals("guest")) {
		response.sendRedirect("../Pages/HomePage.jsp?error=notLoggedIn");
		return;
	}
	
	String getCheckoutStatus = request.getParameter("checkout");
	
	if (getCheckoutStatus.equals("true")) {
		session.removeAttribute("shoppingCart");
	}
	
	if (session.getAttribute("successOrderID") != null && session.getAttribute("orderDate") != null && session.getAttribute("paymentMethod") != null && session.getAttribute("couponCode") != null && session.getAttribute("orderStatus") != null) {
	%>

	<div class="my-5">
		<div class="card text-center p-5 shadow-none">

			<!-- Card content -->
			<div class="card-body">
				<!-- Title -->
				<h4 class="card-title">Hooray! You have placed an order!</h4>

				<!-- Card Icon -->
				<img class="img-fluid" src="../../image/successfulOrder.jpg"
					alt="successfulOrderIcon" height="650" width="450">

				<p class="card-text pb-3">Here are your order details</p>

				<div class="row">

					<div class="col-lg-5"></div>


					<div class="cardPosition col-lg-2 text-left">
						<p class="card-text">
						Order ID: <%= session.getAttribute("successOrderID").toString() %><br><br>
						Order Date: <%= session.getAttribute("orderDate").toString() %><br><br>
						Payment Method: <%= session.getAttribute("paymentMethod").toString() %><br><br>
						Coupon Code: <%= session.getAttribute("couponCode").toString() %><br><br>
						Order Status: <%= session.getAttribute("orderStatus").toString() %><br><br>
						</p>
					</div>


					<div class="col-lg-5"></div>

				</div>

				<!-- Text -->
				<p class="card-text mt-5">We appreciate your support!</p>
				<!-- Button -->
				<a href="./HomePage.jsp"
					class="btn aqua-gradient text-dark rounded btn-ContinueShopping">Return
					to homepage</a>
				<br>
				<a href="../../../../getUserOrders" class="text-muted small" style="display: block;">Click here to view your orders</a>

			</div>

		</div>
	</div>
	
	<%
	} else {
		response.sendRedirect("./HomePage.jsp?error=unauthorised");
		return;
	} %>

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