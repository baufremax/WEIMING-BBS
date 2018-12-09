<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.io.*, java.sql.*, javax.xml.parsers.*, javax.xml.transform.*, javax.xml.transform.dom.*,
    javax.xml.transform.stream.*, org.w3c.dom.*" %>
 <%!
 public class CleanXML {
	 
	  public void saveAsDownload() {
		  
	  }

	  public String getXML(String userID, String filePath) throws Exception {
	    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	    DocumentBuilder builder = factory.newDocumentBuilder();
	    Document doc = builder.newDocument();
	    Element results = doc.createElement("Results");
	    doc.appendChild(results);

	    // Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	    Class.forName("com.mysql.jdbc.Driver");
	    // Connection con = DriverManager
	    //     .getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=c:/access.mdb");
	    String URL = "jdbc:mysql://localhost/bbs";
			String USERNAME = "root";
			String PASSWORD = "wzy960806";
	    Connection con = DriverManager
	        .getConnection(URL, USERNAME, PASSWORD);
	    String selectBasicInfo = "select nickname, gender, birthdate, userLevel from bbsUser" +
	    	    " where userID = ?";
	    	    String selectPosts = "select postID, sectionName, nickname, title, content, postTime, clickNum, replyNum"
	    	    + " from bbsUser natural join posts natural join section"
	    	    + " where userID = ?";
	    	    String selectReply = "select c.postID, floorNum, nickname, replyContent, replyTime, praiseNum"
	    	    + " from bbsUser a natural join replys b, posts c" 
	    	    + " where b.postID = c.postID and a.userID = ?";
	    PreparedStatement infoPre = con.prepareStatement(selectBasicInfo);
	    PreparedStatement postsPre = con.prepareStatement(selectPosts);
	    PreparedStatement replyPre=  con.prepareStatement(selectReply);
	    infoPre.setString(1, userID);
	    postsPre.setString(1, userID);
	    replyPre.setString(1, userID);
	    ResultSet info = infoPre.executeQuery();
	    ResultSet posts = postsPre.executeQuery();
	    ResultSet replies = replyPre.executeQuery();

	    ResultSetMetaData rsmdInfo = info.getMetaData();
	    int colCountInfo = rsmdInfo.getColumnCount();

	    while (info.next()) {
	      Element infoRow = doc.createElement("BasicInfo");
	      results.appendChild(infoRow);
	      for (int i = 1; i <= colCountInfo; i++) {
	        String columnName = rsmdInfo.getColumnName(i);
	        Object value = info.getObject(i);
	        Element node = doc.createElement(columnName);
	        node.appendChild(doc.createTextNode(value.toString()));
	        infoRow.appendChild(node);
	      }
	    }

	    ResultSetMetaData rsmdPost = posts.getMetaData();
	    int colCountPost = rsmdPost.getColumnCount();
	    Element postsNode = doc.createElement("Posts");
	    results.appendChild(postsNode);
	    while (posts.next()) {
	      Element postRow = doc.createElement("Post");
//	      results.appendChild(postRow);
	      for (int i = 1; i <= colCountPost; i++) {
	        String columnName = rsmdPost.getColumnName(i);
	        Object value = posts.getObject(i);
	        Element node = doc.createElement(columnName);
	        node.appendChild(doc.createTextNode(value.toString()));
	        postRow.appendChild(node);
	      }
	      postsNode.appendChild(postRow);
	    }
	    
	    ResultSetMetaData rsmdReply = replies.getMetaData();
	    int colCountReply = rsmdReply.getColumnCount();
	    Element repliesNode = doc.createElement("Replies");
	    results.appendChild(repliesNode);
	    while (replies.next()) {
	      Element replyRow = doc.createElement("Reply");
//	      results.appendChild(replyRow);
	      for (int i = 1; i <= colCountReply; i++) {
	        String columnName = rsmdReply.getColumnName(i);
	        Object value = replies.getObject(i);
	        Element node = doc.createElement(columnName);
	        node.appendChild(doc.createTextNode(value.toString()));
	        replyRow.appendChild(node);
	      }
	      repliesNode.appendChild(replyRow);
	    }
	    
	    DOMSource domSource = new DOMSource(doc);
	    TransformerFactory tf = TransformerFactory.newInstance();
	    Transformer transformer = tf.newTransformer();
	    transformer.setOutputProperty(OutputKeys.INDENT, "yes");
//	    transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
	    transformer.setOutputProperty(OutputKeys.METHOD, "xml");
	    transformer.setOutputProperty(OutputKeys.ENCODING, "ISO-8859-1");
	    StringWriter sw = new StringWriter();
	    StreamResult sr = new StreamResult(sw);
	    transformer.transform(domSource, sr);
		
	    //filePath = request.getContextPath()+"/app/download" + "/" + userID;
	    //File file = new File()
	    File file = new File(filePath);
	    PrintStream ps = new PrintStream(new FileOutputStream(file));
	    ps.println(sw.toString());
	   	ps.close();
	   	
	    System.out.println(sw.toString());
	    
	    con.close();
	    info.close();
	    posts.close();
	    replies.close();
	    return sw.toString();
	  }
	}
 %>
 
 <%
 	String userID = request.getParameter("userID");
	String userName = request.getParameter("userName");
 	CleanXML userXml = new CleanXML();
 	String filePath = "/Users/wzy/Desktop/JSP/workspace/BBS_Proj/xml/" + userID+ ".xml";
 	String myXml = userXml.getXML(userID, filePath);
 	String path = request.getContextPath();
 	 String basePath = request.getScheme() + "://"
 	                 + request.getServerName() + ":" + request.getServerPort()
 	                 + path + "/";
 	System.out.println(basePath);
 	request.setAttribute("userName", request.getParameter("userName"));
	%>
	<%-- <jsp:forward page="user_center.jsp" /> --%>
	<%-- <%  
  response.setContentType("application/x-msdownload");//设置为下载application/x-download  
  String filedownload = "/xml/" + userID + userName + ".xml"; //即将下载的文件的相对路径  
  String filenamedisplay = userID + userName + ".xml"; //下载文件时显示的文件保存名称  
  response.setAttrib
  response.sendRedirect("user_center.jsp");
  response.addHeader("Content-Disposition","attachment;filename=" + filenamedisplay);  
  try{  
       RequestDispatcher dis = application.getRequestDispatcher(filedownload);  
       if(dis!= null){  
           dis.forward(request,response);  
       }  
       response.flushBuffer();  
  }catch(Exception e){  
       e.printStackTrace();  
  }finally{  
     
  }  
%>  --%>
	<%-- <jsp:forward page="user_center.jsp" /> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>USER</title>
</head>
<body>
<table>
<tr>
	<td><a href="welcome.jsp">HomePage</a></td>
	<td><a href="user_center.jsp?userName=<%= session.getAttribute("username")%>">UserCenter</a></td>
</tr>
</table>
<xmp><%= myXml %></xmp>