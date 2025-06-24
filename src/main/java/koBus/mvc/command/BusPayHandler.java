package koBus.mvc.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
// import koBus.mvc.domain.TicketDTO;         // 예시 DTO
// import koBus.mvc.persistence.TicketDAO;    // 예시 DAO

public class BusPayHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 1. 파라미터 받아오기
        String deprCd = request.getParameter("deprCd");
        System.out.println("[BusPayHandler] deprCd 파라미터: " + deprCd); // 로그 확인용

        // 2. DAO를 통해 승차권 정보 조회
        // TicketDAO dao = new TicketDAO();
        // ResvDTO ticket = dao.getTicketByDeprCd(deprCd);

        String deprDt = request.getParameter("deprDt");        // 출발일
        String deprTime = request.getParameter("deprTime");    // 출발시간

        String deprNm = request.getParameter("deprNm");        // 출발지 이름
        String arvlNm = request.getParameter("arvlNm");        // 도착지 이름

        String cacmCd = request.getParameter("cacmCd");        // 고속사 코드
        String indVBusClsCd = request.getParameter("indVBusClsCd"); // 버스 등급 코드

        String selAdltCnt = request.getParameter("selAdltCnt"); // 성인 매수
        String selChldCnt = request.getParameter("selChldCnt"); // 아동 매수
        String selTeenCnt = request.getParameter("selTeenCnt"); // 청소년 매수

        String selSeatNum = request.getParameter("selSeatNum"); // 좌석 번호 (예: "15,9")
        
        request.setAttribute("deprCd", deprCd);
        request.setAttribute("deprDt", deprDt);
        request.setAttribute("deprTime", deprTime);
        request.setAttribute("deprNm", deprNm);    // 출발지 이름
        request.setAttribute("arvlNm", arvlNm);    // 도착지 이름
        request.setAttribute("cacmCd", cacmCd);
        request.setAttribute("indVBusClsCd", indVBusClsCd);
        request.setAttribute("selAdltCnt", selAdltCnt);
        request.setAttribute("selChldCnt", selChldCnt);
        request.setAttribute("selTeenCnt", selTeenCnt);
        request.setAttribute("selSeatNum", selSeatNum);



        // 4. 이동할 JSP 경로 리턴 (예시: busPay.jsp)
        return "/koBus/koBusFile/busPay.jsp";
    }
}
