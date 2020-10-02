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
@WebServlet("/adminUpdateProductNoImage")
public class adminUpdateProductNoImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public adminUpdateProductNoImage() {
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
		
			//Retrieves the form field(s) that will be consumed by the SQL Query for update
			String productName = request.getParameter("productName");
			String productSupplier = request.getParameter("productSupplier");
			int productCode = Integer.parseInt(request.getParameter("productCode"));
			int isAvailable = Integer.parseInt(request.getParameter("productAvail"));
			int productCat = Integer.parseInt(request.getParameter("productCat"));
			int productQty = Integer.parseInt(request.getParameter("productQuantity"));
			double productBuyPrice = Double.parseDouble(request.getParameter("productBuyPrice"));
			double productSellPrice = Double.parseDouble(request.getParameter("productSellPrice"));
			String productBriefDescription = request.getParameter("productBriefDesc");
			String productDescription = request.getParameter("productDescription");
			String productImage = request.getParameter("storeImageName");
			String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminUpdateProduct.jsp?update=false";
		
			boolean updateStatus = false;


			SQLString sqlConnUrl = new SQLString();
			updateProductToDB update = new updateProductToDB();
			updateStatus = update.updateProductNoImage(productCode, productCat, productName, productSupplier,
					productBriefDescription, productDescription, productQty, productBuyPrice, productSellPrice,
					isAvailable, productImage, sqlConnUrl.getSQLConnString());

			if (updateStatus) {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminUpdateProduct.jsp?update=true";
			} else {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminUpdateProduct.jsp?update=false";
			}
			
			response.sendRedirect(redirectURL);

		}

	}