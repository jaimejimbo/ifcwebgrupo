package banco;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Movimientos
 */
@WebServlet("/movimientos.php")
public class Movimientos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Movimientos() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cuenta_id = Integer.parseInt(request.getParameter("cuentaid"));
		HttpSession sesion = request.getSession();
		String nombre = (String) sesion.getAttribute("nombre");
		String classurl = (String) sesion.getAttribute("classurl");
		String sqlurl = (String) sesion.getAttribute("sqlurl");
		String sqluser = (String) sesion.getAttribute("sqluser");
		String sqlpwd = (String) sesion.getAttribute("sqlpwd");
		MovimientosEJB mejb = new MovimientosEJB(classurl, sqlurl, sqluser, sqlpwd);
		ResultSet rs = mejb.getMovs(cuenta_id, nombre);
		sesion.setAttribute("datos", rs);
		response.sendRedirect(request.getContextPath().concat("/jsp/privado/movimientos.jsp"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
