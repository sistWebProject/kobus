package koBus.mvc.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ItemPurListPageHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, Exception, Throwable {
		// 상품 구매내역 페이지 
		return "/koBusFile/itemPurListPage.jsp";
	}

}
