<!--
Name: Alwin Singh (p1935996)
Name: Choh Kaifeng (p1935590)
Class: DIT/2B/21
Group: 3
Subject: J2EE CA1 Assignment
-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="fusionTechUserModel.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style>
#sidebarMenu {
	-moz-box-shadow: -3px 0 10px 0 #000;
	-webkit-box-shadow: -3px 0 10px 0 #000;
	box-shadow: -3px 0 10px 0 #000;
}
</style>
</head>

<%
//System.out.println("Getting log in status");

UserDetails getUserData = new UserDetails();

String getUserRole = "guest";

if (session.getAttribute("userData") != null) {
	getUserData = (UserDetails) session.getAttribute("userData");
	getUserRole = getUserData.getUserType();
}

if (getUserRole == null || !getUserRole.equals("admin")) {
	response.sendRedirect("../Pages/HomePage.jsp?error=unauthorised");
}
%>

<body>
	<nav id="sidebarMenu"
		class="col-md-3 col-lg-2 d-md-block sidebar collapse text-light">
		<div class="sidebar-sticky pt-3">
			<h3 class="text-center mt-4"
				style="font-size: 19px; font-weight: normal;">
				<i class="fas fa-user-shield pr-2 pl-0 ml-0"></i> FusionTech Admin
			</h3>
			<hr class="mx-2">
			<h6
				class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 text-muted">
				<span>Overview</span> <a
					class="d-flex align-items-center text-muted" href="#"
					aria-label="Add a new report"> <span data-feather="plus-circle"></span>
				</a>
			</h6>
			<ul class="nav flex-column">
				<li class="nav-item mt-3 mb-3"><a class="nav-link adminNavLink active"
					href="../Pages/AdminDashboard.jsp"> <span data-feather="home"></span>
						<i class="fas fa-home pr-3"></i>Dashboard
				</a></li>
			</ul>

			<hr class="m-2">
			<h6
				class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-3 text-muted">
				<span>Category Management</span> <a
					class="d-flex align-items-center text-muted" href="#"
					aria-label="Add a new report"> <span data-feather="plus-circle"></span>
				</a>
			</h6>

			<ul class="nav flex-column">
				<li class="nav-item"><a class="nav-link adminNavLink"
					href="../Pages/AdminViewAllCat.jsp"> <span data-feather="file"></span>
						<i class="fas fa-table pr-3"></i>View All Category
				</a></li>
				<li class="nav-item"><a class="nav-link adminNavLink"
					href="../Pages/AdminCreateCat.jsp"> <span data-feather="file"></span>
						<i class="fas fa-plus-circle pr-3"></i>Add New Category
				</a></li>
				<li class="nav-item"><a class="nav-link adminNavLink"
					href="../Pages/AdminUpdateCat.jsp"> <span data-feather="file"></span>
						<i class="fas fa-marker pr-3"></i>Update Category
				</a></li>
				<li class="nav-item"><a class="nav-link adminNavLink"
					href="../Pages/AdminDeleteCat.jsp"> <span data-feather="users"></span>
						<i class="fas fa-trash pr-3"></i>Delete Category
				</a></li>
			</ul>



			<hr class="m-2">
			
						<h6
				class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-3 text-muted">
				<span>Product Management</span> <a
					class="d-flex align-items-center text-muted" href="#"
					aria-label="Add a new report"> <span data-feather="plus-circle"></span>
				</a>
			</h6>
			<ul class="nav flex-column">
				<li class="nav-item"><a class="nav-link"
					href="../../../../adminGetAllProducts?buttonValue=VAP"> <span
						data-feather="file"></span> <i class="fas fa-table pr-3"></i>View
						All Products
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="../Pages/AdminCreateProduct.jsp"> <span
						data-feather="file"></span><i class="fas fa-cart-plus pr-3"></i>Create
						New Product
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="../Pages/AdminUpdateProduct.jsp"> <span
						data-feather="users"></span> <i class="fas fa-marker pr-3"></i>Update
						Products
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="../Pages/AdminDeleteProduct.jsp"> <span
						data-feather="bar-chart-2"></span> <i class="fas fa-trash pr-3"></i>Delete
						Products
				</a></li>
			</ul>




			<hr class="m-2">
			<h6
				class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-3 text-muted">
				<span>Customer Management</span> <a
					class="d-flex align-items-center text-muted" href="#"
					aria-label="Add a new report"> <span data-feather="plus-circle"></span>
				</a>
			</h6>

			<ul class="nav flex-column">
				<li class="nav-item"><a class="nav-link"
					href="../../../../getAllCustomers"> <span data-feather="file"></span>
						<i class="fas fa-table pr-3"></i>View All Customers
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="../../../../getUserType"> <span data-feather="file"></span><i
						class="fas fa-cart-plus pr-3"></i>Create New Customer
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="../../../../updateCustomerList" name="update"> <span
						data-feather="users"></span> <i class="fas fa-marker pr-3"></i>Update
						Customer
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="../../../../deleteCustomerList" name="delete"> <span
						data-feather="bar-chart-2"></span> <i class="fas fa-trash pr-3"></i>Delete
						Customer
				</a></li>
			</ul>


			
			<hr class="m-2">
			<h6
				class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-3 text-muted">
				<span>Order Management</span> <a
					class="d-flex align-items-center text-muted" href="#"
					aria-label="Add a new report"> <span data-feather="plus-circle"></span>
				</a>
			</h6>
			<ul class="nav flex-column">
				<li class="nav-item"><a class="nav-link adminNavLink"
					href="../../../../adminGetAllOrders"> <span data-feather="file"></span>
						<i class="fas fa-table pr-3"></i>View & Manage Orders
				</a></li>
			</ul>

		</div>
	</nav>
</body>
</html>