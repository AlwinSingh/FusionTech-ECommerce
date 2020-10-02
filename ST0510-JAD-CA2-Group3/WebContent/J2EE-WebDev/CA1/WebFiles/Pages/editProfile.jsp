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

<%
	UserDetails user = new UserDetails();
	
	if (session.getAttribute("userData") != null) {
		user = (UserDetails) session.getAttribute("userData");
	} else {
		response.sendRedirect("HomePage.jsp?error=notLoggedIn");	
	}
%>

<body>
	<%@ include file="../HTML/WebPageNavBar.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col-lg-4">
				<div class="profile-card-4 z-depth-3">
					<div class="card">
						<div class="card-body text-center primary-color-dark rounded-top">
							<div class="user-box">
								<img src="https://bootdey.com/img/Content/avatar/avatar7.png"
									alt="user avatar">
							</div>
							<h5 class="mb-1 text-white"><%= userName %></h5>
							<h6 class="text-light text-capitalize"><%= userRole %></h6>
							<p class="badge" id="editMsg"></p>
						</div>
						<div class="card-body">
							<ul class="list-group shadow-none">
								<li class="list-group-item">
									<div class="list-icon">
										<i class="fa fa-phone-square"></i>
									</div>
									<div class="list-details">
										<span style="display: none" class="userPhone"><%= user.getUserPhone() %></span>
										<small>Mobile Number</small>
									</div>
								</li>
								<li class="list-group-item">
									<div class="list-icon">
										<i class="fa fa-envelope"></i>
									</div>
									<div class="list-details">
										<span><%= user.getUserEmail() %></span> <small>Email Address</small>
									</div>
								</li>
								<li class="list-group-item primary-color-dark">
				                  <div class="list-icon text-light">
				                    <i class="fa fa-globe"></i>
				                  </div>
				                  <div class="list-details">
				                  <a class="text-light" href="../../../../getUserAddresses">
				                    <span>Edit Addresses</span>
				                    <small class="text-light">Edit your shopping & billing address</small>
				                  </a>
				                  </div>
				                </li>
				                <li class="list-group-item primary-color-dark">
				                  <div class="list-icon text-light">
				                    <i class="fa fa-database"></i>
				                  </div>
				                  <div class="list-details">
				                  <a class="text-light" href="../../../../getUserOrders">
				                    <span>View Your Orders</span>
				                    <small class="text-light">View & Cancel Orders</small>
				                  </a>
				                  </div>
				                </li>

							</ul>
							<!-- <div class="row text-center mt-4">
                  <div class="col p-2">
                   <h4 class="mb-1 line-height-5">154</h4>
                    <small class="mb-0 font-weight-bold">Projects</small>
                   </div>
                    <div class="col p-2">
                      <h4 class="mb-1 line-height-5">2.2k</h4>
                     <small class="mb-0 font-weight-bold">Followers</small>
                    </div>
                    <div class="col p-2">
                     <h4 class="mb-1 line-height-5">9.1k</h4>
                     <small class="mb-0 font-weight-bold">Views</small>
                    </div>
                 </div>-->
						</div>
						<!--<div class="card-footer text-center">
                 <a href="javascript:void()" class="btn-social btn-facebook waves-effect waves-light m-1"><i class="fa fa-facebook"></i></a>
                 <a href="javascript:void()" class="btn-social btn-google-plus waves-effect waves-light m-1"><i class="fa fa-google-plus"></i></a>
                 <a href="javascript:void()" class="list-inline-item btn-social btn-behance waves-effect waves-light"><i class="fa fa-behance"></i></a>
                 <a href="javascript:void()" class="list-inline-item btn-social btn-dribbble waves-effect waves-light"><i class="fa fa-dribbble"></i></a>
               </div>-->
					</div>
				</div>
			</div>
			<div class="col-lg-8">
				<div class="card z-depth-3">
					<div class="card-body">
						<ul class="nav nav-pills nav-pills-muted nav-justified mb-4">
							<!--<li class="nav-item">
                    <a href="javascript:void();" data-target="#profile" data-toggle="pill" class="nav-link active show"><i class="icon-user"></i> <span class="hidden-xs">Profile</span></a>
                </li>
                <li class="nav-item">
                    <a href="javascript:void();" data-target="#messages" data-toggle="pill" class="nav-link"><i class="icon-envelope-open"></i> <span class="hidden-xs">Messages</span></a>
                </li>-->
							<li class="nav-item"><a data-target="#edit"
								data-toggle="pill"
								class="nav-link primary-color-dark text-white disabled"> <i
									class="icon-note"></i> <span class="hidden-xs">Edit</span></a></li>
						</ul>
						<!--<div class="tab-content p-3">
                <div class="tab-pane active show" id="profile">
                    <h5 class="mb-3">User Profile</h5>
                    <div class="row">
                        <div class="col-md-6">
                            <h6>About</h6>
                            <p>
                                Web Designer, UI/UX Engineer
                            </p>
                            <h6>Hobbies</h6>
                            <p>
                                Indie music, skiing and hiking. I love the great outdoors.
                            </p>
                        </div>
                        <div class="col-md-6">
                            <h6>Recent badges</h6>
                            <a href="javascript:void();" class="badge badge-dark badge-pill">html5</a>
                            <a href="javascript:void();" class="badge badge-dark badge-pill">react</a>
                            <a href="javascript:void();" class="badge badge-dark badge-pill">codeply</a>
                            <a href="javascript:void();" class="badge badge-dark badge-pill">angularjs</a>
                            <a href="javascript:void();" class="badge badge-dark badge-pill">css3</a>
                            <a href="javascript:void();" class="badge badge-dark badge-pill">jquery</a>
                            <a href="javascript:void();" class="badge badge-dark badge-pill">bootstrap</a>
                            <a href="javascript:void();" class="badge badge-dark badge-pill">responsive-design</a>
                            <hr>
                            <span class="badge badge-primary"><i class="fa fa-user"></i> 900 Followers</span>
                            <span class="badge badge-success"><i class="fa fa-cog"></i> 43 Forks</span>
                            <span class="badge badge-danger"><i class="fa fa-eye"></i> 245 Views</span>
                        </div>
                        <div class="col-md-12">
                            <h5 class="mt-2 mb-3"><span class="fa fa-clock-o ion-clock float-right"></span> Recent Activity</h5>
                            <table class="table table-hover table-striped">
                                <tbody>                                    
                                    <tr>
                                        <td>
                                            <strong>Abby</strong> joined ACME Project Team in <strong>`Collaboration`</strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>Gary</strong> deleted My Board1 in <strong>`Discussions`</strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>Kensington</strong> deleted MyBoard3 in <strong>`Discussions`</strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>John</strong> deleted My Board1 in <strong>`Discussions`</strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>Skell</strong> deleted his post Look at Why this is.. in <strong>`Discussions`</strong>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>-->
						<!--<div class="tab-pane" id="messages">
                    <div class="alert alert-info alert-dismissible" role="alert">
    			   <button type="button" class="close" data-dismiss="alert">�</button>
				    <div class="alert-icon">
					 <i class="icon-info"></i>
				    </div>
				    <div class="alert-message">
				      <span><strong>Info!</strong> Lorem Ipsum is simply dummy text.</span>
				    </div>
                  </div>
                    <table class="table table-hover table-striped">
                        <tbody>                                    
                            <tr>
                                <td>
                                   <span class="float-right font-weight-bold">3 hrs ago</span> Here is your a link to the latest summary report from the..
                                </td>
                            </tr>
                            <tr>
                                <td>
                                   <span class="float-right font-weight-bold">Yesterday</span> There has been a request on your account since that was..
                                </td>
                            </tr>
                            <tr>
                                <td>
                                   <span class="float-right font-weight-bold">9/10</span> Porttitor vitae ultrices quis, dapibus id dolor. Morbi venenatis lacinia rhoncus. 
                                </td>
                            </tr>
                            <tr>
                                <td>
                                   <span class="float-right font-weight-bold">9/4</span> Vestibulum tincidunt ullamcorper eros eget luctus. 
                                </td>
                            </tr>
                            <tr>
                                <td>
                                   <span class="float-right font-weight-bold">9/4</span> Maxamillion ais the fix for tibulum tincidunt ullamcorper eros. 
                                </td>
                            </tr>
                        </tbody> 
                    </table>
                </div>-->
						<div class="tab-pane" id="edit">
							<form action="../../../../updateUserProfile"
								method="POST">
								<div class="form-group row">
									<label class="col-lg-3 col-form-label form-control-label">First
										name</label>
									<div class="col-lg-9">
										<input class="form-control" id="userFirstName"
											name="userFirstName" type="text" value="<%= user.getUserFirstName() %>"
											required>
									</div>
								</div>
								<div class="form-group row">
									<label class="col-lg-3 col-form-label form-control-label">Last
										name</label>
									<div class="col-lg-9">
										<input class="form-control" id="userLastName"
											name="userLastName" type="text" value="<%= user.getUserLastName() %>"
											>
									</div>
								</div>
								<div class="form-group row">
									<label class="col-lg-3 col-form-label form-control-label">Email</label>
									<div class="col-lg-9">
										<input class="form-control" id="userNewEmail"
											name="userNewEmail" type="email" value="<%= user.getUserEmail() %>"
											required>
									</div>
								</div>
								<!--<div class="form-group row">
                            <label class="col-lg-3 col-form-label form-control-label">Change profile</label>
                            <div class="col-lg-9">
                                <input class="form-control" type="file">
                            </div>
                        </div>-->
								<div class="form-group row">
									<label class="col-lg-3 col-form-label form-control-label">Phone
										Number</label>
									<div class="col-lg-9">
										<input class="form-control" id="userPhone" name="userPhone"
											type="text" value="<%= user.getUserPhone() %>" required>
									</div>
								</div>
								<div class="form-group row">
									<label class="col-lg-3 col-form-label form-control-label">Primary
										Address</label>
									<div class="col-lg-9">
										<input class="form-control" id="userAddress"
											name="userAddress" type="text" value="<%= user.getUserAddress() %>"
											placeholder="" required>
									</div>
								</div>
								<div class="form-group row">
									<label class="col-lg-3 col-form-label form-control-label">Secondary
										Address</label>
									<div class="col-lg-9">
										<input class="form-control" id="userAddress2"
											name="userAddress2" type="text" value="<%= user.getUserAddress2() %>"
											placeholder="Optional secondary address">
									</div>
								</div>
								<div class="form-group row">
									<label class="col-lg-3 col-form-label form-control-label"></label>
									<div class="col-lg-6">
										<input class="form-control" id="userCity" name="userCity"
											type="text" value="<%= user.getUserCity() %>" placeholder="City"
											required>
									</div>
									<div class="col-lg-3">
										<input class="form-control" id="userState" name="userState"
											type="text" value="<%= user.getUserState() %>" placeholder="State"
											required>
									</div>
								</div>

								<div class="form-group row">
									<label class="col-lg-3 col-form-label form-control-label">Postal
										Code</label>
									<div class="col-lg-9">
										<input class="form-control" id="userPostalCode"
											name="userPostalCode" type="text"
											value="<%= user.getUserPostalCode() %>" required>
									</div>
								</div>

								<div class="form-group row">
									<label class="col-lg-3 col-form-label form-control-label">Country</label>
									<div class="col-lg-9">
										<input class="form-control" id="userCountry"
											name="userCountry" type="text" value="<%= user.getUserCountry() %>"
											required>
									</div>
								</div>
								<div class="form-group row">
									<label class="col-lg-3 col-form-label form-control-label">Password</label>
									<div class="col-lg-6">
										<input class="form-control" id="userPass" name="userPass"
											type="password" value="<%= user.getUserPass() %>" required> <input
											type="hidden" id="hiddenOriginalUserPass"
											value="<%= user.getUserPass() %>">
									</div>
									<div class="col-lg-3">
										<button type="button" id="viewPassBtn"
											class="btn btn-sm btn-dark">View Pass</button>
									</div>
								</div>
								<!--<div class="form-group row">
                            <label class="col-lg-3 col-form-label form-control-label">Confirm password</label>
                            <div class="col-lg-9">
                                <input class="form-control" type="password" value="<%= user.getUserPass() %>">
                            </div>
                        </div>-->
								<div class="form-group row">
									<label class="col-lg-3 col-form-label form-control-label"></label>
									<div class="col-lg-9">
										<input type="reset" class="btn btn-danger editProfileResetBtn"
											value="Reset"> <input type="submit"
											class="btn primary-color-dark text-light"
											value="Save Changes">
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>


	<%@ include file="../HTML/WebPageFooter.html"%>


	<div class="modal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Confirm Password</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>Please confirm your password</p>
					<p id="cfmPassErr"></p>
					<div class="form-group">
						<label for="pwd">Password:</label> <input type="password"
							class="form-control" id="confirmInputPass" required>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button"
						class="btn primary-color-dark text-white modalViewPassBtn">View
						Password</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
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
<script src="../../js/UserValidateEditProfile.js"></script>

