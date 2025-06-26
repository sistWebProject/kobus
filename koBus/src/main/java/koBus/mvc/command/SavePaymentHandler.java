package koBus.mvc.command;

import java.sql.Date;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import koBus.mvc.domain.BusPaymentDTO;
import koBus.mvc.domain.BusReservationDTO;


public class SavePaymentHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");

        // 1. 결제 관련 파라미터 수신
        String imp_uid = request.getParameter("imp_uid");
        String merchant_uid = request.getParameter("merchant_uid");
        String pay_method = request.getParameter("pay_method");
        String amountStr = request.getParameter("amount");
        String pay_status = request.getParameter("pay_status");
        String pg_tid = request.getParameter("pg_tid");
        String paid_at_str = request.getParameter("paid_at");
        String user_id = request.getParameter("user_id");
        String resId = request.getParameter("resId"); // JS에서 넘긴 고유 예매ID

        int amount = Integer.parseInt(amountStr);
        long paidAtMillis = Long.parseLong(paid_at_str) * 1000L;
        Date paid_at = new Date(paidAtMillis);

        // 2. BusReservationDTO 생성
        BusReservationDTO rDto = new BusReservationDTO();
        rDto.setResId(resId); // JS에서 생성한 UUID 등 사용
        rDto.setUserId(user_id);
        rDto.setBshID(request.getParameter("bshid"));
        rDto.setSeatNumber(request.getParameter("seat_number"));
        String boardingDtRaw = request.getParameter("boarding_dt");
        System.out.println("🛑 [DEBUG] 받은 boarding_dt 파라미터: " + boardingDtRaw);

        if (boardingDtRaw != null) {
            if (boardingDtRaw.contains("T")) {
                boardingDtRaw = boardingDtRaw.replace("T", " ");
            }
            if (boardingDtRaw.length() == 16) {
                boardingDtRaw += ":00";
            } else if (boardingDtRaw.length() == 10) {
                boardingDtRaw += " 00:00:00";
            }
        }

        Timestamp boardingDt = Timestamp.valueOf(boardingDtRaw);
        rDto.setBoardingDt(boardingDt);

        rDto.setTotalPrice(amount);

        // 3. BusPaymentDTO 생성
        BusPaymentDTO pDto = new BusPaymentDTO();
        pDto.setResId(resId); // 위 예매 resId와 동일하게 설정
        pDto.setUserId(user_id);
        pDto.setImpUid(imp_uid);
        pDto.setMerchantUid(merchant_uid);
        pDto.setPayMethod(pay_method);
        pDto.setAmount(amount);
        rDto.setResvStatus("결제완료");
        pDto.setPayStatus(pay_status);
        pDto.setPgTid(pg_tid);
        pDto.setPaidAt(paid_at);

        // 4. Service를 통한 트랜잭션 처리
        BusPaymentService service = new BusPaymentService();
        boolean success = service.insertReservationAndPayment(rDto, pDto);

        // 5. 응답
        response.setContentType("application/json; charset=UTF-8");
        response.getWriter().write("{\"result\": " + (success ? 1 : 0) + "}");

        return null; // AJAX 응답이므로 null 반환
    }
}
