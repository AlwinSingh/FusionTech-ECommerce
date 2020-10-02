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
<%@ page import = "fusionTechProductModel.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - Add Product</title>
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

	<%
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
		String sqlStr = "SELECT CategoryName FROM Category;";
		String sqlStrGetLastCode = "SELECT MAX(PRODUCTCODE) 'LastProductCode' FROM PRODUCTS;";
		ResultSet getLastPdtCode = stmt.executeQuery(sqlStrGetLastCode);
		int index = 0;

		while (getLastPdtCode.next()) {
	%>

	<div class="container-fluid">
		<div class="row">

			<%@include file="../HTML/adminDashNavBar.jsp"%>

			<main role="main"
				class="col-md-9 ml-sm-auto col-lg-10 pt-5 mt-5 px-0 mx-0">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 px-md-4 border-bottom">
					<h1 class="h2">Create New Product</h1>
				</div>

				<div
					class="justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 px-md-4 mb-3">
					<p id="errorMsg"></p>
					<form action="../../../../addNewProduct" method="post"
						enctype="multipart/form-data" name="createProduct"
						class="needs-validation" novalidate>
						<div class="form-group">
							<div class="name productNameLabel">Product Name:</div>
							<input type="text" name="productName"
								class="form-control my-input" id="productName"
								placeholder="Enter Product Name... ">
						</div>
						<div class="form-group">
							<div class="name productSupplierLabel">Product Supplier:</div>
							<input type="text" name="productSupplier"
								class="form-control my-input" id="productSupplier"
								placeholder="Enter Product Supplier... ">
						</div>
						<div class="form-group row">
							<div class="col" style="opacity: 0.55;">
								<div class="name productCodeLabel text-muted">Product
									Code: (Assigned)</div>
								<input type="text" id="productCode" name="productCode"
									class="form-control disabled text-muted"
									placeholder="<%=(getLastPdtCode.getInt("LastProductCode") + 1)%>"
									value="<%=getLastPdtCode.getInt("LastProductCode") + 1%>" />
							</div>
							<div class="col">
								<div class="name productCatLabel">Category:</div>
								<select id="productCat" id="productCat" class="form-control"
									name="productCat">
									<%
										}
									ResultSet rs = stmt.executeQuery(sqlStr);
									// STEP 6: PROCESS RESULTS
									while (rs.next()) {
										index++;
									%>

									<option value="<%=index%>"><%=rs.getString("CategoryName")%></option>

									<%
										}
									conn.close();
									} catch (Exception e) {
										out.println("ERROR: " + e);
									}
									%>
								</select>
							</div>
							<div class="col">
								<div class="name productQtyLabel">Product Quantity:</div>
								<input type="number" id="productQty" name="productQuantity"
									class="form-control" placeholder="Product Quantity" />
							</div>

							<div class="col">
								<div class="name productBuyPriceLabel">Buy Price: $</div>
								<input type="number" id="productBuyPrice" name="productBuyPrice"
									class="form-control" placeholder="Product Buy Price" />
							</div>

							<div class="col">
								<div class="name productSellPriceLabel">Sell Price: $</div>
								<input type="number" id="productSellPrice"
									name="productSellPrice" class="form-control"
									placeholder="Product Sell Price" />
							</div>


						</div>
						<div class="form-group">
							<div class="name imageUploadLabel">Image Upload:</div>
							<input id="imageUploadFile" type="file"
								class="btn rounded btn-sm primary-color-dark text-light"
								name="file" size="50" accept="image/*" />
						</div>
						<div class="form-group">
							<div class="name pdtBriefDescLabel">Product Brief
								Description:</div>
							<textarea class="form-control" id="pdtBriefDesc"
								name="productBriefDescription"
								placeholder="Enter Product Description" rows="2"></textarea>
						</div>
						<div class="form-group">
							<div class="name pdtDescLabel">Product Description:</div>
							<textarea class="form-control" id="pdtDesc"
								name="productDescription"
								placeholder="Enter Product Description" rows="3"></textarea>
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
<script src="../../js/AdminValidateAddProduct.js"></script>

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
		$("#errorMsg").html('<b>That product name is already taken!</b>');
	}
</script>
</html>