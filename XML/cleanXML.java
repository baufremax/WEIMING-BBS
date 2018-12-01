import java.io.StringWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class cleanXML {

  public static void main(String args[]) throws Exception {
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
    	    " where userID = 1";
    	    String selectPosts = "select postID, sectionName, nickname, title, content, postTime, clickNum, replyNum"
    	    + " from bbsUser natural join posts natural join section"
    	    + " where userID = 1";
    	    String selectReply = "select c.postID, floorNum, nickname, replyContent, replyTime, praiseNum"
    	    + " from bbsUser a natural join replys b, posts c" 
    	    + " where b.postID = c.postID and a.userID = 1";
    ResultSet info = con.createStatement().executeQuery(selectBasicInfo);
    ResultSet posts = con.createStatement().executeQuery(selectPosts);
    ResultSet replies = con.createStatement().executeQuery(selectReply);

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
//      results.appendChild(postRow);
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
//      results.appendChild(replyRow);
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
//    transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
    transformer.setOutputProperty(OutputKeys.METHOD, "xml");
    transformer.setOutputProperty(OutputKeys.ENCODING, "ISO-8859-1");
    StringWriter sw = new StringWriter();
    StreamResult sr = new StreamResult(sw);
    transformer.transform(domSource, sr);

    System.out.println(sw.toString());

    con.close();
    info.close();
    posts.close();
    replies.close();
  }
}
