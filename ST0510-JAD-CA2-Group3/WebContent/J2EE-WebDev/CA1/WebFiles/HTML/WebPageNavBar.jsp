<!--
Name: Alwin Singh (p1935996)
Name: Choh Kaifeng (p1935590)
Class: DIT/2B/21
Group: 3
Subject: J2EE CA1 Assignment
-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<!-- Material Design Bootstrap -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.18.0/css/mdb.min.css"
	rel="stylesheet">
<style>
body {
	font-family: 'Lato', 'Helvetica Neue', Helvetica, Arial, sans-serif;
}

h1, h2, h3, h4, h5, h6 {
	font-family: 'Montserrat', sans-serif;
	font-weight: 700;
}
</style>

<body>
	<!-- The file blow (getLogInStatus) checks whether the user Logged in is a Guest / Admin / Registered User.
 According to what the user is, the JS file called 'DynamicNavBar.js' will append the Navbar for the respective
 User through use of hidden input fields in getLogInStatus.jsp -->
	<%@ include file="../JSPProcessing/getLogInStatus.jsp"%>

	<!--Navbar -->
	<nav
		class="navbar navbar-expand-lg fixed-top text-light bg-dark fusionTechNavBar">
		<a class="navbar-brand text-light" href="HomePage.jsp">Fusion Tech</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent-333"
			aria-controls="navbarSupportedContent-333" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent-333">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link text-light"
					href="../Pages/HomePage.jsp">Home <span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link text-light"
					href="../Pages/AboutPage.jsp">About</a></li>
				<li class="nav-item"><a class="nav-link text-light"
					href="../../../../getAllCategories">Products</a></li>
				<li class="nav-item"><a class="nav-link text-light"
					href="../Pages/ContactUs.jsp">Contact Us</a></li>
				<li class="nav-item" id="adminNavBarItem"><a class="nav-link"
					href="#"></a></li>
				<li class="nav-item" id="accountNavBarItem"><a class="nav-link"
					href="#"></a></li>
			</ul>
			<ul class="navbar-nav ml-auto nav-flex-icons">

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-333"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-money-bill-wave"></i>
				</a>
					<div class="dropdown-menu dropdown-menu-right dropdown-default"
						aria-labelledby="navbarDropdownMenuLink-333">
						<a class="dropdown-item" href="../../../../CurrencyConverter?convertTo=sgd">SGD</a> <a class="dropdown-item"
							href="../../../../CurrencyConverter?convertTo=myr">MYR</a> <a class="dropdown-item" href="../../../../CurrencyConverter?convertTo=usd">USD</a>
					</div></li>
				
				<!-- <li class="nav-item"><a href="./userCurrencyConverter.jsp"
					target="_blank"
					class="nav-link text-light waves-effect waves-light"> <i
						class="fas fa-coins"></i>
				</a></li> -->
				
				<li class="nav-item"><a href="http://www.twitter.com"
					target="_blank"
					class="nav-link text-light waves-effect waves-light"> <i
						class="fab fa-twitter"></i>
				</a></li>
				<li class="nav-item"><a href="http://www.google.com"
					target="_blank"
					class="nav-link text-light waves-effect waves-light"> <i
						class="fab fa-google-plus-g"></i>
				</a></li>
				<li class="nav-item dropdown accountManagementNavBar"><a
					class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-333"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-user"></i>
				</a>
					<div class="dropdown-menu dropdown-menu-right dropdown-default"
						aria-labelledby="navbarDropdownMenuLink-333">
						<a class="dropdown-item" href="../Pages/editProfile.jsp">Edit
							Profile</a>
						<a class="dropdown-item" href="../../../../getUserAddresses">Edit
							Addresses</a>
						<a class="dropdown-item" href="../../../../getUserOrders">View Orders</a>
					</div></li>
				<li class="nav-item cartOptionNavBar"><a
					href="shoppingCart.jsp"
					class="nav-link text-light waves-effect waves-light"> <i
						class="fa fa-shopping-cart"></i>
				</a></li>
			</ul>
		</div>
	</nav>
	<!--/.Navbar -->
</body>
</html>