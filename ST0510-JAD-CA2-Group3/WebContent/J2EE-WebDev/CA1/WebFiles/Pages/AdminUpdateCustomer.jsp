<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.sql.*, fusionTechProductModel.*, java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - Update Customer</title>
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
				System.out.println(session.getAttribute("usersList"));
			if (session.getAttribute("usersList") != null) {
				System.out.println("Exists....: " + session.getAttribute("usersList"));
				ArrayList<UserDetails> usersList = (ArrayList<UserDetails>) session.getAttribute("usersList");

				System.out.println("Loaded the arrayList... " + usersList.size());
			%>

			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 p-0">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 px-md-4 border-bottom">
					<h1 class="h2">Update Customers</h1>
					<div class="wrap">
					</div>
				</div>

				<div
					class="table-wrapper-scroll-y fusionTech-scrollbar pb-2 px-md-4 mb-3 mt-3 table-responsive text-nowrap">
					<div style="min-height: 343px !important;">
						<form action="./AdminEditCustomer.jsp" method="POST">
							<p id="updateMsg"></p>

							<table
								class="table table-bordered table-hover table-sm text-center"
								id="tbl-content">
								<thead class="text-light" style="background-color: #0a224a;">
									<tr>
										<th scope="col">User ID</th>
										<th scope="col">First Name</th>
										<th scope="col">LastName</th>
										<th scope="col">Email</th>
										<th scope="col">Other Information</th>
										<th scope="col">Role</th>
										<th scope="col">Update</th>
									</tr>
								</thead>
								<%
									for (int i = 0; i < usersList.size(); i++) {
									//System.out.println(usersList.get(i).getUserEmail());
								%>
								<tr>
									<td><%=usersList.get(i).getUserID()%></td>
									<td><%=usersList.get(i).getUserFirstName()%></td>
									<td><%=usersList.get(i).getUserLastName()%></td>
									<td><%=usersList.get(i).getUserEmail()%></td>
									<td>
										<button type="button"
											class="btn btn-sm btn-primary text-light btnOtherInfo"
											data-toggle="modal" data-target="#otherInfoModal"
											data-custom-user-address1="<%=usersList.get(i).getUserAddress()%>"
											data-custom-brief-address2="<%=usersList.get(i).getUserAddress2()%>"
											data-custom-user-phone="<%=usersList.get(i).getUserPhone()%>"
											data-custom-brief-city="<%=usersList.get(i).getUserCity()%>"
											data-custom-user-state="<%=usersList.get(i).getUserState()%>"
											data-custom-brief-postal-code="<%=usersList.get(i).getUserPostalCode()%>"
											data-custom-user-country="<%=usersList.get(i).getUserCountry()%>">
											View Other Information</button>
									</td>
									<td><%=usersList.get(i).getUserType()%></td>
									<td>
										<button type="submit" name="editBtn"
											class="btn btn-sm editBtn btn-primary text-light"
											value="<%=i%>">Edit</button>
									</td>
									<!--  <td>
										<button type="button"
											class="btn btn-sm btn-primary text-light btnDesc"
											data-toggle="modal" data-target="#pdtDescModal"
											data-custom-desc="">View Description</button>
									</td>
									<td>
										<button type="submit" data-custom-value-name=""
											data-custom-value=""
											class="btn btn-sm btn-primary text-light viewBtnProcess">View
											Category</button>
									</td> -->
								</tr>

								<%
									}
								}
								%>

							</table>

							<!-- <input type="hidden" id="ProductLineID" name="getProductLineID"
								value=""> <input type="hidden" id="ProductLineName"
								name="getProductLineName" value=""> -->
						</form>
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
					<br> <b class="font-weight-bold">State:</b>
					<p class="state"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
					<br> <b class="font-weight-bold">Postal Code:</b>
					<p class="postalCode"
						style="word-break: break-word; white-space: pre-wrap; margin-bottom: 0"></p>
					<br> <b class="font-weight-bold">Country:</b>
					<p class="country"
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
	<div class="errmodal modal" tabindex="-1" role="dialog">
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
	$(".btnOtherInfo").click(function() {
		var address1 = $(this).attr('data-custom-user-address1');
		var address2 = $(this).attr('data-custom-brief-address2');
		var phone = $(this).attr('data-custom-user-phone');
		var city = $(this).attr('data-custom-brief-city');
		var state = $(this).attr('data-custom-user-state');
		var postalCode = $(this).attr('data-custom-brief-postal-code');
		var country = $(this).attr('data-custom-user-country');
		$(".address1").text(address1);
		$(".address2").text(address2);
		$(".phone").text(phone);
		$(".city").text(city);
		$(".state").text(state);
		$(".postalCode").text(postalCode);
		$(".country").text(country);
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

	var code = GetURLParameter('UpdateCustomer');

	if (code == "false") {
		$(".customModalBodyText").text("Email or Phone already exists!");
		$(".errmodal").modal();
	} else if (code =="true"){
			$("#updateMsg").text("Successfully updated a Customer!");
		
	}
</script>
</body>
</html>
