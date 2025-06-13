var allDeprList       = []; // 출발지 리스트
var allRotInfAllList  = []; // 노선 전체 리스트
var allRotInfrLen     = 0;  // 노선 전체 데이터 건수
var allplen = 0; // tab 구분자
var allPrchAmt = 0; // 할부 개월수를 표시할지 말지

$(document).ready(function() {
	$("#tmpPsbYN").css('display', 'none');		// 임시차 문구
	$("#divTermDesc").css('display', 'none');	// 사용기간 문구
	
	$("#payType1").prop("checked");
	
	
	/**
	 * 20200602 yahan 프리패스 할인구매는 6/15일 이후부터 사용가능
	 */
	var min = 0;
//	if ($("#frpsPrchGdEvent").val() == "Y"){
//		var dt = new Date();		//오늘날짜 전체
//		var yyyy  = dt.getFullYear();		//선택한 년도
//		var mm    = dt.getMonth()+1;		//선택한 월
//		var mm2Len = Number(mm) < 10 ? "0"+mm : mm;			// 선택ㅡㅜ?ㅌ월 ex:01 두글자로 변환
//		var ddTo    = Number(dt.getDate()) < 10 ? "0"+dt.getDate() : dt.getDate(); 			// 숫자형
//		var yymmdd = yyyy+""+mm2Len+""+ddTo;		//오늘날짜
//
//		if (yymmdd < 20200615) {
//			min = 15 - dt.getDate();
//		}
//	}
	var max = min+10;
	
	
	
	//사용시작일 	
	$('#datepickerItem').datepicker({
		showOn:"button",
		buttonImage:"/koBus/images/ico_calender.png",
		buttonImageOnly:true,
		buttonText:"사용시작일 선택 달력",
		minDate: min,
		maxDate: max,
		beforeShow: function(){
			var date_offset = $(this).parents('.date_picker_wrap').offset();
			var date_width  = $(this).parents('.date_picker_wrap').outerWidth();
			var date_height = $(this).parents('.date_picker_wrap').outerHeight();
			var picker_width = $('#ui-datepicker-div').outerWidth();
			if($('body').width() == 320){
				setTimeout(function(){
					$('#ui-datepicker-div').css({
						"top" : date_offset.top + date_height ,
						"left" : 0
					});
				});
			}else {
				setTimeout(function(){
					$('#ui-datepicker-div').css({
						"top" : date_offset.top + date_height ,
						"left" : (date_offset.left + date_width) - picker_width
					});
				});
			}
		},
		beforeShowDay: disableAllTheseDays
	});
	
	// 특정날짜들 배열
	var disabledDays = ["2019-4-18"];
	
	// 특정일 선택막기
	function disableAllTheseDays(date) {
		var m = date.getMonth(), d = date.getDate(), y = date.getFullYear();
		for (i = 0; i < disabledDays.length; i++) {
			if($.inArray(y + '-' +(m+1) + '-' + d,disabledDays) != -1) {
				return [false];
			}
		}
		return [true];
	}
	
	//오늘날짜
	var dtOp= new Date();	
	var yyyyOp = dtOp.getFullYear();
	var mmOp   = dtOp.getMonth()+1;
	var ddOp   = dtOp.getDate();
	var mm2LenOp = Number(mmOp) < 10 ? "0"+mmOp : mmOp;
	var dd2LenOp = Number(ddOp) < 10 ? "0"+ddOp : ddOp;
	
	var openDt = yyyyOp +""+ mm2LenOp +""+ dd2LenOp;
	
	var dt0 = new Date();
	var dt1 = new Date();
	var dt = new Date();	
	
	if(openDt == "20190417"){
		dt0.setDate(dt1.getDate()+2);
		dt1.setDate(dt1.getDate()+2);		
		dt.setDate(dt.getDate()+2);
	}else{
		/**
		 * 20200602 yahan
		 */
//		dt0.setDate(dt1.getDate()+1);
//		dt1.setDate(dt1.getDate()+1);		
//		dt.setDate(dt.getDate()+1);
		dt0.setDate(dt1.getDate()+min);
		dt1.setDate(dt1.getDate()+min);		
		dt.setDate(dt.getDate()+min);
	}
	
	var yyyy = dt.getFullYear();
	var mm   = dt.getMonth()+1;
	var week = new Array('일','월','화','수','목','금','토');
	var dd   = dt.getDate();
	var wkdy = week[dt.getDay()];
	var yyDtm = yyyy+". "+mm+". "+dd+". "+wkdy;
	var mm2Len = Number(mm) < 10 ? "0"+mm : mm;
	var dd2Len = Number(dd) < 10 ? "0"+dd : dd;
	var dd0    = Number(dt0.getDate()) < 10 ? "0"+dt0.getDate() : dt0.getDate();
	var dd1    = Number(dt.getDate()) < 10 ? "0"+(dt.getDate()) : (dt.getDate());
	
	var yymmdd = yyyy+""+mm2Len+""+dd2Len;
	var yymmddD0 = yyyy+""+mm2Len+""+dd0;
	
	$(".text_date1").text(yyDtm);
	$("#exdtSttDt").val(yymmdd);
	
	$('#datepickerItem').on('change', function(){
		fnYyDtmStup($('#datepickerItem').val());
		$('.datepicker-active').focus();
		$('.datepicker-btn').removeClass('datepicker-active');
	});
	
	fnFrpsDtl();
	
	fnSetCardCam();
	
	$("#goPrdprchFn").click(function () {
    // 이용약관
    if (!$("#agree1").is(":checked")) {
        $('#agree1').focus();
        alert("서비스 이용약관에 동의해 주세요.");
        return;
    }
    if (!$("#agree2").is(":checked")) {
        $('#agree2').focus();
        alert("운송 약관에 동의해 주세요.");
        return;
    }
    if (!$("#agree3").is(":checked")) {
        $('#agree3').focus();
        alert("개인정보 취급방침에 동의해 주세요.");
        return;
    }

    // 사용시작일 
    if ($("#exdtSttDt").val() == "") {
        $('#datepickerItem').focus();
        alert("사용시작일을 선택해 주세요. \n (사용시작일은 금일로부터 10일이내 선택이 가능합니다.)");
        return;
    }

    // 생년월일 유효성
    if ($("#mbrsBrdt").val().length != 6) {
        alert("구매자 생년월일 6자리를 입력해주세요.");
        $("#mbrsBrdt").focus();
        return;
    }

    // 구매옵션
    if ($("#selOption").val() == "0" || $("#selOption").val() == "") {
        alert("구매옵션을 선택해주세요.");
        $('#optSelectric').focus();
        return;
    }

    // 결제 전 사용자 확인
    if (!confirm("결제하시겠습니까?")) {
        return;
    }

    // 포트원 결제 실행
    requestPay();  // 아래에 정의
});
	

	// 캘린더 오늘 텍스트 추가
	$("#ui-datepicker-div").datepicker({
		beforeShowDay: function(date) {
			const today = new Date();
			
			if (date.getFullYear() === today.getFullYear() && date.getMonth() === today.getMonth() && date.getDate() === today.getDate()) {
				return [true, "ui-datepicker-today", "오늘"];
			}
			return [true, ""];
		},
//		onSelect: function() {
//			addTodaySpan();
//		}
	});
	
	$(".ui-datepicker-trigger").on("click", function() {
		setTimeout(addTodaySpan, 50);
		$(this).parent().addClass('datepicker-active');
		$("#ui-datepicker-div").focus();
		$(".ui-state-disabled").attr("tabindex", "-1");
		$(".ui-datepicker-prev, .ui-datepicker-next").attr("href", "javascript:void(0)");
	});
	$(".ui-corner-all").on("click", function() {
		setTimeout(addTodaySpan, 50);
		$("#ui-datepicker-div").focus();
		$(".ui-state-disabled").attr("tabindex", "-1");
		$(".ui-datepicker-prev, .ui-datepicker-next").attr("href", "javascript:void(0)");
	});
	
	function addTodaySpan() {
		const $todayTd = $('td.ui-datepicker-today');
		const $activeLink = $('td.ui-datepicker-current-day a');		
		
		if ($todayTd.length && !$todayTd.find('.today').length) {
			$todayTd.append('<span class="today">오늘</span>');
		}
		
		if ($activeLink) {
			$activeLink.attr('title', '선택됨');
		}
	}
});

