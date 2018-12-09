package com.service;
 
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;
 
import org.jdom.*;
import org.jdom.output.XMLOutputter;
 
public class NewsImpl implements NewsInterface{
 
	
	public String GetNews(int StartPage, int EndPage) 
	{
		// 创建根节点 list;
	    Element root = new Element("xyt");
	  
	   // 根节点添加到文档中；
	    Document Doc = new Document(root);
	   
	    Connection conn = null;
	    Statement stmt = null ;
	   // 此处 for 循环可替换成 遍历 数据库表的结果集操作;
	    try {
			Class.forName("org.gjt.mm.mysql.Driver").newInstance();
			 String url_connect ="jdbc:mysql://localhost/nxu_life?user=root&password=12345&useUnicode=true&characterEncoding=gb2312";
 
		        //first为你的数据库名
			 	try {
					conn = DriverManager.getConnection(url_connect);
				} catch (SQLException e0) {
					// TODO Auto-generated catch block
					e0.printStackTrace();
				}
 
		        
				try {
					stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				} catch (SQLException e00) {
					// TODO Auto-generated catch block
					e00.printStackTrace();
				}
 
		        String sql="select page_id,title,url,publishtime,page,department from news where page_id>="+StartPage+" and page_id<="+EndPage;
 
		        try {
					ResultSet rs=stmt.executeQuery(sql);
					 while(rs.next()){
						   String page_id=rs.getString("page_id");
						   String title=rs.getString("title");
						   String url=rs.getString("url");
						   String publishtime=rs.getString("publishtime");
						   String page=rs.getString("page");
						   String department=rs.getString("department");
				           // 创建节点 user;
				           Element elements = new Element("news");
				           // 给 user 节点添加属性 id;
				           elements.setAttribute("id",page_id);
				          
				           // 给 user 节点添加子节点并赋值；
				           // new Element("name")中的 "name" 替换成表中相应字段，setText("xuehui")中 "xuehui 替换成表中记录值；
				           elements.addContent(new Element("url").setText(url));
				           elements.addContent(new Element("title").setText(title));
				           elements.addContent(new Element("publishtime").setText(publishtime));
				           elements.addContent(new Element("page").setText(page));
				           elements.addContent(new Element("department").setText(department));
				           // 给父节点list添加user子节点;
				           root.addContent(elements);
				 
				       }
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
 
		} catch (InstantiationException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IllegalAccessException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} catch (ClassNotFoundException e3) {
			// TODO Auto-generated catch block
			e3.printStackTrace();
		}
 
	   
	 
	    XMLOutputter XMLOut = new XMLOutputter();
	    String XMLString =XMLOut.outputString(Doc);
	    return XMLString;
	    //System.out.println( XMLString);
    }
}
