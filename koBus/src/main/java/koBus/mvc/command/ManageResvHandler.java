package koBus.mvc.command;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.util.ConnectionProvider;

import koBus.mvc.domain.ResvDTO;
import koBus.mvc.persistence.ResvDAO;
import koBus.mvc.persistence.ResvDAOImpl;

public class ManageResvHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, Exception, Throwable {
		
		System.out.println("> ManageResvHandler.process() ...");
		
		Connection conn = ConnectionProvider.getConnection();
		ResvDAO dao = new ResvDAOImpl(conn);
		HttpSession session = request.getSession(false);
		String mainParam = request.getParameter("mainParam");
		
		 if (session == null || session.getAttribute("id") == null) {
		        // 로그인 안 된 상태
		        response.sendRedirect("/koBus/koBusFile/logonMain.jsp");
		        return null;
		}
		
		String loginId = (String) session.getAttribute("id");
		System.out.println("현재 로그인한 사용자 ID: " + loginId);
		
		List<ResvDTO> resvList = dao.searchResvList(loginId);
		
		
		// alcnAllList 생성
		List<Map<String, Object>> alcnAllList = new ArrayList<>();

		// 가는 편
		Map<String, Object> goTrip = new HashMap<>();
		goTrip.put("mrsMrnpno", request.getParameter("mrsMrnpno"));
		goTrip.put("mrsMrnpsno", request.getParameter("mrsMrnpsno"));
		goTrip.put("alcnDeprDt", request.getParameter("alcnDeprDt"));
		goTrip.put("alcnDeprTime", request.getParameter("alcnDeprTime"));
		goTrip.put("deprnCd", request.getParameter("deprnCd"));
		goTrip.put("arvlCd", request.getParameter("arvlCd"));
		goTrip.put("deprnNm", request.getParameter("deprnNm"));
		goTrip.put("arvlNm", request.getParameter("arvlNm"));
		goTrip.put("takeDrtm", request.getParameter("takeDrtm"));
		goTrip.put("cacmCd", request.getParameter("cacmCd"));
		goTrip.put("cacmNm", request.getParameter("cacmNm"));
		goTrip.put("deprNm", request.getParameter("deprNm"));
		goTrip.put("adltNum", request.getParameter("adltNum"));
		goTrip.put("chldNum", request.getParameter("chldNum"));
		goTrip.put("teenNum", request.getParameter("teenNum"));
		goTrip.put("payNm", request.getParameter("payNm"));
		goTrip.put("pynDvsCd", request.getParameter("pynDvsCd"));
		goTrip.put("pynDtlCd", request.getParameter("pynDtlCd"));
		goTrip.put("prmmDcDvsCd", request.getParameter("prmmDcDvsCd"));
		goTrip.put("rtrpMrsYn", request.getParameter("rtrpMrsYn"));
		goTrip.put("tckSeqList", request.getParameter("tckSeqList"));
		alcnAllList.add(goTrip);

		// 오는 편
		String rtrpYn = request.getParameter("rtrpMrsYn");
		if ("Y".equalsIgnoreCase(rtrpYn)) {
			String alcnDeprDt2 = request.getParameter("alcnDeprDt2");
			String alcnDeprTime2 = request.getParameter("alcnDeprTime2");
			if (alcnDeprDt2 != null && !alcnDeprDt2.isEmpty() && alcnDeprTime2 != null && !alcnDeprTime2.isEmpty()) {
				Map<String, Object> rtnTrip = new HashMap<>();
				rtnTrip.put("mrsMrnpno", request.getParameter("mrsMrnpno2"));
				rtnTrip.put("mrsMrnpsno", request.getParameter("mrsMrnpsno2"));
				rtnTrip.put("alcnDeprDt", alcnDeprDt2);
				rtnTrip.put("alcnDeprTime", alcnDeprTime2);
				rtnTrip.put("deprnCd", request.getParameter("deprnCd2"));
				rtnTrip.put("arvlCd", request.getParameter("arvlCd2"));
				rtnTrip.put("deprnNm", request.getParameter("deprnNm2"));
				rtnTrip.put("arvlNm", request.getParameter("arvlNm2"));
				rtnTrip.put("takeDrtm", request.getParameter("takeDrtm2"));
				rtnTrip.put("cacmCd", request.getParameter("cacmCd2"));
				rtnTrip.put("cacmNm", request.getParameter("cacmNm2"));
				rtnTrip.put("deprNm", request.getParameter("deprNm2"));
				rtnTrip.put("adltNum", request.getParameter("adltNum2"));
				rtnTrip.put("chldNum", request.getParameter("chldNum2"));
				rtnTrip.put("teenNum", request.getParameter("teenNum2"));
				rtnTrip.put("payNm", request.getParameter("payNm2"));
				rtnTrip.put("pynDvsCd", request.getParameter("pynDvsCd2"));
				rtnTrip.put("pynDtlCd", request.getParameter("pynDtlCd2"));
				rtnTrip.put("prmmDcDvsCd", request.getParameter("prmmDcDvsCd2"));
				rtnTrip.put("rtrpMrsYn", request.getParameter("rtrpMrsYn2"));
				rtnTrip.put("tckSeqList", request.getParameter("tckSeqList2"));
				alcnAllList.add(rtnTrip);
			}
		}

		Map<String, Object> responseMap = new HashMap<>();
		responseMap.put("alcnAllList", alcnAllList);

		if ("ajax".equalsIgnoreCase(mainParam)) {
			Gson gson = new Gson();
			String json = gson.toJson(responseMap);

			response.setContentType("application/json;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(json);
			out.flush();
			out.close();

			return null;
		}

;
		
		request.setAttribute("resvList", resvList);
		
		return "/koBusFile/kobusManageResv.jsp";
	}

}
