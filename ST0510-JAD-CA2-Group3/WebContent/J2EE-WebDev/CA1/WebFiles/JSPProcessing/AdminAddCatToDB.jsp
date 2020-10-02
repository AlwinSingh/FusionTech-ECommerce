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
<title>AdminAddCatToDB</title>
</head>
<body>
	<%@ include file="../JSPProcessing/sqlPassword.jsp"%>

	<%
	String redirectURL = "../Pages/AdminDashboard.jsp?addCat=true";
	int catID = Integer.parseInt(request.getParameter("CatID"));
	String catName = request.getParameter("CatName");
	String catDescription = request.getParameter("CatDesc");
	String catImage = request.getParameter("CatImage");
	try {
		// STEP 1: LOAD JDBC DRIVER
		Class.forName("com.mysql.jdbc.Driver");
		// STEP 2: DEFINE CONNECTION URL
		String connURL = "jdbc:mysql://localhost/j2eeca2?user=root&password=" + sqlPass + "&serverTimezone=UTC&useSSL=false";
		// STEP 3: ESTABLISH CONNECTION TO URL
		Connection conn = DriverManager.getConnection(connURL);
		// STEP 4: CREATE STATEMENT OBJECT
		Statement stmt = conn.createStatement();
		// STEP 5: EXECUTE SQL COMMAND
		String insertStr = "INSERT INTO Category(catID, CategoryName, Description) values (?, ?, ?)";

		//Prepared Statement prevents SQL Injection
	    PreparedStatement pstmt = conn.prepareStatement(insertStr);
	    
		//The '?' corresponds to the input below
	    pstmt.setInt(1, catID);
	    pstmt.setString(2, catName);
	    pstmt.setString(3, catDescription);

	    
	    int insert = pstmt.executeUpdate();
	    
	conn.close();
	} catch (SQLException e) {
		//If there is an SQL Error, it will return back to the page with the code in the URL
		//From there, error can be handled using JS (Get URL Function)
		redirectURL = "../Pages/AdminCreateCat.jsp?errCode=" +e.getErrorCode();
	}
	
	response.sendRedirect(redirectURL);
	%>
</body>

</html>