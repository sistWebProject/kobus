var allDeprList       = []; // 출발지 리스트
var allRotInfAllList  = []; // 노선 전체 리스트
var allRotInfrLen     = 0;  // 노선 전체 데이터 건수
var allplen = 0; // tab 구분자
var allPrchAmt = 0; // 할부 개월수를 표시할지 말지

$(document).ready(function() {	
	//사용시작일 
	//fnYyDtmStup(0,'text_date1','0');
//	$("#divAdtnDtl").css('display', 'none');
	$("#tmpPsbYN").css('display', 'none');		// 임시차 문구
	$("#divTermDesc").css('display', 'none');	// 사용기간 문구
	var minDateSet = 1;
	
	var dt = new Date();		//오늘날짜 전체
	var yyyy  = dt.getFullYear();		//선택한 년도
	var mm    = dt.getMonth()+1;		//선택한 월
	var mm2Len = Number(mm) < 10 ? "0"+mm : mm;			// 선택월 ex:01 두글자로 변환
	var ddTo    = Number(dt.getDate()) < 10 ? "0"+dt.getDate() : dt.getDate(); 			// 숫자형
	var yymmddD0 = yyyy+""+mm2Len+""+ddTo;		//오늘날짜
	
	$.ajax({	
        url      : "/koBus/adtnprdnew/pass/readPassRotLinInf.ajax",
        
        dataType : "json",
        success  : function(arrList){	
        	
        	var deprAll ="";
         	allRotInfrLen = arrList.len;
        	for(var inx = 0 ; inx < allRotInfrLen ; inx++){					//8.for문으로 return받은 map안의 list정보들을 빼와서 다시 이중배열에 넣기
        		allRotInfAllList[inx] = new Array();								//8.1 javascript에선 이중배열을 쓸수 없기 때문에 list생성후 배열을 뒤에 붙여야한다.
       			allRotInfAllList[inx][0] = arrList.adtnRotInfList[inx].adtnDeprNm;	//상품출발지명
       			allRotInfAllList[inx][1] = arrList.adtnRotInfList[inx].adtnArvlNm;	//상품도착지명
       			allRotInfAllList[inx][2] = arrList.adtnRotInfList[inx].adtnDeprCd + "";	//상품출발지코드
       			allRotInfAllList[inx][3] = arrList.adtnRotInfList[inx].adtnArvlCd + "";	//상품도착지코드  
       			allRotInfAllList[inx][4] = arrList.adtnRotInfList[inx].deprNm;		//출발지명
       			allRotInfAllList[inx][5] = arrList.adtnRotInfList[inx].arvlNm;		//도착지명
       			allRotInfAllList[inx][6] = true;							// 상품 출도착지 중복 제거
       			allRotInfAllList[inx][7] = arrList.adtnRotInfList[inx].adtnPrdSellSttDt;		//배차게시시작일
       			if(allRotInfAllList[inx][7] > yymmddD0 ){
       				minDateSet = getDateDiff(yymmddD0, allRotInfAllList[inx][7]);
        		}else{
        			minDateSet = 1;
        		}

       			allRotInfAllList[inx][8] = minDateSet;		//배차게시시작일
        	}
        	for(var inx=0; inx<allRotInfrLen; inx++){
        		for(var inz=inx+1; inz<allRotInfrLen; inz++){
        			if((allRotInfAllList[inx][0] == allRotInfAllList[inz][1]) && (allRotInfAllList[inx][1] == allRotInfAllList[inz][0])){        				
        				allRotInfAllList[inx][6] = false;
        			}
        			if((allRotInfAllList[inx][0] == allRotInfAllList[inz][0]) && (allRotInfAllList[inx][1] == allRotInfAllList[inz][1])){
        				allRotInfAllList[inx][6] = false;
        			}
        		}
        	}
        	
        	// select
        	if (is_select("selUseRot")){
	        	var blockItem = "<option value=''>이용노선을 선택하세요.</option>";
	        	var blockSubItem = "";
	        	var itemNo = 1;
	        	
	        	for(var inx=0; inx < allRotInfrLen ; inx++){
	        		if(allRotInfAllList[inx][6]){
	        			blockItem += "<option value="+allRotInfAllList[inx][2]+allRotInfAllList[inx][3]+allRotInfAllList[inx][8]+">" + allRotInfAllList[inx][0] + " &harr; " + allRotInfAllList[inx][1] + "</option>";
	        			itemNo++;
	        		}
	        		blockSubItem += "<li id=\"subRot"+inx+"\" value="+allRotInfAllList[inx][2]+allRotInfAllList[inx][3]+" style=\"display:none;\">"+ allRotInfAllList[inx][4] + "&rarr;" + allRotInfAllList[inx][5] +"</li>"
	        	}
	
	        	$("#selUseRot").html(blockItem);
	        	$("#selUseRot").selectric();
	        	$("#useRotDtl").html(blockSubItem);
        	}
        	// input
        	else{
	        	var blockItem = "<li><a href=\"javascript:void(0)\">이용노선을 선택하세요.</a></li>";
	        	var blockSubItem = "";
	        	var itemNo = 1;
	        	
	        	for(var inx=0; inx < allRotInfrLen ; inx++){
	        		if(allRotInfAllList[inx][6]){
	        			var val = allRotInfAllList[inx][2]+allRotInfAllList[inx][3]+allRotInfAllList[inx][8];
	        			var txt = allRotInfAllList[inx][0] + " &harr; " + allRotInfAllList[inx][1];
	        			blockItem += "<li><a href=\"javascript:void(0)\" title=\"정기권 상품별 탑승가능 노선 안내 보기\" onclick=\"onSelectChange(this,'"+ val +"', 'selUseRot')\">"+ txt +"</a></li>";
	        			itemNo++;
	        		}
	        		blockSubItem += "<li id=\"subRot"+inx+"\" value="+allRotInfAllList[inx][2]+allRotInfAllList[inx][3]+" style=\"display:none;\">"+ allRotInfAllList[inx][4] + "&rarr;" + allRotInfAllList[inx][5] +"</li>"
	        	}
	
	        	$("#selUseRotLi").html(blockItem);
	        	$("#useRotDtl").html(blockSubItem);
        	}
        },
        error:function (e){
            //alert("connection error");
        }
    });
	
	fnSetCardCam();
	
	$("#goPrdprchFn").click(function(){ //결제하기 유효성 검사
				
		// 이용약관
		if(!$("#agree1").is(":checked")){
			// 약관 1 미동의 시
			$('#agree1').focus();
			alert("서비스 이용약관에 동의해 주세요.");
			return;
		}
		if(!$("#agree2").is(":checked")){
			// 약관 2 미동의 시
			$('#agree2').focus();
			alert("운송 약관에 동의해 주세요.");
			return;
		}
		if(!$("#agree3").is(":checked")){
			// 약관 3 미동의 시
			$('#agree3').focus();
			alert("개인정보 취급방침에 동의해 주세요.");
			return;
		}
		// 노선
		if($("#selUseRot").val() == ""){
			// 노선 선택이 없는 경우
			alert("이용노선을 선택해주세요.");
			$('#rotSelectric').focus(); // 포커스 이동
			return;
		}				
		// 사용시작일 		
		if($("#exdtSttDt").val() == ""){
			alert("사용시작일을 선택해 주세요. \n (사용시작일은 다음날로부터 10일이내 선택이 가능합니다.)");
			$('.datepicker-btn').focus(); // 포커스 이동
			return;
		}				
		/*if($("input:radio[name=adtnPrdUseNtknCd]:checked").length == 0){		
			alert("이용권종을 선택해주세요.");
			return;
		}
		if($("input:radio[name=wkdWkeNtknCd]:checked").length == 0){
			alert("사용일을 선택해주세요.");
			return;
		}
		if($("input:radio[name=adtnPrdUseClsCd]:checked").length == 0){
			alert("버스이용등급을 선택해주세요.");
			return;
		}
		if($("input:radio[name=adtnPrdUsePsbDno]:checked").length == 0){
			alert("상품종류룰 선택해주세요.");
			return;
		}*/
		
		
		/**
		 * 20200709 yahan
		 */
		//if($("#mbrsBrdt").val() == ""){
		if($("#mbrsBrdt").val().length != 6){
			alert("구매자 생년월일 6자리를 입력해주세요.");
			$("#mbrsBrdt").focus();
			return;
		}
		
		
		// 20200513 yahan
		if($("#selOption").val() == "0" || $("#selOption").val() == ""){
			// 구매옵션 선택이 없는 경우
			$('#optSelectric').focus(); // 포커스 이동
			alert("구매옵션을 선택해주세요.");
			return;
		}
		
		var payType="card";
		if($("input:radio[id='payType6']").is(":checked")){ // 간편결제
			if(!fnVldtPay()){
				return;
			}
			payType="pay";
		}
		else{
			//if($("input:radio[id='payType1']").is(":checked"))
			{ // 신용카드
				if(!fnVldtCard()){
					return;
				}
				payType="card";
			}
		}

		$("#pymType").val(payType);
		
		if(!confirm("결제하시겠습니까?")){
			return;
		}

		if(payType == "pay"){ // 간편결제
			fnPayPymWin();	
		} else {
			//fn_PrdprchFn(); // 결제 진행
			fnStplCfmPym();
		}
	});
});

