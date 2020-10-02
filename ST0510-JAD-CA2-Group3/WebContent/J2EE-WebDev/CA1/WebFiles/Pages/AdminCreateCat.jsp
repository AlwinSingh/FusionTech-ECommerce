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
<title>Fusion Tech - Create Category</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link href="../../css/AdminDash.css" rel="stylesheet">
<link href="../../css/AdminForms.css" rel="stylesheet">
</head>
<%@ include file="../JSPProcessing/sqlPassword.jsp"%>
<%
	try {
	// STEP 1: LOAD JDBC DRIVER
	Class.forName("com.mysql.jdbc.Driver");
	// STEP 2: DEFINE CONNECTION URL
	String connURL = "jdbc:mysql://localhost/j2eeca2?user=root&password=" + sqlPass
	+ "&serverTimezone=UTC&useSSL=false";
	// STEP 3: ESTABLISH CONNECTION TO URL
	Connection conn = DriverManager.getConnection(connURL);
	// STEP 4: CREATE STATEMENT OBJECT
	Statement stmt = conn.createStatement();
	// STEP 5: EXECUTE SQL COMMAND
	String sqlStrGetLastCode = "SELECT MAX(catID) 'LastCategoryID' FROM Category;";
	ResultSet getLastCatID = stmt.executeQuery(sqlStrGetLastCode);
	int index = 0;

	while (getLastCatID.next()) {
%>

<body>
	<%@include file="../HTML/WebPageNavBar.jsp"%>

	<div class="container-fluid">
		<div class="row">

			<%@include file="../HTML/adminDashNavBar.jsp"%>

			<main role="main"
				class="col-md-9 ml-sm-auto col-lg-10 pt-5 mt-5 px-0 mx-0">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 px-md-4 border-bottom">
					<h1 class="h2">Create New Category</h1>
				</div>

				<div
					class="justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 px-md-4 mb-3">
					<p id="errorMsg"></p>
					<form action="../../../../addNewCat" method="post" name="createCat"
						class="needs-validation" novalidate>
						<div class="row">
							<div class="col-6">
								<div class="form-group">
									<div class="name catIDLabel text-muted">Category ID
										(Assigned):</div>
									<input type="text" name="CatID"
										class="form-control my-input text-muted disabled" id="CatID"
										placeholder=""
										value="<%=(getLastCatID.getInt("LastCategoryID") + 1)%>"
										required>
								</div>
							</div>

							<%
								}
							conn.close();
							} catch (Exception e) {
								out.println("ERROR: " + e);
							}
							%>

							<div class="col-6">
								<div class="form-group">
									<div class="name catLabel">Category Name:</div>
									<input type="text" name="CatName" class="form-control my-input"
										id="CatName" placeholder="Enter Category Name... " required>
								</div>
							</div>
						</div>
						<!--<div class="form-group">
							<div class="name catImageLabel">Image Link:</div>
							<input type="text" name="CatImage" class="form-control my-input"
								id="CatImage" placeholder="Enter Category Image Link " required>
						</div>-->
						<div class="form-group">
							<div class="name catDescLabel">Category Description:</div>
							<textarea class="form-control" id="CatDesc" name="CatDesc"
								placeholder="Enter Category Description" rows="4"></textarea>
						</div>
						<div class="btn-toolbar mb-2 mb-md-0">
							<div class="btn-group mr-2">
								<button onclick="validateFields()" type="submit"
									class="btn btn-lg rounded primary-color-dark text-light">
									<i class="fas fa-paper-plane pr-3"></i>Upload
								</button>
							</div>
						</div>
					</form>
				</div>
				<br>
				<%@ include file="../HTML/WebPageFooter.html"%>
			</main>
		</div>
	</div>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="../../js/DynamicNavBar.js"></script>
<script src="../../js/AdminValidateAddCategory.js"></script>

<script>
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

	var errCode = parseInt(GetURLParameter('errCode'));

	if (errCode == 1062) {
		$("#errorMsg").addClass('text-danger');
		$("#errorMsg").html('<b>That product code is already taken!</b>');
	}
</script>
</html>