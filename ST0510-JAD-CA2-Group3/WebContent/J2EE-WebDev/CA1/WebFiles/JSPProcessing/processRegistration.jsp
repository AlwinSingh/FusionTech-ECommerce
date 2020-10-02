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
<%@ page import="java.security.*,passEncryption.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fusion Tech - Registration</title>
</head>
<%@ include file="../JSPProcessing/sqlPassword.jsp"%>
<%
	String redirectURL = "../Pages/Login.jsp?justRegistered=false";
final String secretKey = "ssshhhhhhhhhhh!!!!";
passEncryption cryptPass = new passEncryption();

try {
	String Email = (request.getParameter("regEmail").toString()).toLowerCase();
	String Password = request.getParameter("regPassword").toString();
	Password = cryptPass.encrypt(Password, secretKey);
	String FirstName = request.getParameter("regFirstName").toString();
	String LastName = request.getParameter("regLastName").toString();
	Integer Phone = Integer.parseInt(request.getParameter("regPhone").toString());
	String Address1 = request.getParameter("regAddress1").toString();
	String City = request.getParameter("regCity").toString();
	String State = request.getParameter("regState").toString();
	Integer PostalCode = Integer.parseInt(request.getParameter("regPostalCode"));
	String Country = request.getParameter("regCountry").toString();

	session.setAttribute("regEmail", Email);
	session.setAttribute("regFirstName", FirstName);
	session.setAttribute("regLastName", LastName);
	session.setAttribute("regPhone", Phone.toString());
	session.setAttribute("regAddress1", Address1);
	session.setAttribute("regCity", City);
	session.setAttribute("regState", State);
	session.setAttribute("regPostalCode", PostalCode.toString());
	session.setAttribute("regCountry", Country);

	String insertStr = "INSERT INTO Users (Email, Password, FirstName, LastName, Phone, Address1, City, State, PostalCode, Country) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	// Step1: Load JDBC Driver
	Class.forName("com.mysql.jdbc.Driver");
	// Step 2: Define Connection URL
	String connURL = "jdbc:mysql://localhost/j2eeca2?user=root&password="+sqlPass+"&serverTimezone=UTC&useSSL=false";
	// Step 3: Establish connection to URL
	Connection conn = DriverManager.getConnection(connURL);
	// Step 4: Create Statement object
	PreparedStatement pstmt = conn.prepareStatement(insertStr);
	pstmt.setString(1, Email);
	pstmt.setString(2, Password);
	pstmt.setString(3, FirstName);
	pstmt.setString(4, LastName);
	pstmt.setInt(5, Phone);
	pstmt.setString(6, Address1);
	pstmt.setString(7, City);
	pstmt.setString(8, State);
	pstmt.setInt(9, PostalCode);
	pstmt.setString(10, Country);
	;
	int insert = pstmt.executeUpdate();

	if (insert > 0) {
		session.invalidate();
		redirectURL = "../Pages/Login.jsp?justRegistered=true";
	}

	// Step 5: Close connection
	conn.close();
} catch (SQLException e) {
	redirectURL = "../Pages/RegisterPage.jsp?errCode=" + e.getErrorCode();
}

response.sendRedirect(redirectURL);
%>


<body>
</body>
</html>