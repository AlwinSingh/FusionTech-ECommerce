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
<link rel="stylesheet" href="../../css/displayCategoryProducts.css">
</head>

<body>
	<%@ include file="../JSPProcessing/sqlPassword.jsp"%>
	<div class="container mt-5 mb-5">
		<form action="viewProduct.jsp" method="POST" class="col-12">
			<div class="row">
				<%
					try {
					// Step1: Load JDBC Driver
					Class.forName("com.mysql.jdbc.Driver");
					// Step 2: Define Connection URL
					String connURL = "jdbc:mysql://localhost/j2eeca2?user=root&password=" + sqlPass
					+ "&serverTimezone=UTC&useSSL=false";
					// Step 3: Establish connection to URL
					Connection conn = DriverManager.getConnection(connURL);
					// Step 4: Create Statement object
					Statement stmt = conn.createStatement();
					// Step 5: Execute SQL Command
					//By selecting Distinct it removes duplicate products
					String sqlStrCategories = "SELECT DISTINCT * FROM PRODUCTS LIMIT 3;";
					ResultSet products = stmt.executeQuery(sqlStrCategories);
					// Step 6: Process Result
					while (products.next()) {
				%>

				<div class="col-4">
					<figure class="card card-product">
						<div class="img-wrap pt-2">
							<img
								src="../../Group3DIT2B21Resources/<%=products.getString("Image")%>">
						</div>
						<figcaption class="info-wrap text-center">
							<h6 class="title text-dots">
								<a href="#"><%=products.getString("Name")%></a>
							</h6>
							<div class="action-wrap">
								<div class="price-wrap h5 mt-2">
									<span class="price-new">$<%=products.getString("SellPrice")%></span>
								</div>
								<!-- price-wrap.// -->
							</div>
							<!-- action-wrap -->
						</figcaption>
						<hr>
						<button type="submit"
							class="btn btn-primary btn-sm float-right productBtnProcess"
							data-custom-value-name="<%=products.getString("Name")%>"
							data-custom-value="<%=products.getString("ProductCode")%>">
							View Product</button>
					</figure>
					<!-- card // -->
				</div>
				<!-- col // -->

				<%
					}
				%>

				<input type="hidden" id="productInput" name="getProductCode"
					value=""> <input type="hidden" id="productNameInput"
					name="getProductName" value="">
			</div>
		</form>
	</div>


	<%
		// Step 7: Close connection
	conn.close();
	} catch (Exception e) {
		System.err.println("Error :" + e);
	}
	%>

</body>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	//Upon pressing the 'View Product' button, it redirects to the viewProduct.jsp
	//viewProduct.jsp needs a specific productName and ID which is why upon clicking the button it passes the value of that particular button to the hidden input field
	$('.productBtnProcess').click(
			function() {
				var categoryName = $(this).attr('data-custom-value-name');
				var categoryID = $(this).attr('data-custom-value');
				var setHiddenInputName = $("#productNameInput").attr('value',
						categoryName)
				var setHiddenInputValue = $("#productInput").attr('value',
						categoryID)
			});
</script>

</html>