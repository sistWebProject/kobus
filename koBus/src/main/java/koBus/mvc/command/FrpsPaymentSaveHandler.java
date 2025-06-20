package koBus.mvc.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import koBus.mvc.domain.FreePassPaymentDTO;
import koBus.mvc.persistence.FreePassPaymentDAO;
import java.sql.Date;

public class FrpsPaymentSaveHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 파라미터 받아오기
        String userId = request.getParameter("user_id");
        String adtnPrdSno = request.getParameter("adtn_prd_sno");
        String impUid = request.getParameter("imp_uid");
        String merchantUid = request.getParameter("merchant_uid");
        String payMethod = request.getParameter("pay_method");
        int amount = Integer.parseInt(request.getParameter("amount"));
        String payStatus = request.getParameter("pay_status");
        String pgTid = request.getParameter("pg_tid");

        // paid_at : UNIX timestamp (초단위)면 변환 필요
        String paidAtStr = request.getParameter("paid_at");
        Date paidAt = null;
        if (paidAtStr != null && !paidAtStr.isEmpty()) {
            long ts = Long.parseLong(paidAtStr) * 1000L;
            paidAt = new Date(ts);
        }

        FreePassPaymentDTO dto = new FreePassPaymentDTO();
        dto.setUserId(userId);
        dto.setAdtnPrdSno(adtnPrdSno);
        dto.setImpUid(impUid);
        dto.setMerchantUid(merchantUid);
        dto.setPayMethod(payMethod);
        dto.setAmount(amount);
        dto.setPayStatus(payStatus);
        dto.setPgTid(pgTid);
        dto.setPaidAt(paidAt);

        FreePassPaymentDAO dao = new FreePassPaymentDAO();
        int result = dao.insert(dto);

        response.setContentType("application/json; charset=UTF-8");
        response.getWriter().write("{\"result\": " + result + "}");
        return null; // ajax이므로 별도 이동 없음
    }
}
