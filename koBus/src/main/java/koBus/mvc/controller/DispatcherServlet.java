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
	
	// Map �꽑�뼵 : key=url,  value=紐⑤뜽 媛앹껜瑜� �깮�꽦�빐�꽌 
	   public Map<String, CommandHandler> commandHandlerMap = new HashMap<>();

	@Override
	public void init() throws ServletException {
		super.init();
		System.out.println("> DispatcherServlet.init()...");
		String mappingPath = this.getInitParameter("mappingPath");
		String realPath = this.getServletContext().getRealPath(mappingPath);
		System.out.println("> realPath : " + realPath);
		
		// WEB-INF/command.properties �뙆�씪�씫湲�
		
		/*
		 * .properties �뙆�씪濡쒕��꽣 URL - �겢�옒�뒪紐� 留ㅽ븨 �젙蹂대�� �씫怨�
		 *	�넃
		 *	�빐�떦 �겢�옒�뒪紐낆쓣 湲곕컲�쑝濡� 由ы뵆�젆�뀡�쑝濡� �겢�옒�뒪 濡쒕뵫 諛� 媛앹껜 �깮�꽦
		 *	�넃
		 *	Map<String, CommandHandler> �삎�깭濡� ���옣
		 *	�넃
		 *	�떎�뻾 �떆 URL濡� �슂泥��씠 �뱾�뼱�삤硫� �빐�떦 媛앹껜瑜� 爰쇰궡 �떎�뻾
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
			
			// �겢�옒�뒪 媛앹껜瑜� ���옣�븷 蹂��닔 �꽑�뼵
			//  Class.forName()�쑝濡� 濡쒕뵫�븷 �겢�옒�뒪 �젙蹂대�� �떞湲� �쐞�븳 以�鍮�
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
		// 2�떒怨� - �슂泥쵻RL 遺꾩꽍  
		String requestURI = req.getRequestURI(); 
		System.out.println(requestURI);
		int beginIndex = req.getContextPath().length();
		
		requestURI = requestURI.substring(beginIndex);
		System.out.println(requestURI);
		
		// 3�떒怨� - 濡쒖쭅泥섎━�븯�뒗 紐⑤뜽媛앹껜瑜� commandHandlerMap�쑝濡� 遺��꽣 �뼸�뼱�삤湲�
		CommandHandler handler = this.commandHandlerMap.get(requestURI);
		 System.out.println("=== commandHandlerMap 키 목록 ===");
		    for (String key : commandHandlerMap.keySet()) {
		        System.out.println(key + " => " + commandHandlerMap.get(key));
		    }

		    System.out.println("핸들러 매핑 결과: " + handler);
		String view = null;
		try {
			view = handler.process(req, resp);
		} catch (Throwable e) {
			// TODO Auto-generated catch block
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

