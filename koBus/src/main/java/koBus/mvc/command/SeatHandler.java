package koBus.mvc.command;

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
	    String busId = "BUS002";
	    int totalSeat = 0;
	    List<SeatDTO> seatList = null;
	    
	    try {
			Connection conn = ConnectionProvider.getConnection();
			SeatDAO dao = new SeatDAOImpl(conn);
			
			totalSeat = dao.getTotalSeats(busId);
			
			System.out.println("SeatHandler totalSeat : "  + totalSeat);
			
			seatList = dao.searchSeat(busId);
			
			System.out.println("SeatHandler seatList length : " + seatList);
			System.out.println(seatList.size());
			
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    request.setAttribute("totalSeat", totalSeat);
	    request.setAttribute("seatList", seatList);
	    
		
		return "/koBusFile/kobus_seat.jsp";
	}

    
}