//부가상품 상세 조회
function fnFrpsDtl(){
	var frpsPrchFrm = $("form[name=frpsPrchFrm]").serialize() ;
	$.ajax({	
	    url      : "/koBus/adtnprdnew/frps/readFrpsDtlInf.ajax",
	    type	 : "post",
	    data 	 : frpsPrchFrm,
	    dataType : "json",
	    success  : function(arrList){	
	    	var allDtlInfAllList  = []; // 부가상품 전체 리스트
	    	var deprAll ="";
	     	allDtlrLen = arrList.len;
	    	for(var inx = 0 ; inx < allDtlrLen ; inx++){					//8.for문으로 return받은 map안의 list정보들을 빼와서 다시 이중배열에 넣기
	    		allDtlInfAllList[inx] = new Array();								//8.1 javascript에선 이중배열을 쓸수 없기 때문에 list생성후 배열을 뒤에 붙여야한다.
	    		allDtlInfAllList[inx][0] = arrList.adtnDtlList[inx].adtnPrdUseClsCd;	//부가상품사용등급코드
	    		allDtlInfAllList[inx][1] = arrList.adtnDtlList[inx].adtnPrdUseClsNm;	//부가상품사용등급명
	    		allDtlInfAllList[inx][2] = arrList.adtnDtlList[inx].adtnPrdUsePsbDno;	//부가상품사용가능일수
	    		allDtlInfAllList[inx][3] = arrList.adtnDtlList[inx].adtnPrdUseNtknCd;	//부가상품사용권종코드 
	    		allDtlInfAllList[inx][4] = arrList.adtnDtlList[inx].adtnPrdUseNtknNm;	//부가상품사용권종명
	    		allDtlInfAllList[inx][5] = arrList.adtnDtlList[inx].wkdWkeNtknCd;		//주중주말권종코드
	    		allDtlInfAllList[inx][6] = arrList.adtnDtlList[inx].wkdWkeNtknNm;		//주중주말권종명
	    		allDtlInfAllList[inx][7] = arrList.adtnDtlList[inx].tempAlcnTissuPsbYn;	//임시배차발권가능여부
	    		allDtlInfAllList[inx][8] = arrList.adtnDtlList[inx].adtnPrdSno;			//부가상품일련번호
	    		allDtlInfAllList[inx][9] = arrList.adtnDtlList[inx].adtnDcYn;			//할인부가상품여부
	    	}	
	
	    	/*var weekItem = "";
	    	var kindItem = "";
	    	var gradeItem = "";
	    	        	
	    	for(var inx=0; inx < allDtlrLen ; inx++){
	    		if(inx == 0 || (inx > 0 && allDtlInfAllList[inx][3] != allDtlInfAllList[inx-1][3])){
	    			kindItem += "<span class=\"custom_radio type3\"><input type=\"radio\" id=\"adtnPrdUseNtknCd"+inx+"\" name=\"adtnPrdUseNtknCd\" value="+allDtlInfAllList[inx][3]+" onclick=\"fnSelPrdKind('"+allDtlInfAllList[inx][4]+"')\"><label for=\"adtnPrdUseNtknCd"+inx+"\"><span>"+allDtlInfAllList[inx][4]+"</span></label></span>";
	    		}
	    		if(inx == 0 || (inx > 0 && allDtlInfAllList[inx][0] != allDtlInfAllList[inx-1][0])){
	    			gradeItem += "<span class=\"custom_radio type3\"><input type=\"radio\" id=\"adtnPrdUseClsCd"+inx+"\" name=\"adtnPrdUseClsCd\" value="+allDtlInfAllList[inx][0]+" onclick=\"fnSelPrdGrade('"+allDtlInfAllList[inx][1]+"')\"><label for=\"adtnPrdUseClsCd"+inx+"\"><span>"+allDtlInfAllList[inx][1]+"</span></label></span>";
	    		}        		
	    		if(inx == 0 || (inx > 0 && allDtlInfAllList[inx][5] != allDtlInfAllList[inx-1][5])){
	    			weekItem += "<span class=\"custom_radio type3\"><input type=\"radio\" id=\"wkdWkeNtknCd"+inx+"\" name=\"wkdWkeNtknCd\" value="+allDtlInfAllList[inx][5]+" onclick=\"fnSelPrdWeek('"+allDtlInfAllList[inx][6]+"')\"><label for=\"wkdWkeNtknCd"+inx+"\"><span>"+allDtlInfAllList[inx][6]+"</span></label></span>";
	    		}
	    	}
	    	*/
	    	
	    	
	    	// select
	    	if (is_select("selOption")){
		    	var blockItem = "<option value='0'>구매옵션을 선택하세요.</option>";
	        	var blockSubItem = "";
	        	var tmpAlcnYn = "";
	        	var saleAlcnYn = "";
	        	var itemNo = 1;
	        	
	        	for(var inx=0; inx < allDtlrLen ; inx++){
	        		if(allDtlInfAllList[inx][7] == "Y"){
	        			tmpAlcnYn = " / 임시";
	        		}else{
	        			tmpAlcnYn = "";
	        		}
	        		/**
	        		 * 20200520 yahan
	        		 */
	        		if(allDtlInfAllList[inx][9] == "Y"){
	        			saleAlcnYn = "할인 ";
	        		}else{
	        			saleAlcnYn = "";
	        		}
	        		
	        		/**
	        		 * 20200601 yahan
	        		 * 이벤트 일때는 할인권만 노출
	        		 */
	        		if ($("#frpsPrchGdEvent").val() == "Y" && allDtlInfAllList[inx][9] == "Y" ||
	        			$("#frpsPrchGdEvent").val() != "Y" && allDtlInfAllList[inx][9] != "Y" 	) {
	        			
	        			blockItem += "<option value="+allDtlInfAllList[inx][3]+"/"+allDtlInfAllList[inx][0]+"/"+allDtlInfAllList[inx][5]+"/"+allDtlInfAllList[inx][2]+"/"+allDtlInfAllList[inx][7]+"/"+allDtlInfAllList[inx][8]+">" + saleAlcnYn + allDtlInfAllList[inx][2] + "일권 / " + allDtlInfAllList[inx][1] + " / " + allDtlInfAllList[inx][6] + " / " + allDtlInfAllList[inx][4]+tmpAlcnYn+"</option>";
	        		}
	        	}
	
	        	$("#selOption").html(blockItem);
	        	$("#selOption").selectric();
	    	}
	    	// input
	    	else{
		    	var blockItem = "<li><a href=\"javascript:void(0)\" onclick=\"onSelectChange(this,'0', 'selOption')\">구매옵션을 선택하세요</a></li>";
	        	var blockSubItem = "";
	        	var tmpAlcnYn = "";
	        	var saleAlcnYn = "";
	        	var itemNo = 1;
	        	
	        	for(var inx=0; inx < allDtlrLen ; inx++){
	        		if(allDtlInfAllList[inx][7] == "Y"){
	        			tmpAlcnYn = " / 임시";
	        		}else{
	        			tmpAlcnYn = "";
	        		}
	        		/**
	        		 * 20200520 yahan
	        		 */
	        		if(allDtlInfAllList[inx][9] == "Y"){
	        			saleAlcnYn = "할인 ";
	        		}else{
	        			saleAlcnYn = "";
	        		}
	        		
	        		/**
	        		 * 20200601 yahan
	        		 * 이벤트 일때는 할인권만 노출
	        		 */
	        		if ($("#frpsPrchGdEvent").val() == "Y" && allDtlInfAllList[inx][9] == "Y" ||
	        			$("#frpsPrchGdEvent").val() != "Y" && allDtlInfAllList[inx][9] != "Y" 	) {
	        			
	        			var val = allDtlInfAllList[inx][3]+"/"+allDtlInfAllList[inx][0]+"/"+allDtlInfAllList[inx][5]+"/"+allDtlInfAllList[inx][2]+"/"+allDtlInfAllList[inx][7]+"/"+allDtlInfAllList[inx][8];
	        			var txt = saleAlcnYn + allDtlInfAllList[inx][2] + "일권 / " + allDtlInfAllList[inx][1] + " / " + allDtlInfAllList[inx][6] + " / " + allDtlInfAllList[inx][4]+tmpAlcnYn;
	        			blockItem += "<li><a href=\"javascript:void(0)\" onclick=\"onSelectChange(this,'"+ val +"', 'selOption')\">"+ txt +"</a></li>";
	        		}
	        	}
	        	
	        	$("#selOptionLi").html(blockItem);
	    	}
	    	/*$("#kindList").html(kindItem);
	    	$("#gradeList").html(gradeItem);
	    	$("#weekList").html(weekItem);*/
	    	
	    	$("#weekTd").html("");
	    	$("#kindTd").html("");
	    	$("#gradeTd").html("");
	    	$("#fulTermTd").html("");
	    	$("#pubAmt").html("0 원");
	    	$("#goodsPrice").val(0); // 20241010 간편결제 금액설정
	    	$("#divTermDesc").css('display', 'none');
	    },
	    error:function (e){
	        //alert("connection error");
	    }
	});
	
}

