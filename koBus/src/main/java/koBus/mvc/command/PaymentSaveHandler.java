package koBus.mvc.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import koBus.mvc.persistence.PaymentDAO;
import koBus.mvc.persistence.ReservationDAO;
import koBus.mvc.domain.PaymentDTO;
import koBus.mvc.domain.ReservationDTO;

import java.sql.Date;
import java.util.UUID;

public class PaymentSaveHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 1. 세션에서 userId 추출 (로그인 필요)
        // String userId = (String) request.getSession().getAttribute("userId");
        /*
        if (userId == null) {
            response.setStatus(401); // 인증 오류
            response.getWriter().write("로그인 필요");
            return null;
        }
		*/
        
        // 임시 결제 db저장 확인용 로그인값(합칠땐 지우고 위 로그인 인증코드 활성화!)
        String userId = (String) request.getSession().getAttribute("userId");
        if (userId == null) {
            // ★ 테스트용! 실제 배포 전엔 꼭 삭제
            userId = "KUS001"; // 또는 실제 존재하는 아이디
        }
        
        // 2. 결제 파라미터 추출
        String impUid = request.getParameter("imp_uid");
        String merchantUid = request.getParameter("merchant_uid");
        String payMethod = request.getParameter("pay_method");
        String amountStr = request.getParameter("amount");
        String payStatus = request.getParameter("pay_status");
        String pgTid = request.getParameter("pg_tid");
        String paidAtStr = request.getParameter("paid_at");

        int amount = 0;
        try {
            amount = Integer.parseInt(amountStr);
        } catch (Exception e) {
            response.setStatus(400);
            response.getWriter().write("금액 오류");
            return null;
        }
        
        System.out.println("1. paidAtStr: " + paidAtStr);

        Date paidAt = null;
        if (paidAtStr != null && !paidAtStr.isEmpty()) {
            try {
                long paidAtMillis = Long.parseLong(paidAtStr) * 1000L;
                paidAt = new java.sql.Date(paidAtMillis);
                System.out.println("2. 변환된 paidAt(java.sql.Date): " + paidAt);
            } catch (Exception e) {
                paidAt = null;
                System.out.println("3. paidAt 변환 실패! " + e.getMessage());
            }
        }

        // 3. 결제 DTO 생성
        PaymentDTO payDto = new PaymentDTO();
        payDto.setUserId(userId);
        payDto.setImpUid(impUid);
        payDto.setMerchantUid(merchantUid);
        payDto.setPayMethod(payMethod);
        payDto.setAmount(amount);
        payDto.setPayStatus(payStatus);
        payDto.setPgTid(pgTid);
        payDto.setPaidAt(paidAt);
        System.out.println("4. payDto.getPaidAt(): " + payDto.getPaidAt());

        // 4. 예매 파라미터 추출 (프론트에서 같이 전달해야 함)
        String bshID = request.getParameter("bshID");
        String seatID = request.getParameter("seatID");
        String rideDateStr = request.getParameter("rideDate"); // "yyyy-MM-dd"
        String resvType = request.getParameter("resvType");     // (옵션, 예매타입 등)
        int mileage = 0;
        try {
            String mileageStr = request.getParameter("mileage");
            if (mileageStr != null) mileage = Integer.parseInt(mileageStr);
        } catch (Exception e) { mileage = 0; }

        // 예매 정보 자동 생성
        String resID = UUID.randomUUID().toString();
        Date rideDate = (rideDateStr != null && !rideDateStr.isEmpty()) ? Date.valueOf(rideDateStr) : null;
        Date resvDate = new Date(System.currentTimeMillis());
        String resvStatus = "결제완료";
        String seatAble = "Y";
        int qrCode = (int)(Math.random() * 900000) + 100000; // 6자리 랜덤 QR

        ReservationDTO resvDto = new ReservationDTO();
        resvDto.setResID(resID);
        resvDto.setBshID(bshID);
        resvDto.setSeatID(seatID);
        resvDto.setKusID(userId);
        if (rideDate == null) {  // 테스트용 임시
            rideDate = new java.sql.Date(System.currentTimeMillis()); // 오늘 날짜
        }
        resvDto.setRideDate(rideDate);
        resvDto.setResvDate(resvDate);
        resvDto.setResvStatus(resvStatus);
        resvDto.setResvType(resvType);
        resvDto.setQrCode(qrCode);
        resvDto.setMileage(mileage);
        resvDto.setSeatAble(seatAble);

        // 5. 결제와 예매 모두 저장 (트랜잭션 처리함)
        PaymentDAO dao = new PaymentDAO();
        boolean result = dao.insertPaymentAndReservation(payDto, resvDto);
        // result가 true면 둘 다 성공, 아니면 둘 중 하나라도 실패

        // 6. 결과 반환 (둘 다 성공해야 OK)
        response.setContentType("application/json;charset=UTF-8");
        if (result) {
            response.getWriter().write("{\"result\":\"ok\"}");
        } else {
            response.setStatus(500);
            response.getWriter().write("{\"result\":\"fail\"}");
        }

        return null; // AJAX 응답, JSP 이동 안함
    }
}
