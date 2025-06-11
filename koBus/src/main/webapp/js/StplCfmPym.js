/* 전역변수 : 모든 전역변수에 접두사로 all 사용
 * 최종확인변수 : 모든 변수에 접미사 cfm 사용 
 */
$(document).ready(function() {
	
	fnAdtnPrdNewChk();
		
	if ($('#extrComp').val() == 'ARMY'){
		fnMblTck('CHG');
		$("#mblTckYn").css("display","none");
		// 결제정보
		$('#payTyepAllUl').css("display","none");
		$('#tab1').css("display","none");
		$('#tab7').css("display","block");
	}
	else{
		//$("#payType1").attr("checked",true); //기본 카드결제 체크
		$("#payType1").trigger("click"); //기본 카드결제 체크
		/*
		if($("#mblUtlzPsbYnOrg").val() == "N"){
			fnMblTck('CHG');
			$("#mblTckYn").css("display","none");
		}else{
		*/
			if($("#mblTissuYn").val()=="N"){
				fnMblTck('CHG');// 기본 홈티켓
				$("#mblTckYn").css("display","block");
			}else{
				var mblTckOpenYn = "Y";
				
				/**
				 * 20200709 yahan
				 * 남윤주과장 요청으로 미사용
				if($("#tlcnTrcnUtlzPsbYn").val() == "N"){ //통합단말기가 없는 경우 모바일 발권 불가
					mblTckOpenYn = "N";
				}
				*/
				
					//위의 조건에 걸리면 모바일 반권불가, 자동으로 일반티켓으로 변경처리
				if(mblTckOpenYn != "Y"){
					fnMblTck('CHG');
					$("#mblTckYn").css("display","none");
				}else{
					fnMblTck('CAN');// 기본 모바일티켓설정
					$("#mblTckYn").css("display","block");
				}
			}
		/*
		}
		*/
	}

	// 할부 활성/비활성 제어 (20190517 수정)
	if($("#pathDvs").val() != "rtrp"){
		if(Number($("#tissuAmt").val()) > 50000){
			$("#mipMmSel").css("display","block");
		}
	}else{ // 왕복일경우
		var rtrpDtl1 = ($("#rtrpDtl1").val());
		var arrDtl1 = rtrpDtl1.split(':');
		var rtrpDtl2 = ($("#rtrpDtl2").val());
		var arrDtl2 = rtrpDtl2.split(':');
		
		var goAmt = arrDtl1[12];		// 왕편 결제금액
		var backAmt = arrDtl2[12];	// 복편 결제금액
		
		//if($("#ctyPrmmDcYn").val() == "Y"){ //시외우등 왕복일경우
		//20211222 왕복할인이 일때는 총합으로 할부 표시 
		if($("#prmmDcDvsCd").val() == "4"){
			if(Number($("#tissuAmt").val()) > 50000){
				$("#mipMmSel").css("display","block");
			}
		}else{	//일반 왕복일 경우
			if(goAmt > 50000 && backAmt > 50000){ // 왕편 복편 둘다 50000 이상일 경우에만 할부 가능 
				$("#mipMmSel").css("display","block");
			}
		}
	}
	
	var takeDrtmAll = Number($("#takeDrtmOrg").val()); //전체소요시간
	var takeDrtm = "";
	var takeDrtmHH = parseInt(takeDrtmAll/60) ; 
	if(takeDrtmHH > 0){
		takeDrtm = parseInt(takeDrtmAll/60)+"시간 "+(takeDrtmAll%60)+"분 소요";
	}else{
		takeDrtm = (takeDrtmAll%60)+"분 소요";
	}
	$("#takeDrtm").text(takeDrtm); //소요시간
	$("#takeDrtm2").text(takeDrtm); //소요시간
	
	var selAdltCnt = $("#selAdltCnt").val();
	var selAdltDcCnt = $("#selAdltDcCnt").val();
	var selChldCnt = $("#selChldCnt").val();
	var selTeenCnt = $("#selTeenCnt").val();
	var selUvsdCnt = $("#selUvsdCnt").val();
	var selSncnCnt = $("#selSncnCnt").val();
	var selDsprCnt = $("#selDsprCnt").val();
	// 20210525 yahan
	var selVtr3Cnt = $("#selVtr3Cnt").val();
	var selVtr5Cnt = $("#selVtr5Cnt").val();
	var selVtr7Cnt = $("#selVtr7Cnt").val();
	
	var selDfptCnt = $("#selDfptCnt").val();
	
	var totSelCnt = "";	
	
	var totCnt = Number(selAdltCnt)+Number(selAdltDcCnt)+Number(selChldCnt)+Number(selTeenCnt)+Number(selUvsdCnt)+Number(selSncnCnt)+Number(selDsprCnt)
					+Number(selVtr3Cnt)+Number(selVtr5Cnt)+Number(selVtr7Cnt)+Number(selDfptCnt);
	
	
	
	if(selAdltCnt > 0 || selAdltDcCnt > 0){
		var adltCnt = Number(selAdltCnt)+Number(selAdltDcCnt);
		totSelCnt += "일반 "+adltCnt+"명, ";
		if(adltCnt > 1){ //마일리지 발권 불가 
			 $(this).find('.mileage').hide();
		}
	}
	if(totCnt > 1 || selUvsdCnt > 0 || selChldCnt > 0 || selTeenCnt > 0){ //마일리지 발권 불가 
		 $(this).find('.mileage').hide();
	}
	
	if(selUvsdCnt > 0){
		// 20240608 건보공단
		var txt = "대학생";
		if ($("#deprCd").val() == '246' || $("#arvlCd").val() == '246' || $("#deprCd").val() == '244' || $("#arvlCd").val() == '244') txt = "건보공단";
		totSelCnt += txt+" "+selUvsdCnt+"명, ";
	}
	if(selTeenCnt > 0){
		totSelCnt += "중고생 "+selTeenCnt+"명, ";
	}
	if(selChldCnt > 0){
		totSelCnt += "초등생 "+selChldCnt+"명, ";
	}
	if(selSncnCnt > 0){
		totSelCnt += "경로 "+selSncnCnt+"명, ";
	}
	if(selDsprCnt > 0){
		totSelCnt += "장애인 "+selDsprCnt+"명, ";
	}
	// 20210525 yahan
	if(selVtr3Cnt > 0){
		totSelCnt += "보훈30 "+selVtr3Cnt+"명, ";
	}
	if(selVtr5Cnt > 0){
		totSelCnt += "보훈50 "+selVtr5Cnt+"명, ";
	}
	if(selVtr7Cnt > 0){
		totSelCnt += "보훈70 "+selVtr7Cnt+"명, ";
	}
	if(selDfptCnt > 0){
		totSelCnt += "후불 "+selDfptCnt+"명, ";
	}

	if(totSelCnt.length > 0){
		totSelCnt = totSelCnt.substring(0, (totSelCnt.length -2));
	}
	if($("#pathDvs").val() != "rtrp" || $("#pathStep").val() != 2){
	//	$("#totSelCntView2").text(totSelCnt);
	//}else{
		$("#totSelCntView").text(totSelCnt);
	}
	if(Number($("#estmAmt").val()) > 0){
		$("#estmAmtView").text(comma($("#estmAmt").val())+"원");
	}
	if(Number($("#dcAmt").val()) > 0){
		$("#dcAmtView").text("-"+comma($("#dcAmt").val())+"원");
	}else{
		$("#dcAmtView").text("0원");
	}
	if(Number($("#tissuAmt").val()) > 0){
		$("#tissuAmtView").text(comma($("#tissuAmt").val())+"원");
	}
	payH();
//	payH($(window).width());
	if($("#mblUtlzPsbYnOrg").val() == "N"){
		$("#unmnTerView").css("display","none");
		$("#rtrpTckYn").css("display","none");
		$("#IEChcView").css("display","none");
		$("#noMobileTck").css("display","block");
	}else{
		if($("#unmnTerYn").val() == "N" && $("#rtrpYn").val() == "N"){
			var uaChecHead = window.navigator.userAgent;
			// 20240527 크롬 계좌이체 허용
			//if(uaChecHead.indexOf('MSIE') <= 0 && uaChecHead.indexOf('Trident') <= 0)
			{ // IE 브라우저 체크
				$("#unmnTerView").css("display","none");
				$("#rtrpTckYn").css("display","none");
				
				if ($('#extrComp').val() == ''){
					//$("#IEChcView").css("display","block");
					$("#IEChcView").css("display","none");
				}
				
				$("#noMobileTck").css("display","none");
				//$("#payTypeAcnt").css("display","none");
			}
		}else{
			if($("#unmnTerYn").val() == "Y" || $("#tlcnTrcnUtlzPsbYn").val() == "N" || $("#prmmDcDvsCd").val() != "0"){
				$("#unmnTerView").css("display","block");
				$("#rtrpTckYn").css("display","none");
				$("#IEChcView").css("display","none");
				$("#noMobileTck").css("display","none");
			}
			if($("#rtrpYn").val() == "Y"){
				$("#unmnTerView").css("display","none");
				$("#rtrpTckYn").css("display","block");
				$("#IEChcView").css("display","none");
				$("#noMobileTck").css("display","none");
			}
		}
	}
	
	$("#agreeAll").on('click',function(){
		fnChgCfmBtn();
	});
	
	//이지노선 계좌이체 임시 불럭
	/*if($("#deprCd").val() == "190" ||
		$("#deprCd").val() == "398" ||
		$("#deprCd").val() == "399" ||
		$("#deprCd").val() == "535" ||
		$("#deprCd").val() == "550" ||
		$("#deprCd").val() == "560" ||
		$("#deprCd").val() == "575" ||
		$("#deprCd").val() == "578" ||
		$("#deprCd").val() == "580" ||
		$("#deprCd").val() == "590" ||
		$("#deprCd").val() == "635" ||
		$("#deprCd").val() == "640" ||
		$("#deprCd").val() == "420" ||
		$("#deprCd").val() == "389" ||
		$("#deprCd").val() == "390" ||
		$("#deprCd").val() == "391" ||
		$("#deprCd").val() == "312" ||
		$("#deprCd").val() == "388" ||
		$("#deprCd").val() == "397" ||
		$("#deprCd").val() == "313" ||
		$("#deprCd").val() == "394" ||
		$("#deprCd").val() == "396" ||
		$("#deprCd").val() == "020" ||
		$("#deprCd").val() == "030" ||
		$("#deprCd").val() == "031" ||
		$("#deprCd").val() == "032" ||
		$("#deprCd").val() == "035" ||
		$("#deprCd").val() == "309" ||
		$("#deprCd").val() == "310" 
	){*/
	fnEzCheck();
});

