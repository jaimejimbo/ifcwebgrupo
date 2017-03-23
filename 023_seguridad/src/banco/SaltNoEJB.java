package banco;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;

public class SaltNoEJB {
	
	private Connection con = null;
	private CallableStatement call = null;
	
	public SaltNoEJB(){
		
	}

	public String getSalt(String pwd, String salt, String email, String classurl, String sqlurl, String sqluser, String sqlpwd) {
    	try {
			Class.forName(classurl);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	try {
			con = DriverManager.getConnection(sqlurl, sqluser, sqlpwd);
			call = con.prepareCall("call get_salt(?)");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			call.setString(1, email);
			ResultSet rs = call.executeQuery();
			if (rs.next()){
				salt = rs.getString(1);
			} else {
				salt = BCrypt.gensalt(16);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			call.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return salt;
	}
	
	
}
