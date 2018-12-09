<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.util.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>

<%
Connection con = null;// build a database connect
PreparedStatement pre = null;
PreparedStatement sectionPre = null;
ResultSet result = null;
ResultSet sectionRes = null;
String URL = "jdbc:mysql://localhost/bbs";
String USERNAME = "root";
String PASSWORD = "wzy960806";
String sectionName = request.getParameter("sectionName");
String sectionID = null;
String searchOption = request.getParameter("searchOption");
try {
	con = DriverManager.getConnection(URL, USERNAME, PASSWORD);// 获取连接
	String sql = "select * from " + searchOption + " where sectionName = ?";
	pre = con.prepareStatement(sql);
	pre.setString(1, sectionName);
	result = pre.executeQuery();
	
	String sectionSql =  "select sectionID from section where sectionName = ?";
	sectionPre = con.prepareStatement(sectionSql);
	sectionPre.setString(1, sectionName);
	sectionRes = sectionPre.executeQuery();
	if (sectionRes.next()) {
		sectionID = sectionRes.getString("sectionID");
	}
	if (sectionRes != null)
		sectionRes.close();
	if (sectionPre != null)
		sectionPre.close();
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
		<td><a href="user_center.jsp?userName=<%= session.getAttribute("username")%>">UserCenter</a></td>
		<td><a href="section.jsp">Sections</a></td>
	</tr>
</table>
<h2><%= request.getParameter("sectionName") %></h2>
<p><a href="post_new.jsp?sectionName=<%=  request.getParameter("sectionName") %>">NEW POST</a></p>
<table>
	<% while (result.next()) { %>
	<% if (searchOption.equals("userPostBySection") || searchOption.equals("userReplyBySection")) {
		String postNum = null;
		String userID = result.getString("userID");
		String postSql = "select count(*) as postnum from posts natural join bbsUser where userID = ? and sectionID = ?";
		PreparedStatement postPre = con.prepareStatement(postSql);
		postPre.setString(1, userID);
		postPre.setString(2, sectionID);
		ResultSet postRes = postPre.executeQuery();
		if (postRes.next()) {
			postNum = postRes.getString("postnum");
		}
		if (postRes != null) 
			postRes.close();
		if (postPre != null)
			postPre.close();
		String replyNum = null;
		String replySql = "select count(*) as replynum from posts natural join section, replys natural join bbsUser"
				+ " where sectionID = ? and posts.postID = replys.postID and bbsUser.userID = ?";
		PreparedStatement replyPre = con.prepareStatement(replySql);
		replyPre.setString(1, sectionID);
		replyPre.setString(2, userID);
		ResultSet replyRes = replyPre.executeQuery();
		if (replyRes.next()) {
			replyNum = replyRes.getString("replynum");
		}
		if (replyRes != null)
			replyRes.close();
		if (replyPre != null)
			replyPre.close();
		%>
		<tr>
		<td><a href="user_center.jsp?userName=<%= result.getString("nickname") %>"><%= result.getString("nickname") %></a></td>
		<td><%= result.getString("gender") %></td>
		<td><%= result.getString("birthdate") %></td>
		<td>(<%= postNum %> posts and <%= replyNum %> replies in this section)</td>
		</tr>
		<%
			}
		if (searchOption.equals("hotPostBySection")) {
			String postID = result.getString("postID");
			String postSql = "select nickname from posts, replys natural join bbsUser where replys.postID = posts.postID and posts.postID = ?";
			PreparedStatement postPre = con.prepareStatement(postSql);
			postPre.setString(1, postID);
			ResultSet postRes = postPre.executeQuery();
				%>
				<%-- <h2>title: <%= result.getString("title") %></h2> --%>
		<tr>
			<%-- <td><a><%= result.getString("postID") %></a></td> --%>
			<td>title: <a><%= result.getString("title") %></a></td>
			<td>poster: <%=  result.getString("nickname")%></td>
			</tr>
		
			<% if (result.getString("lastRepliedTime") != null) { %>
			<tr>
			<td>lastRepliedTime: <%= result.getString("lastRepliedTime") %></td>
			</tr>
			<%  } %>
			<tr>
			<td>postTime: <%= result.getString("postTime") %></td>
			<td><a href="post_display.jsp?postID=<%= result.getString("postID") %>&sectionName=<%= request.getParameter("sectionName") %>">details</a></td>
		</tr>
			<tr>
			<td><%= result.getString("content") %></td>
			</tr>
		<% 
		boolean firstReply = true;
		while(postRes.next()) { 
			if (firstReply) {
		%>
		<tr><td><b>ReplyerName:</b></td></tr>
		<% firstReply = false; 
		} %>
		<tr>
		<td><%= postRes.getString("nickname") %></td>
		</tr>
		<% 
		}
		if (postRes != null) 
			postRes.close();
		if (postPre != null)
			postPre.close();
		%>
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
		<td><a href="user_center.jsp?userName=<%= result.getString("nickname") %>"><%= result.getString("nickname") %></a></td>
	</tr> 
	<% } %>
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
      }%>
</table>
</body>
</html>