//2018.01.19 이지노선 수정
function fnEzCheck(){
	
	/**
	 * 20200709 yahan
	 * 홈티켓가능여부 적용 htckUseYn

	// 20200622 yahan
	// 홈티켓 불가노선 처리...
	if(
			$("#deprCd").val() == "020" && $("#arvlCd").val() != "500" || // 센트럴-광주노선 제외 20200622 yahan
			$("#deprCd").val() == "032" ||
			$("#deprCd").val() == "190" ||
			$("#deprCd").val() == "310" ||
			$("#deprCd").val() == "420" ||
			$("#deprCd").val() == "399" ||
			$("#deprCd").val() == "398" ||
			$("#deprCd").val() == "390" ||
			$("#deprCd").val() == "389" ||
			$("#deprCd").val() == "391" ||
			$("#deprCd").val() == "312" ||
			$("#deprCd").val() == "388" ||
			$("#deprCd").val() == "397" ||
			$("#deprCd").val() == "393" ||
			$("#deprCd").val() == "394" ||
			$("#deprCd").val() == "396" ||
			$("#deprCd").val() == "535" ||
			$("#deprCd").val() == "550" ||
			$("#deprCd").val() == "560" ||
			$("#deprCd").val() == "575" ||
			$("#deprCd").val() == "578" ||
			$("#deprCd").val() == "580" ||
			$("#deprCd").val() == "590" ||
			$("#deprCd").val() == "635" ||
			$("#deprCd").val() == "640" ||
			$("#deprCd").val() == "401" ||
			$("#deprCd").val() == "405" ||
			$("#deprCd").val() == "407" 
		){
	*/
	if ($("#htckUseYn").val() != "Y" ){
		
		$("#mblTckYn").css("display","none");
		// 20200622 yahan
		//$(this).find('.pay_account').hide();
		$('.inradio .tabs').each(function(){
			var tabCnt = $(this).find('li:visible').size();
			var agent = navigator.userAgent.toLowerCase();
			// 20200622 yahan
//			//$(this).find('.pay_account').hide();
//			if ( winW > 767) {
//				if($("#rtrpYn").val() == "N"){
//					 //tabCnt = tabCnt -1;
//				}
//			}
			$(this).addClass('col'+tabCnt);
		});
	}
	
	// 20200622 yahan 이지노선 계좌이체 불가
	if (
			$("#deprCd").val() == "020" ||
			$("#deprCd").val() == "032" ||
			$("#deprCd").val() == "190" ||
			$("#deprCd").val() == "310" ||
			$("#deprCd").val() == "420" ||
			$("#deprCd").val() == "399" ||
			$("#deprCd").val() == "398" ||
			$("#deprCd").val() == "390" ||
			$("#deprCd").val() == "389" ||
			$("#deprCd").val() == "391" ||
			$("#deprCd").val() == "312" ||
			$("#deprCd").val() == "388" ||
			$("#deprCd").val() == "397" ||
			$("#deprCd").val() == "393" ||
			$("#deprCd").val() == "394" ||
			$("#deprCd").val() == "396" ||
			$("#deprCd").val() == "535" ||
			$("#deprCd").val() == "550" ||
			$("#deprCd").val() == "560" ||
			$("#deprCd").val() == "575" ||
			$("#deprCd").val() == "578" ||
			$("#deprCd").val() == "580" ||
			$("#deprCd").val() == "590" ||
			$("#deprCd").val() == "635" ||
			$("#deprCd").val() == "640" ||
			$("#deprCd").val() == "401" ||
			$("#deprCd").val() == "405" ||
			$("#deprCd").val() == "407" ||
			$("#deprCd").val() == "244" || 	// 원주혁신
			$("#deprCd").val() == "246"		// 원주기업도시
		){
		// $("#payTypeAcnt").css("display","none");
	}
}

function  fnChkNext(obj,nextFld){
// 20241004 웹접근성 제외	
//	// 20201124 yahan
//	if($(obj).val().length == $(obj).attr("maxlength")){
//		$("#"+nextFld).val('');
//		$("#"+nextFld).focus();
//	}
}




function requestPay() {
    var IMP = window.IMP;
    IMP.init('imp31168041'); // 테스트용 가맹점 식별코드

    IMP.request_pay({
        pg: 'html5_inicis.INIpayTest',
        pay_method: ['card', 'trans'],
        merchant_uid: 'ORD_TEST_' + new Date().getTime(),
        name: '테스트 상품명',
        amount: 100,
        buyer_email: 'testuser@example.com',
        buyer_name: '테스트 사용자',
        buyer_tel: '010-1234-5678',
        buyer_addr: '테스트시 테스트구 테스트동',
        buyer_postcode: '12345'
    }, function (rsp) {
        if (rsp.success) {
            alert('테스트 결제 성공! imp_uid: ' + rsp.imp_uid);
            console.log('결제 응답:', rsp);
        } else {
            var msg = '테스트 결제에 실패하였습니다.';
            msg += '\n에러 내용: ' + rsp.error_msg;
            alert(msg);
            console.error('결제 실패 응답:', rsp);
        }
    });
}


var check = 0;	
function fnLgnNonUsr(){ //신규접속 비회원 (중복가입방지 check)
	if(check == 0){
		check++;
		var phoneNum1Val = $("#phoneNum11").val()+""+$("#phoneNum12").val()+""+$("#phoneNum13").val();
		$("#nombrsid").val(phoneNum1Val);
		$("#nombrspass").val($("#nonMbrsPw").val());
		
		var nonMbrsLgnFrm = $("form[name=nonMbrsLgnFrm]").serialize() ;
		$.ajax({	
	        url      : "/mbrs/lgn/NonUsrInsert.ajax",
	        type     : "post",
	        data : nonMbrsLgnFrm,
	        dataType : "json",
	        async    : true,
	        success  : function(lgnNonUsrCfmMap){
		           	
		       	if(lgnNonUsrCfmMap.resultStatus=="Y"){
		       		fnStplCfm();
		       	}else{
		       		$("#loading").hide();
		       		alert(lgnNonUsrCfmMap.err_msg);
		       		$("#phoneNum12").focus();
		       		return;
		       	}
	        },
	        error : function (e){
	        	$("#loading").hide();
	            alert("잠시 후 다시 이용하여 주시기 바랍니다.");
	            return;
	        }
		});
	}
}



function fnStplCfm(){
	if($("input:radio[id='payType5']").is(":checked")){
		$("#loading").hide();
		if(!fnVldtMileage()){
			return;
		}
		var popMileage = $('[data-remodal-id=popMileageCanc]').remodal().open();
	}else{
		var payType = '';
		$("#loading").hide();
		
		if($("input:radio[id='payType6']").is(":checked")){ // 간편결제
			if(!fnVldtPay()){
				return;
			}
			payType="pay";
		}
		else if($("input:radio[id='payType1']").is(":checked")){ // 카드결제 체크
			if(!fnVldtCard()){
				return;
			}
			payType="card";
		}else if($("input:radio[id='payType2']").is(":checked")){
			if(!fnVldtAcnt()){
				return;
			}
			payType="acnt";		
		}else if($("input:radio[id='payType3']").is(":checked")){
			payType="perd";			
			if(!fnVldtAdtnPrd(payType)){
				return;
			}else{				
				//alert("부가상품 권종과 일치하지 않는 경우 부가상품 권종으로 변경되어 발권됩니다.");
				/*if($("#selUvsdCnt").val() > 0 || $("#selTeenCnt").val() > 0 || $("#selChldCnt").val() > 0 || $("#selSncnCnt").val() > 0 || $("#selDsprCnt").val() > 0){
					alert("정기권으로 결제시 일반권으로 변경되어 발권됩니다.");
				}	*/			
				$("#userDvsCd").val("1"); //부가상품 개인만
			}
		}else if($("input:radio[id='payType4']").is(":checked")){
			payType="frps";	
			if(!fnVldtAdtnPrd(payType)){
				return;
			}else{				
				if($("#selUvsdCnt").val() > 0 || $("#selTeenCnt").val() > 0 || $("#selChldCnt").val() > 0 || $("#selSncnCnt").val() > 0 || $("#selDsprCnt").val() > 0 ||
						$("#selVtr3Cnt").val() > 0 || $("#selVtr5Cnt").val() > 0 || $("#selVtr7Cnt").val() > 0 || $("#selDfptCnt").val() > 0){
					alert("프리패스로 결제시 일반권으로 변경되어 발권됩니다.");
				}				
				$("#userDvsCd").val("1"); //부가상품 개인만
			}
		}
		if($("input:radio[id='moTicket']").is(":checked") == true){
			$("#mblUtlzPsbYn").val("Y");
		}else if($("input:radio[id='nomalTicket']").is(":checked") == true){
			$("#mblUtlzPsbYn").val("N");
		}
		
		if ($('#extrComp').val() == 'ARMY'){
			payType = 'dfpt';
		}
		
		$("#pymType").val(payType);

// 20200807 yahan 문구삭제
//		// 다인 예매일 경우
//		if($("#selSeatCnt").val() > 1){
//			alert("다인표 부분 취소 시 시간변경이 불가합니다.");
//		}
		
		if(!confirm("결제하시겠습니까?")){
			return;
		}

		// 계좌이체 도중에 결제종류 탭글릭 방지
		$("#loading").show();
		if(payType == "acnt"){ // 계좌이체
			fnAcntTrnPg();	
		} else if(payType == "pay"){ // 간편결제
			fnPayPymWin();	
		} else {
			fnStplCfmPym();
		}
	}
}


