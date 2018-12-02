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
	<form action="reply_new_action.jsp?postID=<%= request.getParameter("postID") %>" method="post">
		<table>
			<tr>
				<td colspan="2">Your New Reply</td>
			</tr>
				<td>Content：</td>
			</tr>
			<tr>
				<td><textarea name="content" cols="40" rows="10" ></textarea></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Reply" /> </td>
			</tr>
		</table>
	</form>
</body>
</html>