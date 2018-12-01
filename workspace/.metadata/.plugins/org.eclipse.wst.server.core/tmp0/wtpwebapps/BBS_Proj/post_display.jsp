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
String postID = request.getParameter("postID");
try {
	con = DriverManager.getConnection(URL, USERNAME, PASSWORD);// 获取连接
	String sql = "select * from posts a natural join bbsUser b, replys c natural join bbsUser d" 
	+ " where a.postID = c.postID and a.postID = ?";
	pre = con.prepareStatement(sql);
	pre.setString(1, postID);
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
<title>POST</title>
</head>
<body>
<table>
	<tr>
		<td><a href="welcome.jsp">HomePage</a></td>
		<td><a href="user_center.jsp">UserCenter</a></td>
		<td><a href="section.jsp">Sections</a></td>
	</tr>
</table>
<% boolean firstResult = true;
   while (result.next()) { %>
	<% if (firstResult) { %>
		<h2><%= result.getString("title") %></h2>
		<table>
		<tr>
			<td>Author: <a href="user_center.jsp?userName=<%= result.getString("nickname") %>"><%= result.getString("nickname") %></a></td>
		</tr>
		<tr>
			<td>PostTime: <%= result.getString("postTime") %></td>
		</tr>
		</table>
		<p><%= result.getString("content") %></p>
		<h3>Replies: </h3>
	<% firstResult = false;
	} %>
	<div>
	<table>
		<tr>
			<td>Floor #<%= result.getString("floorNum") %></td>
		</tr>
		<tr>
			<td>ReplyTime: <%= result.getString("replyTime") %></td>
		</tr>
		<tr>
			<td>Replyer: <a href="user_center.jsp?userName=<%= result.getString("d.nickname") %>"><%= result.getString("d.nickname") %></a></td>
		</tr>
		<tr>
			<td>Praise: <%= result.getString("praiseNum") %></td>
		</tr>
	</table>
	<p><a><%= result.getString("replyContent") %></a></p>
	</div>
<% } %>
</body>
</html>