function fnStplCfmPym(){
	// 계좌이체 도중에 결제종류 탭글릭 방지
	//$("#loading").show();
	
	//카드번호 암호화 (181227)
	var rsa = new RSAKey();
	rsa.setPublic($("#RSAModulus").val(),$("#RSAExponent").val());		
	$("#allCardNum").val(rsa.encrypt($("#allCardNum").val()));	
	
	var stplCfmPymFrm = $("form[name=stplCfmPymFrm]").serialize() ;
	
	$.ajax({	
        url      : "/mrs/tissuFnDt.ajax",
        type     : "post",
        data : stplCfmPymFrm,
        dataType : "json",
        async    : true,
        success  : function(tissuFnDtMap){
        	var failCd  = tissuFnDtMap.MSG_CD;
        	var failMsg = tissuFnDtMap.MSG_NM;
        	if(failCd == "FEEINFOERR"){
        		$("#loading").hide();
        		
        		// 20240527 계좌이체 실패시 자동취소 추가
        		if ($('#pymType').val() == 'acnt'){
    				var acntDtaPupFrm = $("form[name=acntDtaPupFrm]").serialize() ;
    				$.ajax({	
    			        url      : "/mrs/acntPymCanc.ajax",
    			        type     : "post",
    			        data : acntDtaPupFrm,
    			        dataType : "json",
    			        async    : true,
    			        success  : function(acntCancMap){
    			        	var resultCd  = acntCancMap.ResultCode;
    			        	var resultMsg = acntCancMap.ResultMsg;
    			        	// 결과코드 (취소성공: 2001, 취소진행중: 2002, 기취소성공: 2015)
    			        	if(resultCd == "2001" || resultCd == "2002" || resultCd == "2015"){
    			        		alert(failMsg + "\n\n※계좌이체 결제 취소가 완료되었습니다.");
    			        	}else{
    			        		alert(failMsg + "\n\n★계좌이체 결제 취소에 실패했습니다.\n  ⇒" + resultMsg);
    			        	}
    			        },
    			        error : function(){
    			        	alert(failMsg + "\n\n★계좌이체 결제 취소에 실패했습니다.\n  ⇒예매내역과 결제내역을 꼭 확인해주세요.");
    			        }
    				});
        		}
        		else
        			alert(failMsg);
        			
        		$('#caPerson').focus();
        		return;
        	}else{
	        	//$("#tissuFnAllData").val(tissuFnDtMap);
	        	$("#tissuFnfailYn").val(tissuFnDtMap.failYn);
	        	$("#tissuFnrtnMsgNm").val(tissuFnDtMap.tissuInfMap.rtnMsgNm);
	        	$("#tissuFnrtnDtlMsgNm").val(tissuFnDtMap.tissuInfMap.rtnDtlMsgNm);
	        	var tissuFnLen = tissuFnDtMap.pymCfmlListLn;
	        	var htckPsbYn = "Y";
	        	for(var inx = 0 ; inx < tissuFnLen ; inx++){
	        		if(inx == 0){
	        			$("#tissuFndeprDtDtl1").val(tissuFnDtMap.pymCfmlList[inx].DEPR_DT_DTL);
	        			$("#tissuFndeprTimeDtl1").val(tissuFnDtMap.pymCfmlList[inx].DEPR_TIME_DTL);
	        			$("#tissuFnmrsMrnpNo1").val(tissuFnDtMap.pymCfmlList[inx].MRS_MRNP_NO);
	        			$("#tissuFndeprTrmlNm1").val(tissuFnDtMap.pymCfmlList[inx].DEPR_TRML_NM);
	        			$("#tissuFnarvlTrmlNm1").val(tissuFnDtMap.pymCfmlList[inx].ARVL_TRML_NM);
	        			$("#tissuFntakeDrtm1").val(tissuFnDtMap.pymCfmlList[inx].takeDrtm);
	        			$("#tissuFncacmNm1").val(tissuFnDtMap.pymCfmlList[inx].CACM_NM);
	        			$("#tissuFncacmCss1").val(tissuFnDtMap.pymCfmlList[inx].CACM_CSS);
	        			$("#tissuFnbusClsNm1").val(tissuFnDtMap.pymCfmlList[inx].BUS_CLS_NM);
	        			$("#tissuFnrotRdhmNo1").val(tissuFnDtMap.pymCfmlList[inx].ROT_RDHM_NO_VAL);
	        			$("#tissuFnmrsNumAll1").val(tissuFnDtMap.pymCfmlList[inx].MRS_NUM_ALL);
	        			$("#tissuFnsatsNo1").val(tissuFnDtMap.pymCfmlList[inx].SATS_NO);
	        		}else{
	        			$("#tissuFndeprDtDtl2").val(tissuFnDtMap.pymCfmlList[inx].DEPR_DT_DTL);
	        			$("#tissuFndeprTimeDtl2").val(tissuFnDtMap.pymCfmlList[inx].DEPR_TIME_DTL);
	        			$("#tissuFnmrsMrnpNo2").val(tissuFnDtMap.pymCfmlList[inx].MRS_MRNP_NO);
	        			$("#tissuFndeprTrmlNm2").val(tissuFnDtMap.pymCfmlList[inx].DEPR_TRML_NM);
	        			$("#tissuFnarvlTrmlNm2").val(tissuFnDtMap.pymCfmlList[inx].ARVL_TRML_NM);
	        			$("#tissuFntakeDrtm2").val(tissuFnDtMap.pymCfmlList[inx].takeDrtm);
	        			$("#tissuFncacmNm2").val(tissuFnDtMap.pymCfmlList[inx].CACM_NM);
	        			$("#tissuFncacmCss2").val(tissuFnDtMap.pymCfmlList[inx].CACM_CSS);
	        			$("#tissuFnbusClsNm2").val(tissuFnDtMap.pymCfmlList[inx].BUS_CLS_NM);
	        			$("#tissuFnrotRdhmNo2").val(tissuFnDtMap.pymCfmlList[inx].ROT_RDHM_NO_VAL);
	        			$("#tissuFnmrsNumAll2").val(tissuFnDtMap.pymCfmlList[inx].MRS_NUM_ALL);
	        			$("#tissuFnsatsNo2").val(tissuFnDtMap.pymCfmlList[inx].SATS_NO);
	        		}
	        		if(tissuFnDtMap.pymCfmlList[inx].HTCK_PSB_YN != "Y"){
	        			htckPsbYn = "N";
	        		}
	        	}
	        	$("#tissuFnpymCfmTime").val(tissuFnDtMap.tissuInfMap.pymCfmTime);
	        	$("#tissuFnpymType").val(tissuFnDtMap.tissuInfMap.pymType);
	        	$("#tissuFnpynDtlCd").val(tissuFnDtMap.tissuInfMap.pynDtlCd);
	        	$("#tissuFnmblUtlzPsbYn").val(tissuFnDtMap.tissuInfMap.mblUtlzPsbYn);
	        	$("#tissuFnpsrmCls").val(tissuFnDtMap.tissuInfMap.psrmCls);
	        	$("#tissuFnestmAmt").val(tissuFnDtMap.tissuInfMap.estmAmt);
	        	$("#tissuFndcAmt").val(tissuFnDtMap.tissuInfMap.dcAmt);
	        	$("#tissuFntissuAmt").val(tissuFnDtMap.tissuInfMap.tissuAmt);
	        	$("#tissuFnacmtMlg").val(tissuFnDtMap.tissuInfMap.acmtMlg);
	        	$("#tissuFnmrsMrnpNoOrg").val(tissuFnDtMap.tissuInfMap.mrsMrnpNoOrg);
	        	$("#tissuFnrecNcnt1").val(tissuFnDtMap.recNcnt1);
	        	$("#tissuHtckPsbYn").val(htckPsbYn);
	        	
	        	if(tissuFnDtMap.tkn != null && tissuFnDtMap.tkn != ""){
	        		if($("#deprCd").val() == tissuFnDtMap.deprCd && $("#arvlCd").val() == tissuFnDtMap.arvlCd){
		        		$("#token").val(tissuFnDtMap.tkn);
		        		$("#transport").val("04");
		        		$("#code").val("01");		// 01:결제, 02:취소, 99: 오류
		        		$("#date").val($("#tissuFndeprDtDtl1").val()+$("#tissuFndeprTimeDtl1").val());
		        		$("#from").val($("#tissuFndeprTrmlNm1").val());
		        		$("#to").val($("#tissuFnarvlTrmlNm1").val());
		        		if(tissuFnLen > 1) { // 왕복
		        			$("#sn").val("(왕복)"+$("#tissuFnarvlTrmlNm2").val()+"/"+$("#tissuFndeprTrmlNm2").val()+"/"+$("#tissuFndeprDtDtl2").val()+$("#tissuFndeprTimeDtl2").val());	
		        		}else{	// 편도
		        			$("#sn").val("");
		        		}		        		
		        		fnTissuFnPc();
	        		}else{
	        			fnTissuFn();
	        		}
	        	}else{
	        		fnTissuFn();	
	        	}
        	}
        },
        error : function (e){
        	$("#loading").hide();
            alert("결제가 실패되었습니다. 잠시 후 다시 시도해주시기 바랍니다.");
            $('#caPerson').focus();
            
            return;
        }
	});
}

//평창 앱 연계시 호출 
function fnTissuFnPc(){
	var stplCfmPymFrm = $("form[name=stplCfmPymPcFrm]").serialize() ;		
	$.ajax({	
		url      : "https://maas.kt.com/srvapi/ex_content/pay_back",
        type     : "POST",
        data : stplCfmPymFrm,      
        dataType : "json",
        contentType:"application/json; charset=UTF-8",
        async    : true,
        success  : function(data){
        	var result_code = data.result_code;
        	var result_msg = data.result_msg;        	
        	$("#loading").hide();
    		$("#stplCfmPymFrm").attr("action","/mrs/pymcfm.do");
    		$("#stplCfmPymFrm").submit();
        },
        error : function(){
        	$("#loading").hide();
    		$("#stplCfmPymFrm").attr("action","/mrs/pymcfm.do");
    		$("#stplCfmPymFrm").submit();
        }
        
	});
}
	
	

function fnTissuFn(){	
	$("#loading").hide();
	$("#stplCfmPymFrm").attr("action","/mrs/pymcfm.do");
	$("#stplCfmPymFrm").submit();
	
}



function fnAcntTrnPg(){ //계좌이체정보 조회
	//alert("계좌이체");
	var stplCfmPymFrm = $("form[name=stplCfmPymFrm]").serialize() ;
	$.ajax({	
        url      : "/mrs/acntTrnDta.ajax",
        type     : "post",
        data : stplCfmPymFrm,
        dataType : "json",
        async    : true,
        success  : function(acntTrnMap){
	       	if(acntTrnMap.resultYn == "Y"){
	       		$("#goodsName").val(acntTrnMap.goodsName);
	       		$("#amt").val(acntTrnMap.price);
	       		$("#buyerName").val(acntTrnMap.buyerName);
	       		$("#buyerTel").val(acntTrnMap.buyerTel);
	       		$("#moid").val(acntTrnMap.moid);
	       		$("#mid").val(acntTrnMap.merchantID);
	       		$("#userIP").val(acntTrnMap.userAddr);
	       		$("#mallIP").val(acntTrnMap.inetAddr);
	       		$("#charSet").val(acntTrnMap.charset);
	       		$("#buyerEmail").val(acntTrnMap.buyerEmail);
	       		$("#socketYN").val(acntTrnMap.socketYN);
	       		$("#encodeParameters").val(acntTrnMap.encodeParameters);
	       		$("#ediDate").val(acntTrnMap.ediDate);
	       		$("#encryptData").val(acntTrnMap.hashString);
	       		$("#vExp").val(getTomorrow());
	       		
	       	    var pgPayFrm = document.acntDtaFrm;
	       	    //goPay(pgPayFrm);
	       	    fnAcntPymWin();
	       	}else{
	            alert("계좌이체 정보 입력 실패:err");
	            return;
	       	}
        },
        error : function (e){
            alert("계좌이체 정보 입력 실패:err");
            return;
        }
	});
}

// 계좌이체
function  fnAcntPymWin(){
//	window.open("","acntPymPup","width=800,height=530,toolbar=no,menubar=no,resizable=yes");
//	$("#acntDtaFrm").attr("action","/mrs/acntpympup.do");
//	$("#acntDtaFrm").attr("target","acntPymPup");
//	$("#acntDtaFrm").submit();
	
	openDialog(function(win){
		
	});
}
// 간편결제
function  fnPayPymWin(){
	openDialog(function(win){
		
	});
}

var openDialog = function(closeCallback){
	var win = window.open("","pymPup","width=560,height=850,toolbar=no,menubar=no,resizable=yes");
	var payType = $("#pymType").val();//지불방법
	if (payType == "acnt"){
		$("#acntDtaFrm").attr("action","/mrs/acntpympup.do");
		$("#acntDtaFrm").attr("target","pymPup");
		$("#acntDtaFrm").submit();
	}

	if (payType == "pay"){
		$("input:radio[name='pynDtlCd']").each(function(){
			if ($(this).is(":checked")){
				$("#payMethodCd").val( $(this).val() );
			}
		});
		
		$("#payDtaFrm").attr("action","/mrs/payCheckout.do");
		$("#payDtaFrm").attr("target","pymPup");
		$("#payDtaFrm").submit();
	}
	
	$("#popupStatus").val('');

	var interval = window.setInterval(function(){
		try {
			if (win == null || win.closed) {
				window.clearInterval(interval);
				
				if ($("#popupStatus").val() != 'ok'){ 
					alert('팝업창을 종료하여 결제가 중단 되었습니다.\n다시 시도해 주세요.');
					location.reload(); 
				} 
			}
		}
		catch(e){
			
		}
	}, 1000);
	return win;
};


function fnVldtCmn(){ //공통사항 체크
	if($("input:checkbox[id='agree1']").is(":checked") == false){
		alert("이용약관에 동의해 주세요.");
		$("#agree1").focus();
		return false;
	}
	if($("input:checkbox[id='agree2']").is(":checked") == false){
		alert("이용약관에 동의해 주세요.");
		$("#agree2").focus();
		return false;
	}
	if($("input:checkbox[id='agree3']").is(":checked") == false){
		alert("이용약관에 동의해 주세요.");
		$("#agree3").focus();
		return false;
	}

	return true;
}



