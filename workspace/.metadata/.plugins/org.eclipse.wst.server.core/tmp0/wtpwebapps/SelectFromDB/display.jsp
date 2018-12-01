
<%@ page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver"); %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%! 
	public class Advisor {
		String URL = "jdbc:mysql://localhost/university";
		String USERNAME = "root";
		String PASSWORD = "wzy960806";
		
		Connection connection = null;
		PreparedStatement selectAdvisor = null;
		ResultSet resultSet = null;
		
		public Advisor() {
			try {
				connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
				selectAdvisor = connection.prepareStatement(
						"SELECT s_ID, i_ID FROM university.advisor"
						+" WHERE s_ID = ? AND i_ID = ?;");	
						// the space in front of WHERE is necessary!!
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		public ResultSet getAdvisor(String s_ID, String i_ID) {
			try {
				selectAdvisor.setString(1, s_ID);
				selectAdvisor.setString(2, i_ID);
				resultSet = selectAdvisor.executeQuery();
				
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
			return resultSet;
		}
	}
	%>
	
	<%-- get request --%>
	<%
		String s_ID = new String();
		String i_ID = new String();
		
		if (request.getParameter("s_ID") != null) {
			s_ID = request.getParameter("s_ID");
		}
		if (request.getParameter("i_ID") != null) {
			i_ID = request.getParameter("i_ID");
		}
		
		Advisor advisor = new Advisor();
		ResultSet advisors = advisor.getAdvisor(s_ID, i_ID);
	%>
	
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