function getDateDiff(cStartDate,cEndDate)
{
	var sDate;
	var eDate;

	sDate1 = cStartDate.substring(0,4);
	sDate2 = cStartDate.substring(4,6);
	sDate3 = cStartDate.substring(6,8);
	eDate1 = cEndDate.substring(0,4);
	eDate2 = cEndDate.substring(4,6);
	eDate3 = cEndDate.substring(6,8);

	var dtSDate;
	var dtEDate;
	
	dtSDate = new Date(sDate1, Number(sDate2)-1, sDate3);
	dtEDate = new Date(eDate1, Number(eDate2)-1, eDate3);
	
	var nDiffDay;
	
	nDiffDay = ( dtEDate.getTime() - dtSDate.getTime() ) / (1000*60*60*24);
	
	return nDiffDay;
}

function fnFrmSubmit(){
	$("#passPrchGdFrm").attr("action","/adtnprdnew/pass/passPrch.do");
	$("#passPrchGdFrm").submit();
}

function fn_selChange(value){
	if(value != ""){
		$("#useRotDtl").css('display', 'block');
		$("#useRotDtlDsc").css('display', 'block');	
		var cnt = 0;
		
		for(var inx=0; inx < allRotInfrLen ; inx++){		

			if((value).substring(0,6) == $("[id='subRot"+inx+"']").val()){
				$("[id='subRot"+inx+"']").css('display', 'block');
				cnt++;
			}else{
				$("[id='subRot"+inx+"']").css('display', 'none');
			}
		}
		$("#useRotDtlDsc").text("※ 해당 노선은  "+cnt+"종의 노선 이용이 가능합니다. 예매 시  참고 하시기 바랍니다.");
		
		var rotLinInf = $("#selUseRot").val();
		var exdtSttDt = $("#exdtSttDt").val();
		//if(exdtSttDt != ""){
			$("#adtnDeprTrmlNo").val(rotLinInf.substring(0,3));
			$("#adtnArvlTrmlNo").val(rotLinInf.substring(3,6));
			fnPassDtl();
		//}
//		$("#datepickerItem").val('');
//		$('#datepickerItem').datepicker('destroy');
//		$('#datepickerView').text("");
		test(rotLinInf.substring(6,rotLinInf.length));
		
		setTimeout(function() {
			$("#ui-datepicker-div").attr("tabindex", "0");
			$('.ui-datepicker-trigger').removeAttr('title');
			
			var $datePickerButton = $('button.datepicker-btn');
			var $img = $('.ui-datepicker-trigger');
			var $button = $('<button type="button" class="datepicker-btn"></button>');
			
			if ($datePickerButton.length === 0) {
				$img.wrap($button);
			}
		}, 10);
		$(".date_picker_wrap .hasDatepicker").on("click", function() {
			setTimeout(function() {
				$(".ui-datepicker-prev, .ui-datepicker-next").attr("href", "javascript:void(0)")
			}, 10);
		});
		
		$(document).on('keydown', '#ui-datepicker-div', function(e) {
			if (document.activeElement.id === 'ui-datepicker-div') {
				if (e.key === 'Tab' && e.shiftKey) {
					e.preventDefault();
					
					var lastFocusableLink = $('#ui-datepicker-div .ui-datepicker-calendar a').last();
					lastFocusableLink.focus();
				};
			}		
		});
		$(document).on('keydown', '#ui-datepicker-div .ui-datepicker-calendar a', function(e) {
			var lastFocusableLink = $('#ui-datepicker-div .ui-datepicker-calendar a').last();
			if (document.activeElement === lastFocusableLink[0] && e.key === 'Tab' && !e.shiftKey) {
				e.preventDefault();
				$("#ui-datepicker-div").focus();
			}
			
			if (e.key === 'Enter') {
				e.preventDefault();
				$(this).click();
				setTimeout(function() {
					$('.datepicker-active').focus();
					$('.datepicker-btn').removeClass('datepicker-active');
				}, 0);
			}
		});
		$(document).on('keydown', '.ui-datepicker-header .ui-datepicker-prev', function(e) {
			if (e.key === 'Enter') {
				e.preventDefault();
				$(this).click();
				$(".ui-datepicker-prev, .ui-datepicker-next").attr("href", "javascript:void(0)");
				$(".ui-state-disabled").attr("tabindex", "-1");
				$('.ui-datepicker-prev').focus();
			}
		});
		$(document).on('keydown', '.ui-datepicker-header .ui-datepicker-next', function(e) {
			if (e.key === 'Enter') {
				e.preventDefault();
				$(this).click();
				$(".ui-datepicker-prev, .ui-datepicker-next").attr("href", "javascript:void(0)");
				$(".ui-state-disabled").attr("tabindex", "-1");
				$('.ui-datepicker-next').focus();
			}
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
//			onSelect: function() {
//				addTodaySpan();
//			}
		});
		
		$(".ui-datepicker-trigger").on("click", function() {
			setTimeout(addTodaySpan, 50);
			$(this).parent().addClass('datepicker-active');
			$("#ui-datepicker-div").focus();
			$(".ui-state-disabled").attr("tabindex", "-1");
			$(".ui-datepicker-prev, .ui-datepicker-next").attr("href", "javascript:void(0)");
		});
//		$(".ui-corner-all").on("click", function() {
//			setTimeout(addTodaySpan, 50);
//			$("#ui-datepicker-div").focus();
//			$(".ui-state-disabled").attr("tabindex", "-1");
//			$(".ui-datepicker-prev, .ui-datepicker-next").attr("href", "javascript:void(0)");
//		});
		
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
	}else{
//		$("#useRotDtl").css('display', 'none');
//		$("#useRotDtlDsc").css('display', 'none');	
	}
	fnReset();
	
// 20200804 yahan 이용가능노선 필터링.
//console.log(value);
//	$("#useableInfo > tr").hide();
//	$("#useableInfo > tr[data-id='"+value+"']").show();
	$('[data-remodal-id=useableInfo]').remodal().open();
}

