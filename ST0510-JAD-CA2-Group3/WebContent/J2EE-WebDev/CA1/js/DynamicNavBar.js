		     $(document).ready(function() {
		    	 	//Retrieves the HTML Element that has the session value passed into the hidden input
		    		var userStatusValue = $("#userStatusValue").attr('value');
		    		if (userStatusValue.toLowerCase() == "guest") {
		    			//If user is a guest, disable account management (Edit Profile)
		    			$("#accountNavBarItem").html('<a class="nav-link text-light" href="./Login.jsp">Login / Register</a>');
		    			$(".accountManagementNavBar").css('display', 'none');
		    			$(".cartOptionNavBar").css('display', 'block');
		    		} else {
		    			$("#accountNavBarItem").html('<a class="nav-link text-light" href="../../../../logoutUser">Logout</a>');
		    			$(".accountManagementNavBar").css('display', 'block');
		    			$(".cartOptionNavBar").css('display', 'block');
		    		}
		    		
		    		var userStatusRole = $("#userStatusRole").attr('value');
		    		if (userStatusRole.toLowerCase() == "admin") {
		    			//If user is a admin, show the admin dashboard navbar option
		    			$("#adminNavBarItem").show();
		    			//$(".accountManagementNavBar").css('display', 'none');
		    			$("#adminNavBarItem").html('<a class="nav-link text-light" href="../Pages/AdminDashboard.jsp">Admin Dashboard</a>');
		    		} else {
		    			$("#adminNavBarItem").hide();
		    		}
		     });