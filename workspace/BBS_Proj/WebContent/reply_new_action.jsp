<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.util.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>

<%
Connection con = null;// build a database connect
PreparedStatement userPre = null, pre = null;
ResultSet result = null;
String URL = "jdbc:mysql://localhost/bbs";
String USERNAME = "root";
String PASSWORD = "wzy960806";

String content = request.getParameter("content");
String userName = (String)session.getAttribute("username");
String postID = request.getParameter("postID");
int userID =0 ;
boolean isValid = true;
try {
	con = DriverManager.getConnection(URL, USERNAME, PASSWORD);// 获取连接
	String userSql = "select userID from bbsUser where nickname = ?";
	userPre = con.prepareStatement(userSql);
	userPre.setString(1, userName);
	ResultSet userResult = userPre.executeQuery();
	if (userResult.next()) {
		userID = userResult.getInt("userID");
	}
	else {
		isValid = false;	// user doesn't exist.
	}
	
	if (isValid) {
		String sql = "insert into replys(postID, userID, replyContent, replyTime) values(?, ?, ?, NOW())"; 
		pre = con.prepareStatement(sql);
		pre.setString(1, postID);
		pre.setInt(2, userID);
		pre.setString(3, content);
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
	request.setAttribute("postID", postID);
	%>
	<jsp:forward page="post_display.jsp" />
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