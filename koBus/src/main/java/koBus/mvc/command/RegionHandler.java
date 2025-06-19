package koBus.mvc.command;

import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.ConnectionProvider;

import koBus.mvc.domain.RegionDTO;
import koBus.mvc.persistence.RegionDAO;
import koBus.mvc.persistence.RegionDAOImpl;


public class RegionHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("> RegionHandler.process() ...");

        Connection conn = null;

        String command = request.getRequestURI();
        command = command.substring(request.getContextPath().length()); // /getTerminals.do
        System.out.println("command: " + command);

        String sidoCodeStr = request.getParameter("sidoCode");
        System.out.println(">>> [DAO] sidoCode 파라미터: " + sidoCodeStr);

        try {
            conn = ConnectionProvider.getConnection(); 
            RegionDAO dao = new RegionDAOImpl();

            if (command.equals("/getTerminals.do") && sidoCodeStr != null) {
                List<RegionDTO> list = null;

                if ("all".equalsIgnoreCase(sidoCodeStr)) {
                    list = dao.selectAll();
                } else {
                    try {
                        int sidoCode = Integer.parseInt(sidoCodeStr);
                        list = dao.selectBySidoCode(sidoCode);
                    } catch (NumberFormatException e) {
                        System.out.println("❌ 잘못된 sidoCode: " + sidoCodeStr);
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        return null;
                    }
                }

                response.setContentType("application/json; charset=UTF-8");
                PrintWriter out = response.getWriter();

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

                System.out.println(">> JSON 결과: " + sb.toString());
                out.print(sb.toString());
                out.flush();
                out.close();

                return null;
            }

            return "/koBusFile/KOBUSreservation3.jsp";

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
