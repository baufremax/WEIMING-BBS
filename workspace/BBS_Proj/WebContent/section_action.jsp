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
try {
	con = DriverManager.getConnection(URL, USERNAME, PASSWORD);// 获取连接
	String sql = "select * from section natural join posts where sectionName = ?"
		+ " order by case when lastRepliedTime is not null then unix_timestamp(lastRepliedTime) else unix_timestamp(postTime) end desc";
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
<title>SECTION</title>
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
<form action="section_search.jsp?sectionName=<%= request.getParameter("sectionName") %>" method="post">
			  <select name="searchOption">
			    <option value="userPostBySection">userInfoByPost</option>
			    <option value="userReplyBySection">userInfoByReply</option>
			    <option value="hotPostBySection">hotPost</option>
			    <option value="clickAboveAvg">clickAboveAvg</option>
			    <option value="replyAboveAvg">replyAboveAvg</option>
			  </select>
			  <input type="submit" value="Search">
			</form>
<p><a href="post_new.jsp?sectionName=<%=  request.getParameter("sectionName") %>">NEW POST</a></p>
<table>
	<% while (result.next()) { %>
	<tr>
		<td><a><%= result.getString("postID") %></a></td>
		<td><a><%= result.getString("title") %></a></td>
		<td><a href="post_display.jsp?postID=<%= result.getString("postID") %>&sectionName=<%= request.getParameter("sectionName") %>">details</a></td>
	</tr>
	<% } %>
</table>
</body>
</html>