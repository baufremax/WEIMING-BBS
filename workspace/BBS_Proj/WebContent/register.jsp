<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RegisterPage</title>
</head>
<body>
	<form action="register_action.jsp" method="post">
		<table>
			<tr>
				<td colspan="2">Register Here</td>
			</tr>
			<tr>
				<td>username：</td>
				<td><input type="text" name="username" /></td>
			</tr>
			<tr>
				<td>password：</td>
				<td><input type="password" name="password1" /></td>
			</tr>
			<tr>
				<td>affirm password：</td>
				<td><input type="password" name="password2" /></td>
			</tr>
			<tr>
				<td>gender: </td>
				<td>
					<br>
					<input type="radio" name="gender" value="M"/>male<br>
					<input type="radio" name="gender" value="F"/>female<br>
				</td>
			</tr>
			<tr>
				<td>birthday: </td>
				<td><input type="date" name="birthday" /></td>
			</tr>
			<tr>
				<td>email：</td>
				<td><input type="text" name="email" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="SignUp" /> <a href="login.jsp">return</a></td>
			</tr>
		</table>
	</form>
</body>
</html>