package banco;

import java.rmi.RemoteException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.ejb.EJBException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.ejb.Stateless;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Session Bean implementation class Salt
 */
@Stateless
public class Salt implements SessionBean {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2697837237897559165L;
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private String url = "";
	private String user = "root";
	private String pwd = "";
	
    /**
     * Default constructor. 
     */
    public Salt() {
    }

	public String hash(String pwd, String salt, String email) {
		String encrypted = "";
		if (salt!=""){
			encrypted = BCrypt.hashpw(pwd, salt);
			return encrypted;
		}
		try {
			pstmt.setString(1, email);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()){
				salt = rs.getString(1);
			} else {
				salt = BCrypt.gensalt(16);
			}
			encrypted = BCrypt.hashpw(pwd, salt);
			return encrypted;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@Override
	public void ejbActivate() throws EJBException, RemoteException {
    	try {
			Class.forName("com.mysql.jdbc.Driver.class");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	try {
			con = DriverManager.getConnection(url, user, pwd);
			pstmt = con.prepareStatement("call get_salt(?, ?)");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public void ejbPassivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void ejbRemove() throws EJBException, RemoteException {
		try {
			pstmt.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void setSessionContext(SessionContext arg0) throws EJBException, RemoteException {
		// TODO Auto-generated method stub
		
	}

}
