<!--
Name: Alwin Singh (p1935996)
Name: Choh Kaifeng (p1935590)
Class: DIT/2B/21
Group: 3
Subject: J2EE CA1 Assignment
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,fusionTechUserModel.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - Edit Profile</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="../../css/editProfile.css">
</head>

<body>
	<%@ include file="../HTML/WebPageNavBar.jsp"%>

	<div class="container col-sm-6 col-sm-offset-3 hidden">
		<h1 class="text-center">
			<small>Currency Conversion</small>
		</h1>
		<hr />
		<form>
			<div class="form-group">
				<label for="amountInput">Input Amount</label>
				<div class="input-group">
					<div class="input-group-addon">$</div>
					<input type="number" class="form-control input-lg"
						id="usdAmountInput" autofocus>
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<div class="form-group">
						<div class="form-group">
							<label for="inputState">From Currency</label> <select
								id="inputState" class="form-control">
								<option selected>Choose...</option>
								<option>...</option>
							</select>
						</div>
					</div>
				</div>
				<div class="col-12">
				<div class="form-group">
					<div class="form-group">
						<label for="inputState">To Currency</label> <select
							id="inputState" class="form-control">
							<option selected>Choose...</option>
							<option>...</option>
						</select>
					</div>
				  </div>
				</div>
			</div>
		</form>
		<button type="button" class="btn btn-lg btn-primary rounded w-100">Convert now</button>
		<table class="table">
			<caption id="exchangeRate"></caption>
			<thead>
				<tr>
					<th>???</th>
					<th>???</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td id="usdAmountFormatted">$0.00</td>
					<td id="nzdAmountFormatted">$0.00</td>
				</tr>
			</tbody>
		</table>
		<hr />
	</div>

	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/numeral.js/2.0.6/numeral.min.js"></script>
	<script>
		$(document)
				.ready(
						function() {
							var usdToNzd;
							const accessKey = 'APP ID'
							$
									.get(
											`https://openexchangerates.org/api/latest.json?base=USD&symbols=NZD&app_id=${accessKey}`,
											function(response) {
												usdToNzd = response.rates.NZD;
												$(".exchangeRate").text(
														"1 USD = " + usdToNzd
																+ " NZD");
												$(".container").removeClass(
														"hidden");
											});

							/*
							On every input change for the USD value, update the NZD value.
							And format to a currency format using http://numeraljs.com/
							 */
							$("#usdAmountInput").on(
									"input",
									function(event) {
										// show and format USD amount
										$("#usdAmountFormatted").text(
												numeral(event.target.value)
														.format("$0,0.00"));
										// show and format NZD amount
										$("#nzdAmountFormatted").text(
												numeral(
														event.target.value
																* usdToNzd)
														.format("$0,0.00"));
									});
						});
	</script>

	<%@ include file="../HTML/WebPageFooter.html"%>
</body>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="../../js/DynamicNavBar.js"></script>
<script src="../../js/UserValidateEditProfile.js"></script>

<script>
	function GetURLParameter(sParam) {
		var sPageURL = window.location.search.substring(1);
		var sURLVariables = sPageURL.split('&');
		for (var i = 0; i < sURLVariables.length; i++) {
			var sParameterName = sURLVariables[i].split('=');
			if (sParameterName[0] == sParam) {
				//Once it locates the value passed into the function, it retrieves the next Index [1] which is the value of the URL Parameter
				//It then returns the value which is then stored in a variable 'editCode' down below which is used to match it against conditions
				return sParameterName[1];
			}
		}
	}

	//Retrieves the URL Parameter
	var editCode = GetURLParameter('editCode');
</script>

</html>