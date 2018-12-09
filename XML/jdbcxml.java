import java.io.File;
import java.io.FileWriter;
import java.nio.file.FileAlreadyExistsException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.sun.org.apache.xerces.internal.dom.DocumentImpl;
import com.sun.org.apache.xml.internal.serialize.OutputFormat;
import com.sun.org.apache.xml.internal.serialize.XMLSerializer;
/* JDBC Classes*/
/* Java IO */
/* W3C Interfaces */
/* Xerces DOM Classes */
/* Xerces Serializer */


public class XmlMain { 

    public static final String JDBCURL = "oracle.jdbc.driver.OracleDriver"; 
    public static final String JDBCDRIVER ="jdbc:oracle:thin:@localhost:1521:xe"; 
    public static final String SQL = "select empid, empname, role from employee"; 
    public static String OUTPUTFILE = "./employee.xml"; 
//replace file with Country.xml

    public static void main(String[] args) { 

    try{ 

    /** Step 1 : Making a JDBC Connection with database" **/ 
    Class.forName(JDBCURL) ;
    Connection conn = DriverManager.getConnection(JDBCDRIVER,"system","root"); 

    /** Step 2 : Retrieve the customer data from database **/ 
    Statement statement = conn.createStatement(); 
    ResultSet employeeRS = statement.executeQuery(SQL); 

    /** Step 3 : Build customer XML DOM **/ 
    Document xmlDoc = buildEmployeeXML(employeeRS);

    /** Step 4 : Write output to a file **/ 
    File outputFile = new File(OUTPUTFILE); 
    printDOM(xmlDoc, outputFile); 

    conn.close(); /*Connection close*/ 
    } catch(FileAlreadyExistsException f){
        System.out.println("file alread present at this location");
    }
    catch(Exception e) 
    { 
        System.out.println("Really poor exception handling " +e.toString()); 
    }
    }//Main 

    /*Build XML DOcument from database. The XML object is returned to main method where it is written to flat file.*/ 
    private static Document buildEmployeeXML(ResultSet _employeeRS) throws Exception 
    { 

    Document xmlDoc = new DocumentImpl(); 

    /* Creating the root element */ 
//replace employeetable with countries to set a countries tag
    Element rootElement = xmlDoc.createElement("EmployeeTable"); 
    xmlDoc.appendChild(rootElement); 

    while(_employeeRS.next()) 
    { 

    Element emp = xmlDoc.createElement("employee");
//replace employee with country for country tag

    /* Build the CustomerId as a Attribute*/ 
    emp.setAttribute("empid", _employeeRS.getString("empid")); 

    /* Creating elements within customer DOM*/ 
    Element empName = xmlDoc.createElement("empname"); 
    Element role = xmlDoc.createElement("role"); 

    /* Populating Customer DOM with Data*/ 
    empName.appendChild(xmlDoc.createTextNode(_employeeRS.getString("empname"))); 
    role.appendChild(xmlDoc.createTextNode(_employeeRS.getString("role"))); 

    /* Adding the empname and role elements to the employee Element*/ 
    emp.appendChild(empName); 
    emp.appendChild(role); 

    /* Appending emp to the Root Class*/ 
    rootElement.appendChild(emp); 
    } 
    return xmlDoc; 
    } 

    /* printDOM will write the contents of xml document passed onto it out to a file*/ 
    private static void printDOM(Document _xmlDoc, File _outputFile) throws Exception 
    { 
    OutputFormat outputFormat = new OutputFormat("XML","UTF-8",true); 
    FileWriter fileWriter = new FileWriter(_outputFile); 

    XMLSerializer xmlSerializer = new XMLSerializer(fileWriter, outputFormat); 

    xmlSerializer.asDOMSerializer(); 

    xmlSerializer.serialize(_xmlDoc.getDocumentElement()); 
    } 
}