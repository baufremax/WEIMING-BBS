<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.util.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WELCOME</title>
</head>
<body>
<table>
		<!-- <tr>
			<td><img src="images/bbs.png" />
			</td>
		</tr> -->
		<tr>
			<td colspan="2"><hr />
			</td>
		</tr>
		<tr>
			<td>
				<table>
					<tr>
						<td><a href="welcome.jsp">HomePage</a></td>
						<td><a href="user_center.jsp?userName=<%= session.getAttribute("username")%>">UserCenter</a></td>
					</tr>
					<tr>
						<td><a href="section.jsp">Sections</a>
						</td>
					</tr>
					<tr>
						<td><a>Menu2</a>
						</td>
					</tr>
					<tr>
						<td><a>Menu3</a>
						</td>
					</tr>
					<tr>
						<td><a>Menu4</a>
						</td>
					</tr>
					<tr>
						<td><a>Menu5</a>
						</td>
					</tr>
					<tr>
						<td><a>Menu6</a>
						</td>
					</tr>
					<tr>
						<td><a>Menu7</a>
						</td>
					</tr>
					<tr>
						<td><a>Menu8</a>
						</td>
					</tr>
				</table></td>
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
						<tr>
							<td colspan="2"><input type="submit" value="Logout" /></td>
						</tr>
					</table>
				</form></td>
		</tr>
	</table>
</body>
</html>