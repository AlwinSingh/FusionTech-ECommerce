package servlets;

public class SQLString {
	
	//SQL String that is specified here for easy retrieval and update among developers across all Model Layers
	String sqlString = "jdbc:mysql://localhost/j2eeca2?user=root&password=Wolfteam911$&serverTimezone=UTC";
	
	//Get method that retrieves the SQL connection String above
	public String getSQLConnString() {
		return sqlString;
	}}
