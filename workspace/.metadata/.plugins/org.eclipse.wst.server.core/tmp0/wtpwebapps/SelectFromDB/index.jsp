
<%@ page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver"); %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylsheet" href="style.css" type="text/css">
<title>SelectFromDB</title>
</head>
<body>		
	<h3>SelectFromDB</h3>
	<%! 
	public class Advisor {
		String URL = "jdbc:mysql://localhost/university";
		String USERNAME = "root";
		String PASSWORD = "wzy960806";
		
		Connection connection = null;
		PreparedStatement selectAdvisor = null;
		PreparedStatement insertAdvisor = null;
		PreparedStatement deleteAdvisor = null;
		ResultSet resultSet = null;
		
		public Advisor() {
			try {
				connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
				selectAdvisor = connection.prepareStatement(
						"SELECT * FROM university.advisor");
				insertAdvisor = connection.prepareStatement(
						"INSERT INTO university.advisor (s_ID, i_ID) VALUES (?, ?)");
				deleteAdvisor = connection.prepareStatement(
						"DELETE FROM university.advisor WHERE s_ID = ? AND i_ID = ?");
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		public ResultSet getAdvisor() {
			try {
				resultSet = selectAdvisor.executeQuery();
				
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
			return resultSet;
		}
		
		public int setAdvisor(String s_ID, String i_ID) {
			int result = 0;
			try {
				insertAdvisor.setString(1, s_ID);
				insertAdvisor.setString(2, i_ID);
				result = insertAdvisor.executeUpdate();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
			return result;
		}
		
		public int removeAdvisor(String s_ID, String i_ID) {
			int result = 0;
			try {
				deleteAdvisor.setString(1, s_ID);
				deleteAdvisor.setString(2, i_ID);
				result = deleteAdvisor.executeUpdate();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
			return result;
		}
	}
	%>
	<% 
		// get tuple.
		Advisor advisor = new Advisor();
		ResultSet advisors = advisor.getAdvisor();
		
		int result = 0;
		// insert tuple.
		if (request.getParameter("submitInsert") != null) {		// check if the value is successfully submitted.
			String s_ID = new String();
			String i_ID = new String();
			
			if (request.getParameter("s_ID") != null) {
				s_ID = request.getParameter("s_ID");
			}
			if (request.getParameter("i_ID") != null) {
				i_ID = request.getParameter("i_ID");
			}
			
			result = advisor.setAdvisor(s_ID, i_ID);
		}
		
		// delete tuple.
		if (request.getParameter("submitDelete") != null) {		// check if the value is successfully submitted.
			String s_ID = new String();
			String i_ID = new String();
			
			if (request.getParameter("s_ID") != null) {
				s_ID = request.getParameter("s_ID");
			}
			if (request.getParameter("i_ID") != null) {
				i_ID = request.getParameter("i_ID");
			}
			result = advisor.removeAdvisor(s_ID, i_ID);
		}
		%>

	<%-- insert tuple --%>
	<p>Insert A Tuple.</p>
	<form action="index.jsp" method="POST" name="myInsertForm">
	<table border='0'>
		<tbody>
			<tr>
				<td>S_ID:</td>
				<td><input type="text" name="s_ID" size="50"/></td>
			</tr>
			<tr>
				<td>I_ID:</td>
				<td><input type="text" name="i_ID" size="50"/></td>
			</tr>
		</tbody>
	</table>
	<%-- use JavaScript to check if "result" is 0, and to know whether the update succeeded. --%>
	<input type="hidden" value="<%= result %>" name="hidden" />
	<input type="reset" value="Clear" name="clear" />
	<input type="submit" value="Submit" name="submitInsert" />
	</form>
	
	<%-- delete tuple. --%>
	<p>Delete A Tuple.</p>
	<form action="index.jsp" method="POST" name="myDeleteForm">
	<table border='0'>
		<tbody>
			<tr>
				<td>S_ID:</td>
				<td><input type="text" name="s_ID" size="50"/></td>
			</tr>
			<tr>
				<td>I_ID:</td>
				<td><input type="text" name="i_ID" size="50"/></td>
			</tr>
		</tbody>
	</table>
	<%-- use JavaScript to check if "result" is 0, and to know whether the update succeeded. --%>
	<input type="hidden" value="<%= result %>" name="hidden" />
	<input type="reset" value="Clear" name="clear" />
	<input type="submit" value="Submit" name="submitDelete" />
	</form>
	
	<%-- display table. --%>
	<table border="1">
	<tbody>
		<tr>
			<td>S_ID</td>
			<td>I_ID</td>
		</tr>
		<% while (advisors.next()) { %>
		<tr>
			<td><%= advisors.getString("s_ID") %></td>
			<td><%= advisors.getString("i_ID") %></td>
		</tr>
		<% } %>
	</tbody>
	</table>
</body>
</html>