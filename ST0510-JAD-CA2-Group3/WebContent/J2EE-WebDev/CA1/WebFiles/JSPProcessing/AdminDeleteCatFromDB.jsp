<!--
Name: Alwin Singh (p1935996)
Name: Choh Kaifeng (p1935590)
Class: DIT/2B/21
Group: 3
Subject: J2EE CA1 Assignment
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - Delete Cat</title>
</head>
<body>
	<%@ include file="../JSPProcessing/sqlPassword.jsp"%>
	<%
		String redirectURL = "";
	//Retrieves the value of the category to delete via a hidden form field
	int catCode = Integer.parseInt(request.getParameter("deleteHiddenField"));

	try {
		// STEP 1: LOAD JDBC DRIVER
		Class.forName("com.mysql.jdbc.Driver");
		// STEP 2: DEFINE CONNECTION URL
		String connURL = "jdbc:mysql://localhost/j2eeca2?user=root&password="+sqlPass+"&serverTimezone=UTC&useSSL=false";
		// STEP 3: ESTABLISH CONNECTION TO URL
		Connection conn = DriverManager.getConnection(connURL);
		// STEP 4: CREATE STATEMENT OBJECT
		Statement stmt = conn.createStatement();
		// STEP 5: EXECUTE SQL COMMAND
		String insertStr = "DELETE FROM Category WHERE catID = ?";
		//Prepared statement to prevent SQL Injection
		PreparedStatement pstmt = conn.prepareStatement(insertStr);
		//Value corresponds to the location of '?'
		pstmt.setInt(1, catCode);
		int insert = pstmt.executeUpdate();
		redirectURL = "../Pages/AdminDeleteCat.jsp?delCode=success";

		conn.close();
	} catch (SQLException e) {
		//If there is an SQL Error, place it in the URL and redirect back to the page
		redirectURL = "../Pages/AdminDeleteCat.jsp?delCode=" + e.getErrorCode();
		//out.println("ERROR: " + e);
	}

	response.sendRedirect(redirectURL);
	%>


</body>

</html>