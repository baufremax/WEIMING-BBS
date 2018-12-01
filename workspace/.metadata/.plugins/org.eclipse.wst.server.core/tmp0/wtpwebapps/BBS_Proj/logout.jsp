<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<base href="<%=basePath%>">
<title>LogoutPage</title>
</head>
<body>
<body>
   <%
   session.removeAttribute("username");
   response.sendRedirect("login.jsp");
   %>
  </body>
</body>
</html>