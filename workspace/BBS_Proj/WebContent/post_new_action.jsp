<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.util.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>

<%
Connection con = null;// build a database connect
PreparedStatement userPre = null, sectionPre = null, pre = null;
ResultSet result = null;
String URL = "jdbc:mysql://localhost/bbs";
String USERNAME = "root";
String PASSWORD = "wzy960806";

String title = request.getParameter("title");
String content = request.getParameter("content");
String userName = (String)session.getAttribute("username");
String sectionName = request.getParameter("sectionName");
System.out.println(title + " " + content + " " + userName + " " + sectionName);
int userID =0 ;
int sectionID =0;
boolean isValid = true;
try {
	con = DriverManager.getConnection(URL, USERNAME, PASSWORD);// 获取连接
	String userSql = "select userID from bbsUser where nickname = ?";
	userPre = con.prepareStatement(userSql);
	userPre.setString(1, userName);
	ResultSet userResult = userPre.executeQuery();
	if (userResult.next()) {
		userID = userResult.getInt("userID");
		System.out.println(title + " " + content + " " + userID + " " + sectionID);
	}
	else {
		System.out.println("so...");
		isValid = false;	// user doesn't exist.
	}
	String sectionSql = "select sectionID from section where sectionName = ?";
	sectionPre = con.prepareStatement(sectionSql);
	sectionPre.setString(1, sectionName);
	ResultSet sectionResult = sectionPre.executeQuery();
	if (sectionResult.next()) {
		System.out.println(title + " " + content + " " + userID + " " + sectionID);
		sectionID = sectionResult.getInt("sectionID");
	}
	else {
		isValid = false; 	// section doesn't exist.
	}
	System.out.println(title + " " + content + " " + userID + " " + sectionID);
	if (isValid) {
		String sql = "insert into posts(sectionID, userID, title, content, postTime) values(?, ?, ?, ?, NOW())"; 
		pre = con.prepareStatement(sql);
		pre.setInt(1, sectionID);
		pre.setInt(2, userID);
		pre.setString(3, title);
		pre.setString(4, content);
		pre.executeUpdate();
	}
}
catch (Exception e)
{
    e.printStackTrace();
}
finally
{
    try
    {
        // 逐一将上面的几个对象关闭，因为不关闭的话会影响性能、并且占用资源
        // 注意关闭的顺序，最后使用的最先关闭
        if (result != null)
            result.close();
        if (pre != null)
            pre.close();
        if (con != null)
            con.close();
        //System.out.println("database connection closed！");
    }
    catch (Exception e)
    {
        e.printStackTrace();
    }
}
if (isValid) {
	request.setAttribute("sectionName", sectionName);
	%>
	<jsp:forward page="section_action.jsp" />
	<%
	return;
}
else {
	out.println("<script>alert('Post Failed!!'); window.location='section.jsp' </script>");
	out.flush();
	out.close();
	return;
}
%>