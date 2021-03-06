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
String searchRequest = request.getParameter("searchOption");
try {
	con = DriverManager.getConnection(URL, USERNAME, PASSWORD);// 获取连接
	String sql = "select * from " + searchRequest;
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
<title>SearchResult</title>
</head>
<body>
<table>
	<tr>
		<td><a href="welcome.jsp">HomePage</a></td>
		<td><a href="user_center.jsp?userName=<%= session.getAttribute("username")%>">UserCenter</a></td>
		<td><a href="section.jsp">Sections</a></td>
	</tr>
</table>
<table>
	<% while (result.next()) { %>
	<tr>
		<td><a><%= result.getString("postID") %></a></td>
		<td><a><%= result.getString("title") %></a></td>
		<td>(<%= result.getString("clickNum") %> clicks, <%=result.getString("replyNum") %> replys)</td>
		<td><a href="post_display.jsp?postID=<%= result.getString("postID") %>">details</a></td>
	</tr>
	<% } 
	 try
     {
         // 逐一将上面的几个对象关闭，因为不关闭的话会影响性能、并且占用资源
         // 注意关闭的顺序，最后使用的最先关闭
         if (result != null)
             result.close();
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