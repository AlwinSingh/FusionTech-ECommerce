package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fusionTechProductModel.*;
import fusionTechUserModel.UserDetails;

/**
 * Servlet implementation class inquireReportProducts
 */
@WebServlet("/adminGetAllProducts")
public class adminGetAllProducts extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public adminGetAllProducts() {
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

		HttpSession session = request.getSession();

		int pageSize = 5;
		String pageNumber = "1";
		String oldTableType = "VAL";

		if (session.getAttribute("productInquiryType") != null) {
			// Get old inquiry type to see if need to reset pagination
			oldTableType = session.getAttribute("productInquiryType").toString();
		} else {
			oldTableType = "VAL";
		}

		// System.out.println("Button Value: " + request.getParameter("buttonValue"));
		// System.out.println("Old Table Type: " + oldTableType);

		if (request.getParameter("buttonValue") != null) {
			if (!oldTableType.contentEquals(request.getParameter("buttonValue"))) {
				// System.out.println("New inquiry type");
				pageNumber = "1";
			} else {
				// System.out.println("Same inquiry type");
				// System.out.println("CHECKING: " +request.getParameter("servletPageNumber"));
				if (request.getParameter("servletPageNumber") != null) {
					pageNumber = request.getParameter("servletPageNumber");
				}
			}
		}

		/*
		 * if (pageNumber == null) { System.out.println("It is null"); pageNumber = "1";
		 * }
		 */

		// System.out.println("Page Number: " +pageNumber);

		// System.out.println(pageNumber);

		String redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllProducts.jsp?errorCode=400";

		try {
			SQLString sqlStr = new SQLString();
			ArrayList<allProducts> productsList = null;
			UserDetails user = (UserDetails) session.getAttribute("userData");

			if (user != null && user.getUserType().contentEquals("admin")) {
				String tableType = request.getParameter("buttonValue");
				String filterValue = request.getParameter("filterInputValue");

				if (tableType != null || tableType != "") {
					if (tableType.contentEquals("PWLS")) {
						if (filterValue != "") {
						System.out.println("Setting session for PWLS");
						session.setAttribute("filterValue", filterValue);
						}
					}
				}

				if (request.getParameter("buttonValue") == null || request.getParameter("buttonValue") == "") {
					tableType = "VAP";
					session.setAttribute("productInquiryType", tableType);
				} else {
					if ((filterValue == null || filterValue == "") && tableType.contentEquals("PWLS")) {
						System.out.println("PWLS error now u load ur session");
						System.out.println("PWLS Session: " +filterValue);
						filterValue = session.getAttribute("filterValue").toString();
					}
				}

				if (pageNumber == null || pageNumber == "" || pageNumber.length() < 1) {
					pageNumber = "1";
				}

				if (tableType.equals("VAP") || tableType.equals("default")) {
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllProducts.jsp?page="
							+ (Integer.parseInt(pageNumber) - 1);
					session.setAttribute("productInquiryType", tableType);
				} else {
					redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllProducts.jsp?page="
							+ (Integer.parseInt(pageNumber) - 1) + "&inquireReport=" + tableType;
					session.setAttribute("productInquiryType", tableType);
				}

				// System.out.println("New Table Type: " +
				// session.getAttribute("productInquiryType").toString());

				getInquireReportProductsFromDB inquireReportProducts = new getInquireReportProductsFromDB();
				productsList = inquireReportProducts.inquireProducts(pageSize,
						(pageSize * (Integer.parseInt(pageNumber) - 1)), tableType, filterValue,
						sqlStr.getSQLConnString());

				session.setAttribute("productsList", productsList);
			} else {
				redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/HomePage.jsp?error=unauthorised";
			}
		} catch (Exception e) {
			System.out.println("[Servlet / Admin] Inquire/Report Customers: " + e);
			System.out.println("[Servlet / Admin] Inquire/Report Customers: " + e.getMessage());
			redirectURL = "/ST0510-JAD-CA2-Group3/J2EE-WebDev/CA1/WebFiles/Pages/AdminViewAllProducts.jsp?errorCode=400";
		} finally {
			response.sendRedirect(redirectURL);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
