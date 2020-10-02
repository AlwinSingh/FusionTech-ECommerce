<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.sql.*, fusionTechProductModel.*, java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - View All Customers</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link href="../../css/AdminDash.css" rel="stylesheet">

<style>
.my-custom-scrollbar {
	position: relative;
	height: 200px;
	overflow: auto;
}

.table-wrapper-scroll-y {
	display: block;
}
</style>
</head>
<body>
<body>
	<%@ include file="../JSPProcessing/sqlPassword.jsp"%>
	<%@include file="../HTML/WebPageNavBar.jsp"%>

	<div class="container-fluid pt-5 mt-5">
		<div class="row">

			<%@include file="../HTML/adminDashNavBar.jsp"%>

			<%
				System.out.println(session.getAttribute("customersList"));
			if (session.getAttribute("customersList") != null) {
				System.out.println("Exists....: " + session.getAttribute("customersList"));
				ArrayList<UserDetails> customersList = (ArrayList<UserDetails>) session.getAttribute("customersList");
				System.out.println("Loaded the arrayList... " + customersList.size());
			%>

			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 p-0">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 px-md-4 border-bottom">
					<h1 class="h2 displayMsg"></h1>
					<div class="wrap">
						<form action="../../../../searchCustomers" method="get"
							name="searchCustomers" class="needs-validation mt-3" novalidate>
							<div class="search input-group md-form form-sm form-1 pl-0 ">
								<div class="input-group-prepend">
									<button type="submit" onclick="validateFields()"
										class="input-group-text primary-color-dark lighten-3">
										<i class="fas fa-search text-white" aria-hidden="true"></i>
									</button>
								</div>
								<input type="email" name="searchCustomers"
									class="form-control my-input" id="searchCustomers"
									placeholder="Enter Customer's Email" required>
							</div>
						</form>
					</div>
				</div>



				<div
					class="table-wrapper-scroll-y fusionTech-scrollbar pb-2 px-md-4 mb-3 mt-3 table-responsive text-nowrap">
					<div style="min-height: 343px !important;">

						<form action="../../../../getAllCustomers"
							class="row pb-2 px-md-4 mb-1 mt-2" method="get">
							<input type="hidden" id="buttonValue" name="buttonValue" value="" />
							<button type="submit"
								class="btn btn-md btn-primary text-light col font-weight-bold tableTypeBtn"
								value="PostalCode">
								<i class="fa fa-mail-bulk fa-lg mr-1"></i> View by Postal Code
							</button>
							<button type="submit"
								class="btn btn-md btn-primary text-light col font-weight-bold tableTypeBtn"
								value="Admins">
								<i class="fas fa-user-shield fa-lg mr-1"></i> View all Admins
							</button>
							<button type="submit"
								class="btn btn-md btn-primary text-light col font-weight-bold tableTypeBtn"
								value="Registered">
								<i class="fas fa-user-friends fa-lg mr-1"></i> View Registered
								Users
							</button>
							<button type="submit"
								class="btn btn-md primary-color-dark text-light col font-weight-bold tableTypeBtn"
								value="VAC">
								<i class="fa fa-table fa-lg mr-1"></i> Reset (View All Customers)
							</button>
						</form>
						<table
							class="table table-bordered table-hover table-sm text-center"
							id="tbl-content">
							<thead class="text-light" style="background-color: #0a224a;">
								<tr>
									<th scope="col">User ID</th>
									<th scope="col">First Name</th>
									<th scope="col">LastName</th>
									<th scope="col">Email</th>
									<th scope="col">Country</th>
									<th scope="col">State</th>
									<th scope="col">Postal Code</th>
									<th scope="col">Other Information</th>
									<th scope="col">Role</th>
								</tr>
							</thead>
							<%
								for (int i = 0; i < customersList.size(); i++) {
								//System.out.println(usersList.get(i).getUserEmail());
							%>
							<tr>
								<td><%=customersList.get(i).getUserID()%></td>
								<td><%=customersList.get(i).getUserFirstName()%></td>
								<td><%=customersList.get(i).getUserLastName()%></td>
								<td><%=customersList.get(i).getUserEmail()%></td>
								<td><%=customersList.get(i).getUserCountry()%></td>
								<td><%=customersList.get(i).getUserState()%></td>
								<td><%=customersList.get(i).getUserPostalCode()%></td>
								<td>
									<button type="button"
										class="btn btn-sm btn-primary text-light btnOtherInfo"
										data-toggle="modal" data-target="#otherInfoModal"
										data-custom-user-address1="<%=customersList.get(i).getUserAddress()%>"
										data-custom-brief-address2="<%=customersList.get(i).getUserAddress2()%>"
										data-custom-user-phone="<%=customersList.get(i).getUserPhone()%>"
										data-custom-brief-city="<%=customersList.get(i).getUserCity()%>">
										View Other Information</button>
								</td>
								<td><%=customersList.get(i).getUserType()%></td>
								<%
									}
								}
								%>
							
						</table>
						<input type="hidden" id="productInput" name="getProductCode"
							value=""> <input type="hidden" id="productNameInput"
							name="getProductName" value="">
					</div>
				</div>
				<%@ include file="../HTML/WebPageFooter.html"%>
			</main>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="otherInfoModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Other User
						Information</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<b class="font-weight-bold">User's Address 1:</b>
					<p class="address1"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
					<br> <b class="font-weight-bold">User's Address 2:</b>
					<p class="address2"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
					<br> <b class="font-weight-bold">Phone Number</b>
					<p class="phone"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
					<br> <b class="font-weight-bold">City:</b>
					<p class="city"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn primary-color-dark text-light"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<!--  Error Modal -->
	<div class="modal" id="errModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Error!</h5>
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
<script src="../../js/animateNavBar.js"></script>

<script>
	$(".tableTypeBtn").click(function() {
		var getTableType = $(this).val();
		var setTableType = $("#buttonValue").val(getTableType);
		console.log(setTableType);
	});

	$(".btnOtherInfo").click(function() {
		var address1 = $(this).attr('data-custom-user-address1');
		var address2 = $(this).attr('data-custom-brief-address2');
		var phone = $(this).attr('data-custom-user-phone');
		var city = $(this).attr('data-custom-brief-city');
		$(".address1").text(address1);
		$(".address2").text(address2);
		$(".phone").text(phone);
		$(".city").text(city);
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

	var tableType = GetURLParameter('inquireReport');
	var errCode = GetURLParameter('results');
	var searched = GetURLParameter('searchedCustomers');
	var textValue;

	// Error Msg
	if (errCode == "NoResults") {
		$(".customModalBodyText").text(searched + " does not exists!");
		$("#errModal").modal();
	}

	// For inquiry/reporting & search
	if (searched == undefined && tableType == undefined && errCode == undefined) {
		$(".displayMsg").text("Displaying All Customers");
	} else if (tableType == "PostalCode") {
		tableType = "Postal Code";
		$(".displayMsg").text("Viewing: " + tableType);
	} else if (tableType == "Admins") {
		tableType = "Admins";
		$(".displayMsg").text("Viewing: " + tableType);
	} else if (tableType == "Registered") {
		tableType = "Registered";
		$(".displayMsg").text("Viewing: " + tableType);
	} else if (searched != undefined) {
		$(".displayMsg").text("Displaying Result for: " + searched);
	} else if (errCode == "noResults") {
		$(".displayMsg").text("Displaying Result for: " + searched);
	}
</script>
</body>
</html>
