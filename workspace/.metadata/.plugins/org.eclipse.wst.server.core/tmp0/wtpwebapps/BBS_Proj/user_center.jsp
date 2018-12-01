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
ResultSet postResult = null;
ResultSet replyResult = null;
String URL = "jdbc:mysql://localhost/bbs";
String USERNAME = "root";
String PASSWORD = "wzy960806";
String userName = request.getParameter("userName");
try {
	con = DriverManager.getConnection(URL, USERNAME, PASSWORD);// 获取连接
	String postSql = "select * from bbsUser natural join posts where nickname = ?";
	pre = con.prepareStatement(postSql);
	pre.setString(1, userName);
	postResult = pre.executeQuery();
	
	String replySql = "select * from bbsUser natural join replys where nickname = ?";
	pre = con.prepareStatement(replySql);
	pre.setString(1, userName);
	replyResult = pre.executeQuery();
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
<title>USER</title>
</head>
<body>
<table>
<tr>
	<td><a href="welcome.jsp">HomePage</a></td>
	<td><a href="user_center.jsp?userName=<%= session.getAttribute("username")%>">UserCenter</a></td>
</tr>
</table>
<h2><%= userName %></h2>
<h4>Posts</h4>
<table>
	<% while (postResult.next()) { %>
	<tr>
		<td><a><%= postResult.getString("postID") %></a>
		<td><a><%= postResult.getString("title") %></a></td>
		<td><a href="post_display.jsp?postID=<%= postResult.getString("postID") %>&sectionName=<%= request.getParameter("sectionName") %>">details</a></td>
	</tr>
	<% } %>
</table>
<h4>Replies</h4>
<table>
	<% while (replyResult.next()) { %>
	<tr>
		<td><a><%= replyResult.getString("replyID") %></a>
		<td><a><%= replyResult.getString("replyContent") %></a></td>
	</tr>
	<% } %>
</table>
</body>
</html>