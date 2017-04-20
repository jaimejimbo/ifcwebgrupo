package banco;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
	private PreparedStatement pstmtin = null;
	private PreparedStatement pstmtout = null;
	
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
			pstmtin = con.prepareStatement("call movimientos_in(?, ?)");
			pstmtout = con.prepareStatement("call movimientos_out(?, ?)");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Error1");
			e.printStackTrace();
		}
    }
    
    public List<ResultSet> getMovs(int cuenta_id, int cliente_id){
    	
		try {
			pstmtin.setInt(1, cuenta_id);
			pstmtin.setInt(2, cliente_id);
			ResultSet rs1 = pstmtin.executeQuery();
			pstmtout.setInt(1, cuenta_id);
			pstmtout.setInt(2, cliente_id);
			ResultSet rs2 = pstmtout.executeQuery();
			List<ResultSet> out = new ArrayList<ResultSet>();
			out.add(rs1);
			out.add(rs2);
			return out;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("ERROR2");
			e.printStackTrace();
		}
		return null;
    }
    
    

}
