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
<link rel="stylesheet" href="../../css/displayCategoryProducts.css">
</head>

<body>

	<%@ include file="../JSPProcessing/sqlPassword.jsp"%>
	<%
		int totalUsers = 0;
	int adminUsers = 0;
	int registeredUsers = 0;
	int products = 0;
	int categories = 0;
	int brands = 0;

	try {
		// Step1: Load JDBC Driver
		Class.forName("com.mysql.jdbc.Driver");
		// Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/j2eeca2?user=root&password=" + sqlPass
		+ "&serverTimezone=UTC&useSSL=false";
		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);
		// Step 4: Create Statement object
		Statement stmt = conn.createStatement();
		// Step 5: Execute SQL Command
		//Nested SQL Statement to retrieve multiple values from different tables at once
		String SQLStatement = "SELECT COUNT(*) 'products', (SELECT COUNT(*) FROM Category) 'category', (SELECT COUNT(*) FROM USERS WHERE UserType != 2) 'registered', (SELECT COUNT(*) FROM USERS WHERE UserType = 2) 'admins', (SELECT COUNT(*) FROM USERS) 'total' FROM Products;";
		String SQLUserStatement = "SELECT * FROM Users";
		ResultSet results;

		results = stmt.executeQuery(SQLStatement);

		// Step 6: Process Result
		while (results.next()) {
			totalUsers = results.getInt("total");
			adminUsers = results.getInt("admins");
			registeredUsers = results.getInt("registered");
			products = results.getInt("products");
			categories = results.getInt("category");
			/*brands = results.getInt("brands");*/
		}
		
		results = stmt.executeQuery(SQLUserStatement);
	%>


	<div class="container px-3">
		<div class="row justify-content-center">
			<div class="col-3 card blue-gradient text-white mb-4 mx-4">
				<div class="card-body">Total Registered Users</div>
				<div
					class="card-footer d-flex align-items-center justify-content-between">
					<div class="small text-white">
						<%=totalUsers%>
						Users
					</div>
				</div>
			</div>

			<div class="col-3 card blue-gradient text-white mb-4 mx-4">
				<div class="card-body">Total Categories</div>
				<div
					class="card-footer d-flex align-items-center justify-content-between">
					<div class="small text-white">
						<%=categories%>
						Categories
					</div>
				</div>
			</div>

			<div class="col-3 card blue-gradient text-white mb-4 mx-4">
				<div class="card-body">Total Products</div>
				<div
					class="card-footer d-flex align-items-center justify-content-between">
					<div class="small text-white">
						<%=products%>
						Products
					</div>
				</div>
			</div>
		</div>

		<table
			class="table table-bordered table-hover table-sm text-center mt-3"
			id="tbl-content">
			<thead class="text-light blue-gradient">
				<tr>
					<th scope="col">User Name</th>
					<th scope="col">Email</th>
					<th scope="col">Join Date</th>
				</tr>
				<%
					while (results.next()) {
				%>
				<tr class="text-dark cloudy-knoxville-gradient font-weight-bold">
					<td><%=results.getString("FirstName") + " " + results.getString("LastName")%></td>
					<td><%=results.getString("Email")%></td>
					<td><%=results.getString("Created_At")%></td>
				</tr>
				<%
					}
				%>
			</thead>

			<tr>
		</table>
	</div>

	<%
		// Step 7: Close connection
	conn.close();
	} catch (Exception e) {
		System.err.println("Error :" + e);
	}
	%>

</body>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

</html>