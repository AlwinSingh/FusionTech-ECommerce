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
<title>Fusion Tech - Edit Product</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link href="../../css/AdminDash.css" rel="stylesheet">
<link href="../../css/AdminForms.css" rel="stylesheet">
</head>

<body>
	<%@ include file="../JSPProcessing/sqlPassword.jsp"%>
	<%@include file="../HTML/WebPageNavBar.jsp"%>

	<div class="container-fluid">
		<div class="row">

			<%@include file="../HTML/adminDashNavBar.jsp"%>

			<%
				String selectedid = request.getParameter("editbtn");
			String productName = "", productSupplier = "", productCode = "", productDescription = "", productBriefDesc = "",
					productImage = "";
			int productCat = 0, productQty = 0, productAvail = 0;
			double productSellPrice = 0, productBuyPrice = 0;

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
				String sqlStr = "SELECT * FROM Products WHERE productcode = ?";
				PreparedStatement pstmt = conn.prepareStatement(sqlStr);
				pstmt.setInt(1, Integer.parseInt(selectedid));

				ResultSet rs = pstmt.executeQuery();
				// STEP 6: PROCESS RESULTS 
				while (rs.next()) {
					productName = rs.getString("Name");
					productSupplier = rs.getString("Supplier");
					productCode = rs.getString("ProductCode");
					productCat = rs.getInt("Category");
					productQty = rs.getInt("QtyInStock");
					productSellPrice = rs.getDouble("SellPrice");
					productBuyPrice = rs.getDouble("BuyPrice");
					productDescription = rs.getString("PdtDescription");
					productBriefDesc = rs.getString("BriefDescription");
					productAvail = rs.getInt("isAvailable");
					productImage = rs.getString("Image");
				}
			%>

			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 p-0">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 px-md-4 mb-3 border-bottom">
					<h1 class="h2">Edit Product</h1>
				</div>

				<div
					class="justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 px-md-4 mb-3">
					<form action="#" id="updateProductForm" method="post" name="login"
						enctype="">
						<div class="form-group">
							<div class="name">Product Name:</div>
							<input type="text" name="productName"
								class="form-control my-input" id="productName"
								value="<%out.println(productName);%>" />
						</div>
						<div class="form-group">
							<div class="name">Product Supplier:</div>
							<input type="text" name="productSupplier"
								class="form-control my-input" id="productSupplier"
								value="<%out.println(productSupplier);%>" />
						</div>
						<div class="form-group row">
							<div class="col">
								<div class="name">Product Code:</div>
								<input type="text" name="productCode" class="form-control"
									value="<%out.println(productCode);%>" readonly />
							</div>
							<div class="col">
								<div class="name">Availability:</div>
								<select id="productAvail" class="form-control"
									name="productAvail">
									<%
										if (productAvail == 0) {
									%>
									<option value="0" selected>Not Available</option>
									<option value="1">Available</option>
									<%
										} else {
									%>
									<option value="0">Not Available</option>
									<option value="1" selected>Available</option>
									<%
										}
									%>
								</select>
							</div>
							<div class="col">
								<div class="name">Category:</div>
								<select id="productCat" class="form-control" name="productCat">
									<%
										int i = 0;
									String sqlCatStr = "SELECT CategoryName FROM Category";
									ResultSet getCategories = stmt.executeQuery(sqlCatStr);

									while (getCategories.next()) {
										String categoryName = getCategories.getString("CategoryName");
										i++;

										if (i == productCat) {
									%>
									<option value="<%=i%>" selected><%=categoryName%></option>
									<%
										} else {
									%>
									<option value="<%=i%>"><%=categoryName%></option>
									<%
										}
									}
									%>
								</select>
							</div>
							<div class="col">
								<div class="name">Product Quantity:</div>
								<input type="text" name="productQuantity" class="form-control"
									value="<%out.println(productQty);%>" />
							</div>
							<div class="col">
								<div class="name">Product Sell Price: $</div>
								<input type="text" name="productSellPrice" class="form-control"
									value="<%out.println(productSellPrice);%>" />
							</div>
							<div class="col">
								<div class="name">Product Buy Price: $</div>
								<input type="text" name="productBuyPrice" class="form-control"
									value="<%out.println(productBuyPrice);%>" />
							</div>
						</div>
						<div class="form-group">
							<div class="name imageUploadLabel">Image Upload:</div>
							<!--<input type="text" name="productImage"
								class="form-control my-input" id="productImage"
								placeholder="Enter Product Image Link ">-->

							<div class="showCurrentImage">
								<button type="button"
									class="btn rounded btn-sm primary-color-dark text-light btnImage"
									data-toggle="modal" data-target="#pdtImageModal"
									data-custom-value="<%=productImage%>">View Product
									Image</button>
							</div>

							<input type="hidden" class="storeImageNameHiddenField"
								name="storeImageNameHiddenField" style="display: none"
								value="<%=productImage%>"></input> <input id="imageUploadFile"
								name="productImage" type="file"
								class="btn rounded btn-sm primary-color-dark text-light"
								name="file" size="50" accept="image/*" /> <input type="hidden"
								name="storeImageName" value="<%=productImage%>">
						</div>
						<div class="form-group">
							<div class="name">Product Brief Description:</div>
							<textarea class="form-control" id="message"
								name="productBriefDesc" rows="2"><%out.println(productBriefDesc);%></textarea>
						</div>
						<div class="form-group">
							<div class="name">Product Description:</div>
							<textarea class="form-control" id="message"
								name="productDescription" rows="4"><%out.println(productDescription);%></textarea>
						</div>
						<div class="btn-toolbar mb-2 mb-md-0">
							<div class="btn-group mr-2">
								<button type="submit" class="btn btn-sm btn-danger"
									formaction="AdminUpdateProduct.jsp">Cancel</button>
								<button type="submit"
									class="btn btn-sm btn-success saveProductInfoBtn"
									style="margin-left: 5px">Save</button>
								<!--<button type="submit" class="btn btn-sm btn-success saveProductInfoNoImageBtn" 
									formaction="../JSPProcessing/AdminUpdateToDBNoImage.jsp"
									style="margin-left: 5px">Save (No Image Update)</button>-->
							</div>
						</div>

					</form>
					<%
						conn.close();
					} catch (Exception e) {
						out.println("ERROR: " + e);
					}
					%>
				</div>

				<%@ include file="../HTML/WebPageFooter.html"%>
			</main>
		</div>
	</div>


	<!-- Modal -->
	<div class="modal fade" id="pdtImageModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Product Image</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body imageModalBody text-center"></div>
				<div class="modal-footer">
					<button type="button" class="btn primary-color-dark text-light"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

