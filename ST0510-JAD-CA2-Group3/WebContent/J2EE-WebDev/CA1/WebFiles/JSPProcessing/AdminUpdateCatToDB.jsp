<!--
Name: Alwin Singh (p1935996)
Name: Choh Kaifeng (p1935590)
Class: DIT/2B/21
Group: 3
Subject: J2EE CA1 Assignment
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import=" java.lang.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - Update to DB Cat</title>
</head>

<body>
	<%@ include file="../JSPProcessing/sqlPassword.jsp"%>
	<%
	//Retrieves the information through the form fields
	String catCode = request.getParameter("catCode");
	String catName = request.getParameter("catName");
	String catDesc = request.getParameter("catDescription");
	//Default redirectURL is a update success, if there is an error it will change below through the try catch
	String redirectURL = "../Pages/AdminUpdateCat.jsp?update=true";
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
		String updateStr = "UPDATE Category SET CategoryName = ?,Description = ? WHERE catID = ?";
	    PreparedStatement pstmt = conn.prepareStatement(updateStr);
	    
	    pstmt.setString(1, catName);
	    pstmt.setString(2, catDesc);
	    pstmt.setString(3, catCode);
	    
	    int insert = pstmt.executeUpdate();
		
	//STEP 7
	conn.close();
	} catch (SQLException e) {
		out.println("ERROR: " + e);
		redirectURL = "../Pages/AdminEditingCatPage.jsp?errCode="+e.getErrorCode();
	}
	
	response.sendRedirect(redirectURL);
	%>
</body>
</html>