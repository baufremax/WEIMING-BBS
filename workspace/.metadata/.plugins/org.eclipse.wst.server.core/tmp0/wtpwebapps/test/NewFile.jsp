<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="wzy.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>First JSP</title>
</head>
<body>
<jsp:include page="myHeader.html"/>

<h3>Hello World!</h3>
the time on this server is <%= new java.util.Date() %>

<%= testClass.makeItLower("OOOOP") %>

<h3>JSP built-in Objects</h3>

Request user agent: <%= request.getHeader("User-Agent") %>
<br/>
Reqeust Languange: <%= request.getLocale() %>
<br/><br/>

<form action='user-response.jsp'>
	User: <input type='text' name='User'/>
	Password: <input type='text' name='Password'/>
	<br/>
	Country:<select name="country">
				<option>Brazil</option>
				<option>USA</option>
			</select>
	<br/>
	Favorite Language:
	<input type="radio" name="favoriteLanguage" value="Java"> Java
	<input type="radio" name="favoriteLanguage" value="C++"> C++
	<input type='submit' value='Submit'>
</form>


<jsp:include page="myFooter.jsp"/>
</body>
</html>