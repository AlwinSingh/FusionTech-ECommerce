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
<title>Fusion Tech - Contact Page</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap"
	rel="stylesheet">
</head>
<body>

	<%@ include file="../HTML/WebPageNavBar.jsp"%>
	
	    <div class="jumbotron jumbotron-fluid mb-0 z-depth-2" style="display:block;background-image: linear-gradient(to right, #0b2040, #0a224a) !important;">
        <div class="container">
            <h1 class="display-4 mt-3 text-light">Contact us</h1>
            <p class="text-light">Feel free to contact us down below!</p>
        </div>
    </div>


	<div class="background" style="background-color: white">
		<div class="container py-3">
			<div class="row">
				<!-- Team item-->
				<div class="col mb-2">
					<h2 class="pb-3">Address</h2>
					<iframe
						src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3988.775876175282!2d103.77536081470124!3d1.3097756990447111!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31da1a602ff17c15%3A0xa9545dd23993859e!2sSingapore%20Polytechnic!5e0!3m2!1sen!2ssg!4v1589971164735!5m2!1sen!2ssg"
						width="500" height="350" frameborder="0" style="border: 0;"
						aria-hidden="false" tabindex="0"></iframe>
				</div>
				<!-- End-->

				<!-- Team item-->
				<div class="col mb-2">
					<h2 class="pb-3">Contact Details</h2>
					<div class="bg-white px-4">
						<i class="fas fa-envelope "></i> <span style="font-size: 1em">&nbsp;Email:
							<a href="mailto: fusionTech@hmail.com">&nbsp;fusionTech@hmail.com</a>
						</span> <br> <i class="fas fa-phone pt-2"></i> <span
							style="font-size: 1em">&nbsp;Call: &nbsp;1800-387466
							(1800-fusion)</span> <br> <i class="fas fa-clock"></i> <span
							class="pt-5"> &nbsp;Monday to Sunday (Including Public
							Holidays) 8:00am to 8:00pm</span>
					</div>
				</div>
				<!-- End-->
			</div>
			<br>
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
