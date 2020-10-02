<!--
Name: Alwin Singh (p1935996)
Name: Choh Kaifeng (p1935590)
Class: DIT/2B/21
Group: 3
Subject: J2EE CA2 Assignment
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.ArrayList"%>
<%@ page import="fusionTechProductModel.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - Edit Customer Details</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link href="../../css/AdminDash.css" rel="stylesheet">
<link href="../../css/AdminForms.css" rel="stylesheet">
</head>
<%@ include file="../JSPProcessing/sqlPassword.jsp"%>
<%@include file="../HTML/WebPageNavBar.jsp"%>

<body>
	<%
	int index = Integer.parseInt(request.getParameter("editBtn"));

	if (session.getAttribute("usersList") != null) {
		//System.out.println("Exists....: " + session.getAttribute("usersList"));
	}
	ArrayList<UserDetails> usersList = (ArrayList<UserDetails>) session.getAttribute("usersList");
	//System.out.println("Loaded the arrayList... " + usersList.size());

	System.out.println(session.getAttribute("userTypeList"));
	if (session.getAttribute("userTypeList") != null) {
		//System.out.println("Exists....: " + session.getAttribute("userTypeList"));
	}
	ArrayList<UserDetails> userTypeList = (ArrayList<UserDetails>) session.getAttribute("userTypeList");
	//System.out.println("Loaded the arrayList... " + userTypeList.size());
	%>
	<div class="container-fluid">
		<div class="row">

			<%@include file="../HTML/adminDashNavBar.jsp"%>

			<main role="main"
				class="col-md-9 ml-sm-auto col-lg-10 pt-5 mt-5 px-0 mx-0">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 px-md-4 border-bottom">
					<h1 class="h2">Edit Customer Details</h1>
				</div>


				<div
					class="justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 px-md-4 mb-3">
					<p id="errorMsg"></p>

					<form action="../../../../updateCustomer" method="post"
						name="createCustomer" class="needs-validation" novalidate>

						<input type="hidden" value=<%= usersList.get(index).getUserID() %> name="customerDatabaseId">
						<input type="hidden" id="userRoleName" value="" name="userRoleName">
						
						<div class="form-group">
							<div class="name customerEmail">Customer Email:</div>
							<input type="email" name="customerEmail"
								class="form-control my-input" id="customerEmail"
								placeholder="Enter Email"
								value="<%=usersList.get(index).getUserEmail()%>" required>
						</div>

						<div class="form-group row">
							<div class="col">
								<div class="name firstName">First Name:</div>
								<input type="text" id="firstName" name="firstName"
									class="form-control" placeholder="Enter First Name"
									value="<%=usersList.get(index).getUserFirstName()%>"
									required="required" />
							</div>
							<div class="col">
								<div class="name lastName">Last Name:</div>
								<input type="text" id="lastName" name="lastName"
									class="form-control" placeholder="Enter Last Name"
									value="<%=usersList.get(index).getUserLastName()%>"
									required="required" />
							</div>
						</div>

						<div class="form-group row">
							<div class="col">
								<div class="name productCatLabel">User Role:</div>
								<select id="userRole" id="userRole" class="form-control"
									name="userRole">


									<%
										for (int i = 0; i < userTypeList.size(); i++) {
										int ID = i + 1;
										if (usersList.get(index).getUserType().equals(userTypeList.get(i).getUserType())) {
									%>
									<option value="<%=ID%>" data-typeName=<%=userTypeList.get(i).getUserType()%> selected><%=userTypeList.get(i).getUserType()%></option>

									<%
										} else {
									%>
									<option value="<%=ID%>"  data-typeName=<%=userTypeList.get(i).getUserType()%>><%=userTypeList.get(i).getUserType()%></option>
									<%
										}
									}
									%>
								</select>
							</div>
							<div class="col">
								<div class="name phoneNumber">Phone Number:</div>
								<input type="number" id="phoneNumber" name="phoneNumber"
									class="form-control" placeholder="Phone Number"
									value="<%=usersList.get(index).getUserPhone()%>"
									required="required" />
							</div>

							<div class="col">
								<div class="name address1">Address 1:</div>
								<input type="text" id="address1" name="address1"
									class="form-control" placeholder="Address 1"
									value="<%=usersList.get(index).getUserAddress()%>"
									required="required" />
							</div>
							<div class="col">
								<div class="name address1">Address 2:</div>
								<input type="text" id="address2" name="address2"
									value="<%=usersList.get(index).getUserAddress2()%>"
									class="form-control" placeholder="Address 2" />
							</div>
						</div>


						<div class="form-group row">
							<div class="col">
								<div class="name city">City:</div>
								<input type="text" id="city" name="city" class="form-control"
									value="<%=usersList.get(index).getUserCity()%>"
									placeholder="City" required="required" />
							</div>
							<div class="col">
								<div class="name state">State:</div>
								<input type="text" id="state" name="state" class="form-control"
									value="<%=usersList.get(index).getUserState()%>"
									placeholder="State" required="required" />
							</div>

							<div class="col">
								<div class="name postalCode">Postal Code:</div>
								<input type="number" id="postalCode" name="postalCode"
									class="form-control" placeholder="Postal Code"
									value="<%=usersList.get(index).getUserPostalCode()%>"
									required="required" />
							</div>
							<div class="col">
								<div class="name country">Country:</div>
								<input type="text" id="country" name="country"
									value="<%=usersList.get(index).getUserCountry()%>"
									class="form-control" placeholder="Country" required="required" />
							</div>
						</div>
						<div class="btn-toolbar mb-2 mb-md-0">
							<div class="btn-group mr-2">
								<button type="submit" onclick="validateFields()"
									name="updateBtn" value="<%=usersList.get(index).getUserEmail()%>"
									class="btn btn-lg rounded updateBtn primary-color-dark text-light">
									<i class="fas fa-paper-plane pr-3"></i>Update User
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
<script src="../../js/AdminValidateAddCustomer.js"></script>

<script>
	var currentType = $("#userRole").children("option:selected").attr('data-typeName');
	$("#userRoleName").val(currentType);
	
	
	$("#userRole").change(function(){
	    var selectedType = $(this).children("option:selected").attr('data-typeName');
	    $("#userRoleName").val(selectedType);;
	});

	$(".registerBtn")
			.click(
					function() {
						var registerPassword = $("#password").val();
						var passw = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/;
						if (registerPassword.match(passw)) {
						} else {
							alert("Password must be between 6 to 20 characters which contain at least one numeric digit, one uppercase and one lowercase letter");
							event.preventDefault();
							return false;
						}
					});
</script>
</html>