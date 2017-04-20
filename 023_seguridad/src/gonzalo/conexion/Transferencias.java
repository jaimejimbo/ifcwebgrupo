package gonzalo.conexion;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.Date;

/**
 * Servlet implementation class Transferencias
 */
@WebServlet("/Transferencias")
public class Transferencias extends HttpServlet {
    private static final long serialVersionUID = 1L;
    String classurl;
    String sqlurl;
    String sqluser;
    String sqlpwd;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Transferencias() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sesion = request.getSession();

        this.classurl = (String) request.getAttribute("classurl"); //$NON-NLS-1$
        this.sqlurl = (String) request.getAttribute("sqlurl"); //$NON-NLS-1$
        this.sqluser = (String) request.getAttribute("sqluser"); //$NON-NLS-1$
        this.sqlpwd = (String) request.getAttribute("sqlpwd"); //$NON-NLS-1$

        // Recupero los datos del formulario.

        String receptor = request.getParameter("receptor");
        String cantidad = request.getParameter("cantidad");
        String concepto = request.getParameter("concepto");
        int id_cuenta = Integer.parseInt(request.getParameter("cuenta"));
        // Intento conectarme a la base de datos.


        Connection conexion = null;
        CallableStatement cs = null;
        CallableStatement st = null;
        CallableStatement st2 = null;
        CallableStatement st3 = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        try {

            Class.forName("com.mysql.jdbc.Driver");
            conexion = DriverManager.getConnection("jdbc:mysql://localhost/banco", "root", "");

            //saco id del cliente receptor del dinero a partir de su nombre en variable receptor
            st = conexion.prepareCall("call cliente_id_nombre(?)");
            st.setString(1, receptor);
            rs = st.executeQuery();
            while (rs.next()) {
                int objid = rs.getInt(1);

                //id de persona que transfiere, es decir, quien tiene iniciada sesion
                int cliente_id = Integer.parseInt(sesion.getAttribute("cliente_id").toString());


                st3 = conexion.prepareCall("call seleccionar_cuenta_id(?)");
                boolean inverso = false;
                try {
                    inverso = (Boolean) sesion.getAttribute("inverso");
                } catch (Exception ex) {

                }

                st3.setInt(1, objid);

                rs2 = st3.executeQuery();
                int cuentadestid = -1;
                while (rs2.next()) {
                    cuentadestid = rs2.getInt(1);
                }
                if (cuentadestid == -1) {
                    sesion.setAttribute("errormsg", "El cliente objetivo no tiene cuentas.");
                    System.out.println("Clienteid" + cliente_id);
                    System.out.println("objid" + objid);
                    System.out.println("cuenta cliente" + id_cuenta);
                    System.out.println("cuenta destino" + cuentadestid);
                    request.getRequestDispatcher(request.getContextPath().concat("/jsp/privado/transferir.jsp")).forward(request, response);
                    return;
                }
                cs = conexion.prepareCall("{call transacción(?,?,?,?,?,?,?)}");
                if (inverso) {
                    cs.setInt(2, cliente_id); //mi id, soy quien hago transferencia
                    cs.setInt(1, objid); //id de a quien transfiero
                    cs.setInt(4, id_cuenta); //mi id de cuenta con la que transfiero
                    cs.setInt(3, cuentadestid); //cuenta "principal" del receptor al que transfiero
                } else {
                    System.out.println("No invertida");
                    cs.setInt(1, cliente_id); //mi id, soy quien hago transferencia
                    cs.setInt(2, objid); //id de a quien transfiero
                    cs.setInt(3, id_cuenta); //mi id de cuenta con la que transfiero
                    cs.setInt(4, cuentadestid); //cuenta "principal" del receptor al que transfiero
                }
                sesion.setAttribute("inverso", false);
                Date fecha = new Date();
                cs.setString(5, fecha.toString()); //fecha de transferencia
                cs.setString(6, concepto); //concepto
                cs.setString(7, cantidad); //cantidad que quiero transferir
                cs.executeQuery();
            }
        } catch (SQLException e) {

            e.printStackTrace();
        } catch (ClassNotFoundException e) {

            e.printStackTrace();

        } finally {

            try {
                rs.close();
                cs.close();
                conexion.close();

            } catch (Exception e) {

                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath().concat("/jsp/privado/indexlogged.jsp"));

        }

    }


}






