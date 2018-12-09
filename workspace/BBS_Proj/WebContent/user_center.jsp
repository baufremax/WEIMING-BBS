<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.util.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>

<%
Connection con = null;// build a database connect
PreparedStatement pre = null;
ResultSet postResult = null;
ResultSet replyResult = null;
String URL = "jdbc:mysql://localhost/bbs";
String USERNAME = "root";
String PASSWORD = "wzy960806";
String userName = request.getParameter("userName");
String userID = null;
try {
	con = DriverManager.getConnection(URL, USERNAME, PASSWORD);// 获取连接
	String userSql = "select userID from bbsUser where nickname=?";
	PreparedStatement userPre = con.prepareStatement(userSql);
	userPre.setString(1, userName);
	ResultSet userRes = userPre.executeQuery();
	if (userRes.next()) {
		userID = userRes.getString("userID");
	}
	if (userRes != null) 
		userRes.close();
	if (userPre != null) 
		userPre.close();
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
<p><a href="getXml.jsp?userID=<%= userID %>&userName=<%= userName %>" >Export XML</a></p>
<h4>Posts</h4>
<table>
	<% while (postResult.next()) { %>
	<tr>
		<td><a><%= postResult.getString("postID") %></a>
		<td><a><%= postResult.getString("title") %></a></td>
		<td><a href="post_display.jsp?postID=<%= postResult.getString("postID") %>">details</a></td>
	</tr>
	<% } %>
</table>
<h4>Replies</h4>
<table>
	<% while (replyResult.next()) { %>
	<tr>
		<td><a><%= replyResult.getString("replyID") %></a>
		<td><a><%= replyResult.getString("replyContent") %></a></td>
		<td><a href="reply_display.jsp?replyID=<%= replyResult.getString("replyID") %>">details</a></td>
	</tr>
	<% } 
	try
    {
        // 逐一将上面的几个对象关闭，因为不关闭的话会影响性能、并且占用资源
        // 注意关闭的顺序，最后使用的最先关闭
        if (postResult != null)
            postResult.close();
        if (replyResult  != null)
      	  replyResult.close();
        if (pre != null)
            pre.close();
        if (con != null)
            con.close();
        //System.out.println("database connection closed！");
    }
    catch (Exception e)
    {
        e.printStackTrace();
    }
	%>
</table>
</body>
</html>