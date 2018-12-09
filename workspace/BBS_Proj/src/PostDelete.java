import java.sql.*;


public class PostDelete {
	//Class.forName("com.mysql.jdbc.Driver");
	  Connection con = null;// build a database connect
	  PreparedStatement pre = null;
	  //ResultSet result = null;
	  String URL = "jdbc:mysql://localhost/bbs";
	  String USERNAME = "root";
	  String PASSWORD = "wzy960806";
	  public PostDelete() {
		// TODO Auto-generated constructor stub
		 try {
		Class.forName("com.mysql.jdbc.Driver");
		 }
		 catch (ClassNotFoundException e) {
			 e.printStackTrace();
		 }
		 try {
			 con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
		     String sql = "delete from posts where postID=?";
		     pre = con.prepareStatement(sql);
		 }
		 catch (Exception e) {
			 e.printStackTrace();
		 }
	}
	  public boolean deletePost(String postID) {
		  try {
		  pre.setString(1,  postID);
		  pre.executeUpdate();
		  }
		  catch (SQLException e) {
			  e.printStackTrace();
			  return false;
		  }
		  return true;
	  }
}
