package koBus.mvc.command;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.DBConn;

import koBus.mvc.domain.RegionDTO;
import koBus.mvc.persistence.RegionDAO;
import koBus.mvc.persistence.RegionDAOImpl;


public class RegionHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("> regionHandler.process() ...");
		
        String sidoCode = request.getParameter("sidoCode");

        Connection conn = null;
        List<RegionDTO> list = null;

        try {
            // [2] DB 연결
            conn = DBConn.getConnection();

            // [3] DAO를 통해 지역 목록 조회
            RegionDAO dao = new RegionDAOImpl(conn);
            list = dao.selectBySidoCode(sidoCode);

            // [4] 조회 결과 request 객체에 저장
            request.setAttribute("regionList", list);
            
            System.out.println(">>>>>>>>>>>>>> " + list.size());

        } catch (Exception e) {
            e.printStackTrace();
        }

        // [5] JSP 페이지로 포워딩
        return "KOBUSreservation2.jsp";
	}

	
}
