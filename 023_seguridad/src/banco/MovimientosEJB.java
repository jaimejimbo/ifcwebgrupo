package banco;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Session Bean implementation class MovimientosEJB
 */
@Stateless
@LocalBean
public class MovimientosEJB {

    /**
     * Default constructor. 
     */
	private static final long serialVersionUID = 2697837237897559165L;
	private Connection con = null;
	private PreparedStatement pstmt = null;
	
    public MovimientosEJB(String classurl, String sqlurl, String sqluser, String sqlpwd) {

    	try {
			Class.forName(classurl);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println("Error0");
			e.printStackTrace();
		}
    	try {
			con = DriverManager.getConnection(sqlurl, sqluser, sqlpwd);
			pstmt = con.prepareStatement("call movimientos(?, ?)");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Error1");
			e.printStackTrace();
		}
    }
    
    public ResultSet getMovs(int cuenta_id, String nombre){
    	
		try {
			pstmt.setInt(1, cuenta_id);
			pstmt.setString(2, nombre);
			ResultSet rs = pstmt.executeQuery();
			return rs;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("ERROR2");
			e.printStackTrace();
		}
		return null;
    }
    
    

}
