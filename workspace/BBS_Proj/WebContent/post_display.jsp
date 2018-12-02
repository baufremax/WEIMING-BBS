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
ResultSet replyResult = null;
ResultSet result = null;
String URL = "jdbc:mysql://localhost/bbs";
String USERNAME = "root";
String PASSWORD = "wzy960806";
String postID = request.getParameter("postID");
try {
	con = DriverManager.getConnection(URL, USERNAME, PASSWORD);// 获取连接
	String sql = "select * from posts a natural join bbsUser b, replys c natural join bbsUser d" 
	+ " where a.postID = c.postID and a.postID = ?" ;
	pre = con.prepareStatement(sql);
	pre.setString(1, postID);
	replyResult = pre.executeQuery();
	sql = "select * from posts natural join bbsUser where postID = ?";
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
		<td><a href="user_center.jsp?userName=<%= session.getAttribute("username")%>">UserCenter</a></td>
		<td><a href="section.jsp">Sections</a></td>
	</tr>
</table>
<% 
   if (result.next()) {
	   %>
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
		<p><a href="reply_new.jsp?postID=<%= request.getParameter("postID") %>">New Reply</a></p>
		<%
   }
	boolean firstReply = true;
   	while (replyResult.next()) {
	if (firstReply) {
	   %>
		<h3>Replies: </h3>
		<%
		firstReply = false;
	  }
		%>
	<div>
	<table>
		<tr>
			<td>Floor #<%= replyResult.getString("floorNum") %></td>
		</tr>
		<tr>
			<td>ReplyTime: <%= replyResult.getString("replyTime") %></td>
		</tr>
		<tr>
			<td>Replier: <a href="user_center.jsp?userName=<%= replyResult.getString("d.nickname") %>"><%= replyResult.getString("d.nickname") %></a></td>
		</tr>
		<tr>
			<td>Praise: <%= replyResult.getString("praiseNum") %></td>
			<td>+1</td>
		</tr>
	</table>
	<p><a><%= replyResult.getString("replyContent") %></a></p>
	</div>
<% } %>
</body>
</html>