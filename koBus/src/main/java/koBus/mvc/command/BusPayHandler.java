package koBus.mvc.command;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
// import koBus.mvc.domain.TicketDTO;         // 예시 DTO
// import koBus.mvc.persistence.TicketDAO;    // 예시 DAO

import com.util.ConnectionProvider;

import koBus.mvc.domain.ScheduleDTO;
import koBus.mvc.domain.SeatDTO;
import koBus.mvc.persistence.SeatDAO;
import koBus.mvc.persistence.SeatDAOImpl;

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

		String deprDtFmt = "";
		if (deprDt != null && deprDt.length() == 8) {
			String year = deprDt.substring(0, 4);
			String month = deprDt.substring(4, 6);
			String day = deprDt.substring(6, 8);
			deprDtFmt = year + "." + month + "." + day;
		}

		String deprTime = request.getParameter("deprTime");    // 출발시간

		String deprTimeFmt = "";
		if (deprTime != null && deprTime.length() == 6) {
			String hour = deprTime.substring(0, 2);
			String min = deprTime.substring(2, 4);
			// 필요하다면 초까지: String sec = deprTime.substring(4, 6);
			deprTimeFmt = hour + ":" + min;
		}

		String deprNm = request.getParameter("deprNm");        // 출발지 이름
		String arvlNm = request.getParameter("arvlNm");        // 도착지 이름

		String takeDrtmOrg = request.getParameter("takeDrtmOrg");        // 소요시간
		System.out.println("[BusPayHandler] takeDrtm 파라미터: " + takeDrtmOrg);

		String cacmCd = request.getParameter("cacmCd");        // 고속사 코드
		String cacmNm = request.getParameter("cacmNm");        // 고속사 코드
		String indVBusClsCd = request.getParameter("indVBusClsCd"); // 버스 등급 코드

		String selAdltCnt = request.getParameter("selAdltCnt"); // 성인 매수
		String selChldCnt = request.getParameter("selChldCnt"); // 아동 매수
		String selTeenCnt = request.getParameter("selTeenCnt"); // 청소년 매수

		String selectedSeatIds = request.getParameter("selectedSeatIds");

		String selSeatNum = request.getParameter("selSeatNum"); // 좌석 번호 (예: "15,9")
		String selSeatCnt = request.getParameter("selSeatCnt"); // 총 선택좌석 수
		String allTotAmtPrice = request.getParameter("allTotAmtPrice"); // 총 금액

		request.setAttribute("deprCd", deprCd);
		request.setAttribute("deprDt", deprDt);
		request.setAttribute("deprTime", deprTime);
		request.setAttribute("deprNm", deprNm);    // 출발지 이름
		request.setAttribute("arvlNm", arvlNm);    // 도착지 이름
		request.setAttribute("cacmCd", cacmCd);
		request.setAttribute("cacmNm", cacmNm);
		request.setAttribute("indVBusClsCd", indVBusClsCd);
		request.setAttribute("selAdltCnt", selAdltCnt);
		request.setAttribute("selChldCnt", selChldCnt);
		request.setAttribute("selTeenCnt", selTeenCnt);

		request.setAttribute("selSeatNum", selSeatNum);
		request.setAttribute("estmAmt", allTotAmtPrice);
		request.setAttribute("tissuAmt", allTotAmtPrice);
		request.setAttribute("selSeatCnt", selSeatCnt);
		request.setAttribute("takeDrtmOrg", takeDrtmOrg);
		request.setAttribute("deprTimeFmt", deprTimeFmt);
		request.setAttribute("deprDtFmt", deprDtFmt);



		Connection conn = ConnectionProvider.getConnection();
		SeatDAO dao = new SeatDAOImpl(conn);
		
		// seatNum_SEAT043,seatNum_SEAT044


		Pattern pattern = Pattern.compile("SEAT\\d+");
		Matcher matcher = pattern.matcher(selectedSeatIds);

		List<String> seatIdList = new ArrayList<>();
		while (matcher.find()) {
		    seatIdList.add(matcher.group());
		}

		String seatNos = dao.searchSeatId(seatIdList);
		
		if (seatNos.isEmpty()) {
		    System.out.println("조회된 좌석 번호가 없습니다.");
		} else {
		    System.out.println("좌석 번호들: " + seatNos);
		}
		
		
		request.setAttribute("seatNos", seatNos);
		


		// 4. 이동할 JSP 경로 리턴 (예시: busPay.jsp)
		return "/koBusFile/busPay.jsp";
	}
}
