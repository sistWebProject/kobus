package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.noticeDAO;
import board.dto.NoticeDTO;
import koBus.mvc.command.CommandHandler;

public class NoticeSaveHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 인코딩
    	request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
        // 파라미터 수집
        String notID = request.getParameter("notID");
        String topic = request.getParameter("topic");
        String content = request.getParameter("content");

        // DTO + DAO
        NoticeDTO dto = new NoticeDTO();
        dto.setNotID(notID);
        dto.setTopic(topic);
        dto.setContent(content);

        noticeDAO dao = new noticeDAO();
        dao.insertNotice(dto);

        // 저장 후 목록으로 이동
        response.sendRedirect("noticeList.do"); // 또는 "list.notice" 등 네가 지정한 경로
        return null; // forward 안 할 거면 null
    }
}
