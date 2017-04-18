package banco;


/**
 * Created by Jaime on 18/04/2017.
 */

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;

@WebServlet({"/cuentas.php"})
public class Cuentas extends HttpServlet {

    String classurl = "com.mysql.jdbc.Driver";
    String sqlurl = "jdbc:mysql://localhost/banco";
    String sqluser = "root";
    String sqlpwd = "";

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        httpServletResponse.sendRedirect(httpServletRequest.getContextPath().concat("/"));
    }

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        int cliente_id = Integer.parseInt(httpServletRequest.getParameter("clienteid"));
        CuentasEJB cejb = new CuentasEJB(classurl, sqlurl, sqluser, sqlpwd);
        ResultSet rs = cejb.getCuentas(cliente_id);
        httpServletRequest.setAttribute("cuentas", rs);
        httpServletRequest.getRequestDispatcher(httpServletRequest.getContextPath().concat("/jsp/privado/jquery/mostrar_cuentas.jsp")).forward(httpServletRequest, httpServletResponse);
    }
}
