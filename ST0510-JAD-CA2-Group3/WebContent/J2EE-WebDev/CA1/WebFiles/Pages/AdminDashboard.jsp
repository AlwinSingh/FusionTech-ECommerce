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
<title>Fusion Tech - Admin Dash</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link href="../../css/AdminDash.css" rel="stylesheet">
</head>
<body>
	<%@include file="../HTML/WebPageNavBar.jsp"%>

	<div class="container-fluid">
		<div class="row">
			<%@include file="../HTML/adminDashNavBar.jsp"%>
			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 p-0">
				<div class="contentSpacingDash">
					<div
						class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-5 mt-5 pb-2 px-md-4 mb-3">
						<p style="font-size: 25px; font-weight: bold;">
							Welcome Back,
							<%=userName%></p>
					</div>
					<!-- /.row -->
					<%@ include file="./displayAdminDashboardData.jsp"%>

				</div>
				<%@ include file="../HTML/WebPageFooter.html"%>
			</main>
		</div>
	</div>

	<div class="modal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Success!</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body customModalBodyText">
					<p></p>
				</div>
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
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<!--<script src="../../js/AdminWebSummaryChart.js"></script>-->
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

	var addedProduct = GetURLParameter('addProduct');
	var addedCategory = GetURLParameter('addCat');
	var addedCustomer = GetURLParameter('addCustomer');

	if (addedProduct === 'true') {
		$(".customModalBodyText")
				.text("You have successfully added a product!");
		$(".modal").modal();
	}

	if (addedCategory === 'true') {
		$(".customModalBodyText").text(
				"You have successfully added a category!");
		$(".modal").modal();
	}
	
	if (addedCustomer === 'true') {
		$(".customModalBodyText").text(
				"You have successfully added a new customer!");
		$(".modal").modal();
	}

	if (addedProduct === 'true' && addedCategory === 'true') {
		$(".customModalBodyText").text(
				"You have successfully added a product & a category!");
		$(".modal").modal();
	}
</script>
</html>