function fnNonMbrsYn(nonMbrsYn){
//	var nonMbrsYn = $("#nonMbrsYn").val(); 
	if(nonMbrsYn == "Y"){
		var phoneNum1Val = $("#phoneNum11").val()+""+$("#phoneNum12").val()+""+$("#phoneNum13").val();
		if(phoneNum1Val == "" || phoneNum1Val.length < 10 ){
			alert("예매 조회정보를 다시 입력하여 주세요.");
			$("#phoneNum12").val("");
			$("#phoneNum13").val("");
			$("#phoneNum12").focus();
			return false;
		}	
		if(phoneNum1Val.substring(0,2) != "01"){
			alert("유효하지 않은 휴대폰번호입니다. 다시 입력하여 주세요.");
			$("#phoneNum12").val("");
			$("#phoneNum13").val("");
			$("#phoneNum12").focus();
			return false;
		}
		if($("#nonMbrsPw").val().length < 4 || $("#nonMbrsPwChk").val().length < 4 || ($("#nonMbrsPw").val() != $("#nonMbrsPwChk").val())){
			alert("예매 조회정보를 다시 입력하여 주세요.");
			$("#nonMbrsPw").val("");
			$("#nonMbrsPwChk").val("");
			$("#nonMbrsPw").focus();
			return false;
		}
	}
	return true;
}


function fnVldtPay(){
	if($("#payBirth").val().length != 6){
		alert("생년월일을 정확하게 입력하시기 바랍니다.");
		$('#payBirth').focus(); // 포커스 이동
		return false;
	}
	if ($("input:radio[name='pynDtlCd']:checked").length == 0){
		alert("간편결제 종류를 선택해 주세요.");
		$('#payNaver').focus(); // 포커스 이동
		return false;
	}

	return true;
}

function fnVldtCard(){

	if($("#cardKndCd").val() == "0" || $("#cardKndCd").val() == ""){
//		$('#cardKndCd').focus(); // 포커스 이동
		alert("카드사를 선택하시기 바랍니다.");
		$('a[title="카드 선택"]').focus();
		return false;
	}
	if($("#cardNum1").val().length != 4){
		alert("첫 번째 카드번호 4자리를 정확하게 입력하시기 바랍니다.");
		$('#cardNum1').focus(); // 포커스 이동
		return false;
	}
	if($("#cardNum2").val().length != 4){
		alert("두 번째 카드번호 4자리를 정확하게 입력하시기 바랍니다.");
		$('#cardNum2').focus(); // 포커스 이동
		return false;
	}
	if($("#cardNum3").val().length != 4){
		alert("세 번째 카드번호 4자리를 정확하게 입력하시기 바랍니다.");
		$('#cardNum3').focus(); // 포커스 이동
		return false;
	}
	if($("#cardNum4").val().length != 3 && $("#cardNum4").val().length != 4){
		alert("네 번째 카드번호 4자리를 정확하게 입력하시기 바랍니다.");
		$('#cardNum4').focus(); // 포커스 이동
		return false;
	}
	
	if($("#cardMonth").val().length != 2){
		alert("카드 유효기간 월을 정확하게 입력하시기 바랍니다.");
		$('#cardMonth').focus(); // 포커스 이동
		return false;
	}
	if($("#cardYear").val().length != 2){
		alert("카드 유효기간 년을 정확하게 입력하시기 바랍니다.");
		$('#cardYear').focus(); // 포커스 이동
		return false;
	}
//	if($("#cardMonth").val().length == 2 && (Number($("#cardMonth").val()) <= 0 || Number($("#cardMonth").val()) > 12)){
//		alert("카드 유효기간을 정확하게 입력하시기 바랍니다.");
//		$('#cardMonth').focus(); // 포커스 이동
//		return false;
//	}
	if($("#cardPw").val().length != 2){
		alert("카드 비밀번호를 정확하게 입력하시기 바랍니다.");
		$('#cardPw').focus(); // 포커스 이동
		return false;
	}
	if($("input:radio[id='caPerson']").is(":checked")){
		if($("#caBirth").val().length != 6){
			alert("생년월일 6자리를 정확하게 입력하시기 바랍니다.");
			$('#caBirth').focus(); // 포커스 이동
			return false;
		}
	}
	if($("input:radio[id='caCompany']").is(":checked")){
		var brnChkYn = fnBrnChk("card");
		if(brnChkYn == "N"){
			return false;
		}
	}
	
	var allCardNum = $("#cardNum1").val()+""+$("#cardNum2").val()+""+$("#cardNum3").val()+""+$("#cardNum4").val();
	$("#allCardNum").val(allCardNum);
	
	if ($('#extrComp').val() == ''){
		if ($("#pymType").val() == "card"){
			if (ajaxDecode('cardNum3') == false) { return; }
			if (ajaxDecode('cardNum4') == false) { return; }
			if (ajaxDecode('cardPw') == false) { return; }
		}
	}

	return true;
}



function fnVldtAcnt(){ //계좌이체 val 체크
	
	// 20211129 생년월일 체크 변경
//	if($("input:radio[name=receiptType]:checked").val() == "Person" &&
//		$("#acBirth").val().length != 8){
//		alert("생년월일을 정확하게 입력하시기 바랍니다.");
//		return false;
//	}
//	if($("input:radio[name=receiptType]:checked").val() == "Business" &&
//		$("#acBirth").val().length != 10){
//		alert("사업자번호를 정확하게 입력하시기 바랍니다.");
//		return false;
//	}
	//20211230 생년월일로 통일 
//	if($("input:radio[name=receiptType]:checked").val() == "Business"){
//		if ($("#acBirth").val().length != 10){
//			alert("사업자번호를 정확하게 입력하시기 바랍니다.");
//			$("#acBirth").focus();
//			return false;
//		}
//	}else{
//		if ($("#acBirth").val().length != 6){
//			alert("생년월일을 정확하게 입력하시기 바랍니다.");
//			$("#acBirth").focus();
//			return false;
//		}
//	}
	if ($("#acBirth").val().length != 6){
		alert("생년월일을 정확하게 입력하시기 바랍니다.");
		$("#acBirth").focus();
		return false;
	}

//	if($("input:radio[id='receiptPhone']").is(":checked")){
//		if($("#phoneNum2").val() == "" || $("#phoneNum2").val().length < 10 ){
//			alert("현금영수증 발급을 위한 휴대폰번호를 정확하게 입력해주시기 바랍니다.");
//			$("#phoneNum2").focus();
//			return false;
//		}else{
//			$("#csrcNo").val($("#phoneNum2").val());
//		}	
//	}
//	
//	if($("input:radio[id='receiptCard']").is(":checked")){
//		if($("#reCardNum1").val().length < 4 || $("#reCardNum2").val().length < 4 || $("#reCardNum3").val().length < 4 || $("#reCardNum4").val().length < 4){
//			alert("현금영수증 카드정보를 정확하게 입력하시기 바랍니다.");
//			return false;
//		}else{
//			var acntAllCardNum = $("#reCardNum1").val()+""+$("#reCardNum2").val()+""+$("#reCardNum3").val()+""+$("#reCardNum4").val();
//			$("#csrcNo").val(acntAllCardNum);
//		}
//	}
	// 20201124 yahan
	if($("input:radio[id='receiptPerson']").is(":checked")){
		var value = $("#receiptPersonSelect").val();
		if (value == "receiptPhone") {
			if($("#phoneNum2").val() == "" || $("#phoneNum2").val().length < 10 ){
				alert("현금영수증 발급을 위한 휴대폰번호를 정확하게 입력해주시기 바랍니다.");
				$("#phoneNum2").focus();
				return false;
			}else{
				$("#csrcNo").val($("#phoneNum2").val());
			}
		} else {
			if($("#reCardNum1").val().length < 4 || $("#reCardNum2").val().length < 4 || $("#reCardNum3").val().length < 4 || $("#reCardNum4").val().length < 4){
				alert("현금영수증 카드정보를 정확하게 입력하시기 바랍니다.");
				return false;
			}else{
				var acntAllCardNum = $("#reCardNum1").val()+""+$("#reCardNum2").val()+""+$("#reCardNum3").val()+""+$("#reCardNum4").val();
				$("#csrcNo").val(acntAllCardNum);
			}
		}
		$("#chitUseDvs").val("0"); //개인
	}
	if($("input:radio[id='receiptBusiness']").is(":checked")){
		var value = $("#receiptBusinessSelect").val();
		if (value == "receiptBizn") {
			if($("#reBiznNum1").val().length < 3 || $("#reBiznNum2").val().length < 2 || $("#reBiznNum3").val().length < 5){
				alert("현금영수증 발급을 위한 사업자번호를 정확하게 입력하시기 바랍니다.");
				return false;
			}else{
				var acntAllBiznNum = $("#reBiznNum1").val()+""+$("#reBiznNum2").val()+""+$("#reBiznNum3").val();
				$("#csrcNo").val(acntAllBiznNum);
			}
			
		} else {
			if($("#reCardNum1").val().length < 4 || $("#reCardNum2").val().length < 4 || $("#reCardNum3").val().length < 4 || $("#reCardNum4").val().length < 4){
				alert("현금영수증 카드정보를 정확하게 입력하시기 바랍니다..");
				return false;
			}else{
				var acntAllCardNum = $("#reCardNum1").val()+""+$("#reCardNum2").val()+""+$("#reCardNum3").val()+""+$("#reCardNum4").val();
				$("#csrcNo").val(acntAllCardNum);
			}
		}
		$("#chitUseDvs").val("1"); //사업자
	}
	if($("input:radio[id='receiptNone']").is(":checked")){
		$("#csrcNo").val("");
		$("#chitUseDvs").val("2"); //자진발급
	}
	
	
	$("#userDvsCd").val("1"); //계좌이체는 개인만
	$("#mblUtlzPsbYn").val("N"); //계좌이체는 모바일발권 불가
	return true;
}



function fnBrnChk(divVal){
	var getlist =new Array(10);
	var chkvalue =new Array("1","3","7","1","3","7","1","3","5");
	var brn = "";
	if(divVal == "card"){
		brn = $("#comNumCard").val(); //카드결제 사업자번호
	}
	/* else if(divVal == "acnt"){
		brn = $("#acComNum").val(); //계좌이체 사업자번호
	} */
	var sum = 0;
	var sidliy = 0;
	var sidchk = 0;
	
	if(brn.length != 10){
		alert("사업자번호를 정확하게 입력하시기 바랍니다.");
		return "N";
	}
	for (var i=0;i<10;i++){
		getlist[i] = brn.substring(i,i+1);
	}
	for (var i=0;i<9;i++){
		sum += getlist[i]*chkvalue[i];
	}
	sum = sum +parseInt((getlist[8]*5)/10) ;
	sidliy = sum%10;
	sidchk = 0;

	if ( sidliy != 0 ) {
		sidchk = 10 - sidliy;
	} else {
		sidchk = 0;
	}
	if ( sidchk != getlist[9] ) {
		alert("잘못된 사업자 등록번호 입니다. 다시 입력해주십시오.");
		if(divVal == "card"){
			$("#comNumCard").val("");
			$("#comNumCard").focus();
		}
		/* else if(divVal == "acnt"){
			$("#acComNum").val("");
			$("#acComNum").focus();
		} */
		return "N";
	}else{
		return "Y";
	}
}



function fnVldtAdtnPrd(payType){
	var payTypeNm ="";
	if(payType == "perd"){
		payTypeNm = "정기권";
	}else if(payType == "frps"){
		payTypeNm = "프리패스";
	}
	
	if($("#adtnCpnNo").val() == ""){
		alert(payTypeNm+"의 일련번호를 선택해주세요.");
		return false;
	}else{
		return true;
	}
	
}



