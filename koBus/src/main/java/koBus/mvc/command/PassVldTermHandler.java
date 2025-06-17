package koBus.mvc.command;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

public class PassVldTermHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 1. 요청값 받기
        String startDate = request.getParameter("startDate"); // 예: "20250618"
        String periodStr = request.getParameter("period");    // 예: "5"

        JSONObject termMap = new JSONObject();

        try {
            if (startDate == null || periodStr == null) {
                termMap.put("error", "startDate 또는 period 누락");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            } else {
                // 2. 종료일 계산
                int periodDays = Integer.parseInt(periodStr);
                String endDate = calculateEndDate(startDate, periodDays);

                // 3. 전체 유효기간 텍스트 만들기
                String fulTerm = formatDate(startDate) + " ~ " + formatDate(endDate);

                // 4. 응답 데이터 구성
                termMap.put("termSttDt", startDate);
                termMap.put("timDte", endDate);
                termMap.put("fulTerm", fulTerm);
                termMap.put("pubAmt", 45000); // 임의의 가격
                termMap.put("rotAllCnt", 1);  // 노선 개수 ≥ 1
                termMap.put("adtnDupPrchYn", "N"); // 중복 구매 여부
            }

            // 5. 응답 전송
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print(termMap.toString());
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "서버 오류 발생");
        }

        return null; // Ajax 응답이라 JSP 이동 없음
    }

    // 시작일 + N일 후 날짜 구하기
    private String calculateEndDate(String startDateStr, int days) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date startDate = sdf.parse(startDateStr);
        Calendar cal = Calendar.getInstance();
        cal.setTime(startDate);
        cal.add(Calendar.DATE, days - 1); // 시작일 포함
        return sdf.format(cal.getTime());
    }

    // yyyyMMdd → yyyy.MM.dd 포맷 변경
    private String formatDate(String dateStr) throws Exception {
        SimpleDateFormat sdfIn = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat sdfOut = new SimpleDateFormat("yyyy.MM.dd");
        return sdfOut.format(sdfIn.parse(dateStr));
    }
}