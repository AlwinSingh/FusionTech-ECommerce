package servlets;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import fusionTechProductModel.imageUploadPath;
import fusionTechProductModel.updateProductToDB;

/**
 * Servlet implementation class adminUpdateProduct
 */
@WebServlet("/adminUpdateProduct")
public class adminUpdateProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public adminUpdateProduct() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		imageUploadPath path = new imageUploadPath();
		
		// Pre declared variables for use in the SQL Prepared statement. Placing them in
		// the try catch may cause variables to be not found / initialised
		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminUpdateProduct.jsp?update=false";
		String productName = null;
		String productSupplier = null;
		int productCode = 0;
		int productCat = 0;
		int productQty = 0;
		double productBuyPrice = 0;
		double productSellPrice = 0;
		String productBriefDescription = null;
		String productDescription = null;
		String productImage = null;
		int isAvailable = 0;

		boolean callDatabase = true;
		boolean updateStatus = false;

		File file;
		int maxFileSize = 5000 * 1024;
		int maxMemSize = 5000 * 1024;
		String filePath = path.getUploadPath();
		String fileName = "";

		String contentType = request.getContentType();
		// For file upload, it will be multipart/form-data
		// However, form such form data types, request.getParameter does not work, so we
		// shall see the method used below
		if ((contentType.indexOf("multipart/form-data") >= 0)) {

			// This uses apache commons upload
			/*
			 * This implementation creates FileItem instances which keep their content
			 * either in memory, for smaller items, or in a temporary file on disk, for
			 * larger items. The size threshold, above which content will be stored on disk,
			 * is configurable, as is the directory in which temporary files will be
			 * created.
			 */
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// The size of the files, beyond this are written to the disk
			factory.setSizeThreshold(maxMemSize);
			// This is a must to define as it sets the directory used to temporarily store
			// files that are larger than the configured size threshold.
			factory.setRepository(new File("c:\\temp"));
			/*
			 * This class handles multiple files per single HTML widget, sent using
			 * multipart/mixed encoding type, as specified by RFC 1867. Use
			 * parseRequest(HttpServletRequest) to acquire a list of FileItems associated
			 * with a given HTML widget.
			 */
			ServletFileUpload upload = new ServletFileUpload(factory);
			// Sets the max size which is defined through the variable maxFileSize
			upload.setSizeMax(maxFileSize);
			try {
				List fileItems = upload.parseRequest(request);
				Iterator i = fileItems.iterator();
				// out.println("<html>");
				// out.println("<body>");
				// So long as there are still elements to iterate through
				while (i.hasNext()) {
					// It gets the current element as a FielItem and checks if it is a formfield or
					// not
					FileItem fi = (FileItem) i.next();
					// If it is not a form field, it will match the element name with
					// fi.getFieldName() then it will
					// get the information through fi.getString();
					if (!fi.isFormField()) {
						String fieldName = fi.getFieldName();
						fileName = fi.getName();
						boolean isInMemory = fi.isInMemory();
						long sizeInBytes = fi.getSize();
						file = new File(filePath + "" + fileName);
						fi.write(file);
						// out.println("Uploaded Filename: " + filePath + fileName + "<br>");
					} else {
						String fieldname = fi.getFieldName();
						String fieldvalue = fi.getString();
						if (fieldname.equals("storeImageNameHiddenField")) {
							productImage = fieldvalue;
						}

						if (fieldname.equals("productName")) {
							productName = fieldvalue;
						}

						if (fieldname.equals("productSupplier")) {
							productSupplier = fieldvalue;
						}

						if (fieldname.equals("productCode")) {
							productCode = Integer.parseInt(fieldvalue);
						}
						if (fieldname.equals("productAvail")) {
							isAvailable = Integer.parseInt(fieldvalue);
						}
						if (fieldname.equals("productCat")) {
							productCat = Integer.parseInt(fieldvalue);
						}
						if (fieldname.equals("productQuantity")) {
							productQty = Integer.parseInt(fieldvalue);
						}
						if (fieldname.equals("productBuyPrice")) {
							productBuyPrice = Double.parseDouble(fieldvalue);
						}
						if (fieldname.equals("productSellPrice")) {
							productSellPrice = Double.parseDouble(fieldvalue);
						}
						if (fieldname.equals("productBriefDesc")) {
							productBriefDescription = fieldvalue;
						}
						if (fieldname.equals("productDescription")) {
							productDescription = fieldvalue;
						}
					}
				}

				if (!productImage.equals(fileName)) {
					File f = new File(path + "" + productImage);
					f.delete();
				}
			} catch (Exception e) {
				callDatabase = false;
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminUpdateProduct.jsp?update=true?error="
						+ e.getMessage();
			}
		} else {
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminUpdateProduct.jsp?update=false";
			callDatabase = false;
		}

		if (callDatabase) {
			SQLString sqlConnUrl = new SQLString();
			updateProductToDB update = new updateProductToDB();
			updateStatus = update.updateProduct(productCode, productCat, productName, productSupplier,
					productBriefDescription, productDescription, productQty, productBuyPrice, productSellPrice,
					isAvailable, fileName, sqlConnUrl.getSQLConnString());

			if (updateStatus) {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminUpdateProduct.jsp?update=true";
			} else {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminUpdateProduct.jsp?update=false";
			}

		}

		response.sendRedirect(redirectURL);

	}

}
