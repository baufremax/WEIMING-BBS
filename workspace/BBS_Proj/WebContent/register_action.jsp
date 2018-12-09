<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.util.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>

<% 
  String username = request.getParameter("username");
  String password1 = request.getParameter("password1");
  String password2 = request.getParameter("password2");
  String gender = request.getParameter("gender");
  String birthday = request.getParameter("birthday");
  String email = request.getParameter("email");
  if(username==null||"".equals(username.trim())||password1==null||"".equals(password1.trim())||password2==null||"".equals(password2.trim())||!password1.equals(password2)){
	  System.out.println("username and password cannot be null!！");
	  out.println("<script>alert('username and password cannot be null!!'); window.location='register.jsp' </script>");
	  out.flush();
	  out.close();
	  // response.sendRedirect("register.jsp");
	  // return;
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
      con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
      String sql = "select * from bbsUser where nickname=?";
      pre = con.prepareStatement(sql);
      pre.setString(1, username);
      result = pre.executeQuery();
      
      if (!result.next()){
    	  sql = "insert into bbsUser(nickname, userPassword, gender, birthdate, email) values(?,?,?,?,?)";
    	  PreparedStatement insPre = con.prepareStatement(sql);
          insPre.setString(1, username);
          insPre.setString(2, password1);
          insPre.setString(3, gender);
          insPre.setString(4, birthday);
          insPre.setString(5, email);
          insPre.executeUpdate();
    	  isValid = true;
    	  if (insPre != null) 
        	  insPre.close();
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
          //System.out.println("database closed！");
      }
      catch (Exception e)
      {
          e.printStackTrace();
      }
  }
  if(isValid){
	  System.out.println("SignUp succeeded，please login！");
	  //response.sendRedirect("login.jsp");
	  out.println("<script>alert('SignUp succeeded，please login!!'); window.location='login.jsp' </script>");
	  out.flush();
	  out.close();
	  return;
  }else{
	  System.out.println("Register Failed！Please type in correct username or birthday format!!");
	  // response.sendRedirect("register.jsp");
	  out.println("<script>alert('user already exists!!'); window.location='register.jsp' </script>");
	  out.flush();
	  out.close();
	  // return;
  }
 %>