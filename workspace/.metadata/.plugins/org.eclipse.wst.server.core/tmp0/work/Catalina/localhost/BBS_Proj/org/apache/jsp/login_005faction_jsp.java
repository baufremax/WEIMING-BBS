/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.92
 * Generated at: 2018-11-27 10:47:56 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.*;

public final class login_005faction_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\n');
 Class.forName("com.mysql.jdbc.Driver"); 
      out.write('\n');
      out.write('\n');

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

      out.write("\n");
      out.write(" \n");
      out.write("  ");
 
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
  
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
