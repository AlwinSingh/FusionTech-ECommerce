<!--
Name: Alwin Singh (p1935996)
Name: Choh Kaifeng (p1935590)
Class: DIT/2B/21
Group: 3
Subject: J2EE CA1 Assignment
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import=" java.lang.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - Edit Product</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link href="../../css/AdminDash.css" rel="stylesheet">
<link href="../../css/AdminForms.css" rel="stylesheet">
</head>

<body>
	<%@ include file="../JSPProcessing/sqlPassword.jsp"%>
	<%@include file="../HTML/WebPageNavBar.jsp"%>

	<div class="container-fluid">
		<div class="row">

			<%@include file="../HTML/adminDashNavBar.jsp"%>

			<%
				String selectedid = request.getParameter("editbtn");
			String Code = "", CatCode = "", CatName = "", CatDescription = "", Image = "";
			try {
				// STEP 1: LOAD JDBC DRIVER
				Class.forName("com.mysql.jdbc.Driver");
				// STEP 2: DEFINE CONNECTION URL
				String connURL = "jdbc:mysql://localhost/j2eeca2?user=root&password="+sqlPass+"&serverTimezone=UTC&useSSL=false";
				// STEP 3: ESTABLISH CONNECTION TO URL
				Connection conn = DriverManager.getConnection(connURL);
				// STEP 4: CREATE STATEMENT OBJECT
				Statement stmt = conn.createStatement();
				// STEP 5: EXECUTE SQL COMMAND
				String sqlStr = "SELECT * FROM category WHERE catID = ?";
				PreparedStatement pstmt = conn.prepareStatement(sqlStr);
				pstmt.setInt(1, Integer.parseInt(selectedid));
				// STEP 6: PROCESS RESULTS 
				ResultSet rs = pstmt.executeQuery();
				
				while (rs.next()) {
					CatCode = rs.getString("CatID");
					CatName = rs.getString("CategoryName");
					CatDescription = rs.getString("Description");
					Image = rs.getString("IMAGE");
				}
			%>

			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 p-0">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 px-md-4 mb-3 border-bottom">
				</div>

				<div
					class="justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 px-md-4 mb-3">
					<form action="../JSPProcessing/AdminUpdateCatToDB.jsp"
						method="post" name="login">
						<h1 class="h2 pt-5 pb-2">Edit Category</h1>
						<div class="form-group">
							<div class="name">Category Name:</div>
							<input type="text" name="catName" class="form-control my-input"
								id="catName" value="<%out.println(CatName);%>" />
						</div>

						<div class="form-group row">
							<div class="col">
								<div class="name">Category ID:</div>
								<input type="text" name="catCode" class="form-control"
									value="<%out.println(CatCode);%>" readonly />
							</div>
							<!--<div class="col">

								<div class="name">Image Link:</div>
								<input type="text" name="catImage" class="form-control my-input"
									id="catImage" value=""
							</div>-->
						</div>

						<div class="form-group">
							<div class="name">Category Description:</div>
							<textarea class="form-control" id="" name="catDescription"
								rows="4"><%out.println(CatDescription);%></textarea>
						</div>
						<div class="btn-toolbar mb-2 mb-md-0">
							<div class="btn-group mr-2">
								<button type="submit" class="btn btn-sm btn-danger"
									formaction="AdminUpdateCat.jsp">Cancel</button>
								<button type="submit" class="btn btn-sm btn-success"
									style="margin-left: 5px">Save</button>
							</div>
						</div>

					</form>
					<%
						conn.close();
					} catch (Exception e) {
						out.println("ERROR: " + e);
					}
					%>
				</div>
				<br>
				<br>
				<br>
				<%@ include file="../HTML/WebPageFooter.html"%>
			</main>
		</div>
	</div>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="../../js/DynamicNavBar.js"></script>
</html>