package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import koBus.mvc.command.CommandHandler;

public class GoBusHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Throwable {
        // 필요한 로직 있으면 여기에 작성
        return "/html/go_bus.jsp";  // forward 방식 (DispatcherServlet에서 forward 처리)
    }
}