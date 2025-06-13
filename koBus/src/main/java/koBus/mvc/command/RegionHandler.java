package koBus.mvc.command;

import java.io.PrintWriter;
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
        System.out.println("> RegionHandler.process() ...");
        
        

        String command = request.getRequestURI();
        command = command.substring(request.getContextPath().length()); // /getTerminals.do or /region.do
        System.out.println("command: " + command);  // ★ 확인
        
        String sidoCode = request.getParameter("sidoCode");
        

        try (Connection conn = DBConn.getConnection()) {
            RegionDAO dao = new RegionDAOImpl(conn);
            

            
            // ✅ AJAX 비동기 요청 처리 (JSON 응답)
            if (command.equals("/getTerminals.do") && sidoCode != null) {
                List<RegionDTO> list = dao.selectBySidoCode(sidoCode);

                response.setContentType("application/json; charset=UTF-8");
                PrintWriter out = response.getWriter();

                // JSON 수동 생성
                StringBuilder sb = new StringBuilder();
                sb.append("[");
                for (int i = 0; i < list.size(); i++) {
                    RegionDTO dto = list.get(i);
                    sb.append("{")
                      .append("\"regID\":\"").append(dto.getRegID()).append("\",")
                      .append("\"regName\":\"").append(dto.getRegName()).append("\",")
                      .append("\"sidoCode\":\"").append(dto.getSidoCode()).append("\"")
                      .append("}");
                    if (i < list.size() - 1) sb.append(",");
                }
                sb.append("]");
                
                System.out.println(">> JSON 결과: " + sb.toString());  // ✅ 최종 JSON 로그

                out.print(sb.toString());
                out.flush(); // ✅ 꼭 flush 필요

                out.close();
                return null; // JSON 응답만 하고 종료
            }
            

            // ✅ JSP 페이지 포워딩용 기본 처리
            return "KOBUSreservation3.jsp";

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
