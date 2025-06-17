package koBus.mvc.persistence;

import java.sql.SQLException;
import java.util.HashMap;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.response.MultipleDetailMessageSentResponse;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;


public class CertificationCodeDAOImpl implements CertificationCodeDAO{

	// 전화번호 입력해서 인증번호받기 위해 유효성 검사한 인증번호 건네주는 함수
	@Override
	public String telCertificationNum(String inputNumber, int randomNumber) throws SQLException { 
		
		randomNumber = (int)((Math.random()*(9999-1000+1)) + 1000);
		String strRandomNumber = Integer.toString(randomNumber);
		
		String api_key = "NCSWFQ7FIGQ6B1L9";
	    String api_secret = "YTRCYGZJY5XDJNBW9LMBZQKDIAK72EBM";
	    DefaultMessageService messageService = NurigoApp.INSTANCE.initialize(
	    		api_key,
	    		api_secret,
	            "https://api.coolsms.co.kr"
	        );
	    
	    Message message = new Message();
        message.setFrom("01044232801");  // 사전에 등록된 번호
        message.setTo(inputNumber);    // 예: 01012345678
        message.setText("[코드] 인증번호는 ["+ strRandomNumber +"] 입니다.");
        
        try {
            MultipleDetailMessageSentResponse response = messageService.send(message);
            System.out.println(response);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return strRandomNumber;
	
	}

}