//이용권종 클릭시
function fnSelPrdKind(val){
	$("#kindTd").html(val);
}

//버스이용등급 클릭시
function fnSelPrdGrade(val){
	$("#gradeTd").html(val);
}

//상품종류 클릭시
function fnSelPrdWeek(val){
	if($("#mbrsBrdt").val() == ""){
		alert("생년월일을 입력해주세요.");
		$("input:radio[name='wkdWkeNtknCd']").prop("checked",false);
		$("#mbrsBrdt").focus();
		return;
	}
	if($("input:radio[name=adtnPrdUseNtknCd]:checked").length == 0){
		alert("이용권종을 선택해주세요.");
		$("input:radio[name='wkdWkeNtknCd']").prop("checked",false);
		return;
	}else{
		$("#kindTd").html();	
	}
	if($("input:radio[name=adtnPrdUseClsCd]:checked").length == 0){
		alert("버스이용등급을 선택해주세요.");
		$("input:radio[name='wkdWkeNtknCd']").prop("checked",false);
		return;
	}
	$("#weekTd").html(val);
	
	//사용 가능 일수 세팅
	if($("input:radio[name='wkdWkeNtknCd']:checked").val() == "1"){
		$("#adtnPrdUsePsbDno").val("7");	
	}else if($("input:radio[name='wkdWkeNtknCd']:checked").val() == "2"){
		$("#adtnPrdUsePsbDno").val("4");
	}else if($("input:radio[name='wkdWkeNtknCd']:checked").val() == "3"){
		$("#adtnPrdUsePsbDno").val("5");
	}	
	//유효기간 가져오기
	fnAdtnVldTerm();
}

