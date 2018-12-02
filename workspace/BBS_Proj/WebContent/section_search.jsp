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
String sectionName = request.getParameter("sectionName");
String searchOption = request.getParameter("searchOption");
try {
	con = DriverManager.getConnection(URL, USERNAME, PASSWORD);// 获取连接
	String sql = "select * from " + searchOption + " where sectionName = ?";
	pre = con.prepareStatement(sql);
	pre.setString(1, sectionName);
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
<title>SEARCH RESULT</title>
</head>
<body>
<table>
	<tr>
		<td><a href="welcome.jsp">HomePage</a></td>
		<td><a href="user_center.jsp">UserCenter</a></td>
		<td><a href="section.jsp">Sections</a></td>
	</tr>
</table>
<h2><%= request.getParameter("sectionName") %></h2>
<p><a href="post_new.jsp?sectionName=<%=  request.getParameter("sectionName") %>">NEW POST</a></p>
<table>
	<% while (result.next()) { %>
	<% if (searchOption.equals("userPostBySection") || searchOption.equals("userReplyBySection")) {
		%>
		<tr>
		<td><%= result.getString("nickname") %></td>
		<td><%= result.getString("gender") %></td>
		<td><%= result.getString("birthdate") %></td>
		</tr>
		<%
			}
		if (searchOption.equals("hotPostBySection")) {
				%>
		<tr>
			<td><a><%= result.getString("postID") %></a></td>
			<td>title: <a><%= result.getString("title") %></a></td>
			<td>poster: <%=  result.getString("nickname")%></td>
			<td><a href="post_display.jsp?postID=<%= result.getString("postID") %>&sectionName=<%= request.getParameter("sectionName") %>">details</a></td>
		</tr>
	<% } 
	if (searchOption.equals("clickAboveAvg")) { %>
		<tr>
			<td><%= result.getString("postID") %></td>
			<td><%= result.getString("title") %></td>
			<td>(<%= result.getString("clickNum") %> clicks)</td>
			<td><a href="post_display.jsp?postID=<%= result.getString("postID") %>&sectionName=<%= request.getParameter("sectionName") %>">details</a></td>
		</tr>
	<% } 
	if (searchOption.equals("replyAboveAvg")) { %>
	<tr>
		<td><%= result.getString("userID") %></td>
		<td><%= result.getString("nickname") %></td>
	</tr> 
	<% } %>
	<% } %>
</table>
</body>
</html>