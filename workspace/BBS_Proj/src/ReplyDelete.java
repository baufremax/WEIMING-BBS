import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class ReplyDelete {
	//Class.forName("com.mysql.jdbc.Driver");
	  Connection con = null;// build a database connect
	  PreparedStatement pre = null;
	  //ResultSet result = null;
	  String URL = "jdbc:mysql://localhost/bbs";
	  String USERNAME = "root";
	  String PASSWORD = "wzy960806";
	  public ReplyDelete() {
		// TODO Auto-generated constructor stub
		 try {
		Class.forName("com.mysql.jdbc.Driver");
		 }
		 catch (ClassNotFoundException e) {
			 e.printStackTrace();
		 }
		 try {
			 con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
		     String sql = "delete from replys where replyID=?";
		     pre = con.prepareStatement(sql);
		 }
		 catch (Exception e) {
			 e.printStackTrace();
		 }
	}
	  public boolean deleteReply(String replyID) {
		  try {
		  pre.setString(1,  replyID);
		  pre.executeUpdate();
		  }
		  catch (SQLException e) {
			  e.printStackTrace();
			  return false;
		  }
		  return true;
	  }
}
