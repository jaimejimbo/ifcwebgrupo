package banco;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import java.sql.*;

/**
 * Created by Jaime on 18/04/2017.
 */

@Stateless
@LocalBean
public class CuentasEJB {

    private static final long serialVersionUID = 2697837237897559165L;
    private Connection con = null;
    private PreparedStatement pstmt = null;

    public CuentasEJB(String classurl, String sqlurl, String sqluser, String sqlpwd) {

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



    public ResultSet getCuentas(int cliente_id){
        ResultSet rs = null;
        try {
            pstmt = con.prepareCall("call get_cuentas(?)");
            pstmt.setInt(1, cliente_id);
            rs = pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }



}
