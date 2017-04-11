package banco;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

public class Encriptacion implements Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain fchain)
			throws IOException, ServletException {
		
		
		String email = request.getParameter("email"); //$NON-NLS-1$
		String salt = null;
		String pwd = request.getParameter("pwd");
		//String classurl = request.getParameter("classurl"); //$NON-NLS-1$
		//String sqlurl = request.getParameter("sqlurl"); //$NON-NLS-1$
		//String sqluser = request.getParameter("sqluser"); //$NON-NLS-1$
		//String sqlpwd = request.getParameter("sqlpwd"); //$NON-NLS-1$
		String classurl = "com.mysql.jdbc.Driver";
		String sqlurl = "jdbc:mysql://localhost/banco";
		String sqluser = "root";
		String sqlpwd = "";
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		HttpSession sesion = req.getSession();
		sesion.setAttribute("classurl", classurl);
		sesion.setAttribute("sqlurl", sqlurl);
		sesion.setAttribute("sqluser", sqluser);
		sesion.setAttribute("sqlpwd", sqlpwd);
		
		Salt snejb = new Salt();
		try{
			salt = snejb.hash(pwd, salt, email, classurl, sqlurl, sqluser, sqlpwd);
			request.setAttribute("pwd", (String)BCrypt.hashpw(pwd, salt)); //$NON-NLS-1$
			request.setAttribute("salt", salt); //$NON-NLS-1$
		} catch (NullPointerException ex){
			res.sendRedirect(req.getContextPath().concat("/index.jsp"));
			System.out.println("Error en el salt. Probablemente no esté abierta la base de datos.");
		}
		
		try{
			fchain.doFilter(request, response);
		} catch (Exception ex){
			
		}
	}

	@Override
	public void init(FilterConfig fconf) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