//옵션 선택시  
function fnSelOption(value){
	var optVal = value; 
	
	if(optVal == "0"){
		alert("구매옵션을 선택해주세요.");
		$("#tmpPsbYN").css('display', 'none');
		$("#divTermDesc").css('display', 'none');
		
		// 20200513 yahan
		$("#adtnPrdUseNtknCd").val('');
		$("#adtnPrdUseClsCd").val('');
		$("#wkdWkeNtknCd").val('');
		$("#adtnPrdUsePsbDno").val('');
		$("#adtnPrdSno").val('');
		
		return;
	}
	
	var opt = optVal.split("/");	
	$("#adtnPrdUseNtknCd").val(opt[0]);
	$("#adtnPrdUseClsCd").val(opt[1]);
	$("#wkdWkeNtknCd").val(opt[2]);
	$("#adtnPrdUsePsbDno").val(opt[3]);
	$("#adtnPrdSno").val(opt[5]);
	
	//var optTxt = obj.text();
	//var txt = $("#selOption option:checked").text().split("/");
	var txt = '';
	if (is_select("selOption")){
		txt = $("#selOption option:selected").text().split("/");
	} else{
		txt = $("#selOptionText").val().split("/");
	}

	$("#kindTd").html(txt[0]);
	$("#gradeTd").html(txt[1]);
	$("#weekTd").html(txt[2]);
	//$("#dayTd").html(txt[3]+"일권");
	
	//임시차 가능여부 문구 노출	
	if(opt[4] == "Y"){
		$("#tmpPsbYN").html("※ 해당 옵션은 임시차 배차도 사용 가능합니다.");
			
	}else{
		$("#tmpPsbYN").html("※ 해당 옵션은 임시차 배차는 사용 불가합니다.");		
	}
	$("#tmpPsbYN").css('display', 'block');
	
	//유효기간 가져오기
	fnAdtnVldTerm();
	$("#divTermDesc").css('display', 'block');
		
}

