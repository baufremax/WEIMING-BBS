<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.util.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>
 
  <% 
  String postID = request.getParameter("postID");
  boolean isValid = false;
  Connection con = null;// build a database connect
  PreparedStatement pre = null;
  ResultSet result = null;
  String URL = "jdbc:mysql://localhost/bbs";
  String USERNAME = "root";
  String PASSWORD = "wzy960806";
  try
  {
      //System.out.println("Try to connect database！");
      con = DriverManager.getConnection(URL, USERNAME, PASSWORD);// 获取连接
     // System.out.println("connection succeeded！");
      String sql = "delete from posts where postID = ?";
      pre = con.prepareStatement(sql);// 实例化预编译语句
      pre.setString(1, postID);// 设置参数，前面的1表示参数的索引，而不是表中列名的索引
 	  pre.executeUpdate();
      isValid = true;
  }
  catch (Exception e)
  {
	  isValid = false;
      e.printStackTrace();
  }
  finally
  {
      try
      {
          // 逐一将上面的几个对象关闭，因为不关闭的话会影响性能、并且占用资源
          // 注意关闭的顺序，最后使用的最先关闭
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
  if(isValid){
	  if (request.getParameter("sectionName") != null) {
		  	String sectionName = request.getParameter("sectionName");
		 	request.setAttribute("sectionName", sectionName);
			%>
			<jsp:forward page="moderate_post.jsp" />
			<%
	  }
	  else {
		  out.println("<script>alert('Delete Succeeded!!'); window.location='manage_post.jsp' </script>");
		  out.flush();
		  out.close();
	  }
	  return;
  }else{
	  if (request.getParameter("sectionName") != null) {
		  	String sectionName = request.getParameter("sectionName");
		 	request.setAttribute("sectionName", sectionName);
			%>
			<jsp:forward page="moderate_post.jsp" />
			<%
	  }
	  else {
		  out.println("<script>alert('Delete Failed!!'); window.location='manage_post.jsp' </script>");
		  out.flush();
		  out.close();
	  }
	  return;
  }
  %>