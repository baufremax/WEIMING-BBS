<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="display.jsp" method="POST">
	<table border='0'>
		<tbody>
			<tr>
				<td>S_ID:</td>
				<td><input type="text" name="s_ID" size="50"/></td>
			</tr>
			<tr>
				<td>I_ID:</td>
				<td><input type="text" name="i_ID" size="50"/></td>
			</tr>
		</tbody>
	</table>
	<input type="reset" value="Clear" name="clear" />
	<input type="submit" value="Submit" name="submit" />

</form>
</body>
</html>