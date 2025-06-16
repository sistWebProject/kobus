package koBus.mvc.command;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.util.ConnectionProvider;

import koBus.mvc.domain.RegionDTO2;
import koBus.mvc.persistence.RegionDAO2;
import koBus.mvc.persistence.RegionDAOImpl2;


public class StationHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("> StationHandler.process() ...");
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		String regionCode = request.getParameter("regionCode");
		int sidoCode = 11;
		List<RegionDTO2> regionList = null;

		
		try(Connection conn = ConnectionProvider.getConnection();){
			RegionDAO2 dao = new RegionDAOImpl2(conn);
			
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

			
			String ajax = request.getParameter("ajax");

			System.out.println("ajax = " + ajax);

			if ("true".equalsIgnoreCase(ajax)) {
				Gson gson = new Gson();
				String json = gson.toJson(regionList);

				PrintWriter out = response.getWriter();
				out.write(json);
				out.close();
				// forward 하지 않음
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


		return "/koBusFile/kobusSchedule.jsp";

	}

}
