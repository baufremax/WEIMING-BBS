<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN PAGE</title>
</head>
<body>
	<form action="login_action.jsp" method="post">
		<table>
			<tr>
				<td colspan="2">Login Here</td>
			</tr>
			<tr>
				<td>username：</td>
				<td><input type="text" name="username" />
				</td>
			</tr>
			<tr>
				<td>password：</td>
				<td><input type="password" name="password" />
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Login" /> <a href="register.jsp">SignUp</a>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>