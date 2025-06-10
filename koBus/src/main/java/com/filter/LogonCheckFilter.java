package com.filter;

import java.io.IOException;
import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class LogonCheckFilter
 */
@WebFilter(
		dispatcherTypes = {DispatcherType.REQUEST }
					, 
		urlPatterns = { 
				"/day10/admin/*", 
				"/day10/board/Write.jsp"
		})
public class LogonCheckFilter extends HttpFilter implements Filter {

    public LogonCheckFilter() {
        super();
    }

	public void destroy() {
		
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("> LogonCheckFilter doFilter()");
		
		HttpServletRequest hrequest = (HttpServletRequest) request;
		HttpServletResponse hresponse = (HttpServletResponse) response;
		
		String logonId = null;
		boolean isAuth = false;
		HttpSession session = hrequest.getSession(false);
		
		String originalURL = hrequest.getRequestURI();
		
		if (session != null) {
			logonId = (String) session.getAttribute("auth");
			if (logonId != null) {
				isAuth = true;
			}
		}
		
		if (isAuth) {
			// ?ù∏Ï¶? o Ï≤¥ÌÅ¨ x
			// Í¥?Î¶¨Ïûê x
			chain.doFilter(request, response);
			
			
		}else {
			
		    System.out.println("originalURL : " + originalURL);
		    
		    HttpSession newSession = hrequest.getSession(true);
            newSession.setAttribute("redirectAfterLogin", originalURL);
		    
            String location = "/jspPro/day10/member/Logon.jsp";
		    hresponse.sendRedirect(location);
		}
		
		
		if(!logonId.equals("admin") && originalURL.startsWith("/jspPro/day10/admin")) { 
			hresponse.sendError(500, "Í¥?Î¶¨Ïûê ?ù¥?ô∏ ?†ëÍ∑? Î∂àÍ?");
			return;
		}

		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