//유효기간 가져오기
function fnAdtnVldTerm(){		
	
	var frpsPrchFrm = $("form[name=frpsPrchFrm]").serialize() ;
	$.ajax({	
        url      : "/koBus/adtnprdnew/frps/readFrpsVldTerm.ajax",
        type	 : "post",
        data 	 : frpsPrchFrm,
        dataType : "json",
        success  : function(termMap){	
        	
        	console.log(termMap);

			// 20200515 yahan
			if (termMap.adtnDupPrchYn == "Y" &&
				confirm("동일노선 사용일이 중복되는 프리패스가 있습니다.\n\n추가 구매하시겠습니까?") != true){
        		fnReset();
        		return;

			}
        	
        	if(termMap.rotAllCnt > 0){  
        		if(termMap.termSttDt != $("#exdtSttDt").val()){
        			alert("해당 상품은 선택하신 사용 시작일과 상품의 시작일이 일치 하지 않아 사용시작일이 변경적용 됩니다. ");
        			var getExdt = termMap.termSttDt;
            		var dt = new Date(Number(getExdt.substring(0,4)),Number(getExdt.substring(4,6))-1,Number(getExdt.substring(6,8)));
                	var yyyy = dt.getFullYear();
                	var mm   = dt.getMonth()+1;
                	var dd   = dt.getDate();
                	var week = new Array('일','월','화','수','목','금','토');
                	var wkdy = week[dt.getDay()];
                	var yyDtm = yyyy+". "+mm+". "+dd+". "+wkdy;
                	$(".text_date1").text(yyDtm);
                	$("#exdtSttDt").val(termMap.termSttDt);
        		}
        		var getExdt = termMap.timDte;
        		var dt = new Date(Number(getExdt.substring(0,4)),Number(getExdt.substring(4,6))-1,Number(getExdt.substring(6,8)));
            	var yyyy = dt.getFullYear();
            	var mm   = dt.getMonth()+1;
            	var dd   = dt.getDate();
            	var week = new Array('일','월','화','수','목','금','토');
            	var wkdy = week[dt.getDay()];
            	var yyDtm = yyyy+". "+mm+". "+dd+". ";//+wkdy;
            	
//            	$("#valTerm").text(yyDtm+wkdy);
        		$("#fulTermTd").html(termMap.fulTerm);
        		$("#fulTerm").val(termMap.fulTerm);
        		$("#spanTermDt").html(termMap.fulTerm);
        		
        		$("#pubAmtTop").html(comma(termMap.pubAmt));
        		$("#pubAmt").html(comma(termMap.pubAmt) + " 원");
        		
        		$("#goodsPrice").val(termMap.pubAmt); // 20241010 간편결제 금액설정
        		
        		var mm2Len = Number(mm) < 10 ? "0"+mm : mm;
        		var dd2Len = Number(dd) < 10 ? "0"+dd : dd;
        		$("#exdtEndDt").val(yyyy+""+mm2Len+""+dd2Len);
        		
        		allPrchAmt = termMap.pubAmt; // 예상 금액 설정
        		
        		if(Number(termMap.pubAmt) >= 50000){ // 할부 개월 콤보박스는 5만원으로 분기
        			$("#mipMmShow").css("display","block");
	        	}else{
	        		$("#mipMmShow").css("display","none");
	        	}
        	}else{
        		alert(termMap.rcvMsgNm);  
        		fnReset();
        		return;
        	}
        },
        error:function (e){
            //alert("connection error");
        }
    });
}

