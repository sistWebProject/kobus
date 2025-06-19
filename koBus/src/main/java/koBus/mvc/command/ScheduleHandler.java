package koBus.mvc.command;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Iterator;
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
				
			    
			    jsonBuilder.append("[");  // JSON 배열 시작

			    for (int i = 0; i < regionList.size(); i++) {
			        ScheduleDTO dto = regionList.get(i);
			        

			        System.out.println(regionList);
//					System.out.printf("regID : %s, regName: %s, sidoCode: %s", dto.getRegID(), dto.getRegName(), dto.getSidoCode());


			        jsonBuilder.append("{");
			        jsonBuilder.append("\"regID\":\"").append(dto.getRegID()).append("\",");
			        jsonBuilder.append("\"regName\":\"").append(dto.getRegName()).append("\"");
			        // 필요한 필드 추가
			        jsonBuilder.append("}");

			        if (i < regionList.size() - 1) {
			            jsonBuilder.append(",");
			        }
			    }

			    jsonBuilder.append("]");  // JSON 배열 종료

			    PrintWriter out = response.getWriter();
			    out.write(jsonBuilder.toString());
			    out.close();
			    out.flush();
			    
			    return null;
			    
			}else if("true".equalsIgnoreCase(ajax) && ajaxType.equals("searchSch")) {
				
				
				String deprCd = request.getParameter("deprCd");
				String arvlCd = request.getParameter("arvlCd");
				String deprDtm = request.getParameter("deprDtm");
				String busClsCd = request.getParameter("busClsCd");
				
				switch (busClsCd) {
				case "0":
					busClsCd = "전체";
					break;
				case "7":
					busClsCd = "프리미엄";
					break;
				case "1":
					busClsCd = "우등";
					break;
				case "2":
					busClsCd = "일반";
					break;

				default:
					break;
				}
				
				schList = dao.searchBusSchedule(deprCd, arvlCd, deprDtm, busClsCd);

				int durmin = 0;  // 기본값 설정

				if (!schList.isEmpty()) {
				    durmin = schList.get(0).getDurMin();
				}
				
				System.out.println("schList.size() : " + schList.size());

				jsonBuilder.setLength(0);
				jsonBuilder.append("{");
				jsonBuilder.append("\"rotVldChc\":\"").append(schList.isEmpty() ? "N" : "Y").append("\",");
				jsonBuilder.append("\"alcnCmnMap\": {");
				jsonBuilder.append("\"takeDrtm\":\"").append(durmin).append("\"");
				jsonBuilder.append("},");

				// schList -> alcnAllList 수동 JSON 배열 변환
				jsonBuilder.append("\"alcnAllList\":[");

				for (int i = 0; i < schList.size(); i++) {
				    ScheduleDTO dto = schList.get(i);
				    LocalDateTime departureDate = dto.getDepartureDate();
				    String time = departureDate.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm"));
				    jsonBuilder.append("{");
				    jsonBuilder.append("\"DEPR_TIME_DVS\":\"").append(time).append("\",");
				    jsonBuilder.append("\"CACM_MN\":\"").append(dto.getComName()).append("\",");
				    jsonBuilder.append("\"BUS_CLS_NM\":\"").append(dto.getBusGrade()).append("\",");
				    jsonBuilder.append("\"ADLT_FEE\":").append(dto.getAdultFare()).append(",");
				    jsonBuilder.append("\"CHLD_FEE\":").append(dto.getStuFare()).append(",");
				    jsonBuilder.append("\"TEEN_FEE\":").append(dto.getChildFare()).append(",");
				    jsonBuilder.append("\"RMN_SATS_NUM\":").append(dto.getRemainSeats()).append(",");
				    jsonBuilder.append("\"TOT_SATS_NUM\":").append(dto.getBusSeats());
				    jsonBuilder.append("}");

				    if (i < schList.size() - 1) {
				        jsonBuilder.append(",");
				    }
				}

				jsonBuilder.append("]");
				jsonBuilder.append("}");

				// 응답 출력
				PrintWriter out = response.getWriter();
				out.write(jsonBuilder.toString());
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
		
		if (sourcePage.equals("KOBUSreservation3.jsp")) {
			return "/koBusFile/KOBUSreservation2.jsp";
		} else {
			return "/koBusFile/kobusSchedule.jsp";
		}


		

	}

}