function test(mmm){
	
	$('#datepickerItem').datepicker({
		showOn:"button",
		buttonImage:"/koBus/images/ico_calender.png",
		buttonImageOnly:true,
		buttonText:"사용시작일 선택 달력",
		minDate: mmm,
		maxDate: 10,
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
		}
	});
	
	$('#datepickerItem').on('change', function(){
		fnYyDtmStup($('#datepickerItem').val());
		$('.datepicker-active').focus();
		$('.datepicker-btn').removeClass('datepicker-active');
	});
}

function fnYyDtmStup(dtVal){ // 날짜 계산
		var dtItem = dtVal.split(".");
		var dtBuf = dtItem[0].trim() + (dtItem[1].trim() < 10 ? "0" + dtItem[1].trim() : dtItem[1].trim()) + (dtItem[2].trim() < 10 ? "0" + dtItem[2].trim() : dtItem[2].trim());
		
		var optItem = $("form[id=optform]").serialize();

		var rotLinInf = $("#selUseRot").val();
		if(rotLinInf != ""){
			$("#adtnDeprTrmlNo").val(rotLinInf.substring(0,3));
			$("#adtnArvlTrmlNo").val(rotLinInf.substring(3,6));
			$("#exdtSttDt").val(dtBuf);
			$(".text_date1").text(dtVal);
			$("#tmpPsbYN").css('display', 'none');
			$("#divTermDesc").css('display', 'none');
			fnPassDtl();
		}else{
			alert("이용노선을 선택해주세요.");
			return;
		}
}		