function fnReset(){
	//$("#weekList").html("");
	//$("#kindList").html("");
	//$("#gradeList").html("");
	//$("#dayList").html("");
	$("#rotTd").html("");
	$("#weekTd").html("");
	$("#kindTd").html("");
	$("#gradeTd").html("");
	$("#dayTd").html("");
	//$("#valTerm").text("사용 종료일은 상품종류에 따라 자동 설정 됩니다.");
	$("#fulTermTd").html("");
	$("#pubAmt").html("0 원");
	$("#goodsPrice").val(0); // 20241010 간편결제 금액설정	
	$("#pubAmtTop").html("0");
	$("input:radio[name='adtnPrdUseClsCd']").prop("checked",false);
	$("input:radio[name='adtnPrdUseNtknCd']").prop("checked",false);
	$("input:radio[name='wkdWkeNtknCd']").prop("checked",false);
	$("#tmpPsbYN").css('display', 'none');		// 임시차 문구
	$("#divTermDesc").css('display', 'none');	// 사용기간 문구
	if (is_select("selOption")){
		$("#selOption").val("0").prop("selected",true);
		$("#selOption").selectric();
	}
	else{
		$("#selOption").val('');
	}
}

function fnFrmSubmit(){
	$("#passPrchGdFrm").attr("action","/adtnprdnew/pass/passPrch.do");
	$("#passPrchGdFrm").submit();
}

function fnYyDtmStup(dtVal){ // 날짜 계산	
	var dtItem = dtVal.split(".");
	var dtBuf = dtItem[0].trim() + (dtItem[1].trim() < 10 ? "0" + dtItem[1].trim() : dtItem[1].trim()) + (dtItem[2].trim() < 10 ? "0" + dtItem[2].trim() : dtItem[2].trim());
	
	$(".text_date1").text(dtVal);
	$("#exdtSttDt").val(dtBuf);
	
	fnFrpsDtl();
}		

function fnSetCardCam(){
	$.ajax({	
	    url      : "/mrs/cardCamList.ajax",
	    type     : "post",
	    dataType : "json",
	    success  : function(cardCamListMap){
	    	var listCnt = cardCamListMap.listCnt;
	    	var cardCdList = cardCamListMap.cardCdList;
	    	if(listCnt > 0){
	    		fnSetCardCd(listCnt,cardCdList);
	    	}else{
	    		alert("카드정보를 불러오는중 오류발생!");
	    	}
	    },
	    error : function(){
	    	alert("카드정보를 불러오는중 오류발생!");
	    }
	});
}

function fnSelCardCam(){
	if($("#cardKndCd").val() != "0"){
		$("#cardKindList").find('.label').addClass('add');
	}else{
		$("#cardKindList").find('.label').removeClass('add');
	}
}

