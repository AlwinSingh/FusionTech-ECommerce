<!--
Name: Alwin Singh (p1935996)
Name: Choh Kaifeng (p1935590)
Class: DIT/2B/21
Group: 3
Subject: J2EE CA1 Assignment
-->
<%@ page import="fusionTechUserModel.*"%>

<%
	//System.out.println("Getting log in status");

String userName = "Test";
String userRole = "Test";

UserDetails userData = new UserDetails();

if (session.getAttribute("userData") != null) {
	//System.out.println("User is logged in....");
	userData = (UserDetails) session.getAttribute("userData");
	userName = userData.getUserFirstName() + " " + userData.getUserLastName();
	userRole = userData.getUserType();
	
	//System.out.println("Usr name is: " +userName);
} else {
	//System.out.println("User is not logged in.....");
	userName = "Guest";
	userRole = "guest";
}
%>

<input type="hidden" id="userStatusRole" name="getUserRole"
	value="<%=userRole%>">
<input type="hidden" id="userStatusValue" name="getUserStatus"
	value="<%=userName%>">