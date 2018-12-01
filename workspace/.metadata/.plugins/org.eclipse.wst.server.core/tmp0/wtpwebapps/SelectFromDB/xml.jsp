<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.io.*, java.sql.*, org.w3c.dom.Document, org.w3c.dom.Element,
    javax.xml.parsers.DocumentBuilder, 
    javax.xml.parsers.DocumentBuilderFactory,
    javax.xml.transform.OutputKeys,
	javax.xml.transform.Transformer,
	javax.xml.transform.TransformerFactory,
	javax.xml.transform.dom.DOMSource,
	javax.xml.transform.stream.StreamResult
	"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%! 
/* import java.io.StringWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData; */

/* import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element; */

public class Main {

  public static void main(String args[]) throws Exception {
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document doc = builder.newDocument();
    Element results = doc.createElement("Results");
    doc.appendChild(results);

    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
    Connection con = DriverManager
        .getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=c:/access.mdb");
    
    ResultSet rs = con.createStatement().executeQuery("select * from product");

    ResultSetMetaData rsmd = rs.getMetaData();
    int colCount = rsmd.getColumnCount();

    while (rs.next()) {
      Element row = doc.createElement("Row");
      results.appendChild(row);
      for (int i = 1; i <= colCount; i++) {
        String columnName = rsmd.getColumnName(i);
        Object value = rs.getObject(i);
        Element node = doc.createElement(columnName);
        node.appendChild(doc.createTextNode(value.toString()));
        row.appendChild(node);
      }
    }
    DOMSource domSource = new DOMSource(doc);
    TransformerFactory tf = TransformerFactory.newInstance();
    Transformer transformer = tf.newTransformer();
    transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
    transformer.setOutputProperty(OutputKeys.METHOD, "xml");
    transformer.setOutputProperty(OutputKeys.ENCODING, "ISO-8859-1");
    StringWriter sw = new StringWriter();
    StreamResult sr = new StreamResult(sw);
    transformer.transform(domSource, sr);

    System.out.println(sw.toString());

    con.close();
    rs.close();
  }
}


%>
</body>
</html>