/*fn_PrdprchFn*/
function fnStplCfmPym(){
	$('.loading').show();

	// 결재 하기
	var frpsPrchFrm = $("form[id=frpsPrchFrm]").serialize();
	
	$.ajax({	
        url      : "/adtnprdnew/frps/addFrpsPrdprchFn.ajax",
        type	 : "post",
        data	 : frpsPrchFrm,
        dataType : "json",
        success  : function(prchResultMap){	
	        if(prchResultMap.MSG_CD == "S0000"){
				// 구매 완료 페이지로 이동
	        	$('#adtnCpnNo').val(prchResultMap.ADTN_CPN_NO);
				$('#adtnDeprNm').val(prchResultMap.adtnDeprNm);
				$('#adtnArvlNm').val(prchResultMap.adtnArvlNm);
				$('#adtnPrdUseClsNm').val(prchResultMap.adtnPrdUseClsNm);
				$('#adtnPrdUseNtknNm').val(prchResultMap.adtnPrdUseNtknNm);
				$('#wkdWkeNtknNm').val(prchResultMap.wkdWkeNtknNm);
				$('#adtnPrdUsePsbDno').val(prchResultMap.ADTN_PRD_USE_PSB_DNO);
				$('#timSttDte').val(prchResultMap.timSttDte);
				$('#timEndDte').val(prchResultMap.timEndDte);
				$('#prchAmt').val(prchResultMap.prchAmt);
				$('#mipMmNum').val(prchResultMap.mipMmNum);
				
				$("#frpsPrchFrm").attr({action:'/adtnprdnew/frps/frpsPrchFn.do', method:'post'}).submit(); //전송
			}else{
				if(prchResultMap.MSG_DTL_CTT != null && prchResultMap.MSG_DTL_CTT != ""){
					alert(prchResultMap.MSG_DTL_CTT);
				} else {
					alert("현재 시스템 장애로 인하여 결제가 불가합니다. 잠시 후 다시 시도해 주세요.1");
				}
			}
			$('#caPerson').focus();
			$('.loading').hide();
        }, complete:function() {
        	$('.loading').hide();
        }, error:function (e) {
        	if(prchResultMap.MSG_DTL_CTT != null && prchResultMap.MSG_DTL_CTT != ""){
				alert(prchResultMap.MSG_DTL_CTT);
			} else {
				alert("현재 시스템 장애로 인하여 결제가 불가합니다. 잠시 후 다시 시도해 주세요.1");
			}
			$('#caPerson').focus();
        	$('.loading').hide();
        }
    });
}

function fn_tab(obj, event, len, nextf){ // 자동 탭 이동 기능
	if(event == "down"){
		allplen = obj.value.length;
	}else if(event == "up"){
		if(obj.value.length != allplen){
			allplen = obj.value.length;
			if(allplen == len){
				//nextf.focus();
			}
		}
		fn_isNumber(obj);
	}
}

function fn_isNumber(obj){ // 숫자인가
	var chkNo = Number(obj.value); // 맨 앞이 0일수 있으므로.
	var testNo = obj.value + "";
	
	if(isNaN(testNo) || isNaN(chkNo)){
		alert("숫자를 입력해 주세요!");
		obj.value = "";
	}
}

function fn_chkMonth(obj, spt){ 
	
	if((spt == 1) && ($("#cardMonth").val().length == 2)){
		// 유효기간 월
		var chkItem = $("#cardMonth").val();
		if(chkItem < 1 || chkItem > 12){
			alert("올바른 카드 유효기간(월)을 입력해주세요.");
			$("#cardMonth").val("");
		}
	}
	if((spt == 2) && ($("#caBirth").val().length == 6)){
		// 생년월일
		var item = $("#caBirth").val();
		if (Number(item) < 200000) item = '20'+item; else item = '19'+item;
		var chkItem = new Date(item.substring(0,4), item.substring(4,6), item.substring(6,8));
		if(chkItem == "Invalid Date" || Number(item.substring(4,6)) < 1 || Number(item.substring(4,6)) > 12 || Number(item.substring(6,8)) < 1 || Number(item.substring(6,8)) > 32){
			alert("올바른 생년월일을 입력해주세요.");
			$("#caBirth").val("");
		}
	}
	if((spt == 3) && ($("#mbrsBrdt").val().length == 6)){
		// 생년월일
//		var item = $("#mbrsBrdt").val();
//		var chkItem = new Date(item.substring(0,4), item.substring(4,6), item.substring(6,8));
//		if(chkItem == "Invalid Date" || Number(item.substring(4,6)) < 1 || Number(item.substring(4,6)) > 12 || Number(item.substring(6,8)) < 1 || Number(item.substring(6,8)) > 32){
//			alert("올바른 생년월일을 입력해주세요.");
//			$("#mbrsBrdt").val("");
//		}
		/**
		 * 20200709 yahan
		 */
		if (isValidDate($("#mbrsBrdt").val()) == false){
			$("#mbrsBrdt").val('');
		}
	}
	fn_isNumber(obj); 
}