</body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="../../js/DynamicNavBar.js"></script>

<script>
	$(".btnImage")
			.click(
					function() {
						var imageName = $(this).attr('data-custom-value');
						$(".imageModalBody")
								.html(
										"<img class='img-fluid' style='max-height: 300px' src='../../Group3DIT2B21Resources/" + imageName + "' alt=" + imageName + ">");
					});

	/*$('input:file').change(function() {
		if ($("#imageUploadFile")[0].files.length != 0 ){
			$(".saveProductInfoBtn").attr('formaction', '../JSPProcessing/AdminUpdateToDB.jsp');
			 //$(".saveProductInfoNoImageBtn").addClass("disabled");
			 //$(".saveProductInfoBtn").removeClass("disabled");
		 } else {
			 $(".saveProductInfoBtn").attr('formaction', '../JSPProcessing/AdminUpdateToDBNoImage.jsp');
			 //$(".saveProductInfoNoImageBtn").removeClass("disabled");
			 //$(".saveProductInfoBtn").addClass("disabled");
		 }
	});*/

	$(".saveProductInfoBtn").click(
			function() {
				if ($("#imageUploadFile")[0].files.length != 0) {
					$('#updateProductForm').attr('enctype',
							'multipart/form-data').attr("encoding",
							"multipart/form-data");
					$('#updateProductForm').attr('action',
							'../../../../adminUpdateProduct');
				} else {
					$('#updateProductForm').attr('enctype', '').attr(
							"encoding", "");
					$('#updateProductForm').attr('action',
							'../../../../adminUpdateProductNoImage');
				}
			});

	function getInputSelection(el) {
		var start = 0, end = 0, normalizedValue, range, textInputRange, len, endRange;

		if (typeof el.selectionStart == "number"
				&& typeof el.selectionEnd == "number") {
			start = el.selectionStart;
			end = el.selectionEnd;
		} else {
			range = document.selection.createRange();

			if (range && range.parentElement() == el) {
				len = el.value.length;
				normalizedValue = el.value.replace(/\r\n/g, "\n");

				// Create a working TextRange that lives only in the input
				textInputRange = el.createTextRange();
				textInputRange.moveToBookmark(range.getBookmark());

				// Check if the start and end of the selection are at the very end
				// of the input, since moveStart/moveEnd doesn't return what we want
				// in those cases
				endRange = el.createTextRange();
				endRange.collapse(false);

				if (textInputRange.compareEndPoints("StartToEnd", endRange) > -1) {
					start = end = len;
				} else {
					start = -textInputRange.moveStart("character", -len);
					start += normalizedValue.slice(0, start).split("\n").length - 1;

					if (textInputRange.compareEndPoints("EndToEnd", endRange) > -1) {
						end = len;
					} else {
						end = -textInputRange.moveEnd("character", -len);
						end += normalizedValue.slice(0, end).split("\n").length - 1;
					}
				}
			}
		}

		return {
			start : start,
			end : end
		};
	}

	function detectLineBreak() {
		var element = document.getElementById("message");
		// Focus element, in case that it's not
		element.focus();
		var currentString = $("#message").text();
		var result = getInputSelection(element);
		var splitString = currentString.substring(0, result.start);
		var splitStringRemainder = currentString.substring(result.start);
		var combinedString = splitString + "<br>" + splitStringRemainder;
		//$("#message").text(combinedString);
		console.log(combinedString);
		return false;
	}
</script>
</html>