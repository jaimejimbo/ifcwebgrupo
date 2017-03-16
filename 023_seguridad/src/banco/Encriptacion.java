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
		String reg = request.getParameter("reg");
		String salt;
		if (reg=="yes"){
			salt = null;
		} else {
			salt = BCrypt.gensalt(16);
		};
		String password = request.getParameter("pwd");
		request.setAttribute("pwd", (String)BCrypt.hashpw(password, salt));
		fchain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig fconf) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
