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
		String email = request.getParameter("email");
		String salt = BCrypt.gensalt(16);
		String pwd = request.getParameter("pwd");
		System.out.println("Entra en el filtro");
		System.out.println(pwd);
		System.out.println(salt);
		//Conseguir salt con el ejb
		request.setAttribute("pwd", (String)BCrypt.hashpw(pwd, salt));
		request.setAttribute("salt", salt);
		fchain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig fconf) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
