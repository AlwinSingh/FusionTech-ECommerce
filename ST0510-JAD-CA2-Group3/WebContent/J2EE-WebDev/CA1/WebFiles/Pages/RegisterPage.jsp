<!--
Name: Alwin Singh (p1935996)
Name: Choh Kaifeng (p1935590)
Class: DIT/2B/21
Group: 3
Subject: J2EE CA1 Assignment
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - Registration</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link rel="stylesheet" href="../../css/Register.css">
</head>

<%
String firstName = (String) session.getAttribute("regFirstName");
String lastName = (String) session.getAttribute("regLastName");
String Email = (String) session.getAttribute("regEmail");
String Phone = (String) session.getAttribute("regPhone");
String regAddress = (String) session.getAttribute("regAddress1");
String City = (String) session.getAttribute("regCity");
String State = (String) session.getAttribute("regState");
String postalCode = (String) session.getAttribute("regPostalCode");
String Country = (String) session.getAttribute("regCountry");

if (firstName == null) {
	firstName = "";
}

if (lastName == null) {
	lastName = "";
}

if (Email == null) {
	Email = "";
}

if (Phone == null) {
	Phone = "";
}

if (regAddress == null) {
	regAddress = "";
}

if (City == null) {
	City = "";
}

if (State == null) {
	State = "";
}

if (postalCode == null) {
	postalCode = "";
}

if (Country == null) {
	Country = "";
}
%>

<body>

	<div class="signup-form">
		<form action="../JSPProcessing/processRegistration.jsp" method="POST">
			<h3 class="login-heading mb-4 text-light text-center">Welcome to
				Fusion Tech!</h3>
			<p class="hint-text">Create your account. It's free and only
				takes a minute.</p>
			<p class="hint-text" id="errorMsg"></p>
			<div class="form-group">
				<div class="row">
					<div class="col-6">
						<input type="text" class="form-control" name="regFirstName"
							placeholder="First Name" required="required"
							value=<%=firstName%>>
					</div>
					<div class="col-6">
						<input type="text" class="form-control" name="regLastName"
							placeholder="Last Name" required="required"
							value="<%=lastName%>">
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-6">
					<div class="form-group">
						<input type="email" class="form-control" id="regEmail"
							name="regEmail" placeholder="Email" required="required"
							value="<%=Email%>">
					</div>

					<div class="form-group">
						<input type="password" id="regPassword" class="form-control"
							name="regPassword" placeholder="Password" required="required">
					</div>
					<!--<div class="form-group">
            <input type="password" class="form-control" name="confirm_password" placeholder="Confirm Password" required="required">
        </div>-->
					<div class="form-group">
						<input type="number" class="form-control" name="regPhone"
							placeholder="Phone Number" required="required"
							value="<%=Phone%>">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" name="regAddress1"
							placeholder="Address" required="required"
							value="<%=regAddress%>">
					</div>
				</div>
				<div class="col-6">
					<div class="form-group">
						<input type="text" class="form-control" name="regCity"
							placeholder="City" required="required" value="<%=City%>">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" name="regState"
							placeholder="State" required="required" value="<%=State%>">
					</div>
					<div class="form-group">
						<input type="number" class="form-control" name="regPostalCode"
							placeholder="Postal Code" required="required"
							value="<%=postalCode%>">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" name="regCountry"
							placeholder="Country" required="required" value="<%=Country%>">
					</div>
				</div>
			</div>

			<div class="form-group mt-2">
				<label class="checkbox-inline"><input type="checkbox"
					required="required"> I accept the Terms of Use &amp;
					Privacy Policy</label>
			</div>
			<div class="form-group">
				<button
					class="btn btn-lg btn-block btn-login registerBtn text-uppercase font-weight-bold mb-3"
					type="submit">Register</button>
			</div>
		</form>
		<div class="text-center text-light">
			Already have an account? <a href="Login.jsp">Sign in</a>
		</div>
	</div>

</body>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
	$(".registerBtn")
			.click(
					function() {
						var registerPassword = $("#regPassword").val();
						var passw = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/;
						if(registerPassword.match(passw)) 
						{ 
						}
						else
						{ 
						alert("Password must be between 6 to 20 characters which contain at least one numeric digit, one uppercase and one lowercase letter");
						event.preventDefault();
						return false;
						}
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

	var errCode = GetURLParameter('errCode');

	if (errCode == "1062") {
		$("#errorMsg").text(
				"Error! Phone number / Email has already been taken!");
	}
</script>
</html>