function fnCardKindSel(val){
	if(val == "indl"){
		$("#indlBrdtCard").css("display","block");
		$("#cprtBrnCard").css("display","none");
		$("#userDvsCd").val("1");
		
		// 할부 활성/비활성 제어 (20190517 수정)
		if($("#pathDvs").val() != "rtrp"){
			if(Number($("#tissuAmt").val()) > 50000){
				$("#mipMmSel").css("display","block");
			}else{
				$("#mipMmSel").css("display","none");
			}
		}else{ // 왕복일경우
			var rtrpDtl1 = ($("#rtrpDtl1").val());
			var arrDtl1 = rtrpDtl1.split(':');
			var rtrpDtl2 = ($("#rtrpDtl2").val());
			var arrDtl2 = rtrpDtl2.split(':');
			
			var goAmt = arrDtl1[12];		// 왕편 결제금액
			var backAmt = arrDtl2[12];	// 복편 결제금액
			
			//if($("#ctyPrmmDcYn").val() == "Y"){ //시외우등 왕복일경우
			//20211222 왕복할인이 일때는 총합으로 할부 표시 
			if($("#prmmDcDvsCd").val() == "4"){
				if(Number($("#tissuAmt").val()) > 50000){
					$("#mipMmSel").css("display","block");
				}else{
					$("#mipMmSel").css("display","none");
				}
			}else{	//일반 왕복일 경우
				if(goAmt > 50000 && backAmt > 50000){ // 왕편 복편 둘다 50000 이상일 경우에만 할부 가능 
					$("#mipMmSel").css("display","block");
				}else{
					$("#mipMmSel").css("display","none");
				}
			}
		}
		
	}else if(val == "cprt"){
		$("#indlBrdtCard").css("display","none");
		$("#cprtBrnCard").css("display","block");
		$("#userDvsCd").val("2");
		$("#mipMmSel").css("display","none");
	}
}



function fnMblTck(mblTckVal){
	
	if(mblTckVal == "CAN"){
		
		/**
		 * 20200709 yahan
		 * 남윤주과장 요청으로 미사용
		if($("#tlcnTrcnUtlzPsbYn").val() == "N"){
			alert("선택하신 차량은 모바일티켓 발권이 불가합니다.");
			fnMblTck("CHG");
			return;
		}
		*/
		
		$("input:radio[id='moTicket']").prop("checked",true);
		$("#moTicketSpan").addClass("active");
		$("#nomoTicketSpan").removeClass("active");
		$("#mblUtlzPsbYn").val("Y");
		$("#mobileAppGd").css("display","block");
		$("#mobileAppInf").css("display","block");
	}
	
	if(mblTckVal == "CHG"){
		if($("input:radio[id='nomalTicket']").is("checked") == false){
			$("#moTicketSpan").removeClass("active");
			$("#nomoTicketSpan").addClass("active");
			$("input:radio[id='nomalTicket']").prop("checked",true);
			$("#mblUtlzPsbYn").val("N");
			$("#mobileAppGd").css("display","none");
			$("#mobileAppInf").css("display","none");
			
			// 일반티켓을 선택하면 간편결제를 이용할수 없다. 카드결제를 기본으로 선택한다.
			if ($("#pymType").val() == "pay"){
				$("#payType1").trigger("click");
			}
		}
	}
	
	fnSetCardCam(mblTckVal);
}



function fnSetCardCam(mblTckVal){
	var stplCfmPymFrm = $("form[name=stplCfmPymFrm]").serialize() ;
	$.ajax({	
        url      : "/mrs/cardCamList.ajax",
        type     : "post",
        data : stplCfmPymFrm,
        dataType : "json",
        async    : true,
        success  : function(cardCamListMap){
        	var listCnt = cardCamListMap.listCnt;
        	var cardCdList = cardCamListMap.cardCdList;
        	if(listCnt > 0){
        		fnSetCardCd(listCnt,cardCdList,mblTckVal);
        	}else{
        		alert("카드사 정보를 불러오기 실패");
        	}
        },
        error : function(){
        	alert("카드사 정보를 불러오기 실패");
        }
	});
}



function fnSetCardCd(listCnt,cardCdList,mblTckVal){
	// asis
	if (is_select("cardKndCd")){ // select 태크처리
		var selectOption = "";
		selectOption = "<option value=\"0\">카드를 선택하세요</option>";
		for(var inx = 0 ; inx < listCnt ; inx++){
			if(cardCdList[inx].useListYn == "Y"){
				selectOption += "<option value=\""+cardCdList[inx].buyCmpyCd+"\">"+cardCdList[inx].buyCmpyKorNm+"</option>";
			}
		}
		selectOption += "<option value=\"01\">기타</option>";
	
		$("#cardKndCd").html(selectOption);
		$("#cardKndCd").selectric();
	}
	// renewal
	else {
		var selectOption = "<li><a href=\"javascript:void(0)\" onclick=\"onSelectChange(this,'0', 'cardKndCd')\">카드를 선택하세요</a></li>";

		for(var inx = 0 ; inx < listCnt ; inx++){
			if(cardCdList[inx].useListYn == "Y"){
				selectOption += "<li><a href=\"javascript:void(0)\" onclick=\"onSelectChange(this,'"+cardCdList[inx].buyCmpyCd+"', 'cardKndCd')\">"+cardCdList[inx].buyCmpyKorNm+"</a></li>";
			}
		}
		selectOption += "<li><a href=\"javascript:void(0)\" onclick=\"onSelectChange(this,'01', 'cardKndCd')\">기타</a></li>";
		
		$("#cardKndCdLi").html(selectOption);
	}
}




function fnPymType(obj,payType){
	$("#pymType").val(payType);//지불방법 설정
	$("#adtnPrdVldChkYn").val("N");
	fnSetAdtnPrdInvl(); //부가상품 초기화
	
	if(payType =='pay'){ //간편결제
		$("#adtnPrdDvsCdVldt").val("");
		$("#mblTckYn").css("display","block");
		/*$("#cardNotice").css("display","block");
		$("#acntNotice1").css("display","none");
		$("#acntNotice2").css("display","none");
		$("#famtNotice").css("display","none");
		$("#perdNotice").css("display","none");
		$("#milageNotice").css("display","none");*/
		if(Number($("#tissuAmt").val()) > 0){
			$("#tissuAmtView").text(comma($("#tissuAmt").val())+"원");
		}
		if($("input:radio[id='nomalTicket']").prop("checked") == true){
			alert("간편결제시 모바일티켓으로만 발권 가능합니다.\n일반티켓 발권을 원하시면 다른 결제수단을 선택하시기 바랍니다.");
			fnMblTck('CAN');// 기본 모바일티켓설정
		}
	}else if(payType =='card'){ //카드결제
		$("#adtnPrdDvsCdVldt").val("");
		$("#mblTckYn").css("display","block");
		/*$("#cardNotice").css("display","block");
		$("#acntNotice1").css("display","none");
		$("#acntNotice2").css("display","none");
		$("#famtNotice").css("display","none");
		$("#perdNotice").css("display","none");
		$("#milageNotice").css("display","none");*/
		if(Number($("#tissuAmt").val()) > 0){
			$("#tissuAmtView").text(comma($("#tissuAmt").val())+"원");
		}
	}else if(payType =='acnt'){ //계좌이체
		
		$("#adtnPrdDvsCdVldt").val("");
		var uaChec = window.navigator.userAgent;
		// 20240527 크롬 계좌이체 허용
		//if(uaChec.indexOf('MSIE') > 0 || uaChec.indexOf('Trident') > 0)
		{ // IE 브라우저 체크
			$("#mblTckYn").css("display","none");
			/*$("#cardNotice").css("display","none");
			$("#acntNotice1").css("display","block");
			$("#acntNotice2").css("display","block");
			$("#famtNotice").css("display","none");
			$("#perdNotice").css("display","none");
			$("#milageNotice").css("display","none");*/
			alert("계좌이체 결제 시 일반티켓으로만 발권 가능합니다.\n모바일티켓 발권을 원하시면 다른 결제수단을 선택하시기 바랍니다.");
			fnMblTck('CHG');
		}
		if(Number($("#tissuAmt").val()) > 0){
			$("#tissuAmtView").text(comma($("#tissuAmt").val())+"원");
		}
	}else if(payType =='perd'){ //정기권
		$("#adtnPrdPayType").val(payType);
		if(Number($("#passCnt").val()) == 0){
			alert("사용가능한 정기권이 없습니다.\n다른 결제수단을 선택해주세요.");
			$("#tab3").html("<div class='noti_wrap'><p class='noti noData'>사용 가능한 정기권이 없습니다.</p></div>");
			return false;
		}else{
			if($("#selSeatCnt").val() > 1){
				alert("다인표 예매시 정기권으로 결제 불가합니다.\n다른 결제수단을 선택해주세요.");
				$("#tab3").html("<div class='noti_wrap'><p class='noti noData'>다인표 예매시 정기권으로 결제 불가합니다.</p></div>");
			}else{
				fnChgCfmBtn();
			}			
		}					
	}else if(payType == 'frps'){ //프리패스
		$("#adtnPrdPayType").val(payType);		
		if(Number($("#frpsCnt").val()) == 0){
			alert("사용가능한 프리패스가 없습니다.\n다른 결제수단을 선택해주세요.");
			$("#tab4").html("<div class='noti_wrap'><p class='noti noData'>사용 가능한 프리패스가 없습니다.</p></div>");
			return false;
		}else{
			if($("#selSeatCnt").val() > 1){
				alert("다인표 예매시 프리패스로 결제 불가합니다.\n다른 결제수단을 선택해주세요.");
				$("#tab4").html("<div class='noti_wrap'><p class='noti noData'>다인표 예매시 프리패스로 결제 불가합니다.</p></div>");
			}else{
				fnChgCfmBtn();
			}	
		}			
	}else if(payType == 'mileage'){ //마일리지
		$("#mblTckYn").css("display","none");
		/*$("#cardNotice").css("display","none");
		$("#acntNotice1").css("display","none");
		$("#acntNotice2").css("display","none");
		$("#famtNotice").css("display","none");
		$("#perdNotice").css("display","none");
		$("#milageNotice").css("display","block");*/
		fnUseMileageVal(); //사용가능 마일리지 조회		
	}
	
	if(payType != 'mileage'){
		if(payType !='famt' && payType != 'perd'){
			payH();
		}
		
		fnChgCfmBtn();
	}
	fnEzCheck();
}
		



function fnAdtnPrdChgYnSet(){
	fnAdtnPrdChgYn("N");
}



/*function fnChgCfmBtnChkAll(){
	alert("aaa");
	if($(this).is(":checked")){
		$(".agreement_wrap input[type=checkbox]").each(function(){
			$(this).prop("checked", true);
		});
	} else {
		$(".agreement_wrap input[type=checkbox]").each(function(){
			$(this).prop("checked", false);
		});
	}
}*/



function fnChgCfmBtn(){
	var chkAllVal = fnValYnChk();
	
	if(chkAllVal == "Y"){
		$("#stplCfmBtn").removeClass("ready");
	}else{
		$("#stplCfmBtn").addClass("ready");
	}
}



function fnAdtnPrdChgYn(ynVal){
	if(ynVal == "N"){
		$("#adtnPrdPayType").val("");
		$("#payType1").click();
	}else{
		var payType = $("#adtnPrdPayType").val();
		fnAdtnPrdChg(payType);
	}
}



function fnAdtnPrdChg(payType){
	$("#mblTckYn").css("display","block");
	$("#cardNotice").css("display","none");
	$("#acntNotice1").css("display","none");
	$("#acntNotice2").css("display","none");
	$("#milageNotice").css("display","none");
	$("#tissuAmtView").text("0원");
	if(payType == 'famt'){
		$("#famtNotice").css("display","block");
		$("#perdNotice").css("display","none");
		$("#adtnPrdDvsCd").val("1");
		$("#adtnPrdDvsCdVldt").val("1");
	}else if(payType == 'perd'){
		$("#famtNotice").css("display","none");
		$("#perdNotice").css("display","block");
		$("#adtnPrdDvsCd").val("2");
		$("#adtnPrdDvsCdVldt").val("2");
	}
	//fnAdtnPrdChk(payType);
}



