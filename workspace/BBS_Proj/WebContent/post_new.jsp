<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NEW POST</title>
</head>
<body>
<table>
	<tr>
		<td><a href="welcome.jsp">HomePage</a></td>
		<td><a href="user_center.jsp?userName=<%= session.getAttribute("username")%>">UserCenter</a></td>
		<td><a href="section.jsp">Sections</a></td>
	</tr>
</table>
	<form action="post_new_action.jsp?sectionName=<%= request.getParameter("sectionName") %>" method="post">
		<table>
			<tr>
				<td colspan="2">Your New Post</td>
			</tr>
			<tr>
				<td>Title：</td>
			</tr>
			<tr>
				<td><input type="text" name="title" /></td>
			</tr>
			<tr>
				<td>Content：</td>
			</tr>
			<tr>
				<td><textarea name="content" cols="40" rows="10" ></textarea></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Post" /> </td>
			</tr>
		</table>
	</form>
</body>
</html>