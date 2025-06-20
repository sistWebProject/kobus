package koBus.mvc.command;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.util.ConnectionProvider;

import koBus.mvc.domain.ScheduleDTO;
import koBus.mvc.persistence.ScheduleDAO;
import koBus.mvc.persistence.ScheduleDAOImpl;


public class ScheduleHandler implements CommandHandler {
	

	/*
	 * 노선 스케줄 조회 테스트 시 사용할 데이터
	| BSHID  | 노선ID   | 출발지       		| 도착지 | 회사명  | 버스등급 | 출발일시             | 도착일시             | 소요시간 | 남은좌석 | 일반요금   | 중고생요금  | 초등생요금  |
	| ------ | ------ | --------- | --- 	| ---- | ---- | ---------------- | ---------------- | ---- | ---- | ------ | ------ | ------ |
	| BSH009 | ROU003 | 강남고속버스터미널 | 안산  | 중앙고속 | 우등   | 2025-06-03 18:00 | 2025-06-03 20:00 | 120분 | 10   | 22,000 | 18,700 | 15,400 |
	| BSH010 | ROU004 | 센트럴시티(서울) 	| 용인  | 금남고속 | 일반   | 2025-06-04 08:00 | 2025-06-04 10:00 | 120분 | 27   | 23,000 | 19,550 | 16,200 |
	| BSH011 | ROU001 | 동서울       		| 광명  | 금호고속 | 일반   | 2025-06-25 08:00 | 2025-06-25 10:00 | 120분 | 7    | 19,693 | 16,739 | 13,785 |
	| BSH012 | ROU001 | 동서울       		| 광명  | 금호고속 | 프리미엄 | 2025-06-25 13:00 | 2025-06-25 15:00 | 120분 | 9    | 23,149 | 19,676 | 16,204 |
	| BSH013 | ROU001 | 동서울       		| 광명  | 금호고속 | 우등   | 2025-06-25 18:00 | 2025-06-25 20:00 | 120분 | 22   | 25,265 | 21,475 | 17,685 |
	| BSH014 | ROU002 | 서울남부터미널   	| 성남  | 동부고속 | 일반   | 2025-06-26 08:00 | 2025-06-26 10:00 | 120분 | 7    | 18,325 | 15,576 | 12,827 |
	| BSH015 | ROU002 | 서울남부터미널   	| 성남  | 동부고속 | 일반   | 2025-06-26 13:00 | 2025-06-26 15:00 | 120분 | 33   | 24,857 | 21,128 | 17,399 |
	| BSH016 | ROU002 | 서울남부터미널   	| 성남  | 동부고속 | 일반   | 2025-06-26 18:00 | 2025-06-26 20:00 | 120분 | 38   | 26,595 | 22,605 | 18,616 |
	| BSH017 | ROU003 | 강남고속버스터미널 	| 안산  | 중앙고속 | 우등   | 2025-06-27 08:00 | 2025-06-27 10:00 | 120분 | 25   | 21,552 | 18,319 | 15,086 |
	| BSH018 | ROU003 | 강남고속버스터미널 	| 안산  | 중앙고속 | 프리미엄 | 2025-06-27 13:00 | 2025-06-27 15:00 | 120분 | 3    | 18,284 | 15,541 | 12,798 |
	| BSH019 | ROU003 | 강남고속버스터미널 	| 안산  | 중앙고속 | 우등   | 2025-06-27 18:00 | 2025-06-27 20:00 | 120분 | 17   | 25,855 | 21,976 | 18,098 |
	| BSH020 | ROU004 | 센트럴시티(서울) 	| 용인  | 금남고속 | 일반   | 2025-06-28 08:00 | 2025-06-28 10:00 | 120분 | 44   | 21,182 | 18,004 | 14,827 |
	| BSH021 | ROU004 | 센트럴시티(서울) 	| 용인  | 금남고속 | 일반   | 2025-06-28 13:00 | 2025-06-28 15:00 | 120분 | 24   | 26,169 | 22,243 | 18,318 |
	| BSH022 | ROU005 | 인천공항      		| 의정부 | 중부고속 | 프리미엄 | 2025-06-29 08:00 | 2025-06-29 10:00 | 120분 | 18   | 20,500 | 17,425 | 14,300 |
	| BSH023 | ROU005 | 인천공항      		| 의정부 | 중부고속 | 우등   | 2025-06-29 13:00 | 2025-06-29 15:00 | 120분 | 21   | 20,500 | 17,425 | 14,300 |
	| BSH024 | ROU005 | 인천공항      		| 의정부 | 중부고속 | 일반   | 2025-06-29 18:00 | 2025-06-29 20:00 | 120분 | 6    | 20,500 | 17,425 | 14,300 |

	 */

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("> StationHandler.process() ...");
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		String regionCode = request.getParameter("regionCode");
		int sidoCode = 11;
		List<ScheduleDTO> regionList = null;
		List<ScheduleDTO> schList = null;
		StringBuilder jsonBuilder = new StringBuilder();
		String sourcePage = request.getParameter("sourcePage");
		
