<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%= request.getParameter("User") %>
<%= request.getParameter("Password") %>
<br/>

the user is ${ param.User }
password is ${ param.Password }
</body>
</html>