function fnAcntCsrcInf(csrcType, recpType){
	// 20201124 yahan
	if(csrcType == "Business"){
		var value = $("#receiptBusinessSelect").val();
		if (!is_select("receiptBusinessSelect")){
			value = recpType;
			$("#receiptBusinessSelect").val(recpType);
		}
		
		if (value == "receiptBizn"){
			$("#acntCsrcCard").css("display","none");
			$("#acntCsrcBizn").css("display","block");
		} else {
			$("#acntCsrcCard").css("display","block");
			$("#acntCsrcBizn").css("display","none");
		}
	}
	else if(csrcType == "Person"){
		var value = $("#receiptPersonSelect").val();
		if (!is_select("receiptPersonSelect")){
			value = recpType;
			$("#receiptPersonSelect").val(recpType);
		}
		
		if (value == "receiptPhone"){
			$("#acntCsrcMbph").css("display","block");
			$("#acntCsrcCard").css("display","none");
		} else {
			$("#acntCsrcMbph").css("display","none");
			$("#acntCsrcCard").css("display","block");
		}
	}
	
	fnChgCfmBtn();
}

//20201124 yahan
function fnAcntCsrcInf2(csrcType){
	if(csrcType == "Business"){
		$("#acntCsrcPerson").css("display","none");
		$("#acntCsrcBusiness").css("display","block");

		$("#acntCsrcMbph").css("display","none");
		var value = $("#receiptBusinessSelect").val();
		if (value == "receiptBizn"){
			$("#acntCsrcBizn").css("display","block");
			$("#acntCsrcCard").css("display","none");
		} else {
			$("#acntCsrcBizn").css("display","none");
			$("#acntCsrcCard").css("display","block");
		}
		
		//20211230 생년월일로 통일 
//		$("#acBirthText").text("사업자등록번호10자리");
//		$("#acBirthLabel").text("(-)없이");
//		$("#acBirth").val("");
//		$("#acBirth").attr("maxlength", "10");
		
	}
	else if(csrcType == "Person"){
		$("#acntCsrcPerson").css("display","block");
		$("#acntCsrcBusiness").css("display","none");
		
		var value = $("#receiptPersonSelect").val();
		if (value == "receiptPhone"){
			$("#acntCsrcMbph").css("display","block");
			$("#acntCsrcCard").css("display","none");
		} else {
			$("#acntCsrcMbph").css("display","none");
			$("#acntCsrcCard").css("display","block");
		}
		$("#acntCsrcBizn").css("display","none");
		
		//20211230 생년월일로 통일 
//		$("#acBirthText").text("생년월일 6자리(YYMMDD)");
//		$("#acBirthLabel").text("예)1980년11월11일 → 801111");
//		$("#acBirth").val("");
//		$("#acBirth").attr("maxlength", "6");
		
	}
	else if(csrcType == "None"){
		$("#acntCsrcPerson").css("display","none");
		$("#acntCsrcBusiness").css("display","none");
		
		$("#acntCsrcMbph").css("display","none");
		$("#acntCsrcCard").css("display","none");
		$("#acntCsrcBizn").css("display","none");
	}
	
	fnChgCfmBtn();
}



/*function fnAcntPymResult(){ //계좌이체 팝업에서 리턴하는 function
	$("#trnTrdId").val(tid);
	$("#trnAmt").val(amt);
	$("#ooaNm").val(ooaNm);

	fnStplCfmPym();
}*/



//가상계좌입금만료일 설정 (today +1)
function getTomorrow(){
    var today = new Date();

    var yyyy = today.getFullYear().toString();
    var mm = (today.getMonth()+1).toString();
    var dd = (today.getDate()+1).toString();
    if(mm.length < 2){mm = '0' + mm;}
    if(dd.length < 2){dd = '0' + dd;}
    return (yyyy + mm + dd);
}

//오늘 날짜
function getToDay(){
    var today = new Date();

    var yyyy = today.getFullYear().toString();
    var mm = (today.getMonth()+1).toString();
    var dd = (today.getDate()).toString();
    if(mm.length < 2){mm = '0' + mm;}
    if(dd.length < 2){dd = '0' + dd;}
    return (yyyy + mm + dd);
}

function fnAdtnPrdChk(prdType){
	var prdTypeAdtnPrdList = prdType+"AdtnPrdList";
	var prdTypeAdtnPrdListDiv = prdType+"AdtnPrdListDiv";
	var prdTypeInfoInput = prdType+"InfoInput";
	var prdTypeInfoMsg = prdType+"InfoMsg";
	var prdTypeIndvDtlInfo = prdType+"IndvDtlInfo";
	
	$("#loading").show();
	var stplCfmPymFrm = $("form[name=stplCfmPymFrm]").serialize() ;
	$.ajax({	
        url      : "/mrs/adtnPrdVal.ajax",
        type     : "post",
        data : stplCfmPymFrm,
        dataType : "json",
        async    : true,
        success  : function(adtnPrdValMap){
//        	테스트를 위해 주석처리 후 하드코딩으로 테스트
 			if(adtnPrdValMap.prdListCnt > 0){
				$("#adtnPrdVldCnt").val(adtnPrdValMap.prdListCnt);
				$("#tab4").css("display","block");
				$("#"+prdTypeAdtnPrdListDiv).css("display","block");
				$("#"+prdTypeInfoInput).css("display","none");
				$("#"+prdTypeInfoMsg).removeClass("show");
				$("#"+prdTypeIndvDtlInfo).css("display","none");
				 var adntPrdListAll = "<option value='0'>선택</option>";
				for(var inx = 0 ; inx < adtnPrdValMap.prdListCnt ; inx++){
					var prdNum = adtnPrdValMap.adntPrdList[inx].ADTN_CPN_NO;
					var adntPrdListIndv = adtnPrdValMap.adntPrdList[inx].ADTN_CPN_NO //부가상품번호
										+":"+adtnPrdValMap.adntPrdList[inx].DEPR_TRML_NM //출발지터미널명
										+":"+adtnPrdValMap.adntPrdList[inx].ARVL_TRML_NM //도착지터미널명
										+":"+adtnPrdValMap.adntPrdList[inx].PASS_NTKN_CD //상품등급
										+":"+adtnPrdValMap.adntPrdList[inx].PASS_NTKN_NM //상품등급
										+":"+adtnPrdValMap.adntPrdList[inx].EXDT_END_DT //만료일자
										+":"+adtnPrdValMap.adntPrdList[inx].EXDT_END_DT_DTL //만료일자
					adntPrdListAll += "<option value='"+adntPrdListIndv+"'>"+prdNum+"</option>"; //사용가능 부가상품 코드
				}
				adntPrdListAll += "<option value='999'>직접입력</option>";
				$("#"+prdTypeAdtnPrdList).html(adntPrdListAll); 
				$("#"+prdTypeAdtnPrdList).selectric();
			}else{
				$("#adtnPrdVldCnt").val("0");
				$("#"+prdTypeAdtnPrdListDiv).css("display","none");
				$("#"+prdTypeInfoInput).css("display","block");
				if(adtnPrdValMap.MSG_CD == "S0000"){
					$("#"+prdTypeInfoMsg).removeClass("show");
				}else{
					$("#"+prdTypeInfoMsg).addClass("show");
				}
				$("#"+prdTypeIndvDtlInfo).css("display","none");
			} 
 			$("#loading").hide();
        },
        error : function (e){
        	$("#loading").hide();
			$("#adtnPrdVldCnt").val("0");
			$("#"+prdTypeAdtnPrdListDiv).css("display","none");
			$("#"+prdTypeInfoInput).css("display","block");
			$("#"+prdTypeInfoMsg).removeClass("show");
			$("#"+prdTypeIndvDtlInfo).css("display","none");
        },
        complete:function(){
        	$("#loading").hide();
        }
	});
	window.setTimeout(fnPayH,100);
	
}

