<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.util.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WELCOME</title>
</head>
<body>
<h2>Welcome to WEIMING BBS!!</h2>
<table>
		<!-- <tr>
			<td><img src="images/bbs.png" />
			</td>
		</tr> -->
		<tr>
		<td>
				<table>
					<tr>
						<td><a href="welcome.jsp">HomePage</a></td>
						<td><a href="user_center.jsp?userName=<%= session.getAttribute("username")%>">UserCenter</a></td>
						<td><a href="section.jsp">Sections</a></td>
				</tr>
					
				</table></td>
			</tr>
			<tr>
			<td>
			<form action="bbs_search.jsp" method="post">
			  <select name="searchOption">
			    <option value="topClick">Top10 Click Post</option>
			    <option value="topReply">Top10 Reply Post</option>
			  </select>
			  <input type="submit" value="Search">
			</form>
			</td>
			</tr>
			<tr>
			<td>
				<form action="logout.jsp" method="post">
					<table>
						<tr>
							<td colspan="2">Login Succeeded!</td>
						</tr>
						<tr>
							<td>Welcome,</td>
							<td>${ username }</td>
						</tr>
						<% 
						String userID = (String)session.getAttribute("userID");
						if ("1".equals(userID)) { %>
						<tr>
							<td><a href="manage_user.jsp">ManageUser</a></td>
							<td><a href="manage_post.jsp">ManagePost</a></td>
						</tr>
						<% } %>
						<tr>
							<td colspan="2"><input type="submit" value="Logout" /></td>
						</tr>
					</table>
				</form></td>
		</tr>
	</table>
</body>
</html>