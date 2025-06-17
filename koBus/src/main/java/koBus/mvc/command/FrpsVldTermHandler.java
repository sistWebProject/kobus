package koBus.mvc.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import net.sf.json.JSONObject;

public class FrpsVldTermHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();

            // 1. 클라이언트에서 전달된 값 받기
            String startDate = request.getParameter("startDate"); // 예: 20250612
            String periodStr = request.getParameter("period");    // 예: 30

            JSONObject result = new JSONObject();

            // 2. 유효성 체크
            if (startDate == null || periodStr == null) {
                result.put("rcvMsgNm", "시작일 또는 기간이 없습니다.");
                result.put("rotAllCnt", 0); // 구매 불가 상태로 응답
                out.print(result.toString());
                return null;
            }

            // 3. 종료일 계산
            int periodDays = Integer.parseInt(periodStr);
            String endDate = calculateEndDate(startDate, periodDays);
            String fulTerm = formatDate(startDate) + " ~ " + formatDate(endDate);

            // 4. JSON 응답 구성
            result.put("termSttDt", startDate); // 시작일
            result.put("timDte", endDate);      // 종료일
            result.put("fulTerm", fulTerm);     // 전체 유효기간 텍스트

            result.put("pubAmt", 45000);        // 가상의 금액
            result.put("rotAllCnt", 1);         // 1 이상이면 구매 가능
            result.put("adtnDupPrchYn", "N");   // 중복 구매 아님

            out.print(result.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // 시작일 + 기간 계산
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