// 부가상품 리스트 신규 추가 (181226)
var passCnt = 0; 	// 사용가능한 정기권 갯수
var frpsCnt = 0;	// 사용가능한 프리패스 갯수
function fnAdtnPrdNewChk(){
	var prdTypeAdtnPrdList = "perdAdtnPrdList";
	var prdTypeAdtnPrdListDiv = "perdAdtnPrdListDiv";
	var prdTypeInfoInput = "perdInfoInput";
	var prdTypeInfoMsg = "perdInfoMsg";
	var prdTypeIndvDtlInfo = "perdIndvDtlInfo";
	
	var prdTypeAdtnPrdList2 = "frpsAdtnPrdList";
	var prdTypeAdtnPrdListDiv2 = "frpsAdtnPrdListDiv";
	var prdTypeInfoInput2 = "frpsInfoInput";
	var prdTypeInfoMsg2 = "frpsInfoMsg";
	var prdTypeIndvDtlInfo2 = "frpsIndvDtlInfo";
	
	$("#loading").show();
	var stplCfmPymFrm = $("form[name=stplCfmPymFrm]").serialize() ;
	
	$.ajax({	
        url      : "/mrs/adtnPrdValNew.ajax",
        type     : "post",
        data : stplCfmPymFrm,
        dataType : "json",
        async    : true,
        success  : function(adtnPrdValNewMap){
 			if(adtnPrdValNewMap.prdListCnt > 0){
				$("#adtnPrdVldCnt").val(adtnPrdValNewMap.prdListCnt);
				$("#"+prdTypeAdtnPrdListDiv).css("display","block");
				$("#"+prdTypeInfoInput).css("display","none");
				$("#"+prdTypeInfoMsg).removeClass("show");
				$("#"+prdTypeIndvDtlInfo).css("display","none");
				$("#"+prdTypeAdtnPrdListDiv2).css("display","block");
				$("#"+prdTypeInfoInput2).css("display","none");
				$("#"+prdTypeInfoMsg2).removeClass("show");
				$("#"+prdTypeIndvDtlInfo2).css("display","none");
				var adntPrdListAll = "";						
				var adntPrdListAll2 = "";						
				for(var inx = 0 ; inx < adtnPrdValNewMap.prdListCnt ; inx++){
					var prdNum = adtnPrdValNewMap.adntPrdList[inx].ADTN_CPN_NO;
					var prdKnd = adtnPrdValNewMap.adntPrdList[inx].ADTN_PRD_KND_CD;
					var adntPrdListIndv = adtnPrdValNewMap.adntPrdList[inx].ADTN_CPN_NO 		//부가상품번호
									+":"+adtnPrdValNewMap.adntPrdList[inx].ADTN_PRD_KND_CD 		//부가상품 종류(2:정기권,3:프리패스)
									+":"+adtnPrdValNewMap.adntPrdList[inx].ADTN_PRD_USE_PSB_DNO //사용가능일수
									+":"+adtnPrdValNewMap.adntPrdList[inx].wkdWkeNtknNm 		//주말주중권종
									+":"+adtnPrdValNewMap.adntPrdList[inx].adtnPrdUseClsNm 		//사용가능등급
									+":"+adtnPrdValNewMap.adntPrdList[inx].EXDT_STT_DT			//유효기간 시작일
									+":"+adtnPrdValNewMap.adntPrdList[inx].EXDT_END_DT	 		//유효기간 종료일
									+":"+adtnPrdValNewMap.adntPrdList[inx].adtnPrdUseNtknNm 	//사용가능권종
									+":"+adtnPrdValNewMap.adntPrdList[inx].PUB_USER_NO 			//20211218 발행사용자번호 TGO, MOB
	
					//정기권
					if(prdKnd == "2"){
						if (is_select("perdAdtnPrdList")){
							if(passCnt == 0){
								adntPrdListAll = "<option value='0'>정기권 번호를 선택해주세요.</option>";		
							}
							adntPrdListAll += "<option value='"+adntPrdListIndv+"'>"+prdNum+"</option>"; //사용가능 부가상품 코드
						}
						else{
							if(passCnt == 0){
								adntPrdListAll = "<li><a href=\"javascript:void(0)\" onclick=\"onSelectChange(this,'0', 'perdAdtnPrdList')\">정기권 번호를 선택해주세요.</a></li>";
							}
							adntPrdListAll = "<li><a href=\"javascript:void(0)\" onclick=\"onSelectChange(this,'"+ adntPrdListIndv +"', 'perdAdtnPrdList')\">"+ prdNum +"</a></li>";
						}
						passCnt++;
					}
					
					//프리패스
					if(prdKnd == "3"){
						var timDteAll = "";
						for(var jnx = 0 ; jnx < adtnPrdValNewMap.timDteListCnt ; jnx++){
							var fpCpnNo = adtnPrdValNewMap.adntTimDteList[jnx].FP_CPN_NO;	//프리패스 번호
							if(prdNum == fpCpnNo){
								timDteAll += adtnPrdValNewMap.adntTimDteList[jnx].TIM_DTE + "/";	//탑승가능일
							}
						}
						adntPrdListIndv += ":"+timDteAll;
						
						if (is_select("frpsAdtnPrdList")){
							if(frpsCnt == 0){
								adntPrdListAll2 = "<option value='0'>프리패스 번호를 선택해주세요.</option>";		
							}
							adntPrdListAll2 += "<option value='"+adntPrdListIndv+"'>"+prdNum+"</option>"; //사용가능 부가상품 코드
						}
						else{
							if(frpsCnt == 0){
								adntPrdListAll2 = "<li><a href=\"javascript:void(0)\" onclick=\"onSelectChange(this,'0', 'frpsAdtnPrdList')\">프리패스 번호를 선택해주세요.</a></li>";
							}
							adntPrdListAll2 = "<li><a href=\"javascript:void(0)\" onclick=\"onSelectChange(this,'"+ adntPrdListIndv +"', 'frpsAdtnPrdList')\">"+ prdNum +"</a></li>";
						}
						frpsCnt++;
					}						
				}
				 
				if (is_select("perdAdtnPrdList")){
					$("#"+prdTypeAdtnPrdList).html(adntPrdListAll);
					$("#"+prdTypeAdtnPrdList).selectric();
				}
				else{
					$("#perdAdtnPrdListLi").html(adntPrdListAll);
				}
				 
				if (is_select("frpsAdtnPrdList")){
					$("#"+prdTypeAdtnPrdList2).html(adntPrdListAll2);
					$("#"+prdTypeAdtnPrdList2).selectric();
				}
				else{
					$("#frpsAdtnPrdListLi").html(adntPrdListAll2);
				}
			}else{
				$("#adtnPrdVldCnt").val("0");
				$("#"+prdTypeAdtnPrdListDiv).css("display","none");
				$("#"+prdTypeInfoInput).css("display","block");
				$("#"+prdTypeAdtnPrdListDiv2).css("display","none");
				$("#"+prdTypeInfoInput2).css("display","block");
				if(adtnPrdValNewMap.MSG_CD == "S0000"){
					$("#"+prdTypeInfoMsg).removeClass("show");
					$("#"+prdTypeInfoMsg2).removeClass("show");
				}else{
					$("#"+prdTypeInfoMsg).addClass("show");
					$("#"+prdTypeInfoMsg2).addClass("show");
				}
				$("#"+prdTypeIndvDtlInfo).css("display","none");	
				$("#"+prdTypeIndvDtlInfo2).css("display","none");	
			}
 			//부가상품 갯수 표기 			
 			$("#passCntSp").html("("+passCnt+")"); 		
 			$("#frpsCntSp").html("("+frpsCnt+")");
 			$("#passCnt").val(passCnt);
 			$("#frpsCnt").val(frpsCnt); 			
 			
 			$("#loading").hide();
        },
        error : function (e){
        	$("#loading").hide();
			$("#adtnPrdVldCnt").val("0");
			$("#"+prdTypeAdtnPrdListDiv).css("display","none");
			$("#"+prdTypeInfoInput).css("display","block");
			$("#"+prdTypeInfoMsg).removeClass("show");
			$("#"+prdTypeIndvDtlInfo).css("display","none");
        },
        complete:function(){
        	$("#loading").hide();
        }
	});
	window.setTimeout(fnPayH,100);
	
}

function fnPayH(){
	payH();
}


function fnAdtnPrdMod(prdType, value){
	$("#adtnPrdVldChkYn").val("N"); //부가상품 일련번호 유효성 체크여부
	
	var prdTypeAdtnPrdList = prdType+"AdtnPrdList";
	var prdTypeAdtnPrdListDiv = prdType+"AdtnPrdListDiv";
	var prdTypeAdtnPrdInfo = prdType+"AdtnPrdInfo";
	var prdTypeAdtnPrdExdt = prdType+"AdtnPrdExdt";
	var prdTypeIndvDtlInfo = prdType+"IndvDtlInfo";
	var prdTypeInfoMsg = prdType+"InfoMsg";
	var adtnPrdChcVal = value.split(":");
	var prdTypeNumList =  prdType+"NumList";
	var tmeneyGo = "";
	if (adtnPrdChcVal.length >= 9) tmeneyGo = adtnPrdChcVal[8];
	
	if(adtnPrdChcVal[0] != "0" && tmeneyGo != "TGO"){
		var infoDtl = "";
		var exdtStt = adtnPrdChcVal[5];
		var exdtEnd = adtnPrdChcVal[6];
		//var timDte = adtnPrdChcVal[8];	//탑승가능일
		var timDte = adtnPrdChcVal[9];	//탑승가능일
		var exdtDtl = ""; 
		
		if(adtnPrdChcVal[1] == "3"){	//프리패스
			infoDtl = adtnPrdChcVal[7] +" / "+ adtnPrdChcVal[2] +"일 / "+ adtnPrdChcVal[4] +" / "+ adtnPrdChcVal[3];
			var arrTimDte = timDte.split("/");
			var timDteTxt = ""; 
			for(var inx = 0 ; inx < arrTimDte.length-1 ; inx++){
				var today = getToDay();
				var yyyy = arrTimDte[inx].substring(0,4);
				var mm = arrTimDte[inx].substring(4,6);
				var dd = arrTimDte[inx].substring(6,8);
				
				if(inx > 0){
					var yyyymm1 = arrTimDte[inx-1].substring(0,6);
					var yyyymm2 = arrTimDte[inx].substring(0,6);
					
					if(yyyymm1 != yyyymm2){				
						if(today < arrTimDte[inx]){
							timDteTxt += yyyy + "년 " + mm + "월 " +"<em class='accent'>"+ dd + "일 </em>";
						}else{
							timDteTxt += yyyy + "년 " + mm + "월 " +"<span class='txt_gray2'>"+ dd + "일 </span>";
						}
					}else{
						if(today < arrTimDte[inx]){
							timDteTxt += "<em class='accent'>"+ dd + "일 </em>";
						}else{
							timDteTxt += "<span class='txt_gray2'>"+ dd + "일 </em>";
						}
					}
				}else{
					if(today < arrTimDte[inx]){
						timDteTxt += yyyy + "년 " + mm + "월 " +"<em class='accent'>"+ dd + "일 </em>";
					}else{
						timDteTxt += yyyy + "년 " + mm + "월 " +"<span class='txt_gray2'>"+ dd + "일 </span>";
					}
				}			
			}
			exdtDtl = timDteTxt;
		}else if(adtnPrdChcVal[1] == "2"){	//정기권
			infoDtl = adtnPrdChcVal[7] +" 정기권/"+ adtnPrdChcVal[2] +"일/"+ adtnPrdChcVal[4] +"/"+ adtnPrdChcVal[3];
			exdtStt = exdtStt.substring(0,4)+"."+exdtStt.substring(4,6)+"."+exdtStt.substring(6,8);
			exdtEnd = exdtEnd.substring(0,4)+"."+exdtEnd.substring(4,6)+"."+exdtEnd.substring(6,8);
			exdtDtl = "해당 상품의 사용기간은 "+exdtStt+"~"+exdtEnd+" 입니다. 사용기간 중에만 사용이 가능합니다.";
		}

		$("#"+prdTypeAdtnPrdInfo).html(infoDtl);
		$("#"+prdTypeAdtnPrdExdt).html(exdtDtl);
		$("#adtnCpnNo").val(adtnPrdChcVal[0]);
		$("#tissuAmtView").text("0원");
	}else{
		$("#"+prdTypeNumList).removeClass('add');
		$("#"+prdTypeAdtnPrdListDiv).css("display","block");
		$("#"+prdTypeAdtnPrdInfo).css("display","none");
		$("#"+prdTypeInfoMsg).removeClass("show");
		$("#"+prdTypeIndvDtlInfo).css("display","none");
		$("#adtnPrdInpYn").val("N");
	}
	
	// 20211218 티머니GO App 
	if (tmeneyGo == "TGO"){
		alert("티머니GO App 에서 발행한 부가상품은 홈페이지에서 사용할 수 없습니다.\n" +
				"티머니GO App을 이용해 주세요.");
		location.reload();
		return;
	}
	
	fnChgCfmBtn();
	payH();
}



function fnGetMbrsAdtnVal(prdType,obj){
	$("#adtnPrdVldChkYn").val("Y");
	var adtnPrdChcVal = obj.value.split(":");
	var adtnPrdprdTypeDeprNm = "adtnPrd"+prdType+"DeprNm";
	var adtnPrdprdTypeArvlNm = "adtnPrd"+prdType+"ArvlNm";
	var adtnPrdprdTypeClsNm = "adtnPrd"+prdType+"ClsNm";
	var adtnPrdprdTypePubSno = "adtnPrd"+prdType+"PubSno";
	var adtnPrdprdTypeExdt = "adtnPrd"+prdType+"Exdt";

	$("#"+adtnPrdprdTypeDeprNm).text(adtnPrdChcVal[1]);
	$("#"+adtnPrdprdTypeArvlNm).text(adtnPrdChcVal[2]);
	$("#"+adtnPrdprdTypeClsNm).text(adtnPrdChcVal[4]);
	$("#"+adtnPrdprdTypePubSno).text(adtnPrdChcVal[0]);
	$("#"+adtnPrdprdTypeExdt).text(adtnPrdChcVal[6]);

	$("#adtnPrdPubChtkSno").val(adtnPrdChcVal[0]);
	$("#adtnPrdAutho").val("");
}



function fnAdtnPrdInfoMod(prdType){ //입력데이터 수정
	var cnt = $("#adtnPrdVldCnt").val();
	
	fnSetAdtnPrdInvl(prdType);//부가상품 데이터 초기화
	var prdTypeAdtnPrdListDiv = prdType+"AdtnPrdListDiv";
	var prdTypeInfoInput = prdType+"InfoInput";
	var prdTypeInfoMsg = prdType+"InfoMsg";
	var prdTypeIndvDtlInfo = prdType+"IndvDtlInfo";
	var adtnPrdInpYn = $("#adtnPrdInpYn").val();
	var prdTypeAdtnPrdList = prdType+"AdtnPrdList";//select box
	$("#"+prdTypeAdtnPrdList).val("999").attr("selected","selected");
	$("#"+prdTypeAdtnPrdList).selectric();
	if(cnt > 0 && adtnPrdInpYn == "N"){ //select box 입력이면서 select box 값이 1이상일경우.
		$("#"+prdTypeAdtnPrdListDiv).css("display","block");
		$("#"+prdTypeInfoInput).css("display","block");
		$("#"+prdTypeInfoMsg).removeClass("show");
		$("#"+prdTypeIndvDtlInfo).css("display","none");
	}else{
		$("#"+prdTypeAdtnPrdListDiv).css("display","none");
		$("#"+prdTypeInfoInput).css("display","block");
		$("#"+prdTypeInfoMsg).removeClass("show");
		$("#"+prdTypeIndvDtlInfo).css("display","none");
	}
	$("#adtnPrdVldChkYn").val("N");
	$("#adtnPrdPubChtkSno").text("");
	$("#adtnCpnNo").val("");
	$("#adtnPrdAutho").text("");
	payH();
}