// 부가상품 상세 조회
function fnPassDtl(){
	var rotLinInf = $("#selUseRot").val();
	var datepickerItem = $("#datepickerItem").val();
	if(rotLinInf == "" || datepickerItem == ""){
		return;
	}
	
	var passPrchFrm = $("form[name=passPrchFrm]").serialize() ;
	$.ajax({	
        url      : "/koBus/adtnprdnew/pass/readPassDtlInf.ajax",
        type	 : "post",
        data 	 : passPrchFrm,
        dataType : "json",
        success  : function(arrList){
console.log(arrList);

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
        	var dayItem = "";
        	        	
        	for(var inx=0; inx < allDtlrLen ; inx++){
        		if(inx == 0 || (inx > 0 && allDtlInfAllList[inx][5] != allDtlInfAllList[inx-1][5])){
        			weekItem += "<span class=\"custom_radio type3\"><input type=\"radio\" id=\"wkdWkeNtknCd"+inx+"\" name=\"wkdWkeNtknCd\" value="+allDtlInfAllList[inx][5]+" onclick=\"fnSelPrdWeek('"+allDtlInfAllList[inx][6]+"')\"><label for=\"wkdWkeNtknCd"+inx+"\"><span>"+allDtlInfAllList[inx][6]+"</span></label></span>";
        		}
        		if(inx == 0 || (inx > 0 && allDtlInfAllList[inx][3] != allDtlInfAllList[inx-1][3])){
        			kindItem += "<span class=\"custom_radio type3\"><input type=\"radio\" id=\"adtnPrdUseNtknCd"+inx+"\" name=\"adtnPrdUseNtknCd\" value="+allDtlInfAllList[inx][3]+" onclick=\"fnSelPrdKind('"+allDtlInfAllList[inx][4]+"')\"><label for=\"adtnPrdUseNtknCd"+inx+"\"><span>"+allDtlInfAllList[inx][4]+"</span></label></span>";
        		}
        		if(inx == 0 || (inx > 0 && allDtlInfAllList[inx][0] != allDtlInfAllList[inx-1][0])){
        			gradeItem += "<span class=\"custom_radio type3\"><input type=\"radio\" id=\"adtnPrdUseClsCd"+inx+"\" name=\"adtnPrdUseClsCd\" value="+allDtlInfAllList[inx][0]+" onclick=\"fnSelPrdGrade('"+allDtlInfAllList[inx][1]+"')\"><label for=\"adtnPrdUseClsCd"+inx+"\"><span>"+allDtlInfAllList[inx][1]+"</span></label></span>";
        		}
        		if(inx == 0 || (inx > 0 && allDtlInfAllList[inx][2] != allDtlInfAllList[inx-1][2])){
        			dayItem += "<span class=\"custom_radio type3\"><input type=\"radio\" id=\"adtnPrdUsePsbDno"+inx+"\" name=\"adtnPrdUsePsbDno\" value="+allDtlInfAllList[inx][2]+" onclick=\"fnSelPrdDay('"+allDtlInfAllList[inx][2]+"')\"><label for=\"adtnPrdUsePsbDno"+inx+"\"><span>"+allDtlInfAllList[inx][2]+"일권</span></label></span>";
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
	        		
	       			blockItem += "<option value="+allDtlInfAllList[inx][3]+"/"+allDtlInfAllList[inx][0]+"/"+allDtlInfAllList[inx][5]+"/"+allDtlInfAllList[inx][2]+"/"+allDtlInfAllList[inx][7]+"/"+allDtlInfAllList[inx][8]+">" + 
	       									saleAlcnYn + allDtlInfAllList[inx][4] + " 정기권 / " + allDtlInfAllList[inx][2]+"일 / "+ allDtlInfAllList[inx][1] + " / " + allDtlInfAllList[inx][6] + "</option>";
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
	    	
        	/*
        	$("#weekList").html(weekItem);
        	$("#kindList").html(kindItem);
        	$("#gradeList").html(gradeItem);
        	$("#dayList").html(dayItem);*/
        	
        	$("#rotTd").html($("#selUseRot").find('option:selected').text());
        	
        	$("#weekTd").html("");
        	$("#kindTd").html("");
        	$("#gradeTd").html("");
        	$("#dayTd").html("");
        	$("#valTerm").text("사용 종료일은 상품종류에 따라 자동 설정 됩니다.");
    		$("#fulTermTd").html("");
    		$("#pubAmt").html("0 원");
    		$("#goodsPrice").val(0); // 20241010 간편결제 금액설정
    		$("#divAdtnDtl").css('display', 'block');
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

//사용일 클릭시
function fnSelPrdWeek(val){
	$("#weekTd").html(val);
}

//버스이용등급 클릭시
function fnSelPrdGrade(val){
	$("#gradeTd").html(val);
}

//상품종류 클릭시
function fnSelPrdDay(val){
	if($("#mbrsBrdt").val() == ""){
		alert("생년월일을 입력해주세요.");
		$("input:radio[name='adtnPrdUsePsbDno']").prop("checked",false);
		$("#mbrsBrdt").focus();
		return;
	}		
	if($("input:radio[name=adtnPrdUseNtknCd]:checked").length == 0){
		alert("이용권종을 선택해주세요.");
		$("input:radio[name='adtnPrdUsePsbDno']").prop("checked",false);
		return;
	}else{
		$("#kindTd").html();	
	}
	if($("input:radio[name=wkdWkeNtknCd]:checked").length == 0){
		alert("사용일을 선택해주세요.");
		$("input:radio[name='adtnPrdUsePsbDno']").prop("checked",false);
		return;
	}
	if($("input:radio[name=adtnPrdUseClsCd]:checked").length == 0){
		alert("버스이용등급을 선택해주세요.");
		$("input:radio[name='adtnPrdUsePsbDno']").prop("checked",false);
		return;
	}
	$("#dayTd").html(val+"일");
	
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
	$("#gradeTd").html(txt[2]);
	$("#weekTd").html(txt[3]);
	$("#dayTd").html(txt[1]);
	
	//임시차 가능여부 문구 노출	
	if(opt[4] == "Y"){
		$("#tmpPsbYN").html("※ 해당 옵션은 임시차 배차도 사용 가능합니다.");
			
	}else{
		$("#tmpPsbYN").html("※ 해당 옵션은 임시차 배차는 사용 불가합니다.");		
	}
	$("#tmpPsbYN").css('display', 'block');
	
	
	// 20200729 yahan 전일권
	if (opt[2] == '1') {
		$("#label_week").css('display', 'block');
		$("#label_holi").css('display', 'none');
	} else {
		// 3 주중권
		$("#label_week").css('display', 'none');
		$("#label_holi").css('display', 'block');
	}
	
	//유효기간 가져오기
	fnAdtnVldTerm();
	$("#divTermDesc").css('display', 'block');
}
/*
function setTermParamsToForm() {
    // 1. 시작일 추출
    let dateStr = $("#datepickerView").text().trim(); // 예: "2025. 6. 18. 수"
    let dateParts = dateStr.split(".");
    let yyyy = dateParts[0].trim();
    let mm = dateParts[1].trim().padStart(2, '0');
    let dd = dateParts[2].trim().padStart(2, '0');
    let startDate = yyyy + mm + dd;

    // 2. 기간 추출 (option에서 value가 '.../5/...' 식일 경우)
    let optVal = $("#selOption").val(); // 예: "1/3/1/5/Y/0026"
    let period = "0";
    if (optVal) {
        let parts = optVal.split("/");
        if (parts.length >= 4) {
            period = parts[3]; // 5일권의 경우 '5'
        }
    }

    // 3. hidden input 추가
    const $form = $("form[name='passPrchFrm']");
    if ($form.find("input[name='startDate']").length === 0) {
        $form.append(`<input type="hidden" name="startDate" value="${startDate}">`);
    } else {
        $form.find("input[name='startDate']").val(startDate);
    }

    if ($form.find("input[name='period']").length === 0) {
        $form.append(`<input type="hidden" name="period" value="${period}">`);
    } else {
        $form.find("input[name='period']").val(period);
    }
}
*/

//유효기간 가져오기
function fnAdtnVldTerm(){
	// setTermParamsToForm();
	var passPrchFrm = $("form[name=passPrchFrm]").serialize() ;
	
	// [2] 파라미터 유효성 체크 추가
    var startDate = $("input[name='startDate']").val();
    var period = $("input[name='period']").val();
    if(!startDate || !period) {
        console.log("[경고] ajax 호출 차단 - startDate, period 값 없음!", startDate, period);
        // 필요하다면 alert("사용 시작일과 이용기간을 모두 선택해주세요!");
        return;
    }
	
	$.ajax({	
        url      : "/koBus/adtnprdnew/pass/readPassVldTerm.ajax",
        type	 : "post",
        data 	 : passPrchFrm,
        dataType : "json",
        success  : function(termMap){
console.log(termMap);

			// 20200515 yahan
			if (termMap.adtnDupPrchYn == "Y" &&
				confirm("동일노선 사용일이 중복되는 정기권이 있습니다.\n\n추가 구매하시겠습니까?") != true){
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
            	
            	$("#valTerm").text(yyDtm+wkdy);
        		$("#fulTermTd").html(termMap.fulTerm);
        		$("#spanTermDt").html(termMap.fulTerm);
        		
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
        		
        		/*
        		 * 20200909 yahan
        		// 20200804 yahan 주중권 추석연휴 사용불가
        		var optVal = $("#selOption").val();
        		var opt = optVal.split("/");
        		if (opt[2] == '3' && // 주중권
        			termMap.termSttDt <= 20200929 && termMap.timDte >= 20200929){
        			$("#label_spexp").css('display', 'block');
        		}
        		else{
        			$("#label_spexp").css('display', 'none');
        		}
        		*/
        		
        	}else{
        		alert("구매할수 있는 기간이 없습니다.");
        		fnReset();
        		return;
        	}
        },
        error:function (e){
            //alert("connection error");
        }
    });
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

function fnReset(){
	$("#weekList").html("");
	$("#kindList").html("");
	$("#gradeList").html("");
	$("#dayList").html("");
	$("#rotTd").html("");
	$("#weekTd").html("");
	$("#kindTd").html("");
	$("#gradeTd").html("");
	$("#dayTd").html("");
	$("#valTerm").text("사용 종료일은 상품종류에 따라 자동 설정 됩니다.");
	$("#fulTermTd").html("");
	$("#pubAmt").html("0 원");
	$("#goodsPrice").val(0); // 20241010 간편결제 금액설정
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

/*fn_PrdprchFn*/
function fnStplCfmPym(){
	$('.loading').show();

	// 결재 하기
	var passPrchFrm = $("form[id=passPrchFrm]").serialize();

	$.ajax({	
        url      : "/adtnprdnew/pass/addPassPrdprchFn.ajax",
        type	 : "post",
        data	 : passPrchFrm,
        dataType : "json",
        success  : function(prchResultMap){	
        	if(prchResultMap.MSG_CD == "S0000"){
				// 구매 완료 페이지로 이동
	        	$('#adtnCpnNo').val(prchResultMap.ADTN_CPN_NO);
				$('#adtnDeprTrmlNo').val(prchResultMap.ADTN_DEPR_TRML_NO);
				$('#adtnArvlTrmlNo').val(prchResultMap.ADTN_ARVL_TRML_NO);
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
				
				$("#passPrchFrm").attr({action:'/adtnprdnew/pass/passPrchFn.do', method:'post'}).submit(); //전송
        	}else{
				if(prchResultMap.MSG_DTL_CTT != null && prchResultMap.MSG_DTL_CTT != ""){
					alert(prchResultMap.MSG_DTL_CTT);
				} else {
					alert("현재 시스템 장애로 인하여 결제가 불가합니다. 잠시 후 다시 시도해 주세요.");
				}
			}
			$('#caPerson').focus();
			$('.loading').hide();
        }, complete:function() {
        	$('.loading').hide();
        }, error:function (e) {
        	alert("현재 시스템 장애로 인하여 결제가 불가합니다. 잠시 후 다시 시도해 주세요.");
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
	if((spt == 2) && ($("#caBirth").val().length == 8)){
		// 생년월일
		var item = $("#caBirth").val();
		var chkItem = new Date(item.substring(0,4), item.substring(4,6), item.substring(6,8));
		if(chkItem == "Invalid Date" || Number(item.substring(4,6)) < 1 || Number(item.substring(4,6)) > 12 || Number(item.substring(6,8)) < 1 || Number(item.substring(6,8)) > 32){
			alert("올바른 생년월일을 입력해주세요.");
			$("#caBirth").val("");
		}
	}
	if((spt == 3) && ($("#mbrsBrdt").val().length == 8)){
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
		$('#cardKindList').focus(); // 포커스 이동
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
		alert("네 번째 카드번호 4자리를 입력해주세요.");
		$('#cardNum4').focus(); // 포커스 이동
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
			alert("카드 생년월일을 입력해 주세요.");
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

	if (input_name == 'selUseRot'){
		fn_selChange(input_val);
		
		
		var dt = new Date();		//오늘날짜 전체
		var yyyy  = dt.getFullYear();		//선택한 년도
		var mm    = dt.getMonth()+1;		//선택한 월
		var mm2Len = Number(mm) < 10 ? "0"+mm : mm;			// 선택월 ex:01 두글자로 변환
		var ddTo    = Number(dt.getDate()) < 10 ? "0"+dt.getDate() : dt.getDate(); 			// 숫자형
		var yymmddD0 = yyyy+""+mm2Len+""+ddTo;		//오늘날짜

		// 서울-이천, 서울-여주 2025-02-02 까지
		if (input_val == '0101601' || input_val == '0101401') {
			if (yymmddD0 < '20250203') {
				alert("[서울-이천, 서울-여주 노선 정기권 일시 판매 중지]\n\n"
						+ "서울-이천, 서울-여주 노선 차량 등급 및 요금 변경 운행에 따라 정기권 일시 판매가 중지됨을 안내 드립니다.\n"
						+ "이용에 참고하시기 바랍니다.\n"
						+ "\n"
						+ "※ 판매개시일 : 2025년 2월 3일\n"
						+ "※ 2025년 2월 2일까지 판매가 중지 됩니다.\n"
						+ "\n"
						+ "항상 동부고속과 함께해주셔서 감사합니다.");
			}
		}
		
	}

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

$(document).ready(function() {
	$(document).on('keydown', '.btn_confirm', function(e) {
		if (e.key === 'Enter') {
			setTimeout(function() {
				$('a[title="이용노선 선택"]').focus();
			}, 500);
		}
	});
});
