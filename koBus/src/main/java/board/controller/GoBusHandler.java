package board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.noticeDAO;
import board.dto.NoticeDTO;
import koBus.mvc.command.CommandHandler;

public class GoBusHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // 1. 상단 고정 공지 6개 가져오기
        List<NoticeDTO> fixedList = noticeDAO.selectImportantNotices();

        // 2. 일반 공지 전체 가져오기
        List<NoticeDTO> normalList = noticeDAO.selectGeneralNotices();

        // 3. request에 담아서 jsp로 전달
        request.setAttribute("fixedList", fixedList);
        request.setAttribute("normalList", normalList);

        // 4. 최종 이동 페이지 반환 (DispatcherServlet이 forward 처리)
        return "/html/go_bus.jsp";
    }
}