function fnSetAdtnPrdInvl(){
	if (is_select("perdAdtnPrdList")){
		$("#perdAdtnPrdList").val("0").attr("selected","selected");
		$("#perdAdtnPrdList").selectric();
	}
	$("#adtnCpnNo").val("");
	if (is_select("frpsAdtnPrdList")){
		$("#frpsAdtnPrdList").val("0").attr("selected","selected");
		$("#frpsAdtnPrdList").selectric();
	}
	$("#adtnCpnNo").val("");
	$("#perdAdtnPrdInfo").html("정기권 번호를 선택해주세요.");
	$("#frpsAdtnPrdInfo").html("프리패스 번호를 선택해주세요.");
	$("#perdAdtnPrdExdt").html("사용기간 중에만 사용이 가능합니다.");
	$("#frpsAdtnPrdExdt").html("사용기간 중에만 사용이 가능합니다.");
}



function fnMoticketYn(){
	if(!$("#nomoTicketSpan").hasClass("active")){
		var popTchange = $('[data-remodal-id=popTchange]').remodal().open();
	}
}


/* 결제단계에서 좌석선택 단계로 갈경우 선점 취소프로세스, 결제단계에서는 전단계로 가지 못하도록 정책변경으로 주석처리
function fnGoSatsChc(){
	$("#cancPcpyNoAll").val($("#pcpyNoAll").val());
	var satsPcpyCancFrm = $("form[name=satsPcpyCancFrm]").serialize() ;
	$.ajax({	
        url      : "/mrs/satsPcpyCanc.ajax",
        type     : "post",
        data : satsPcpyCancFrm,
        dataType : "json",
        async    : true,
        success  : function(satsPcpyCancMap){
        	if(satsPcpyCancMap.MSG_CD == "S0000"){
        		$("#stplCfmPymFrm").attr("action","/mrs/satschc.do");
        		$("#stplCfmPymFrm").submit();
        	}
        }
	});
}*/



function fnValYnChk(){
	var allChk = "Y";
	if($("input:checkbox[id='agree1']").is(":checked") == false){
		allChk = "N";
	}
	if($("input:checkbox[id='agree2']").is(":checked") == false){
		allChk = "N";
	}
	if($("input:checkbox[id='agree3']").is(":checked") == false){
		allChk = "N";
	}
	var nonMbrsYnChk = $("#nonMbrsYn").val();
	if(nonMbrsYnChk == "Y"){
		// 20210218 yahan
//		var phoneNum1Val = $("#phoneNum11").val()+""+$("#phoneNum12").val()+""+$("#phoneNum13").val();
//		if(phoneNum1Val == "" || phoneNum1Val.length < 10 ){
//			allChk = "N";
//		}	
//		if($("#nonMbrsPw").val().length < 4 || $("#nonMbrsPwChk").val().length < 4 || ($("#nonMbrsPw").val() != $("#nonMbrsPwChk").val())){
//			allChk = "N";
//		}
		if ($("#nonMbrsAuthYn").val() != "Y"){
			allChk = "N";
		}
	}
	
	if($("input:radio[id='payType6']").is(":checked")){ // 간편결제
		if($("#payBirth").val().length != 6){
			allChk = "N";
		}
		if ($("input:radio[name='pynDtlCd']:checked").length == 0){
			allChk = "N";
		}
	}
	else if($("input:radio[id='payType1']").is(":checked")){ // 카드결제 체크
		if($("#cardNum1").val().length < 4 || $("#cardNum2").val().length < 4 || $("#cardNum3").val().length < 4 || $("#cardNum4").val().length == 0){
			allChk = "N";
		}
		if($("#cardMonth").val().length < 2 || $("#cardYear").val().length < 2){
			allChk = "N";
		}
		if($("#cardMonth").val().length == 2 && (Number($("#cardMonth").val()) <= 0 || Number($("#cardMonth").val()) > 12)){
			allChk = "N";
		}
		if($("#cardPw").val().length < 2){
			allChk = "N";
		}
		if($("input:radio[id='caPerson']").is(":checked")){
			if($("#caBirth").val().length != 6){
				allChk = "N";
			}
		}
		if($("input:radio[id='caCompany']").is(":checked")){
			if($("#comNumCard").val().length < 10){
				allChk = "N";
			}
		}
	}else if($("input:radio[id='payType2']").is(":checked")){//계좌이체
		if($("#acBirth").val().length != 6){
			allChk = "N";
		}
	
//		if($("input:radio[id='receiptPhone']").is(":checked")){
//			if($("#phoneNum2").val() == "" || $("#phoneNum2").val().length < 10 ){
//				allChk = "N";
//			}	
//		}
//		
//		if($("input:radio[id='receiptCard']").is(":checked")){
//			if($("#reCardNum1").val().length < 4 || $("#reCardNum2").val().length < 4 || $("#reCardNum3").val().length < 4 || $("#reCardNum4").val().length < 4){
//				allChk = "N";
//			}
//		}
		// 20201124 yahan
		if($("input:radio[id='receiptPerson']").is(":checked")){
			var value = $("#receiptPersonSelect").val();
			if (value == "receiptPhone") {
				if($("#phoneNum2").val() == "" || $("#phoneNum2").val().length < 10 ){
					allChk = "N";
				}
			} else {
				if($("#reCardNum1").val().length < 4 || $("#reCardNum2").val().length < 4 || $("#reCardNum3").val().length < 4 || $("#reCardNum4").val().length < 4){
					allChk = "N";
				}
			}
		}
		if($("input:radio[id='receiptBusiness']").is(":checked")){
			var value = $("#receiptBusinessSelect").val();
			if (value == "receiptBizn") {
				if($("#reBiznNum1").val().length < 3 || $("#reBiznNum2").val().length < 2 || $("#reBiznNum3").val().length < 5){
					allChk = "N";
				}
			} else {
				if($("#reCardNum1").val().length < 4 || $("#reCardNum2").val().length < 4 || $("#reCardNum3").val().length < 4 || $("#reCardNum4").val().length < 4){
					allChk = "N";
				}
			}
		}
//		if($("input:radio[id='receiptNone']").is(":checked")){
//		}

		
	}else if($("input:radio[id='payType3']").is(":checked")){	// 정기권 선택시
		var payType = "perd";
		if($("#adtnCpnNo").val() == ""){
			allChk = "N";
		}				
	}else if($("input:radio[id='payType4']").is(":checked")){	// 프리패스 선택시
		var payType = "frps";
		if($("#adtnCpnNo").val() == ""){
			allChk = "N";
		}		
	}
	else if($("input:radio[id='payType5']").is(":checked")){
		if($("#coBirth2").val().length != 6){
			allChk = "N";
		}
		if($("#mileagePymYn").val() == "C" || $("#mileagePymYn").val() == "N"){
			allChk = "N";
		}
	}
	return allChk;
}



function fnSelCardCam(){
	if($("#cardKndCd").val() != "0"){
		$("#cardKindList").find('.label').addClass('add');
	}else{
		$("#cardKindList").find('.label').removeClass('add');
	}
}



function fnUseMileageVal(){
	$("#loading").show();
	var stplCfmPymFrm = $("form[name=stplCfmPymFrm]").serialize() ;
	$.ajax({	
        url      : "/mrs/useMileageVal.ajax",
        type     : "post",
        data : stplCfmPymFrm,
        dataType : "json",
        async    : true,
        success  : function(useMileageValMap){
        	if(useMileageValMap.MSG_CD == "S0000"){//사용가능 마일리지 조회성공
        		var tissuAmt = $("#tissuAmt").val();
        		var useMileage = useMileageValMap.MLG_AMT;
        		var psnMileageVal = "";
        		var ddtnMileageVal = "";
        		if(Number(useMileage) >= Number(tissuAmt)){//보유마일리지가 사용할 마일리지보다 클경우
        			psnMileageVal = comma(useMileage)+" M";
        			ddtnMileageVal = "<strong class='accent'>"+comma(tissuAmt)+"</strong>M";
        			$("#psnMileage").html(psnMileageVal);
        			$("#psnMileage").removeClass("lack");
        			$("#ddctMileage").html(ddtnMileageVal);
        			$("#tissuAmtView").text(comma(tissuAmt)+" M");
        			$("#mileagePymYn").val("Y");
        		}else{
        			psnMileageVal = comma(useMileage)+" M <span class='error_txt'>마일리지 잔액이 부족합니다.</span>";
        			ddtnMileageVal = "<strong class='accent'>"+comma(tissuAmt)+"</strong>M";
        			$("#psnMileage").html(psnMileageVal);
        			$("#psnMileage").addClass("lack");
        			$("#ddctMileage").html(ddtnMileageVal);
        			$("#tissuAmtView").text("0 M");
        			$("#mileagePymYn").val("C");
        		}
        		fnChgCfmBtn();
        	}else{
        		var errMsgNm = "";
        		if(useMileageValMap.MSG_CD == "ERR"){
        			errMsgNm = "마일리지 조회에 실패하였습니다. 잠시 후 다시 시도해주세요.";
        		}else{
        			errMsgNm = useMileageValMap.MSG_DTL_CTT;
        		}
        		alert(errMsgNm);
        		$("#adtnPrdPayType").val("");
        		$("#payType1").click();
        	}
        },
        error : function(){
        	alert("마일리지 조회에 실패하였습니다. 잠시 후 다시 시도해주세요.");
        	$("#adtnPrdPayType").val("");
        	$("#payType1").click();
        },
    	complete:function(){
    		$("#loading").hide();
    	}
	});
}



function fnMileagePym(chkVal){
	if(chkVal == "Y"){
		$("#adtnPrdBirth").val($("#coBirth2").val());
		payType="mileage";
		$("#pymType").val(payType);
		
		fnStplCfmPym();
	}
	
}




function fnVldtMileage(){
	if($("#coBirth2").val().length != 6){
		alert("생년월일을 정확하게 입력하시기 바랍니다.");
		return false;
	}
	if($("#mileagePymYn").val() == "C"){
		alert("마일리지 잔액이 부족합니다.");
		return false;
	}else if($("#mileagePymYn").val() == "N"){
		alert("마일리지 발권이 불가능합니다.");
		return false;
	}
	
	return true;
}

function onSelectChange(obj, input_val, input_name){
	$("#"+input_name).val(input_val);
	dropdown_process(obj);

	if (input_name == 'perdAdtnPrdList'){
		fnAdtnPrdMod('perd',input_val);
	}
	if (input_name == 'frpsAdtnPrdList'){
		fnAdtnPrdMod('frps',input_val);
	}
}

function setMipMm(value){
	$('#mipMm').val(value);
}



document.addEventListener("DOMContentLoaded", function () {
  const accountMap = {
    kb: "국민은행 123-456-7890",
    shinhan: "신한은행 987-654-3210",
    hana: "하나은행 111-222-3333",
    woori: "우리은행 444-555-6666"
  };

  const bankSelect = document.getElementById("bank");
  const accountEl = document.getElementById("account");

  if (bankSelect) {
    bankSelect.addEventListener("change", function () {
      accountEl.textContent = "계좌번호: " + (accountMap[this.value] || "");
    });
  }
});

