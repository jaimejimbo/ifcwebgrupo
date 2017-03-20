package banco;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
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
		request.setAttribute("classurl", classurl);
		request.setAttribute("sqlurl", sqlurl);
		request.setAttribute("sqluser", sqluser);
		request.setAttribute("sqlpwd", sqlpwd);
		SaltNoEJB snejb = new SaltNoEJB();
		salt = snejb.getSalt(pwd, salt, email, classurl, sqlurl, sqluser, sqlpwd);
		request.setAttribute("pwd", (String)BCrypt.hashpw(pwd, salt)); //$NON-NLS-1$
		request.setAttribute("salt", salt); //$NON-NLS-1$
		fchain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig fconf) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
