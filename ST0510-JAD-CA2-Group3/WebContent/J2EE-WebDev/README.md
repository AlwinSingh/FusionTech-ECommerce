 
B: Web Application Specification 
 
Online Shop 
 
1.	Overview 
 
The COVID-19 pandemic is transforming consumer spending habits and lifestyles around the world, including Singapore. The situation has also acted as a catalyst for the Government’s constant encouragement to retailers to go digital though the SMEs Go Digital programs.  
 
In this assignment your team will be helping a retailer to Go Digital by designing and developing an online store and putting up their products or services on the web.  
 
<b>
For the time being, the system only allows the following roles: <br>
•	Administrator <br>
•	General Public (does not require login) <br>
 
It is expected that more roles will be added in the near future. 
 

The online store should have the following features:
 
(a)	A home (landing) page  <br>
(b)	Product category page  <br>
(c)	Product listing page  <br>
(d)	Product detail page  <br>
(e)	A customer registration page  <br>
(f)	An administrator page to allow the admin user to maintain the products of the online store such as Create, Remove, Update and Delete (CRUD) product info. <br> 
</b>
 
Reference: 
•	https://www.imda.gov.sg/programme-listing/smes-go-digital 
•	https://www.shoptiq.com.sg/blog/the-beauty-of-going-digital-when-old-trade-meetsnew-tech 
•	https://www.shoptiq.com.sg/blog/keeping-the-incense-burning-tradition-gets-adigital-boost 
 

 
2.	Functional Specification  
 
 	The following describes the various roles and their functions: 
 
2.1	Administrator 
 
2.1.1 Administrator can maintain the databases. Section 2.1.2 to 2.1.5 can only be achieved after successful login. The login credentials are to be stored in a database table and you are required to use this table to authenticate the administrator.  
 
2.1.2 The Administrator must be able to Create, Remove, Update and Delete (CRUD) products in the database. 
 
<b>
2.1.3 For each product, the following minimum information must be recorded: 
 
(a)	Product ID (Primary Key) <br>
(b)	Product title or name <br>
(c)	Brief description <br>
(d)	Detail description <br>
(e)	Cost price <br>
(f)	Retail price <br>
(g)	Stock quantity 
(h)	Product category <br>
(i)	Image location <br> 
</b>


----------------------------------------------------------------------------------------

 
Besides the above mandatory product info, the developer may suggest additional info/fields to be recorded. 
 
2.1.4 MySQL database tables has to be created to store the above product information with the following basic requirement: 
  
(a)	Each product category contains a number of products.  
(b)	Below is a sample Entity-Relationship-Diagram of part of a Sample Product Ordering System for your reference: 
 
 
(Source: https://online.visual-paradigm.com/diagrams/templates/entity-relationship-diagram/simple-ordersystem/) 
 
 
 
 **
2.1.5 Each product should have an image associated with it. By default the system will assign a default image. 
 
o Example: You can provide the file name in your web folder e.g. 
“\images\p101.png” as a text field in the Image location in the database. 
 
2.1.6 Minimally there should be at least 3 categories and 9 products in the database.  
 
 
 
 
 
2.2	General Public 
 
2.2.1 Login is not required for General Public.  
 
2.2.2 Public can view products by product category, brief description and detail description. 
 
2.2.3 Public can register as members through the customer registration page. They should be able to retrieve their own records to make changes.  
 
 
 
3.	System Specification  
 
3.1	Web Application Design and Development 
 
3.1.1 There should be a menu that caters to users with different roles. 
3.1.2 Navigation should be easy and intuitive. 
3.1.3 The website must be reasonably attractive, especially for the public. 
 
3.2	Database Design 
 
3.2.1 The database must be properly designed based on the above Functional Spec. 
3.2.2 Your design must cater for future enhancements. 
 

 
4.	Assessment Guidelines 
 
The assignment will be assessed based on the following criteria: 
 
•	Application and adaptation of knowledge learned from classroom (50%) 
•	Demonstrate the requirements stated above correctly and effectively (30%) 
•	Graphical User Interface and user friendliness: (10%)  
•	Advanced Features (10%) 
•	Amount of individual contribution to the project, including the submission of Peer Appraisal form (% of contribution) 
•	Question & Answer during the interview  
**