<script>
	$(document)
			.ready(
					function() {
						var userPhone = $(".userPhone").text();
						var hideUserPhone = userPhone.substring(0,
								(userPhone.length / 2));
						var censorText = "";

						for (var i = 0; i < userPhone.length / 2; i++) {
							censorText += "X";
						}

						$(".userPhone").text(hideUserPhone + censorText).css(
								'display', 'block');

						$('.modalViewPassBtn')
								.click(
										function() {
											var inputPassword = $(
													"#confirmInputPass").val();
											var originalPassword = $(
													"#hiddenOriginalUserPass")
													.attr('value');

											if (inputPassword == originalPassword) {
												$("#cfmPassErr").removeClass(
														'text-danger').text("");
												$("#userPass").attr('type',
														'text');
												$("#confirmInputPass").val("");
												$(".modal").modal("hide");

												setTimeout(function() {
													$("#userPass").attr('type',
															'password');
												}, 10000);

											} else {
												$("#cfmPassErr")
														.addClass('text-danger')
														.text(
																"Input doesn't match your current password!");
												$("#confirmInputPass").val("");
											}
										});

						$("#viewPassBtn").click(function() {
							$(".modal").modal();
						})

						$(".editProfileResetBtn").click(function() {
							$("#userPass").attr('type', 'password');
						})
					});

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

	//Checks the URL Parameter value to see which condition is met and appends the HTML element accordingly
	if (editCode == "true") {
		$("#editMsg").text("Succesfully updated your profile!");
	} else if (editCode == 1062) {
		$("#editMsg").text(
		"Profile update failed! Phone Number / Email already taken!");
	}
	else if (!isNaN(editCode) && editCode.length > 0) {
		$("#editMsg").text(
				"Profile update failed! Please contact system admin!");
	} else {
		$("#editMsg").empty().hide();
	}
</script>

</html>