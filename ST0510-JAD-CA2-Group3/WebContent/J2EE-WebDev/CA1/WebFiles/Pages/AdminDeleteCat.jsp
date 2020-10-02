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
<title>Fusion Tech - Delete Product</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link href="../../css/AdminDash.css" rel="stylesheet">
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
		String sqlStr = "SELECT * FROM Category";
		ResultSet rs = stmt.executeQuery(sqlStr);
	%>

	<div class="container-fluid">
		<div class="row">

			<%@include file="../HTML/adminDashNavBar.jsp"%>

			<main role="main"
				class="col-md-9 ml-sm-auto col-lg-10 pt-5 mt-5 px-0 mx-0">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 px-md-4 border-bottom">
					<h1 class="h2">Delete Category</h1>
					<div class="wrap">

						<%@include file="../HTML/adminDashCatSearchBar.html"%>

					</div>
				</div>
				<div
					class="table-wrapper-scroll-y fusionTech-scrollbar pb-2 px-md-4 mb-3 mt-3 table-responsive text-nowrap">
					<p class="delMsg display-5"></p>
					<div style="min-height: 343px !important;">
						<form action="AdminDeleteCatFromDB.jsp" name="form1" method="post">
							<table
								class="table table-bordered table-hover table-sm text-center"
								id="tbl-content">
								<thead class="text-light" style="background-color: #0a224a;">
									<tr>
										<th scope="col">Category ID</th>
										<th scope="col">Name</th>
										<th scope="col">Description</th>
										<th scope="col">Delete</th>
									</tr>
								</thead>

								<%
									// STEP 6: PROCESS RESULTS
								while (rs.next()) {
									String Code = rs.getString("catID");
									String CatName = rs.getString("CategoryName");
									String CatDescription = rs.getString("Description");
								%>

								<tr>
									<td><%=Code%></td>
									<td><%=CatName%></td>
									<td>
										<button type="button"
											class="btn btn-sm btn-primary text-light btnDesc"
											data-toggle="modal" data-target="#pdtDescModal"
											data-custom-desc="<%=CatDescription%>">View
											Description</button>
									</td>

									<td>
										<button type="button" data-toggle="modal"
											data-target="#delCfmModal" name="deleteButton"
											class="btn  btn-danger btn-sm btn-primary text-light formDelBtn"
											data-custom-value="<%=CatName%>" value="<%=Code%>">
											Delete</button>
									</td>
									<%
										}
									%>
								
							</table>
						</form>
					</div>
					<%
						conn.close();
					} catch (Exception e) {
						out.println("ERROR: " + e);
					}
					%>
				</div>
				<%@ include file="../HTML/WebPageFooter.html"%>
			</main>
		</div>
	</div>


	<!-- Delete Confirmation Modal -->
	<div class="modal fade" id="delCfmModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">DELETE</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body delModalBody"></div>
				<div class="modal-footer">
					<form action="../../../../deleteCat"
						method="POST">
						<button type="button" class="btn btn-danger text-light"
							data-dismiss="modal">NO</button>
						<button type="submit" id="delete"
							class="btn  btn-success text-light">YES</button>
						<input type="hidden" class="deleteHiddenField"
							name="deleteHiddenField" style="display: none" value=""></input>
					</form>
				</div>
			</div>
		</div>
	</div>


	<!-- Description Modal -->
	<div class="modal fade" id="pdtDescModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Category
						Description</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body ModalBodypdtDesc"></div>
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
<script src="../../js/AdminDashCatSearchBar.js"></script>
<script>
	var catCode;
	var catName;

	$(".btnDesc").click(function() {
		var description = $(this).attr('data-custom-desc');
		$(".ModalBodypdtDesc").text(description);
	});

	$(".formDelBtn").click(
			function() {
				catCode = $(this).attr('value');
				catName = $(this).attr('data-custom-value');
				$(".delModalBody").html(
						"You are about to delete....<br>Product Name:"
								+ catName + "<br>Product Code:" + catCode);
			});

	$("#delete").click(function() {
		$(".deleteHiddenField").attr('value', catCode);
	});

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

	var delCode = GetURLParameter('delCode');

	if (delCode === 'success') {
		$(".delMsg").removeClass("text-danger");
		$(".delMsg").text("You have successfully deleted a category");
	} else if (!isNaN(delCode) && delCode.length > 1) {
		$(".delMsg").addClass("text-danger");
		$(".delMsg").text("You encountered an error deleting a category");
	} else {
		$(".delMsg").removeClass("text-danger");
		$(".delMsg").empty();
		$(".delMsg").hide();
	}
</script>
</html>