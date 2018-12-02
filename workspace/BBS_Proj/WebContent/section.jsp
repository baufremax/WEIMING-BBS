<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.util.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
Connection con = null;// build a database connect
PreparedStatement pre = null;
ResultSet result = null;
String URL = "jdbc:mysql://localhost/bbs";
String USERNAME = "root";
String PASSWORD = "wzy960806";
try {
	con = DriverManager.getConnection(URL, USERNAME, PASSWORD);// 获取连接
	String sql = "select sectionName from section";
	pre = con.prepareStatement(sql);
	result = pre.executeQuery();
}
catch (Exception e)
{
    e.printStackTrace();
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SECTION</title>
</head>
<body>
	<table>
	<tr>
		<td><a href="welcome.jsp">HomePage</a></td>
		<td><a href="user_center.jsp?userName=<%= session.getAttribute("username")%>">UserCenter</a></td>
	</tr>
	</table>
	<h2>Select the section you want to access.</h2>
	<table>
	<% while (result.next()) { %>
	<tr>
		<td><a href="section_action.jsp?sectionName=<%= result.getString("sectionName")%>"><%= result.getString("sectionName") %></a></td>
	</tr>
	<% } %>
	</table>
</body>
</html>