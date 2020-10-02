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
<title>Fusion Tech</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link rel="stylesheet" href="../../css/Login.css">
</head>

<%
//session.invalidate();
%>

<body>

	<div class="container-fluid bg-image">
		<div class="row no-gutter">
			<!--<div class="d-none d-md-flex col-md-4 col-lg-6 bg-image"></div>-->
			<div class="col-lg-4"></div>
			<div class="col-md-8 col-lg-4"
				style="background-color: rgba(0, 0, 0, 0.65);">
				<div class="login d-flex align-items-center py-5">
					<div class="container">
						<div class="row">
							<div class="col-md-9 col-lg-8 mx-auto">
								<h3 class="login-heading mb-4 text-light">Welcome to Fusion
									Tech!</h3>
								<p class="display-5 text-center text-light pb-2" id="regMsg"></p>
								<p class="display-5 text-center text-light pb-2" id="errorMsg"></p>
								<p class="display-5 text-center text-light pb-2" id="resetMsg"></p>
								<!--  old action: ../JSPProcessing/verifyLogin.jsp  -->
								<form action="../../../../verifyLogin" method="POST">
									<div class="form-label-group">
										<input name="inputUserEmail" type="text" id="inputEmail"
											class="form-control" placeholder="Email address" required
											autofocus> <label for="inputEmail"><i
											class="fas fa-user pr-3"></i>Email address</label>
									</div>

									<div class="form-label-group">
										<input name="inputUserPass" type="password" id="inputPassword"
											class="form-control" placeholder="Password" required>
										<label for="inputPassword"><i class="fas fa-key pr-3"></i>Password</label>
									</div>

									<!--<div class="custom-control custom-checkbox mb-3">
                  <input type="checkbox" class="custom-control-input" id="customCheck1">
                  <label class="custom-control-label" for="customCheck1">Remember password</label>
                </div>-->

									<button
										class="btn btn-lg btn-block btn-login text-uppercase font-weight-bold mb-3"
										type="submit">Log in</button>
									<div class="text-center">
										<a class="small text-light" href="resetPassword.jsp">Forgot password?</a>
									</div>
									<div class="text-center">
										<a class="small text-light" href="RegisterPage.jsp">Create
											a new account</a>
									</div>
								</form>
								<div class="text-center">
									<a class="small text-light" href="HomePage.jsp">Proceed as
										a guest</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-4"></div>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>

<script>
	function GetURLParameter(sParam) {
		var sPageURL = window.location.search.substring(1);
		//As URL parameters are split via '&', it retrieves the parameter title (e.g. 'errCode')
		var sURLVariables = sPageURL.split('&');
		for (var i = 0; i < sURLVariables.length; i++) {
			var sParameterName = sURLVariables[i].split('=');
			if (sParameterName[0] == sParam) {
				return sParameterName[1];
			}
		}
	}

	//These variables retrieves the respective URL Parameters' value
	var errCode = GetURLParameter('errCode');
	var registerCode = GetURLParameter('justRegistered');
	var resetPassCode = GetURLParameter('resetPass');
	
	//If the value matches either of the conditions below, it updates the text content of the html element
	if (resetPassCode == 'true') {
		$("#resetMsg").text("Successfully updated password! (Check your email)");
	}

	if (registerCode == 'true') {
		$("#regMsg").text("Successfully registered! Please login!");
	}
	
	if (registerCode == "true" && errCode == "invalidLogin") {
		$("#regMsg").text("");
		$("#errorMsg").text("Invalid login credentials!");
	}
	
	if (errCode == "invalidLogin") {
		$("#errorMsg").text("Invalid Credentials!");
	} else if (!isNaN(errCode) && errCode.length > 0) {
		$("#errorMsg").text("Error logging in! Please contact system admin!")
	} else {
		$("#errorMsg").empty().hide();
	}
</script>

</html>