package koBus.mvc.command;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.ConnectionProvider;

import koBus.mvc.domain.SeatDTO;
import koBus.mvc.persistence.SeatDAO;
import koBus.mvc.persistence.SeatDAOImpl;

public class SeatHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("> SeatHandler.process() ...");
		/* String busId = request.getParameter("BUSID"); */
	    String busId = "BUS001";
	    int totalSeat = 0;
	    List<SeatDTO> seatList = null;
	    
	    try {
			Connection conn = ConnectionProvider.getConnection();
			SeatDAO dao = new SeatDAOImpl(conn);
			
			totalSeat = dao.getTotalSeats(busId);
			
			System.out.println("SeatHandler totalSeat : "  + totalSeat);
			
			seatList = dao.searchSeat(busId);
			
			System.out.println(seatList.size());
			
			String ajax = request.getParameter("ajax");

	        System.out.println("ajax = " + ajax);
	        String deprCd = request.getParameter("deprCd");           // 출발지 코드
	        String arvlCd = request.getParameter("arvlCd");           // 도착지 코드
	        String deprDt = request.getParameter("deprDt");           // 출발일자
	        String deprTime = request.getParameter("deprTime");       // 출발시간
	        
	        String selSeatCnt = request.getParameter("selSeatCnt");   // 총 좌석 수
	        String selAdltCnt = request.getParameter("selAdltCnt");   // 일반인 수
	        String selAdltDcCnt = request.getParameter("selAdltDcCnt"); // 일반인 할인 수
	        String selTeenCnt = request.getParameter("selTeenCnt");   // 중고생 수
	        String selChldCnt = request.getParameter("selChldCnt");   // 초등학생 수
	        String selUvsdCnt = request.getParameter("selUvsdCnt");   // 대학생 수
	        String selSncnCnt = request.getParameter("selSncnCnt");   // 경로자 수
	        String selDsprCnt = request.getParameter("selDsprCnt");   // 장애인 수
	        
	        String estmAmt = request.getParameter("estmAmt");         // 예상 운임 금액
	        String dcAmt = request.getParameter("dcAmt");             // 할인 금액
	        String tissuAmt = request.getParameter("tissuAmt");       // 발권 금액
	        
	        System.out.printf(
	        	    "출발지 코드: %s, 도착지 코드: %s, 출발일자: %s, 출발시간: %s%n" +
	        	    "총 좌석 수: %s, 일반인 수: %s, 일반인 할인 수: %s, 중고생 수: %s%n" +
	        	    "초등학생 수: %s, 대학생 수: %s, 경로자 수: %s, 장애인 수: %s%n" +
	        	    "예상 운임 금액: %s, 할인 금액: %s, 발권 금액: %s%n",
	        	    deprCd, arvlCd, deprDt, deprTime,
	        	    selSeatCnt, selAdltCnt, selAdltDcCnt, selTeenCnt,
	        	    selChldCnt, selUvsdCnt, selSncnCnt, selDsprCnt,
	        	    estmAmt, dcAmt, tissuAmt
	        	);

	        
	        if ("true".equalsIgnoreCase(ajax)) {
				// Ajax 요청인 경우 JSON 응답 전송
				response.setContentType("application/json;charset=utf-8");
				PrintWriter out = response.getWriter();
				out.print("{\"result\":\"ok\"}");
				out.close();
				// forward 하지 않음
				return null;
			}
			
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	    catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    request.setAttribute("totalSeat", totalSeat);
	    request.setAttribute("seatList", seatList);
	    
		
		return "/koBusFile/kobus_seat.jsp";
	}

    
}
