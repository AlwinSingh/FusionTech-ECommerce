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

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - Update Product</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link href="../../css/AdminDash.css" rel="stylesheet">
<link href="../../css/AdminSearch.css" rel="stylesheet">
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
		String sqlStr = "SELECT *, C.CategoryName FROM products P, Category C where C.CatID = P.Category";
		ResultSet rs = stmt.executeQuery(sqlStr);
	%>

	<div class="container-fluid">
		<div class="row">

			<%@include file="../HTML/adminDashNavBar.jsp"%>

			<main role="main"
				class="col-md-9 ml-sm-auto col-lg-10 pt-5 mt-5 px-0 mx-0">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 px-md-4 border-bottom">
					<h1 class="h2">Update Product</h1>
					<div class="wrap">

						<%@include file="../HTML/adminDashSearchBar.html"%>

					</div>
				</div>

				<div
					class="table-wrapper-scroll-y fusionTech-scrollbar pb-2 px-md-4 mb-3 mt-3 table-responsive text-nowrap">
					<div style="min-height: 343px !important;">
						<form action="./AdminEditingPage.jsp" name="form1" method="post">
							<p id="updateMsg"></p>
							<table
								class="table table-bordered table-hover table-sm text-center"
								id="tbl-content">
								<thead class="text-light" style="background-color: #0a224a;">
									<tr>
										<th scope="col">Code</th>
										<th scope="col">Name</th>
										<th scope="col">Supplier</th>
										<th scope="col">Category Name (ID)</th>
										<th scope="col">Quantity</th>
										<th scope="col">Price</th>
										<th scope="col">Description</th>
										<th scope="col">Image</th>
										<th scope="col">Edit</th>
									</tr>
								</thead>

								<%
									// STEP 6: PROCESS RESULTS
								while (rs.next()) {
									String productName = rs.getString("Name");
									String productSupplier = rs.getString("Supplier");
									String productCode = rs.getString("ProductCode");
									int productCat = rs.getInt("Category");
									String CategoryName = rs.getString("CategoryName");
									int productQty = rs.getInt("QtyInStock");
									double productPrice = rs.getDouble("BuyPrice");
									String productBriefDescription = rs.getString("BriefDescription");
									String productDescription = rs.getString("PdtDescription");
									String productImage = rs.getString("Image");
								%>

								<tr>
									<td><%=productCode%></td>
									<td><%=productName%></td>
									<td><%=productSupplier%></td>
									<td><%=CategoryName + " (" + productCat + ")"%></td>
									<td><%=productQty%></td>
									<td><%=productPrice%></td>
									<td>
										<button type="button"
											class="btn btn-sm btn-primary text-light btnDesc"
											data-toggle="modal" data-target="#pdtDescModal"
											data-custom-desc="<%=productDescription%>"
											data-custom-brief-desc="<%=productBriefDescription%>">
											View Description</button>
									</td>
									<td>
										<button type="button"
											class="btn btn-sm btn-primary text-light btnImage"
											data-toggle="modal" data-target="#pdtImageModal"
											data-custom-value="<%=productImage%>">View Image</button>
									</td>
									<td>
										<button type="submit" name="editbtn"
											class="btn btn-sm btn-primary text-light"
											value="<%=productCode%>">Edit Product</button>
									</td>
									<%
										}
									%>
								
							</table>
						</form>
						<%
							conn.close();
						} catch (Exception e) {
							out.println("ERROR: " + e);
						}
						%>
					</div>
				</div>
				<%@ include file="../HTML/WebPageFooter.html"%>
			</main>
		</div>
	</div>


	<!-- Modal -->
	<div class="modal fade" id="pdtDescModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Product
						Description</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<b>Full Description:</b>
					<p class="pdtFullDesc"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
					<br> <b>Brief Description:</b>
					<p class="pdtBriefDesc"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn primary-color-dark text-light"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="pdtImageModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Product Image</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body imageModalBody text-center"></div>
				<div class="modal-footer">
					<button type="button" class="btn primary-color-dark text-light"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="../../js/DynamicNavBar.js"></script>
<script src="../../js/AdminDashSearchBar.js"></script>
<script>
	$(".btnDesc").click(function() {
		var description = $(this).attr('data-custom-desc');
		var briefDescription = $(this).attr('data-custom-brief-desc');

		$(".pdtFullDesc").text(description);
		$(".pdtBriefDesc").text(briefDescription);
	})

	$(".btnImage")
			.click(
					function() {
						//Upon clicking the view image button, it will alter the html elements below
						var imageName = $(this).attr('data-custom-value');
						//It will get the imageName through a custom attribute value and pass it to the content that will be displayed in the Modal under the folder 'Group3DIT2B21Resources'
						$(".imageModalBody")
								.html(
										"<img class='img-fluid' style='max-height: 300px' src='../../Group3DIT2B21Resources/" + imageName + "' alt=" + imageName + ">");

					})

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

	var updateCode = GetURLParameter('update');

	if (updateCode == 'true') {
		$("#updateMsg").text("Successfully updated a product!");
	} else if (updateCode == 'false' || !isNaN(updateCode)) {
		$("#updateMsg").text("Failed to update a product!");
	}
</script>
</html>