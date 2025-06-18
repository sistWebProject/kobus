package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.noticeDAO;
import board.dto.NoticeDTO;
import koBus.mvc.command.CommandHandler;

public class NoticeEditHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String method = request.getMethod();

        if (method.equalsIgnoreCase("GET")) {
            String notID = request.getParameter("notID");
            NoticeDTO dto = noticeDAO.selectOne(notID);  // static 방식, String ID

            request.setAttribute("dto", dto);
            return "/notice/noticeEdit.jsp";

        } else if (method.equalsIgnoreCase("POST")) {
            request.setCharacterEncoding("UTF-8");

            String notID = request.getParameter("notID");
            String topic = request.getParameter("topic");
            String content = request.getParameter("content");

            NoticeDTO dto = new NoticeDTO();
            dto.setNotID(notID);
            dto.setTopic(topic);
            dto.setContent(content);

            int result = noticeDAO.updateNotice(dto);

            return "noticeList.do";
        }

        return null;
    }
}
