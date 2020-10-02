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
<title>Fusion Tech - About Page</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="../../css/AboutPage.css">
</head>
<body>

	<%@ include file="../HTML/WebPageNavBar.jsp"%>

	<!--<div class="bg-white pt-5">
		<div class="container py-5">
			<h2 class="font-weight-light" style="text-align: center">
				We aim to provide you with the <span class="text-primary">latest</span>
				and <span class="text-success">most innovative</span> technologies
				and make it <span class="text-warning">suit your style.</span>
			</h2>
			<br>
		</div>
	</div>-->

	<div class="background" style="background-color: #00203FFF">
		<div class="container py-3">
			<div class="row h-100 align-items-center py-1">
				<div class="col-lg-6 d-none d-lg-block">
					<img src="../../image/aboutUsLogo.png" style="width: 85%" alt=""
						class="img-fluid">
					<h5 class="text-white" id="demo"></h5>
				</div>
				<div class="col-lg-6">
					<h1 class="display-4 text-white">ABOUT US</h1>
					<p class="lead text-white mb-0">Established in 2020, Fusion
						Technologies was founded locally in Singapore. Every product and
						service we provide happens because every one of us at Fusion
						Technologies strive towards a common goal - creating the best
						customer experiences.</p>
					<br>
					<p class="lead text-white mb-0">We aim to provide our customers
						with the latest and newest technologies available on the market.</p>
				</div>
			</div>
		</div>
	</div>

	<div class="background" style="background-color: white">
		<div class="container py-3">
			<div class="row h-100 align-items-center py-1">
				<div class="col-lg-6">
					<h1 class="display-4">BRANDS</h1>
					<p class="lead mb-0">At Fusion Technologies, we have the latest
						products from global brands such as Apple & Samsung. We also carry
						accessories from brands like Urban Armour Gear & Spigen to match
						your devices.</p>
					<br>
					<p class="lead mb-0">We believe our customers will be spoiled
						for choices at our wide array of products!</p>
				</div>
				<div class="col-lg-6 d-none d-lg-block" style="text-align: center">
					<img src="../../image/logoCollage.png" style="width: 85%" alt=""
						class="img-fluid">
					<h5 class="text-white" id="demo"></h5>
				</div>
			</div>
		</div>
	</div>

	<div class="background" style="background-color: #00203FFF">
		<div class="container py-3">
			<h2 class="text-white pb-3" style="text-align: center">WHY US?</h2>

			<div class="row text-center" style="justify-content: center">
				<!-- Team item-->
				<div class="col-xl-3 col-sm-6 mb-2">
					<div class="bg-white rounded shadow-sm py-4 px-4"
						style="min-height: 343.55px">
						<img src="../../image/bestPrice.png" alt="" width="200%"
							class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm"
							style="max-height: 144.53px">
						<h5 class="mb-3">Best Price</h5>
						<span class="text-muted">At Fusion Technologies, we ensure
							that you are getting the best out of your money.</span>
					</div>
				</div>
				<!-- End-->

				<!-- Team item-->
				<div class="col-xl-3 col-sm-6 mb-2">
					<div class="bg-white rounded shadow-sm py-4 px-4"
						style="min-height: 343.55px">
						<img src="../../image/returnPolicy.png" alt="" width="200%"
							class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm">
						<h5 class="mb-3">30 Days Policy</h5>
						<span class="text-muted">Have an issue with your new
							device? Email us and we will do an 1 to 1 exchange.</span>
					</div>
				</div>
				<!-- End-->

				<!-- Team item-->
				<div class="col-xl-3 col-sm-6 mb-2">
					<div class="bg-white rounded shadow-sm py-4 px-4"
						style="min-height: 343.55px">
						<img src="../../image/wideVariety.png" alt="" width="69.71%"
							class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm">
						<h5 class="mb-3">Wide Variety</h5>
						<span class="text-muted">We are sure that you are able to
							find something to your liking!</span>
					</div>
				</div>
				<!-- End-->


			</div>
			<br>
			<p class="text-white m-0" style="text-align: center">Terms &
				Conditions applies.</p>
		</div>
	</div>

	<div class="bg-white pt-5">
		<div class="container py-5">
			<h2 class="font-weight-light" style="text-align: center">
				<span>Browse through our wide array of Products available.</span>
			</h2>
			<br>

			<div class="link" style="text-align: center">
				<a href="./ProductCategory.jsp" style="color: black;"><b>Product
						Category</b></a>
			</div>
		</div>
	</div>

	<%@ include file="../HTML/WebPageFooter.html"%>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="../../js/DynamicNavBar.js"></script>
<script src="../../js/animateNavBar.js"></script>
</html>