function fnCardKindSel(val){
	if(val == "indl"){
		$("#indlBrdtCard").css("display","block");
		$("#cprtBrnCard").css("display","none");
		$("#userDvsCd").val("1");
		if(allPrchAmt > 50000){
			$("#mipMmShow").css("display","block");
		}else{
			$("#mipMmShow").css("display","none");
		}
	}else if(val == "cprt"){
		$("#indlBrdtCard").css("display","none");
		$("#cprtBrnCard").css("display","block");
		$("#userDvsCd").val("2");
		$("#mipMmShow").css("display","none");
	}
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

function fnVldtCard(){
	
	if($('#cardKndCd').val() == "0" || $('#cardKndCd').val() == ""){
		alert("결제에 이용하실 카드를 선택해 주세요.");
		$('a[title="카드 선택"]').focus(); // 포커스 이동
		return;
	}
	// 카드번호
	if($("#cardNum1").val() == "" || $("#cardNum1").val().length != 4){
		alert("첫 번째 카드번호 4자리를 입력해주세요.");
		$('#cardNum1').focus(); // 포커스 이동
		return;
	}
	if($("#cardNum2").val() == "" || $("#cardNum2").val().length != 4){
		alert("두 번째 카드번호 4자리를 입력해주세요.");
		$('#cardNum2').focus(); // 포커스 이동
		return;
	}
	if($("#cardNum3").val() == "" || $("#cardNum3").val().length != 4){
		alert("세 번째 카드번호 4자리를 입력해주세요.");
		$('#cardNum3').focus(); // 포커스 이동
		return;
	}
	if($("#cardNum4").val() == "" || $("#cardNum4").val().length == 0){
		// 아맥스 등 카드마다 다르므로
		$('#cardNum4').focus(); // 포커스 이동
		alert("네 번째 카드번호 4자리를 입력해주세요.");
		return;
	}
	// 카드유효기간 월
	if($("#cardMonth").val() == "" || $("#cardMonth").val().length != 2){
		alert("카드유효기간 월을 2자리 입력해주세요.");
		$('#cardMonth').focus(); // 포커스 이동
		return;
	}
	// 카드유효기간 년
	if($("#cardYear").val() == "" || $("#cardYear").val().length != 2){
		alert("카드유효기간 년을 2자리 입력해주세요.");
		$('#cardYear').focus(); // 포커스 이동
		return;
	}
	// 카드번호 비밀번호
	if($("#cardPwd").val() == "" || $("#cardPwd").val().length != 2){
		alert("카드 비밀번호를 입력해주세요.");
		$('#cardPwd').focus(); // 포커스 이동
		return;
	}
	// 생년월일
	if($("input:radio[id='caPerson']").is(":checked")){
		if($("#caBirth").val() == "" || $("#caBirth").val().length != 6){
			alert("생년월일을 입력해 주세요.");
			$('#caBirth').focus(); // 포커스 이동
			return;
		}
		// 할부 선택 
		if(allPrchAmt >= 50000 && $("#mipMm").val() == ""){
			// 5만원이상의 결제에 할부 선택을 하지 않은 경우
			alert("할부 기간을 선택해주세요.");
			$('#mipMmfocus').focus(); // 포커스 이동
			return;
		}
	}
	// 사업자등록 번호
	if($("input:radio[id='caCompany']").is(":checked")){
		var brnChkYn = fnBrnChk("card");
		if(brnChkYn == "N"){
			return false;
		}
	}		
	
	/**
	 * 20200617 yahan
	 */
	if (ajaxDecode('cardNum3') == false) { return false; }
	if (ajaxDecode('cardNum4') == false) { return false; }
	if (ajaxDecode('cardPwd') == false) { return false; }
	
	
	var cardExdt = $("#cardYear").val() + $("#cardMonth").val();
	$("#cardExdt").val(cardExdt)
	var cardNo = $("#cardNum1").val() + $("#cardNum2").val() + $("#cardNum3").val() + $("#cardNum4").val();
	$("#cardNo").val(cardNo);
	
	return true;
}

function fnVldtPay(){
//	if($("#payBirth").val().length != 6){
//		alert("간편결제 생년월일을 정확하게 입력하시기 바랍니다.");
//		$("#payBirth").focus();
//		return false;
//	}
	if ($("input:radio[name='pynDtlCd']:checked").length == 0){
		alert("간편결제 종류를 선택해 주세요.");
		$("#payNaver").focus();
		return false;
	}

	return true;
}

function fnSetCardCd(listCnt,cardCdList){
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

function onSelectChange(obj, input_val, input_name){
	$("#"+input_name).val(input_val);
	dropdown_process(obj);

	if (input_name == 'selOption'){
		$("#selOptionText").val($(obj).text());
		fnSelOption(input_val);
	}
}

function setMipMm(value){
	$('#mipMmNum').val(value);
}

var openDialog = function(closeCallback){
	var win = window.open("","pymPup","width=800,height=530,toolbar=no,menubar=no,resizable=yes");
	var payType = $("#pymType").val();//지불방법

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

	var interval = window.setInterval(function(){
		try {
			if (win == null || win.closed) {
				window.clearInterval(interval);
			}
		}
		catch(e){
			
		}
	}, 1000);
	return win;
};

// 간편결제
function  fnPayPymWin(){
	openDialog(function(win){
		
	});
}
