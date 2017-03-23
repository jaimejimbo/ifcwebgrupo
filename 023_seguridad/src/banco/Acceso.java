package banco;

import java.io.IOException;

import javax.jms.ServerSession;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class Acceso
 */
@WebFilter("/Acceso")
public class Acceso implements Filter {

    /**
     * Default constructor. 
     */
    public Acceso() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		// pass the request along the filter chain
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		boolean allowed = false;
		HttpSession sesion = req.getSession();
		try{
			allowed = (boolean)sesion.getAttribute("allowed");
		} catch (NullPointerException ex){
			System.out.println("El par�metro no existe");
			allowed = false;
		}
		if (allowed){
			chain.doFilter(request, response);
		} else {
			res.sendRedirect(req.getContextPath().concat("/login.jsp"));
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