		System.out.println("sourcePage : " + sourcePage);

		
		try(Connection conn = ConnectionProvider.getConnection();){
			ScheduleDAO dao = new ScheduleDAOImpl(conn);
			
			String ajax = request.getParameter("ajax");
			String ajaxType = request.getParameter("ajaxType");

			System.out.println("ajax = " + ajax);
			System.out.println("ajaxType = " + ajaxType);

			if ("true".equalsIgnoreCase(ajax) && ajaxType.equals("getStationName")) {
				
				if (regionCode == null || regionCode.trim().isEmpty() || 
						regionCode.equalsIgnoreCase("null") || 
						regionCode.equalsIgnoreCase("undefined")) {
					regionCode = "11";
					regionList = dao.selectBySidoCode(sidoCode);
				}else if(regionCode.equals("all")) {
					regionList = dao.selectByRegion();
				}

				else {
					sidoCode = Integer.parseInt(regionCode);
					regionList = dao.selectBySidoCode(sidoCode);
				}
				
				Gson gson = new Gson();
				String json = gson.toJson(regionList);

				PrintWriter out = response.getWriter();
				out.write(json);
				out.close();
				// forward 하지 않음
				return null;

			}else if ("true".equalsIgnoreCase(ajax) && "searchSch".equals(ajaxType)) {

			    String deprCd = request.getParameter("deprCd");
			    String arvlCd = request.getParameter("arvlCd");
			    String deprDtm = request.getParameter("deprDtm");
			    String busClsCd = request.getParameter("busClsCd");

			    switch (busClsCd) {
			        case "0": busClsCd = "전체"; break;
			        case "7": busClsCd = "프리미엄"; break;
			        case "1": busClsCd = "우등"; break;
			        case "2": busClsCd = "일반"; break;
			        default: break;
			    }

			    schList = dao.searchBusSchedule(deprCd, arvlCd, deprDtm, busClsCd);

			    int durmin = 0;
			    if (!schList.isEmpty()) {
			        durmin = schList.get(0).getDurMin();
			    }

			    System.out.println("schList.size() : " + schList.size());

			    // ✅ Gson으로 응답을 만들기 위한 구조 정의
			    Map<String, Object> responseMap = new HashMap<>();
			    responseMap.put("rotVldChc", schList.isEmpty() ? "N" : "Y");

			    Map<String, Object> alcnCmnMap = new HashMap<>();
			    alcnCmnMap.put("takeDrtm", durmin);
			    responseMap.put("alcnCmnMap", alcnCmnMap);

			    List<Map<String, Object>> alcnAllList = new ArrayList<>();

			    for (ScheduleDTO dto : schList) {
			        Map<String, Object> scheduleMap = new HashMap<>();
			        LocalDateTime departureDate = dto.getDepartureDate();
			        String time = departureDate.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm"));

			        scheduleMap.put("DEPR_TIME_DVS", time);
			        scheduleMap.put("CACM_MN", dto.getComName());
			        scheduleMap.put("BUS_CLS_NM", dto.getBusGrade());
			        scheduleMap.put("ADLT_FEE", dto.getAdultFare());
			        scheduleMap.put("CHLD_FEE", dto.getStuFare());
			        scheduleMap.put("TEEN_FEE", dto.getChildFare());
			        scheduleMap.put("RMN_SATS_NUM", dto.getRemainSeats());
			        scheduleMap.put("TOT_SATS_NUM", dto.getBusSeats());

			        alcnAllList.add(scheduleMap);
			    }

			    responseMap.put("alcnAllList", alcnAllList);

			    Gson gson = new Gson();
			    String json = gson.toJson(responseMap);

			    PrintWriter out = response.getWriter();
			    out.write(json);
			    out.flush();
			    out.close();

			    return null;
			}


		}catch (NamingException e) {
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

		request.setAttribute("regionList", regionList);
		
		if ("KOBUSreservation3.jsp".equals(sourcePage)) {
		    return "/koBusFile/KOBUSreservation2.jsp";
		} else {
		    return "/koBusFile/kobusSchedule.jsp";
		}

	}

}