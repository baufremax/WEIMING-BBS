<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.util.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 
  <% 
  String username = request.getParameter("username");
  String password = request.getParameter("password");
  if(username==null||"".equals(username.trim())||password==null||"".equals(password.trim())){
	  out.println("<script>alert('username and password cannot be null!!'); window.location='login.jsp' </script>");
	  out.flush();
	  out.close();
	 /*  System.out.println("username and password cannot be null!!"); */
	  response.sendRedirect("login.jsp");
	  return;
	  //request.getRequestDispatcher("login.jsp").forward(request, response);
  }
  boolean isValid = false;
  Connection con = null;// build a database connect
  PreparedStatement pre = null;
  ResultSet result = null;
  String URL = "jdbc:mysql://localhost/bbs";
  String USERNAME = "root";
  String PASSWORD = "wzy960806";
  try
  {
	  System.out.println(password);
      //System.out.println("Try to connect database！");
      con = DriverManager.getConnection(URL, USERNAME, PASSWORD);// 获取连接
     // System.out.println("connection succeeded！");
      String sql = "select * from bbsUser where nickname=? and userPassword=?";
      pre = con.prepareStatement(sql);// 实例化预编译语句
      pre.setString(1, username);// 设置参数，前面的1表示参数的索引，而不是表中列名的索引
      pre.setString(2, password);// 设置参数，前面的1表示参数的索引，而不是表中列名的索引
      result = pre.executeQuery();// 执行查询，注意括号中不需要再加参数
      if (result.next()){
    	  isValid = true;
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
  if(isValid){
	  System.out.println("Login Succeeded！");
	  session.setAttribute("username", username);
	  response.sendRedirect("welcome.jsp");
	  return;
  }else{
	  out.println("<script>alert('Login Failed!!'); window.location='login.jsp' </script>");
	  out.flush();
	  out.close();
	  return;
  }
  %>