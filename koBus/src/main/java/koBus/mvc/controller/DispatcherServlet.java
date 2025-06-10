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

	@Override
	public void destroy() {
		super.destroy();
	}
	
	// Map 선언 : key=url,  value=모델 객체를 생성해서 
	   public Map<String, CommandHandler> commandHandlerMap = new HashMap<>();

	@Override
	public void init() throws ServletException {
		super.init();
		System.out.println("> DispatcherServlet.init()...");
		String mappingPath = this.getInitParameter("mappingPath");
		String realPath = this.getServletContext().getRealPath(mappingPath);
		System.out.println("> realPath : " + realPath);
		
		// WEB-INF/command.properties 파일읽기
		
		/*
		 * .properties 파일로부터 URL - 클래스명 매핑 정보를 읽고
		 *	↓
		 *	해당 클래스명을 기반으로 리플렉션으로 클래스 로딩 및 객체 생성
		 *	↓
		 *	Map<String, CommandHandler> 형태로 저장
		 *	↓
		 *	실행 시 URL로 요청이 들어오면 해당 객체를 꺼내 실행
		 * 
		 */
		
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
			
			// 클래스 객체를 저장할 변수 선언
			//  Class.forName()으로 로딩할 클래스 정보를 담기 위한 준비
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
		
		// 2단계 - 요청URL 분석  
		String requestURI = req.getRequestURI(); 
		System.out.println(requestURI);
		int beginIndex = req.getContextPath().length();
		
		requestURI = requestURI.substring(beginIndex);
		System.out.println(requestURI);
		
		// 3단계 - 로직처리하는 모델객체를 commandHandlerMap으로 부터 얻어오기
		CommandHandler handler = this.commandHandlerMap.get(requestURI);
		String view = null;
		view = handler.process(req, resp);
		
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

