package koBus.mvc.controller;

import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import koBus.mvc.command.CommandHandler;


public class DispatcherServlet extends HttpServlet {


	private static final long serialVersionUID = 1L;

	@Override
	public void destroy() {
		super.destroy();
	}
	
	
	   public Map<String, CommandHandler> commandHandlerMap = new HashMap<>();

	@Override
	public void init() throws ServletException {
		super.init();
		System.out.println("> DispatcherServlet.init()...");
		String mappingPath = this.getInitParameter("mappingPath");
		String realPath = this.getServletContext().getRealPath(mappingPath);
		System.out.println("> realPath : " + realPath);
		

		
		Properties prop = new Properties();
		try(FileReader reader = new FileReader(realPath)) {
			prop.load(reader);
		} catch (Exception e) {
			throw new ServletException();
		}
		
		Set<Entry<Object, Object>> set = prop.entrySet();
		Iterator<Entry<Object, Object>> ir = set.iterator();
		while (ir.hasNext()) {
			Entry<Object, Object> entry = ir.next();
			String url = (String) entry.getKey();
			String fullName = (String) entry.getValue();
			

			Class<?> commandHandlerClass = null;
			
			try {
				commandHandlerClass = Class.forName(fullName);
				try {
					CommandHandler handler = (CommandHandler) commandHandlerClass.newInstance();
					this.commandHandlerMap.put(url, handler);
				} catch (InstantiationException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				}
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
			
		}
		
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    resp.setContentType("text/html; charset=UTF-8");   // ⬅ 추가
	    resp.setCharacterEncoding("UTF-8");
		
		String requestURI = req.getRequestURI(); 
		System.out.println(requestURI);
		int beginIndex = req.getContextPath().length();
		
		requestURI = requestURI.substring(beginIndex);
		System.out.println(requestURI);
		
		
		CommandHandler handler = this.commandHandlerMap.get(requestURI);
	
		    System.out.println("핸들러 매핑 결과: " + handler);
		String view = null;
		try {
			view = handler.process(req, resp);
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		if (view != null) {
			RequestDispatcher dispatcher = req.getRequestDispatcher(view);
			dispatcher.forward(req, resp);
		}
		
		
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

	

}

