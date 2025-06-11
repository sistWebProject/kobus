<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalTime"%>
<%@ page language="java" trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String deprName = "서울 경부";
	String deprCode = "11";
	String arrvName = "속초";
	String arrvCode = "11";
	int takeTime = 130;
	int distance = 225;
	String company = "(주)동부고속";
	String grade = "일반";
	LocalDate deprDate = LocalDate.of(2025, 6, 11);
	LocalTime deprTime = LocalTime.of(7, 30);
	
	request.setAttribute("deprName", deprName);
	request.setAttribute("deprCode", deprCode);
	request.setAttribute("arrvName", arrvName);
	request.setAttribute("arrvCode", arrvCode);
	request.setAttribute("takeTime", takeTime);
	request.setAttribute("distance", distance);
	request.setAttribute("company", company);
	request.setAttribute("grade", grade);
	
	request.setAttribute("deprDate", deprDate);
	request.setAttribute("deprTime", deprTime);

%>	
	
<!DOCTYPE html>
<html lang="ko" class="pc">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">

<title>예매정보입력(매수 및 좌석선택) | 고속버스예매 | 고속버스예매 | 고속버스통합예매</title>


<link rel="shortcut icon"
	href="https://www.kobus.co.kr/images/favicon.ico">


<script type="text/javascript">
/*********************************************
 * 상수
 *********************************************/
</script>


<link rel="stylesheet" type="text/css"
	href="/koBus/css/common/ui.jqgrid.custom.css">

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>

<script>
//쿠키 가져오기
/* function getCookie( name ) {
	var nameOfCookie = name + "=";
	var x = 0;
	while ( x <= document.cookie.length ) {
		var y = (x+nameOfCookie.length);
		if ( document.cookie.substring( x, y ) == nameOfCookie ) { 
			if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) {
				endOfCookie = document.cookie.length;
			}
			return unescape( document.cookie.substring( y, endOfCookie ) );
		}
		x = document.cookie.indexOf( " ", x ) + 1;
		if ( x == 0 ) {
			break;
		}
	}
	return ""; 
}
//쿠키 넣기
function setCookie( name, value, expiredays ) {
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
} */

// 상단 네비게이션, 모바일 좌측, 모바일 하단 언어선택 설정
/* var lngCdCookie = getCookie("LNG_CD");

lngCdCookie = (lngCdCookie != null && lngCdCookie != undefined && lngCdCookie != "") ? lngCdCookie : "";
var lngCd = (lngCdCookie == "EN" || lngCdCookie == "CN" || lngCdCookie == "JP" || lngCdCookie == "KO") ? lngCdCookie : "KO";
$(document).ready(function() {
	if (navigator.userAgent.toUpperCase().indexOf("MSIE 5") >= 0 || navigator.userAgent.toUpperCase().indexOf("MSIE 6") >= 0 || navigator.userAgent.toUpperCase().indexOf("MSIE 7") >= 0 || navigator.userAgent.toUpperCase().indexOf("MSIE 8") >= 0) {
		// IE 8 이하
		if (location.href.indexOf("/underIE8.do") < 0) {
			// IE 8 이하 페이지 아님
			location.href = "/underIE8.do";
			return false;
		}
	}
	if (window.innerWidth < 768) {
		setCookie("IS_MOBILE_YN_WIDTH","Y",365);
		if (lngCd == "KO" && location.href.indexOf("/cmn/") < 0 && 
				location.href.indexOf("/underIE8.do") < 0 && 
				location.href.indexOf("/mrs/mrsrecppub.do") < 0 && 
				location.href.indexOf("/mrs/mrsrecppub4.do") < 0 && 
				location.href.indexOf("/mrs/mrsmbltck.do") < 0 &&
				location.href.indexOf("/mrs/acntpympup.do") < 0 && 		// 계좌이체
				location.href.indexOf("/mrs/pay") < 0 && 				// 간편결제
				location.href.indexOf("/adtnprdnew/prchpt/adtnrecppubmbl.do") < 0 && 
				location.href.indexOf("/adtnprdnew/frps/frpsPrchGdMbl.do") < 0 &&
				location.href.indexOf("/mbrs/mbrsscsn.do") < 0) {
			location.href = "/mblIdx.do";
			return false;
		}
	} else {
		setCookie("IS_MOBILE_YN_WIDTH","N",365);
	}
	// 타이틀 수정
	if ($("h2").length > 0) {
		$("title").text($("title").text() + " - " + $("h2:eq(0)").text());
	}
	var $objBody = $("body");
	if (!($objBody.hasClass("KO") || $objBody.hasClass("EN") ||  $objBody.hasClass("CN") ||  $objBody.hasClass("JP"))) {
		$objBody.addClass(lngCd);
	}
	
	
	/* asis */
/* 	$("#lng_cd_navi option[value='" + lngCd + "'],#lng_cd_foot option[value='" + lngCd + "']").attr("selected","selected");
	$("#lng_cd_navi,#lng_cd_foot").unbind("change").bind("change",function() {
		var tempCd = this.value;
		lngCd = (tempCd != null && tempCd != undefined && tempCd != "" && (tempCd == "EN" || tempCd == "CN" || tempCd == "JP" || tempCd == "KO")) ? tempCd : "KO";
		setCookie("LNG_CD",lngCd,1);
		lngCdCookie = lngCd;
		//document.location.reload();
		location.href = "/main.do";
	}); 
});  */


/* if (lngCd == "KO") {
	var dt = new Date();		//오늘날짜 전체
	var yyyy  = dt.getFullYear();		//선택한 년도
	var mm    = dt.getMonth()+1;		//선택한 월
	var mm2Len = Number(mm) < 10 ? "0"+mm : mm;			// 선택ㅡㅜ?ㅌ월 ex:01 두글자로 변환
	var ddTo    = Number(dt.getDate()) < 10 ? "0"+dt.getDate() : dt.getDate(); 			// 숫자형
	var yymmddD0 = yyyy+""+mm2Len+""+ddTo;		//오늘날짜
	
	var url = window.location.pathname;

	if (yymmddD0 < 20200128) {
		if (url == "/main.do")
			location.href="/mainExp.do";
	}
} */

</script>
<script type="text/javascript"
	src="/koBus/js/common/ui.js"></script>
<script type="text/javascript"
	src="/koBus/js/common/plugin.js"></script>
<script type="text/javascript"
	src="/koBus/js/common/common.js"></script>

<script type="text/javascript"
	src="/koBus/js/common/jquery.number.js"></script>
<script type="text/javascript"
	src="/koBus/js/common/security.js"></script>


<link rel="stylesheet" type="text/css"
	href="/koBus/css/common/style.css">
<script type="text/javascript"
	src="/koBus/js/new-kor-ui.js"></script>
</head>


<!-- [리뉴얼] 페이지 개별 스크립트 신규 정의함 -->


<body class="KO">
	<!-- [리뉴얼] 스킵 네비게이션 신규 정의 -->
	<nav id="skip">
		<ul>
			<li><a
				href="https://www.kobus.co.kr/mrs/satschc.do#new-kor-content">본문
					바로가기</a></li>
			<li><a href="https://www.kobus.co.kr/mrs/satschc.do#new-kor-gnb">주메뉴
					바로가기</a></li>
			<li><a
				href="https://www.kobus.co.kr/mrs/satschc.do#new-kor-footer">푸터
					바로가기</a></li>
		</ul>
	</nav>

	<!-- 메인 클래스 : wrapper-main -->
	<div class="wrapper wrapper-kor wrapper-sub">


		<!-- quick -->



		<!-- 퀵메뉴 : 서브페이지에만 적용 -->
		<nav id="new-kor-quickmenu" class="">
			<ul class="quickmenu-list">
				<li><a href="https://www.kobus.co.kr/mrs/rotinf.do"> <span
						class="ico"><img
							src="/koBus/images/ico-quick-menu01.png"
							alt=""></span> <span class="text">고속버스 예매</span>
				</a></li>
				<li><a href="https://www.kobus.co.kr/mrs/mrscfm.do"> <span
						class="ico"><img
							src="/koBus/images/ico-quick-menu02.png"
							alt=""></span> <span class="text">예매확인</span>
				</a></li>
				<li><a
					href="https://www.kobus.co.kr/oprninf/arscgd/oprnArscGd.do"> <span
						class="ico"><img
							src="/koBus/images/ico-quick-menu03.png"
							alt=""></span> <span class="text">도착시간 안내</span>
				</a></li>
				<li><a
					href="https://www.kobus.co.kr/adtnprdnew/frps/frpsPrchGd.do"> <span
						class="ico"><img
							src="/koBus/images/ico-quick-menu04.png"
							alt=""></span> <span class="text">프리패스 구매</span>
				</a></li>
				<li><a
					href="https://www.kobus.co.kr/adtnprdnew/pass/passPrchGd.do"> <span
						class="ico"><img
							src="/koBus/images/ico-quick-menu05.png"
							alt=""></span> <span class="text">정기권 구매</span>
				</a></li>
				<li class="to-top"><a href="javascript:void(0)"> <span
						class="ico"><img
							src="/koBus/images/ico-to-top.png"
							alt=""></span> <span class="text">TOP</span>
				</a></li>
			</ul>
		</nav>


		<!-- header -->




		<script>
$(document).ready(function () {
	var langCd = 'KO';
	var langLi = $(".dropdown-wrap.lang-select .dropdown-list li");
	$.each(langLi, function (ix, el) {
		var langItem = $(el).children('a');
		var lang  = langItem.data('lang');
		if (langCd == lang){
			dropdown_process(langItem);
		}
	});
	
	$('.title_wrap').hide();
});
</script>

		<!-- 헤더 -->
		<header id="new-kor-header">
			<div class="top-menu-area">
				<div class="container">
					<h1 id="logo">
						<a href="https://www.kobus.co.kr/main.do"> <img
							src="/koBus/images/logo.png"
							alt="KOBUS 전국고속버스운송사업조합">
						</a>
					</h1>
					<nav class="util-menus">





						<ul class="util-list">

							<li><a href="https://www.kobus.co.kr/mbrs/lgn/loginMain.do"
								class="login">로그인</a></li>
							<li><a
								href="https://www.kobus.co.kr/mbrs/mbrsjoin/mbrsJoin.do">회원가입</a></li>



							<li><a
								href="https://www.kobus.co.kr/mbrs/mbrspage/myPageMain.do">마이페이지</a></li>
							<li><a
								href="https://www.kobus.co.kr/mbrs/trprinqr/pymPtInqr.do">결제내역조회</a></li>
							<li><a href="https://www.kobus.co.kr/etc/sitemap/SiteMap.do">사이트맵</a></li>
						</ul>

						<div class="dropdown-wrap lang-select">
							<a href="javascript:void(0)" class="btn-dropdown" title="언어선택"
								aria-expanded="false"> <span class="text">한국어</span><i
								class="ico ico-arrow-down"></i></a>
							<ul class="dropdown-list" style="display: none;">
								<li class="selected"><a href="javascript:void(0)"
									data-lang="KO" title="선택됨">한국어</a></li>
								<li><a href="javascript:void(0)" data-lang="EN">English</a></li>
								<li><a href="javascript:void(0)" data-lang="CN">中文</a></li>
								<li><a href="javascript:void(0)" data-lang="JP">日本語</a></li>
							</ul>
						</div>





					</nav>
				</div>
			</div>
			<nav class="gnb-menu-area">
				<div class="container">
					<div class="gnb-area">
						<ul id="new-kor-gnb">
							<li><a href="javascript:void(0)">고속버스예매</a>
								<ul>
									<li><a href="https://www.kobus.co.kr/mrs/rotinf.do">고속버스
											예매</a></li>

									<li><a href="https://www.kobus.co.kr/mrs/mrscfm.do">예매확인/취소/변경</a>


									</li>


									<li><a href="https://www.kobus.co.kr/mrs/mrsrecplist.do">영수증발행</a></li>

								</ul></li>
							<li><a href="javascript:void(0)">운행정보</a>
								<ul>
									<li><a
										href="https://www.kobus.co.kr/oprninf/alcninqr/oprnAlcnPage.do">시간표
											조회</a></li>
									<li><a
										href="https://www.kobus.co.kr/oprninf/arscgd/oprnArscGd.do">도착시간
											안내</a></li>
								</ul></li>


							<li><a href="javascript:void(0)">프리패스/정기권</a>
								<ul>
									<li><a
										href="https://www.kobus.co.kr/adtnprdnew/frps/frpsPrchGd.do">프리패스
											여행권</a></li>
									<li><a
										href="https://www.kobus.co.kr/adtnprdnew/pass/passPrchGd.do">정기권</a></li>
									<li><a
										href="https://www.kobus.co.kr/adtnprdnew/prchpt/prdPrchPt.do">상품
											구매내역</a></li>
								</ul></li>


							<li><a href="javascript:void(0)">이용안내</a>
								<ul>
									<li><a href="https://www.kobus.co.kr/ugd/mrsgd/Mrsgd.do">예매
											안내</a></li>
									<li><a
										href="https://www.kobus.co.kr/ugd/mrsgd/MrdgdPrch.do">결제수단
											안내</a></li>
									<li><a href="https://www.kobus.co.kr/ugd/rygd/Rygd.do">승차권
											환불안내</a></li>
									<li><a href="https://www.kobus.co.kr/ugd/mlggd/Mlggd.do">프리미엄
											마일리지</a></li>

									<li><a href="https://www.kobus.co.kr/ugd/trtrgd/Trtrgd.do">휴게소
											환승안내</a></li>
									<li><a href="https://www.kobus.co.kr/ugd/trmlgd/Trmlgd.do">고속버스
											터미널</a></li>
									<li><a href="https://www.kobus.co.kr/ugd/cacmgd/Cacmgd.do">고속버스
											운송회사</a></li>
								</ul></li>
							<li><a href="javascript:void(0)">고객지원</a>
								<ul>
									<li><a
										href="https://www.kobus.co.kr/cscn/ntcmttr/readNtcList.do">공지사항</a></li>
									<li><a
										href="https://www.kobus.co.kr/cscn/qna/readQnaList.do">자주찾는
											질문</a></li>
									<li><a
										href="https://www.kobus.co.kr/cscn/lossClnc/readLossClncList.do">유실물센터
											안내</a></li>
								</ul></li>
						</ul>
					</div>
					<div class="links">
						<!-- <a href="https://www.tmoney.co.kr" class="btn btn-tmoney" title="새창" target="_blank">
					<img src="/images/kor/layout/ico-tmoney-app.png" alt="" />고속버스 티머니
					<i class="ico ico-arrow-new-window"></i>
				</a> -->

						<a href="https://www.kobus.co.kr/cscn/jobmttr/readJobList.do"
							class="btn btn-job" title="새창" target="_blank"> <img
							src="/koBus/images/ico-job-offer.png"
							alt="">승무사원 모집 <i class="ico ico-arrow-new-window"></i>
						</a>
					</div>
					<div class="bg-layer">
						<a
							href="https://safeconnect.co.kr/sfconn/login/csc_pc?et=psn249R01&amp;ptrSvcSn=psn249"
							title="새창" class="gnb-baaner"> <iframe
								src="/koBus/html/_ad-tubebox-002GNB.html"
								title="프레임 (전화번호안심 로그인)" class="ad-frame"></iframe>
						</a>
					</div>
				</div>
			</nav>
		</header>


		<!-- breadcrumb -->

		<!-- 브레드크럼 -->
		<nav id="new-kor-breadcrumb">
			<div class="container">

				<ol class="breadcrumb-list">
					<li><i class="ico ico-home"></i><span class="sr-only">홈</span></li>

					<li>
						<div class="dropdown-wrap breadcrumb-select">



							<a href="javascript:void(0)" class="btn-dropdown" title="대메뉴 선택"
								aria-expanded="false"> <span class="text">고속버스예매</span><i
								class="ico ico-dropdown-arrow"></i></a>

							<ul class="dropdown-list" style="display: none;">

								<li class="selected"><a href="javascript:void(0)"
									title="선택됨">고속버스예매</a></li>

								<li><a
									href="https://www.kobus.co.kr/oprninf/alcninqr/oprnAlcnPage.do">운행정보</a></li>

								<li><a
									href="https://www.kobus.co.kr/adtnprdnew/frps/frpsPrchGd.do">프리패스/정기권</a></li>

								<li><a href="https://www.kobus.co.kr/ugd/mrsgd/Mrsgd.do">이용안내</a></li>

								<li><a
									href="https://www.kobus.co.kr/cscn/ntcmttr/readNtcList.do">고객지원</a></li>

								<li><a
									href="https://www.kobus.co.kr/ugd/bustrop/Bustrop.do">전국고속버스운송사업조합</a></li>

								<li><a
									href="https://www.kobus.co.kr/ugd/trmlbizr/Trmlbizr.do">터미널사업자협회</a></li>

							</ul>
						</div>
					</li>

					<li>
						<div class="dropdown-wrap breadcrumb-select">



							<a href="javascript:void(0)" class="btn-dropdown" title="하위메뉴 선택"
								aria-expanded="false"> <span class="text">고속버스예매</span><i
								class="ico ico-dropdown-arrow"></i></a>
							<ul class="dropdown-list" style="display: none;">
								<li class="selected"><a href="javascript:void(0)"
									title="선택됨">고속버스예매</a></li>

								<li><a href="https://www.kobus.co.kr/mrs/mrscfm.do">예매확인/취소/변경</a></li>

								<li><a href="https://www.kobus.co.kr/mrs/mrsrecplist.do">영수증발행</a></li>
							</ul>
						</div>
					</li>
				</ol>

			</div>
		</nav>


		<article id="new-kor-content" class="full">

			<script>
	var feeList = [];
	
		var tck = '1';
		var dc  = '0';
		var fee = '31900';

		feeList[tck+'_'+dc] = fee;
	
		var tck = '1';
		var dc  = 'b';
		var fee = '30300';

		feeList[tck+'_'+dc] = fee;
	
		var tck = '2';
		var dc  = '0';
		var fee = '16000';

		feeList[tck+'_'+dc] = fee;
	
		var tck = '6';
		var dc  = '0';
		var fee = '31900';

		feeList[tck+'_'+dc] = fee;
	
		var tck = '6';
		var dc  = 'b';
		var fee = '30300';

		feeList[tck+'_'+dc] = fee;
	
		var tck = '9';
		var dc  = '0';
		var fee = '25500';

		feeList[tck+'_'+dc] = fee;
	

	console.log(feeList);
</script>

			<script type="text/javascript"
				src="/koBus/js/SatsChc.js"></script>

			<form name="satsChcFrm" id="satsChcFrm" method="post"
				action="https://www.kobus.co.kr/mrs/satschc.do">
				<input type="hidden" name="deprCd" id="deprCd" value="${deprCode }">
				<!-- 출발지코드 -->
				
				<input type="hidden" name="deprNm" id="deprNm" value="${deprName }">
				<!-- 출발지명 -->
				<input type="hidden" name="arvlCd" id="arvlCd" value="${arrvCode }">
				<!-- 도착지코드 -->
				<input type="hidden" name="arvlNm" id="arvlNm" value="${arrvName }">
				<!-- 도착지명 -->
				<input type="hidden" name="tfrCd" id="tfrCd" value="">
				<!-- 환승지코드 -->
				<input type="hidden" name="tfrNm" id="tfrNm" value="">
				<!-- 환승지명 -->
				<input type="hidden" name="tfrArvlFullNm" id="tfrArvlFullNm"
					value="">
				<!-- 환승지포함 도착지 명 -->
				<input type="hidden" name="pathDvs" id="pathDvs" value="sngl">
				<!-- 직통sngl,환승trtr,왕복rtrp -->
				<input type="hidden" name="pathStep" id="pathStep" value="1">
				<!-- 왕편 복편 설정 -->
				<input type="hidden" name="deprDtm" id="deprDtm" value="20250621">
				<!-- 가는날(편도,왕복) -->
				<input type="hidden" name="deprDtmAll" id="deprDtmAll"
					value="${deprDate }">
				<!-- 가는날(편도,왕복) -->
				<input type="hidden" name="arvlDtm" id="arvlDtm" value="20250621">
				<!-- 오는날(왕복) -->
				<input type="hidden" name="arvlDtmAll" id="arvlDtmAll"
					value="2025. 6. 21. 토">
				<!-- 오는날(왕복) -->
				<input type="hidden" name="busClsCd" id="busClsCd" value="0">
				<!-- 버스등급 -->
				<input type="hidden" name="takeDrtmOrg" id="takeDrtmOrg" value="${takeTime }">
				<!-- 소요시간 -->
				<input type="hidden" name="distOrg" id="distOrg" value="${distance }">
				<!-- 거리 -->
				<!-- 출발일자:deprDtm or arvlDtm, 출발터미널번호:deprCd, 도착터미널번호:arvlCd  -->
				<input type="hidden" name="deprDt" id="deprDt" value="20250621">
				<!-- 출발일 -->
				<input type="hidden" name="deprTime" id="deprTime" value="072000">
				<!-- 출발시각 -->
				<input type="hidden" name="alcnDeprDt" id="alcnDeprDt" value="">
				<!-- 배차출발일 -->
				<input type="hidden" name="alcnDeprTime" id="alcnDeprTime"
					value="072000">
				<!-- 배차출발시각 -->
				<input type="hidden" name="alcnDeprTrmlNo" id="alcnDeprTrmlNo"
					value="010">
				<!-- 배차출발터미널 -->
				<input type="hidden" name="alcnArvlTrmlNo" id="alcnArvlTrmlNo"
					value="200">
				<!-- 배차도착터미널 -->
				<input type="hidden" name="indVBusClsCd" id="indVBusClsCd" value="7">
				<!-- 선택한버스등급 -->
				<input type="hidden" name="cacmCd" id="cacmCd" value="02">
				<!-- 운수사코드 -->
				<input type="hidden" name="deprThruSeq" id="deprThruSeq" value="1">
				<!-- 출발경유순서 -->
				<input type="hidden" name="arvlThruSeq" id="arvlThruSeq" value="4">
				<!-- 도착경유순서 -->

				<input type="hidden" name="adltFee" id="adltFee" value="31900">
				<!-- 일반금액 -->
				<input type="hidden" name="chldFee" id="chldFee" value="16000">
				<!-- 초등생금액 -->
				<input type="hidden" name="teenFee" id="teenFee" value="25500">
				<!-- 중고생금액 -->
				<input type="hidden" name="uvsdFee" id="uvsdFee" value="">
				<!-- 대학생금액 -->
				<input type="hidden" name="sncnFee" id="sncnFee" value="">
				<!-- 경로금액 -->
				<input type="hidden" name="dsprFee" id="dsprFee" value="">
				<!-- 장애인금액 -->

				<input type="hidden" name="vtr3Fee" id="vtr3Fee" value="">
				<!-- 보훈금액30 -->
				<input type="hidden" name="vtr5Fee" id="vtr5Fee" value="">
				<!-- 보훈금액50 -->
				<input type="hidden" name="vtr7Fee" id="vtr7Fee" value="">
				<!-- 보훈금액70 -->
				<input type="hidden" name="dfptFee" id="dfptFee" value="31900">
				<!-- 후불금액 -->
				<!-- 할인금액 -->
				<input type="hidden" name="ctyDcFee1" id="ctyDcFee1" value="">
				<!-- 사전예매 -->
				<input type="hidden" name="ctyDcFee2" id="ctyDcFee2" value="">
				<!-- 단체예매5인 -->
				<input type="hidden" name="ctyDcFee3" id="ctyDcFee3" value="">
				<!-- 뒷좌석예매 -->
				<input type="hidden" name="ctyDcFee4" id="ctyDcFee4" value="">
				<!-- 왕복예매 -->
				<input type="hidden" name="ctyDcFee5" id="ctyDcFee5" value="">
				<!-- 단체예매4인 -->


				<input type="hidden" name="ctyDcFee3Cnt" id="ctyDcFee3Cnt" value="0">
				<!-- 뒷좌석예매 -->

				<input type="hidden" name="dcDvsCd" id="dcDvsCd" value="0">
				<!-- 할인구분코드 -->

				<!-- 20200623 yahan	 -->
				<input type="hidden" name="mrsPsbYn" id="mrsPsbYn" value="Y">
				<!-- 예매가능여부 -->
				<!-- 20200709 yahan	 -->
				<input type="hidden" name="htckUseYn" id="htckUseYn" value="Y">
				<!-- 홈티켓가능여부 -->

				<input type="hidden" name="ctyPrmmDcYn" id="ctyPrmmDcYn" value="Y">
				<!-- 시외우등할인여부 -->
				<input type="hidden" name="prmmDcDvsCd" id="prmmDcDvsCd" value="">
				<!-- 클릭한 우등형할인코드 -->
				<input type="hidden" name="mblUtlzPsbYn" id="mblUtlzPsbYn" value="Y">
				<!-- 모바일발권가능여부 : Y:가능, N:불가능 -->
				<input type="hidden" name="tlcnTrcnUtlzPsbYn" id="tlcnTrcnUtlzPsbYn"
					value="Y">
				<!-- 통합단말기여부  Y:존재, N:없음 -->

				<input type="hidden" name="chkDeprDt" id="chkDeprDt"
					value="20250621">
				<!-- 2일 후 시간체크 -->
				<input type="hidden" name="chkDeprTime" id="chkDeprTime"
					value="072000">
				<!-- 2일 후 시간체크 -->
				<input type="hidden" name="prsTimeAll" id="prsTimeAll"
					value="20250613140651">
				<!-- 2일 후 시간체크 -->

				<input type="hidden" name="rmnSatsNum" id="rmnSatsNum" value="6">
				<!-- 잔여좌석수 -->
				<input type="hidden" name="totSatsNum" id="totSatsNum" value="21">
				<!-- 총좌석수 -->
				<input type="hidden" name="selSeatNum" id="selSeatNum" value="">
				<!-- 선택좌석번호 -->
				<input type="hidden" name="selSeatCnt" id="selSeatCnt" value="0">
				<!-- 선택좌석수 -->
				<input type="hidden" name="selAdltCnt" id="selAdltCnt" value="0">
				<!-- 어른수 -->
				<input type="hidden" name="selAdltDcCnt" id="selAdltDcCnt" value="0">
				<!-- 할인대상어른수 -->
				<input type="hidden" name="selChldCnt" id="selChldCnt" value="0">
				<!-- 초등생수 -->
				<input type="hidden" name="selTeenCnt" id="selTeenCnt" value="0">
				<!-- 중고생수 -->
				<input type="hidden" name="selUvsdCnt" id="selUvsdCnt" value="0">
				<!-- 대학생수 -->
				<input type="hidden" name="selSncnCnt" id="selSncnCnt" value="0">
				<!-- 경로수(권종추가-201906) -->
				<input type="hidden" name="selDsprCnt" id="selDsprCnt" value="0">
				<!-- 장애인수(권종추가-201906) -->
				<input type="hidden" name="selVtr3Cnt" id="selVtr3Cnt" value="0">
				<!-- 보훈수(권종추가-20210525) -->
				<input type="hidden" name="selVtr5Cnt" id="selVtr5Cnt" value="0">
				<!-- 보훈수(권종추가-20210525) -->
				<input type="hidden" name="selVtr7Cnt" id="selVtr7Cnt" value="0">
				<!-- 보훈수(권종추가-20210525) -->
				<input type="hidden" name="selDfptCnt" id="selDfptCnt" value="0">
				<!-- 후불수(권종추가-20220722) -->


				<input type="hidden" name="nonMbrsYn" id="nonMbrsYn" value="Y">
				<!-- 비회원예매Y:비회원, N:회원 테스트용으로 Y고정 -->
				<!-- 선점데이터 -->
				<input type="hidden" name="satsNoAll" id="satsNoAll" value="">
				<!-- 선택좌석번호전체   -->
				<input type="hidden" name="pcpyNoAll" id="pcpyNoAll" value="">
				<!-- 선점번호전체   -->
				<input type="hidden" name="satsNoAll1" id="satsNoAll1" value="">
				<!-- 왕복시 왕편 선택좌석번호전체   -->
				<input type="hidden" name="pcpyNoAll1" id="pcpyNoAll1" value="">
				<!-- 왕복시 왕편 선점번호전체   -->
				<input type="hidden" name="alcnTrmlNoInfo" id="alcnTrmlNoInfo"
					value="">
				<!-- 왕편출도착지 터미널코드 -->
				<input type="hidden" name="satsNoAll2" id="satsNoAll2" value="">
				<!-- 왕복시 복편 선택좌석번호전체   -->
				<input type="hidden" name="pcpyNoAll2" id="pcpyNoAll2" value="">
				<!-- 왕복시 복편 선점번호전체   -->

				<input type="hidden" name="rtSelAdltCnt" id="rtSelAdltCnt" value="">
				<!-- 어른수   -->
				<input type="hidden" name="rtSelChldCnt" id="rtSelChldCnt" value="">
				<!-- 초등생수   -->
				<input type="hidden" name="rtSelUvsdCnt" id="rtSelUvsdCnt" value="">
				<!-- 대학생수   -->
				<input type="hidden" name="rtSelTeenCnt" id="rtSelTeenCnt" value="">
				<!-- 중고생수   -->
				<input type="hidden" name="rtSelSncnCnt" id="rtSelSncnCnt" value="">
				<!-- 경로수(권종추가-201906) -->
				<input type="hidden" name="rtSelDsprCnt" id="rtSelDsprCnt" value="">
				<!-- 장애인수(권종추가-201906) -->
				<input type="hidden" name="rtSelVtr3Cnt" id="rtSelVtr3Cnt" value="">
				<!-- 보훈수(권종추가-20210525) -->
				<input type="hidden" name="rtSelVtr5Cnt" id="rtSelVtr5Cnt" value="">
				<!-- 보훈수(권종추가-20210525) -->
				<input type="hidden" name="rtSelVtr7Cnt" id="rtSelVtr7Cnt" value="">
				<!-- 보훈수(권종추가-20210525) -->
				<input type="hidden" name="rtSelDfptCnt" id="rtSelDfptCnt" value="">
				<!-- 보훈수(권종추가-20210525) -->

				<!-- 예상금액 -->
				<input type="hidden" name="estmAmt" id="estmAmt" value="">
				<!-- 예매금액 -->
				<input type="hidden" name="dcAmt" id="dcAmt" value="">
				<!-- 할인금액 -->
				<input type="hidden" name="tissuAmt" id="tissuAmt" value="">
				<!-- 결제금액 -->

				<input type="hidden" name="rtrpDtl1" id="rtrpDtl1" value="">
				<!-- 왕복시 왕편데이터중 선점을 제외한 나머지 데이터 입력매수,일반인할인매수,일반인,중고생,초등생,대학생,시외우등형할인구분,예매금액,할인금액,결제금액,출발일,출발시간 순으로':'로 구분 -->
				<input type="hidden" name="rtrpDtl2" id="rtrpDtl2" value="">
				<!-- 왕복시 복편데이터중 선점을 제외한 나머지 데이터 입력매수,일반인할인매수,일반인,중고생,초등생,대학생,시외우등형할인구분,예매금액,할인금액,결제금액,출발일,출발시간 순으로':'로 구분 -->


				<input type="hidden" name="webScrnRnwl" id="webScrnRnwl" value="N">
				<!-- 화면갱신을 위한 데이터  Y:새로고침, N:신규 -->
				<input type="hidden" name="teenFeeNCntY" id="teenFeeNCntY" value="">
				<!-- 왕편 청소년 선택 후 복편 배차 청소년 좌석 없는 경우-->
				<input type="hidden" name="uvsdFeeNCntY" id="uvsdFeeNCntY" value="">
				<!-- 왕편 대학생 선택 후 복편 배차 대학생 좌석 없는 경우 -->
				<input type="hidden" name="sncnFeeNCntY" id="sncnFeeNCntY" value="">
				<!-- 왕편 경로 선택 후 복편 배차 경로 좌석 없는 경우 -->
				<input type="hidden" name="dsprFeeNCntY" id="dsprFeeNCntY" value="">
				<!-- 왕편 장애인 선택 후 복편 배차 장애인 좌석 없는 경우 -->
				<input type="hidden" name="vtr3FeeNCntY" id="vtr3FeeNCntY" value="">
				<!-- 왕편 보훈 선택 후 복편 배차 보훈 좌석 없는 경우 -->
				<input type="hidden" name="vtr5FeeNCntY" id="vtr5FeeNCntY" value="">
				<!-- 왕편 보훈 선택 후 복편 배차 보훈 좌석 없는 경우 -->
				<input type="hidden" name="vtr7FeeNCntY" id="vtr7FeeNCntY" value="">
				<!-- 왕편 보훈 선택 후 복편 배차 보훈 좌석 없는 경우 -->
				<input type="hidden" name="dfptFeeNCntY" id="dfptFeeNCntY" value="">
				<!-- 왕편 후불 선택 후 복편 배차 후불 좌석 없는 경우 -->

				<input type="hidden" name="prvtBbizEmpAcmtRt" id="prvtBbizEmpAcmtRt"
					value="N">
				<!-- 국민차장제 대상 여부 (Y/N)-->
				<input type="hidden" name="agrmYn" id="agrmYn" value="U">
				<!-- 국민차장제 동의 여부 (Y/N/U) -->

				<input type="hidden" name="extrComp" id="extrComp" value="">
				<!-- 거래처코드 -->
				<input type="hidden" name="stdDtm" id="stdDtm" value=""> <input
					type="hidden" name="endDtm" id="endDtm" value="">

			</form>

			<div class="loading" id="loading" style="height: 1293px; top: 180px;">
				<p class="load" style="margin-left: -53px;">
					<span class="sr-only">로딩중입니다</span>
				</p>
			</div>

			<div class="title_wrap in_process ticketingT" style="display: none;">

				<a href="https://www.kobus.co.kr/mrs/satschc.do#" class="back">back</a>
				<a href="https://www.kobus.co.kr/mrs/satschc.do#" class="mo_toggle">메뉴</a>

				<h2>고속버스예매</h2>
				<ol class="process">
					<li class="active">예매정보입력</li>
					<li>결제정보입력</li>
					<li class="last">예매완료</li>
				</ol>
			</div>


			<!-- 타이틀 -->
			<div class="content-header"
				data-page-title="예매정보입력(매수 및 좌석선택) | 고속버스예매 | 고속버스예매 | 고속버스통합예매">
				<div class="container">
					<div class="title-area">
						<h2 class="page-title">고속버스예매</h2>
						<ol class="process">
							<li class="active" title="현재 단계"><span class="num">1</span>
								예매정보입력</li>
							<li><span class="num">2</span> 결제정보입력</li>
							<li><span class="num">3</span> 예매완료</li>
						</ol>
					</div>
					<!-- 광고 배너 추후 추가 예정 -->
					<!-- <iframe
						src="/koBus/html/_ad-tubebox-002TITLE.html"
						title="프레임 (전화번호안심 로그인)" class="ad-frame ad-frame-title"></iframe> -->
				</div>
			</div>

			<div class="content-body" id="seatChcPage">
				<div class="container">

					<h3>매수 및 좌석선택</h3>

					<div class="selectSeat_wrap">
						<!-- compareBox -->
						<div class="compare_wrap">
							<!-- 좌측 infoBox -->
							<div class="infoBox">

								<p class="date" id="satsDeprDtm"></p>
								<div class="route_wrap" id="satsRotInfo">
									<div class="inner">

										<dl class="roundBox departure kor">
											<dt>출발</dt>
											<dd id="satsDeprTmlNm"></dd>
										</dl>
										<dl class="roundBox arrive kor">
											<dt>도착</dt>
											<dd id="satsArvlTmlNm"></dd>
										</dl>
									</div>
									<div class="detail_info">
										<span id="satsTakeDrtm"></span> 
										<span id="satsDist"></span>
									</div>
									<div class="btn_r">
										<a href="javascript:void(0)" class="btn btn_modify white"
											onclick="fnUpdRot();" title="노선조회 화면으로 이동">수정</a>
									</div>
								</div>



								<div class="route_wrap">
									<div class="tbl_type2">
										<table>
											<caption>버스 정보 표이며 고속사, 등급, 출발 정보 제공</caption>
											<colgroup>
												<col style="width: 66px;">
												<col>
											</colgroup>
											<tbody>
												<tr>
													<th scope="row">고속사</th>
													<td>${company }</td>
												</tr>
												<tr>
													<th scope="row">등급</th>
													<td>${grade }</td>
												</tr>
												<tr>
													<th scope="row">출발</th>
													<td>${deprTime }</td>
												</tr>
											</tbody>
										</table>
										<div class="btn_r mob_pad">
											<a href="javascript:void(0)" class="btn btn_modify white"
												onclick="fnUpdAlcn();" title="배차조회 화면으로 이동">수정</a>
										</div>
									</div>
								</div>

							</div>
							<!-- //좌측 infoBox -->

							<!-- 우측 detailBox -->
							<div class="detailBox">
								<!-- mobile 매수 선택 -->
								<div class="ticketBox mobileBox">
									<ul class="sel_list col3" id="mobileSelCnt">

										<li>
											<div class="countBox">
												<p class="division">
													<em>일반</em> <span class="text_num count" id="adltCntMob">0</span>


												</p>
												<div class="btn_wrap">
													<ul>


														<li><button type="button" class="btn btn_add">
																<span class="ico_plus"><span class="sr-only">증가</span></span>
															</button></li>
														<li><button type="button" class="btn btn_minus">
																<span class="ico_minus"><span class="sr-only">감소</span></span>
															</button></li>
													</ul>
												</div>
											</div>
										</li>
										<li>
											<div class="countBox">
												<p class="division">
													<em>초등생</em> <span class="text_num count" id="chldCntMob">0</span>
												</p>
												<div class="btn_wrap">
													<ul>


														<li><button type="button" class="btn btn_add">
																<span class="ico_plus"><span class="sr-only">증가</span></span>
															</button></li>
														<li><button type="button" class="btn btn_minus">
																<span class="ico_minus"><span class="sr-only">감소</span></span>
															</button></li>
													</ul>
												</div>
											</div>
										</li>

										<li>
											<div class="countBox">
												<p class="division">
													<em>중고생</em> <span class="text_num count" id="teenCntMob">0</span>


												</p>
												<div class="btn_wrap">
													<ul>
														<li><button type="button" class="btn btn_add">
																<span class="ico_plus"><span class="sr-only">증가</span></span>
															</button></li>
														<li><button type="button" class="btn btn_minus">
																<span class="ico_minus"><span class="sr-only">감소</span></span>
															</button></li>
													</ul>
												</div>
											</div>
										</li>

									</ul>
								</div>
								<!-- //mobile 매수 선택 -->
								<div class="detailBox_head" style="height: 63px;">
									<div class="box_refresh">
										<button type="button" class="btn btn_refresh"
											onclick="fnReload();">
											<span class="ico_refresh"><span class="sr-only">새로고침</span></span>
										</button>
									</div>
									<div class="count_seat">
										<div class="inner">
											<div class="box_count">
												<span class="count_num">잔여 6석 / 전체 21석</span> <span
													class="count_desc"> <span class="ico_square orange">여성/노약자
														우선</span> <!-- 20200724 yahan 뒷좌석 할인 노출조건변경 -->
												</span>
											</div>
										</div>
									</div>
								</div>
								<div class="detailBox_body">
									<!-- 매수선택 -->
									<div class="ticketBox ">
										<ul class="sel_list">

											<li>
												<div class="countBox">
													<p class="division">
														<em>일반</em> <span class="text_num count" id="adltCnt">0</span>

													</p>
													<div class="btn_wrap">
														<ul>

															<li><button type="button" class="btn btn_add">
																	<span class="ico_plus"><span class="sr-only">증가</span></span>
																</button></li>
															<li><button type="button" class="btn btn_minus">
																	<span class="ico_minus"><span class="sr-only">감소</span></span>
																</button></li>
														</ul>
													</div>
												</div>
											</li>

											<li>
												<div class="countBox">
													<p class="division">
														<em>초등생</em> <span class="text_num count" id="chldCnt">0</span>


													</p>
													<div class="btn_wrap">
														<ul>


															<li><button type="button" class="btn btn_add">
																	<span class="ico_plus"><span class="sr-only">증가</span></span>
																</button></li>
															<li><button type="button" class="btn btn_minus">
																	<span class="ico_minus"><span class="sr-only">감소</span></span>
																</button></li>

														</ul>
													</div>
												</div>
											</li>

											<li>
												<div class="countBox">
													<p class="division">
														<em>중고생</em> <span class="text_num count" id="teenCnt">0</span>
													</p>
													<div class="btn_wrap">
														<ul>


															<li><button type="button" class="btn btn_add">
																	<span class="ico_plus"><span class="sr-only">증가</span></span>
																</button></li>
															<li><button type="button" class="btn btn_minus">
																	<span class="ico_minus"><span class="sr-only">감소</span></span>
																</button></li>
														</ul>
													</div>
												</div>
											</li>

										</ul>
									</div>
									<!-- //매수선택 -->
									<!-- 좌석선택 -->

									<!-- 21석 클래스 seat21 -->

									<div class="selectSeat_box">
										<div class="bg_seatBox seat21" style="display: block;">
											<div class="bg_bus_img">
												<img
													src="/koBus/images/bg_bus21.png"
													alt="버스 내부 도면으로 버스의 전방 좌측에는 운전석, 전방 우측에는 출입구가 위치하고 있습니다. 운전석 뒤로는 1,2번 좌석이 있고, 1,2번 좌석 뒤로 두 개의 좌석씩 4,5,7,8,10,11,13,14,16,17,19,20번 좌석이 있습니다. 출입구 뒤에는 3번 좌석이 있으며, 3번 뒤로 6,9,12,15,18,21번 좌석이 있습니다. 2번과 3번 좌석 사이에는 통로가 있으며, 전체적으로 통로를 중심으로 좌측에 2개 좌석, 우측에 1개 좌석이 위치하며 한 줄에 3개의 좌석씩 7줄로 배치되어 있습니다. 총 21개의 좌석이 있으며 좌석 번호는 왼쪽부터 오른쪽으로 증가합니다.">
											</div>
											<div class="seatList">
												<span class="seatBox disabled "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_01"
													value="1"
													onclick="fnSeatChc(this, &#39;seatNum_21_01&#39;);"
													disabled="" title="예매 완료된 좌석" tabindex="-1"
													class="disabled-input"> <label for="seatNum_21_01">1</label>
												</span> <span class="seatBox disabled "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_02"
													value="2"
													onclick="fnSeatChc(this, &#39;seatNum_21_02&#39;);"
													disabled="" title="예매 완료된 좌석" tabindex="-1"
													class="disabled-input"> <label for="seatNum_21_02">2</label>
												</span> <span class="seatBox "> <input type="checkbox"
													name="seatBoxDtl" id="seatNum_21_03" value="3"
													onclick="fnSeatChc(this, &#39;seatNum_21_03&#39;);"
													tabindex="-1" class="disabled-input"> <label
													for="seatNum_21_03">3</label>
												</span> <span class="seatBox disabled "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_04"
													value="4"
													onclick="fnSeatChc(this, &#39;seatNum_21_04&#39;);"
													disabled="" title="예매 완료된 좌석" tabindex="-1"
													class="disabled-input"> <label for="seatNum_21_04">4</label>
												</span> <span class="seatBox disabled "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_05"
													value="5"
													onclick="fnSeatChc(this, &#39;seatNum_21_05&#39;);"
													disabled="" title="예매 완료된 좌석" tabindex="-1"
													class="disabled-input"> <label for="seatNum_21_05">5</label>
												</span> <span class="seatBox disabled "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_06"
													value="6"
													onclick="fnSeatChc(this, &#39;seatNum_21_06&#39;);"
													disabled="" title="예매 완료된 좌석" tabindex="-1"
													class="disabled-input"> <label for="seatNum_21_06">6</label>
												</span> <span class="seatBox disabled "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_07"
													value="7"
													onclick="fnSeatChc(this, &#39;seatNum_21_07&#39;);"
													disabled="" title="예매 완료된 좌석" tabindex="-1"
													class="disabled-input"> <label for="seatNum_21_07">7</label>
												</span> <span class="seatBox disabled "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_08"
													value="8"
													onclick="fnSeatChc(this, &#39;seatNum_21_08&#39;);"
													disabled="" title="예매 완료된 좌석" tabindex="-1"
													class="disabled-input"> <label for="seatNum_21_08">8</label>
												</span> <span class="seatBox disabled "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_09"
													value="9"
													onclick="fnSeatChc(this, &#39;seatNum_21_09&#39;);"
													disabled="" title="예매 완료된 좌석" tabindex="-1"
													class="disabled-input"> <label for="seatNum_21_09">9</label>
												</span> <span class="seatBox disabled "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_10"
													value="10"
													onclick="fnSeatChc(this, &#39;seatNum_21_10&#39;);"
													disabled="" title="예매 완료된 좌석" tabindex="-1"
													class="disabled-input"> <label for="seatNum_21_10">10</label>
												</span> <span class="seatBox disabled "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_11"
													value="11"
													onclick="fnSeatChc(this, &#39;seatNum_21_11&#39;);"
													disabled="" title="예매 완료된 좌석" tabindex="-1"
													class="disabled-input"> <label for="seatNum_21_11">11</label>
												</span> <span class="seatBox disabled "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_12"
													value="12"
													onclick="fnSeatChc(this, &#39;seatNum_21_12&#39;);"
													disabled="" title="예매 완료된 좌석" tabindex="-1"
													class="disabled-input"> <label for="seatNum_21_12">12</label>
												</span> <span class="seatBox disabled "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_13"
													value="13"
													onclick="fnSeatChc(this, &#39;seatNum_21_13&#39;);"
													disabled="" title="예매 완료된 좌석" tabindex="-1"
													class="disabled-input"> <label for="seatNum_21_13">13</label>
												</span> <span class="seatBox "> <input type="checkbox"
													name="seatBoxDtl" id="seatNum_21_14" value="14"
													onclick="fnSeatChc(this, &#39;seatNum_21_14&#39;);"
													tabindex="-1" class="disabled-input"> <label
													for="seatNum_21_14">14</label>
												</span> <span class="seatBox disabled "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_15"
													value="15"
													onclick="fnSeatChc(this, &#39;seatNum_21_15&#39;);"
													disabled="" title="예매 완료된 좌석" tabindex="-1"
													class="disabled-input"> <label for="seatNum_21_15">15</label>
												</span> <span class="seatBox disabled "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_16"
													value="16"
													onclick="fnSeatChc(this, &#39;seatNum_21_16&#39;);"
													disabled="" title="예매 완료된 좌석" tabindex="-1"
													class="disabled-input"> <label for="seatNum_21_16">16</label>
												</span> <span class="seatBox "> <input type="checkbox"
													name="seatBoxDtl" id="seatNum_21_17" value="17"
													onclick="fnSeatChc(this, &#39;seatNum_21_17&#39;);"
													tabindex="-1" class="disabled-input"> <label
													for="seatNum_21_17">17</label>
												</span> <span class="seatBox disabled "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_18"
													value="18"
													onclick="fnSeatChc(this, &#39;seatNum_21_18&#39;);"
													disabled="" title="예매 완료된 좌석" tabindex="-1"
													class="disabled-input"> <label for="seatNum_21_18">18</label>
												</span> <span class="seatBox last_seat "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_19"
													value="19"
													onclick="fnSeatChc(this, &#39;seatNum_21_19&#39;);"
													tabindex="-1" class="disabled-input"> <label
													for="seatNum_21_19">19</label>
												</span> <span class="seatBox last_seat "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_20"
													value="20"
													onclick="fnSeatChc(this, &#39;seatNum_21_20&#39;);"
													tabindex="-1" class="disabled-input"> <label
													for="seatNum_21_20">20</label>
												</span> <span class="seatBox last_seat last "> <input
													type="checkbox" name="seatBoxDtl" id="seatNum_21_21"
													value="21"
													onclick="fnSeatChc(this, &#39;seatNum_21_21&#39;);"
													tabindex="-1" class="disabled-input"> <label
													for="seatNum_21_21">21</label>
												</span>





											</div>
										</div>
									</div>
									<!-- //좌석선택 -->
								</div>
							</div>
							<!-- //우측 detailBox -->
						</div>
						<!-- //compareBox -->
						<!-- 선택좌석 상세보기 -->
						<div class="selectSeat_detail">
							<div class="box_tbl">
								<!-- 선택좌석 -->
								<section class="box_detail">
									<div class="box_title">
										<strong class="txt_tit">선택좌석</strong>
									</div>
									<div class="sel_seatNum">
										<span class="txt_selSeat" style="display: none;">좌석을
											선택해주세요</span> <span class="txt_selSeat selected" id="selSeatView">좌석을
											선택해주세요</span>
										<!-- 좌석번호 선택시 class="selected" 추가 -->
									</div>
								</section>
								<!-- //선택좌석 -->
								<!-- 탑승인원 및 요금 -->
								<section class="box_detail">
									<div class="tbl_type3">
										<table class="taR">
											<caption>탑승 인원에 따른 요금 정보 표</caption>
											<colgroup>
												<col style="width: 115px;">
												<col>
											</colgroup>
											<tbody>
												<tr>
													<th scope="row" class="txt_black">탑승인원 및 요금</th>
													<td id="allTotAmtLocU">0원</td>
												</tr>
















												<tr>
													<th scope="row">일반 <span id="adltSeatCnt">0</span></th>
													<td id="adltTotAmt">0원</td>
												</tr>














												<tr>
													<th scope="row">초등생 <span id="chldSeatCnt">0</span></th>
													<td id="chldTotAmt">0원</td>
												</tr>





























												<tr>
													<th scope="row">중고생 <span id="teenSeatCnt">0</span></th>
													<td id="teenTotAmt">0원</td>
												</tr>








											</tbody>
										</table>
									</div>
								</section>
								<!-- //탑승인원 및 요금 -->
							</div>
							<!-- 할인선택 -->
							<div class="box_tbl">

								<section class="box_detail">
									<div class="box_title">
										<strong class="txt_tit">할인선택</strong>
									</div>
									<ul class="checkList">



										<!-- 왕복이 아닐겨우 단체,사전,뒷좌석할인 적용  -->























										<li><input type="radio" name="salesInfo" id="salesInfo_b"
											onclick="fnCtyPrmmDC(&#39;b&#39;,this);" value="b"> <label
											for="salesInfo_b">주말 할인<span class="price"
												id="holiMrsDc">0원</span></label></li>







										<li style="font-size: 11px;">- 가장 높은 할인율이 자동 적용됩니다.
											(중복불가)</li>
									</ul>
								</section>



								<!-- //할인선택 -->
								<!-- 총 결제금액 -->
								<section class="box_detail total_price">
									<!-- 총 결재금액일 시 class="total_price" 추가 -->
									<div class="box_title">
										<strong class="txt_tit">총 결제금액</strong> <span
											class="sel_price" id="allTotAmtLocD">0원</span>
									</div>
								</section>
								<!-- //총 결제금액 -->
							</div>
						</div>
						<!-- //선택좌석 상세보기 -->
						<div class="btns btn_selectSeat">
							<a href="javascript:void(0)" id="satsChcCfmBtn"
								class="btnL btn_confirm ready btn_pop_focus"
								onclick="fnSatsChcCfm(event);">선택완료</a>
						</div>

					</div>

					<!-- 상세설명 -->
					<ul class="desc_list">

						<li>심야 시간대 출발차량의 1번부터 9번 좌석까지는 여성고객 및 노약자를 위한 좌석으로 운영되고 있습니다.
							교통 약자를 위해 배려해 주시기 바랍니다.</li>
						<li><span class="ico_square orange">색상표기 좌석</span>은 여성고객 및
							노약자를 위한 좌석입니다. 배려해 주시기 바랍니다.</li>



						<!--  <li>할인적용시에는 신용카드 결제만 가능합니다.</li> -->
						<!-- 
						<li>할인대상 노선입니다. 편도의 경우 최대10매, 왕복일경우 최대 5매까지 선택 가능합니다.</li>
						<li>중복할인이 적용되지 않으며, 할인조건에서 하나를 직접 선택하여 적용해야 합니다.</li>
						<li>할인은 성인에게만 적용됩니다.</li>
						<li>단체할인은 5~10명 사이를 선택할 경우에 적용됩니다.</li>
						<li>뒷좌석을 선택하시면, "뒷좌석 할인"이 적용될 수 있습니다.</li> 
						-->







						<li>일부 버스의 경우 실제 좌석배치와 다를 수 있습니다.</li>

					</ul>
					<!-- //상세설명 -->
				</div>

			</div>






			<!-- 180718 수정 -->




			<!-- // 180718 수정 -->




			<script type="text/javascript"
				src="/koBus/js/ReadLgnInf.js"></script>

			<!-- 20200617 yahan -->
			<script type="text/javascript"
				src="/koBus/js/rsa_oaep-min.js"></script>
			<script type="text/javascript"
				src="/koBus/js/jsbn-min2.js"></script>
			<script type="text/javascript"
				src="/koBus/js/typedarray.js"></script>
	$(function(){ initTranskey(); })
</script>


			<input type="hidden" name="locInf" id="locInf" value="sats">
			<!-- 페이지위치 -->
			<input type="hidden" name="adtnflag" id="adtnflag" value="N">
			<!-- 페이지위치 -->
			<!-- 출/도착지 선택 레이어팝업 -->


			<script type="text/javascript"
				src="/koBus/js/ReadLgnInf.js"></script>

			<!-- 20200831 yahan -->
			<script type="text/javascript"
				src="/koBus/js/rsa_oaep-min.js"></script>
			<script type="text/javascript"
				src="/koBus/js/jsbn-min2.js"></script>
			<script type="text/javascript"
				src="/koBus/js/typedarray.js"></script>
			<script>
//	$(function(){ initTranskey(); })
</script>


			<!-- 임시비밀번호 변경 -->

			<form name="lgnForm">
				<input type="hidden" id="returnUrl2" name="returnUrl" value="logout">
			</form>


			<style>
.txt_red {
	font-weight: bold;
	text-decoration: underline;
	color: #e64c2e;
}

.txt_bold {
	font-weight: bold;
	text-decoration: underline;
}
</style>

			<!--
<div class="remodal pop_route" data-remodal-id="popRoute1" role="dialog">
	<div class="title" style="font-size:20px">
		코로나19 고속버스 사회적 거리두기 안내
	</div>
	<div class="cont">
		<ul class="txt">
			
			<li><strong>① 예매시 창가쪽 좌석 우선 선택</strong></li>
			<li><strong>② 차량내 마스크 반드시 착용</strong></li>
			<li><strong>③ 차량내 대화자제 및 음식물 반입·섭취 금지</strong></li>
			<li><strong>※ 중대본 거리두기 단계별 기준 근거</strong></li>
			<li><strong>4. 음식섭취 자제</strong>
				<ul class="desc_list">
					<li>코로나19 예방을 위해 <span class="txt_bold txt_red">차량 내 음식섭취는 자제</span>하여주시기 바랍니다.</li>
				</ul>
			</li>
		</ul>
	</div>
	<div class="btns">
		<button type="button" data-remodal-action="confirm" class="remodal-confirm" >확인</button>
	</div>
	<button type="button" data-remodal-action="close" class="remodal-close"><span class="sr-only">닫기</span></button>
</div> 
-->


			<!-- 2021 / 05 / 14 보훈처 popup 추가  -->

			<!-- 2021 / 05 / 14 보훈처 popup 추가  -->

			<!-- 2024 / 06 / 08 건강보험공단 정보입력 popup 추가  -->

			<!-- 2024 / 06 / 08 건강보험공단 정보입력 popup 추가  -->


			<!-- 2020-03-06 코로나19 예방과 안전운행 안내 -->
			<script>
// 	var popRoute1 = $('[data-remodal-id=popRoute1]').remodal();
// 	popRoute1.open();
</script>
		</article>

		<!-- footer -->














		<!-- 푸터 -->
		<footer id="new-kor-footer">
			<div class="container">
				<div class="footer-top-cont">
					<ul class="express-bus-company-list">
						<li><a href="http://www.kumhobuslines.co.kr/" target="_blank"
							title="새창"><img
								src="/koBus/images/logo-kumho-express.png"
								alt="금호고속"></a></li>
						<li><a href="http://www.dongbubus.com/" target="_blank"
							title="새창"><img
								src="/koBus/images/logo-dongbu-express.png"
								alt="동부고속"></a></li>
						<li><a href="http://www.songnisanbuslines.co.kr/"
							target="_blank" title="새창"><img
								src="/koBus/images/logo-sokrisan-express.png"
								alt="속리산고속"></a></li>
						<li><a href="http://www.dyexpress.co.kr/" target="_blank"
							title="새창"><img
								src="/koBus/images/logo-dongyang-express.png"
								alt="동양고속"></a></li>
						<li><a href="http://www.samhwaexpress.co.kr/" target="_blank"
							title="새창"><img
								src="/koBus/images/logo-samhwa-express.png"
								alt="삼화고속"></a></li>
						<li><a href="http://www.jabus.co.kr/" target="_blank"
							title="새창"><img
								src="/koBus/images/logo-joongang-express.png"
								alt="중앙고속"></a></li>
						<li><a href="http://www.chunilexpress.co.kr/" target="_blank"
							title="새창"><img
								src="/koBus/images/logo-chunil-express.png"
								alt="천일고속"></a></li>
						<li><a href="http://www.hanilexpress.co.kr/" target="_blank"
							title="새창"><img
								src="/koBus/images/logo-hanil-express.png"
								alt="한일고속"></a></li>
					</ul>
					<!-- dropdown-top 클래스 추가 시, 드롭다운 목록 위로 노출 -->
					<div class="dropdown-wrap dropdown-top related-sites-select">
						<a href="javascript:void(0)" class="btn-dropdown" title="관련사이트 이동"
							aria-expanded="false"><span class="text">관련사이트</span><i
							class="ico ico-arrow-down"></i></a>
						<ul class="dropdown-list" style="display: none;">
							<li class="selected"><a
								href="https://www.kobus.co.kr/wchr/main.do" target="_blank"
								title="새창">장애인 휠체어 사이트</a></li>
							<li><a href="https://www.tago.go.kr/" target="_blank"
								title="새창">국가대중교통정보센터</a></li>
							<li><a href="https://www.intis.or.kr/" target="_blank"
								title="새창">인천장애인콜택시</a></li>
							<li><a href="http://www.shinsegaecentralcity.com/"
								target="_blank" title="새창">센트럴시티터미널</a></li>
							<li><a href="https://txbus.t-money.co.kr/" target="_blank"
								title="새창">시외버스 통합예매시스템</a></li>
						</ul>
					</div>
				</div>
				<div class="footer-bottom-cont">
					<address class="address">
						<ul class="policy-list">
							<li><a href="https://www.kobus.co.kr/etc/svcstpl/SvcStpl.do">서비스
									이용약관</a></li>
							<li><a
								href="https://www.kobus.co.kr/etc/indlstpl/IndlStpl.do"
								class="text-bold">개인정보 처리방침</a></li>
							<li><a href="https://www.kobus.co.kr/etc/busstpl/BusStpl.do">고속버스
									운송약관</a></li>
							<li><a href="http://www.tmoney.co.kr/" target="_blank"
								title="새창">티머니</a></li>
						</ul>
						<ul class="contact">
							<li>고객센터 : 1644-9030</li>
							<li>서울특별시 서초구 신반포로 194</li>
							<li>대표자 : 김용성</li>
							<li>통신판매업신고 : 2009-서울서초 0587호</li>
						</ul>
						<p class="copyright">COPYRIGHT© 2016. WWW.KOBUS.CO.KR . ALL
							RIGHT RESERVED</p>
					</address>
					<ul class="greeting-btn-list">
						<li><a
							href="http://www.wa.or.kr/board/list.asp?search=total&amp;SearchString=%B0%ED%BC%D3%B9%F6%BD%BA&amp;BoardID=0006"
							target="_blank" title="새창"><img
								src="/koBus/images/logo-accessibility2.png"
								alt="(사)한국장애인단체총연합회 한국웹접근성인증평가원 웹 접근성 우수사이트 인증마크(WA인증마크)"
								height="40"></a></li>
						<li><a href="https://www.kobus.co.kr/ugd/bustrop/Bustrop.do"
							title="이사장 인사말 바로가기"><img
								src="/koBus/images/logo-kobus.png"
								alt="KOBUS 전국고속버스운송사업조합"></a></li>
						<li><a
							href="https://www.kobus.co.kr/ugd/trmlbizr/Trmlbizr.do"
							title="협회장 인사말 바로가기"><img
								src="/koBus/images/logo-npvtba-express.png"
								alt="전국여객자동차터미널사업자협회"></a></li>
					</ul>
				</div>
			</div>
		</footer>

	</div>








	<div class="remodal-overlay remodal-is-closed" style="display: none;"></div>
	<div class="remodal-wrapper remodal-is-closed" style="display: none;">
		<div class="remodal remodal-is-initialized remodal-is-closed"
			data-remodal-id="modal03" role="dialog"
			data-remodal-options="closeOnOutsideClick: false"
			aria-labelledby="modal1Title" aria-describedby="modal1Desc"
			tabindex="-1">
			<div class="cont">
				<h2>왕복예매할인 안내</h2>
				<p class="txt">
					<span class="accent">왕복예매할인</span> 적용 시 예매 완료 후 승차권 매수변경이 불가합니다.<br>예매
					후 변경을 원하시면 취소 후 다시 예매 하셔야 합니다.
				</p>
				<p class="txt">왕복예매 할인을 적용하시겠습니까?</p>
			</div>
			<div class="btns">
				<button type="button" data-remodal-action="cancel"
					class="remodal-cancel" onclick="fnFeeCanc(&#39;3&#39;);">취소</button>
				<button type="button" data-remodal-action="confirm"
					class="remodal-confirm" onclick="fnFeeOk(&#39;3&#39;);">적용</button>
			</div>
			<button type="button" data-remodal-action="close"
				class="remodal-close btn-gray" onclick="fnFeeCanc(&#39;3&#39;);">
				<span class="sr-only">닫기</span>
			</button>
		</div>
	</div>
	<div class="remodal-wrapper remodal-is-closed" style="display: none;">
		<div class="remodal remodal-is-initialized remodal-is-closed"
			data-remodal-id="modal02" role="dialog"
			data-remodal-options="closeOnOutsideClick: false"
			aria-labelledby="modal1Title" aria-describedby="modal1Desc"
			tabindex="-1">
			<div class="cont">
				<h2>단체예매할인 안내</h2>
				<p class="txt">
					<span class="accent">단체예매할인</span> 적용 시 예매 완료 후 승차권 매수변경이 불가합니다.<br>예매
					후 변경을 원하시면 취소 후 다시 예매 하셔야 합니다.
				</p>
				<p class="txt">단체예매 할인을 적용하시겠습니까?</p>
			</div>
			<div class="btns">
				<button type="button" data-remodal-action="cancel"
					class="remodal-cancel" onclick="fnFeeCanc(&#39;2&#39;);">취소</button>
				<button type="button" data-remodal-action="confirm"
					class="remodal-confirm" onclick="fnFeeOk(&#39;2&#39;);">적용</button>
			</div>
			<button type="button" data-remodal-action="close"
				class="remodal-close btn-gray" onclick="fnFeeCanc(&#39;2&#39;);">
				<span class="sr-only">닫기</span>
			</button>
		</div>
	</div>
	<div class="remodal-wrapper remodal-is-closed" style="display: none;">
		<div class="remodal crew remodal-is-initialized remodal-is-closed"
			data-remodal-id="popCrew1" role="dialog" tabindex="-1">
			<!--  data-remodal-options="closeOnConfirm: false" -->
			<div class="title">
				<h2>국민안전 승무원제 시범운영 안내</h2>
			</div>
			<div class="cont">
				<img
					src="/koBus/images/img_crew_info1.jpg"
					alt="" class="crew_info">
				<div class="alt">
					<h4>국민안전 승무원이 되어 보시겠습니까?</h4>
					<p>
						국민안전 승무원 좌석을 예매하시는 고객께서는 행동요령을 숙지하여<br>유사시 도와주시기 바랍니다.
					</p>
					<ol>
						<li>1. 교통사고나 화재 등 비상상황 발생시 운전기사를 도와 승객 대피</li>
						<li>2. 승객 대피 유도시 운전기사를 도와 탈출로 확보 _ 승강구 수동사용, 비상망치</li>
						<li>3. 소화기 위치 및 사용방법</li>
						<li>4. 버스 이상 운행 및 이상 징후 포착시 운전기사에게 알림</li>
					</ol>
					<h4>혜택</h4>
					<p>고속버스 통합 홈페이지 (www.kobus.co.kr) 또는 모바일 앱 회원으로 가입후 해당 노선의 프리미엄
						고속버스 3번 좌석을 예매하였을 경우 요금의 5% 마일리지 적립 및 추가로 1% 마일리지가 적립됩니다.</p>
					<p>온라인 예매시 국민안전 승무원 좌석의 동의 여부를 확인 후 동의 시에만 마일리지 추가 적립되며 터미널
						매표소에서 예매하신 승차권은 적용되지 않습니다.</p>
				</div>
				<!--
            <p class="tit"><span class="txt_blue">국민안전 승무원이</span> 되어 보시겠습니까?</p>
            <p class="desc">국민안전 승무원 좌석을 예매하시는 고객께서는 행동요령을 숙지하여<br/>유사시 도와주시기 바랍니다.</p>
            <div class="box marT30">
                <ol>
                    <li>
                        <p class="subject"><span class="num">1</span>교통사고나 화재 등 비상상황 발생시 운전기사를 도와 승객 대피</p>
                    </li>
                    <li>
                        <p class="subject"><span class="num">2</span>승객 대피 유도시 운전기사를 도와 탈출로 확보 _ 승강구 수동사용, 비상망치</p>
                    </li>
                    <li>
                        <p class="subject"><span class="num">3</span>소화기 위치 및 사용방법</p>
                    </li>
                    <li>
                        <p class="subject"><span class="num">4</span>버스 이상 운행 및 이상 징후 포착시 운전기사에게 알림</p>
                    </li>
                </ol>
            </div>
            <h4>혜택</h4>
            <p>고속버스 통합 홈페이지 (www.kobus.co.kr) 또는 모바일 앱 회원으로 가입후 해당 노선의 프리미엄 <span class="txt_blue">고속버스 3번 좌석</span>을 예매하였을 경우 <span class="txt_blue">요금의 5% 마일리지 적립 및 추가로 1% 마일리지가 적립</span>됩니다.</p>
            <ul class="desc_list">
                <li>온라인 예매시 국민안전 승무원 좌석의 동의 여부를 확인 후 동의 시에만 마일리지 추가 적립되며 <span class="txt_black">터미널 매표소에서 예매하신 승차권은 적용되지 않습니다.</span></li>
            </ul>
            <div class="btns" style="border-top:0">
                <button data-remodal-action="cancel" class="remodal-cancel">거부</button>
                <button class="remodal-confirm" onclick="popCrewOpen(2);">동의</button>
            </div>
-->
			</div>
			<div class="btn_wrap1">
				<a href="javascript:void(0)" onclick="popCrewOpen(2, &#39;Y&#39;);">동의</a>
				<a href="javascript:void(0)" data-remodal-action="cancel"
					onclick="popCrewClose(1, &#39;N&#39;);">거부</a>
			</div>
		</div>
	</div>
	<div class="remodal-wrapper remodal-is-closed" style="display: none;">
		<div class="remodal crew remodal-is-initialized remodal-is-closed"
			data-remodal-id="popCrew2" role="dialog" tabindex="-1">
			<!--  data-remodal-options="closeOnConfirm: false" -->
			<div class="title">
				<h2>국민안전 승무원제 시범운영 안내</h2>
			</div>
			<div class="cont">
				<img
					src="/koBus/images/img_crew_info2.jpg"
					alt="" class="crew_info">

				<!-- 대체텍스트 -->
				<ul class="alt">
					<li><span>1. 교통사고나 화재 등 비상상황 발생시 운전기사를 도와 승객 대피</span>
						<ul>
							<li><span>1. 교통사고나 화재 등 비상상황 발생</span></li>
							<li><span>2. 운전기사를 도와 안전지대로 승객 대피 유도</span></li>
						</ul></li>
					<li><span>2. 승객 대피 유도시 운전기사를 도와 탈출로 확보 _ 승강구 수동사용, 비상망치</span>
						<ul>
							<li><span>승강구 수동사용</span>
								<ul>
									<li><span>1. 우측으로 돌려서 사용</span></li>
									<li><span>2. 승강구를 밀어 탈출</span></li>
								</ul></li>
							<li><span>비상망치</span>
								<ul>
									<li><span>1. 버스양옆에 위치</span></li>
									<li><span>2. 창문의 가장자리를 가격</span></li>
								</ul></li>
						</ul></li>
					<li><span>3. 소화기 위치 및 사용방법</span>
						<ul>
							<li><span>1. 운전석 뒤, 맨 뒷자석 뒤에 위치</span></li>
							<li><span>2. 안전핀 제거</span></li>
							<li><span>3. 화재방향으로 빗자루 쓸듯이 분사</span></li>
						</ul></li>
					<li><span>4. 버스 이상 운행 및 이상 징후 포착시 운전기사에게 알림</span>
						<ul>
							<li><span>1. 이상 운행 및 이상 징후 포착</span></li>
							<li><span>2. 운전기사에게 통지하여 사고 예방</span></li>
						</ul></li>
				</ul>
				<!--
            <ol>
                <li>
                    <p class="subject"><span class="num">1</span>교통사고나 화재 등 비상상황 발생시 운전기사를 도와 승객 대피</p>
                    <img src="/images/page/img_crew1.jpg" alt="">
                    <ul>
                        <li class="w50">
                            <img src="/images/page/img_m_crew1.jpg" alt="" class="m"> 1. 교통사고나 화재 등 비상상황 발생
                        </li>
                        <li class="w50">
                            <img src="/images/page/img_m_crew2.jpg" alt="" class="m"> 2. 운전기사를 도와 안전지대로 승객 대피 유도
                        </li>
                    </ul>
                </li>
                <li>
                    <p class="subject"><span class="num">2</span>승객 대피 유도시 운전기사를 도와 탈출로 확보 _ <span class="gray">승강구 수동사용, 비상망치</span></p>
                    <ul>
                        <li class="w50">
                            <p>승강구 수동사용</p>
                            <img src="/images/page/img_crew2.jpg" alt="">
                            <img src="/images/page/img_m_crew3.jpg" alt="" class="m">
                            <ul>
                                <li class="w50">1. 우측으로 돌려서 사용</li>
                                <li class="w50">2. 승강구를 밀어 탈출</li>
                            </ul>
                        </li>
                        <li class="w50">
                            <p>비상망치</p>
                            <img src="/images/page/img_crew3.jpg" alt="">
                            <img src="/images/page/img_m_crew4.jpg" alt="" class="m">
                            <ul>
                                <li class="w50">1. 버스양옆에 위치</li>
                                <li class="w50">2. 창문의 가장자리를 가격</li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li>
                    <p class="subject"><span class="num">3</span>소화기 위치 및 사용방법</p>
                    <img src="/images/page/img_crew4.jpg" alt="">
                    <ul>
                        <li class="w50">
                            <img src="/images/page/img_m_crew5.jpg" alt="" class="m"> 1. 운전석 뒤, 맨 뒷자석 뒤에 위치
                            <img src="/images/page/img_m_crew6.jpg" alt="" class="m">
                        </li>
                        <li class="w25">2. 안전핀 제거</li>
                        <li class="w25">3. 화재방향으로 빗자루 쓸듯이 분사</li>
                    </ul>
                </li>
                <li>
                    <p class="subject"><span class="num">4</span>버스 이상 운행 및 이상 징후 포착시 운전기사에게 알림</p>
                    <img src="/images/page/img_crew5.jpg" alt="">
                    <ul class="mb10">
                        <li class="w50">
                            <img src="/images/page/img_m_crew7.jpg" alt="" class="m"> 1. 이상 운행 및 이상 징후 포착
                        </li>
                        <li class="w50">
                            <img src="/images/page/img_m_crew8.jpg" alt="" class="m"> 2. 운전기사에게 통지하여 사고 예방
                        </li>
                    </ul>
                </li>
            </ol>
            -->
				<!--
            <div class="btns" style="border-top:0">
                <button data-remodal-action="cancel" class="remodal-cancel" onclick="alert('당신은 국민안전 승무원이 되셨습니다.')">닫기</button>
            </div>
-->
			</div>
			<div class="btn_wrap2">
				<a href="javascript:void(0)" id="closeCrew"
					data-remodal-action="cancel"
					onclick="popCrewClose(2, &#39;Y&#39;);">닫기</a>
			</div>
		</div>
	</div>
	<div class="remodal-wrapper plogin remodal-is-closed"
		style="display: none;">
		<div
			class="remodal w590 popLogin full remodal-is-initialized plogin remodal-is-closed"
			data-remodal-id="popLogin"
			data-remodal-options="closeOnOutsideClick: false, modifier: plogin"
			role="dialog" tabindex="-1">
			<div class="loading pop" id="loading"
				style="height: 1293px; top: 180px;">
				<p class="load" style="margin-left: -53px;">
					<span class="sr-only">로딩중입니다</span>
				</p>
			</div>
			<div class="title type_blue">로그인</div>
			<form id="lgnUsrInfForm" name="lgnUsrInfForm">
				<div class="cont">
					<div class="login_wrap pop">
						<div class="box_login">
							<h3 class="pop_h3 mob_h3">회원 로그인</h3>
							<p class="h3_desc">회원으로 예매하시면 예매 후 아이디/비밀번호로 간편하게 조회가 가능합니다.</p>
							<div class="inner">
								<fieldset>
									<legend>회원로그인</legend>
									<ul class="loginList">
										<li>
											<div class="box_inputForm">
												<label for="usrId" class="label">아이디</label> <span
													class="box_label"> <input type="text" name="usrId"
													placeholder="아이디를 입력하세요" id="usrId" class="input"
													onkeyup="fnIcoCheck(this);">
												</span>
											</div>
										</li>
										<li>
											<div class="box_inputForm">
												<label for="usrPwd" class="label">비밀번호</label> <span
													class="box_label">
													<button type="button" class="transkey_btn" data-id="usrPwd"
														onclick="transkeyShow(this)">가상키패드 입력</button> <input
													type="password" name="usrPwd" id="usrPwd" tabindex="-1"
													placeholder="비밀번호를 입력하세요" class="input"
													onkeyup="fnIcoCheck(this);" data-tk-kbdtype="qwerty"
													onfocus="tk.onKeyboard(this);">
												</span>
											</div>
										</li>
									</ul>
								</fieldset>
								<input type="hidden" id="popUpDvs" name="popUpDvs" value="Y">
								<p class="btn_squareBox">
									<button type="button" class="btn_confirm ready"
										id="btn_confirm" onclick="fnMngChkCfm(this);">로그인</button>
								</p>



								<div class="box_searchId col2">
									<a href="javascript:lgnSearchId();"><span
										class="ico_searchId">아이디찾기</span></a> <a
										href="javascript:lgnSearchPwd();"><span
										class="ico_searchPW">비밀번호찾기</span></a>
								</div>
							</div>
						</div>
						<div class="box_login non-member">
							<div class="inner">
								<h3 class="pop_h3 mob_h3">비회원 예매</h3>
								<p class="h3_desc">비회원 예매 시 일부 서비스 이용이 제한됩니다.</p>
								<p class="btn_squareBox">
									<button type="button" class="btn_normal"
										onclick="javascript:fnNonUsrMrs();">비회원 예매</button>
								</p>
								<!--fnNonUsrMrs() 각 페이지의 해당 함수의 기능제어 요망  -->
							</div>
						</div>
						<div class="bg_grayBox">
							<p class="txt_desc">고속버스 통합회원으로 가입하시면 홈페이지와 모바일앱과의 예매내역 공유로더욱
								편리한 고속버스 이용이 가능합니다.</p>
							<div class="box_joinUs">
								<a href="javascript:mbrsJoin();" class="btn_joinUs"><span
									class="ico_joinUs">통합회원가입</span></a>
							</div>
						</div>
					</div>
				</div>
				<input type="hidden" id="hidfrmId" name="hidfrmId"
					value="lgnUsrInfForm"><input type="hidden"
					id="transkeyUuid_lgnUsrInfForm" name="transkeyUuid_lgnUsrInfForm"
					value="9df453f5f197a4018e245e89cfab701e6ab26138f18b947641710bec47c943dd"><input
					type="hidden" id="transkey_usrPwd_lgnUsrInfForm"
					name="transkey_usrPwd_lgnUsrInfForm" value=""><input
					type="hidden" id="transkey_HM_usrPwd_lgnUsrInfForm"
					name="transkey_HM_usrPwd_lgnUsrInfForm" value="">
			</form>
			<div class="pop_banner_wrap">
				<span class="txt_banner">예매부터 탑승까지 원스탑 모바일 서비스!</span> <strong
					class="tit_ban">고속버스 모바일앱</strong> <span class="bg_ban mobileApp">고속버스
					모바일앱</span>
			</div>
			<button type="button" data-remodal-action="close"
				class="remodal-close">
				<span class="sr-only">닫기</span>
			</button>
		</div>
	</div>
	<div class="remodal-wrapper remodal-is-closed" style="display: none;">
		<div
			class="remodal pop_change_password remodal-is-initialized remodal-is-closed"
			data-remodal-id="popChangePassword" role="dialog"
			data-remodal-options="closeOnOutsideClick:false" tabindex="-1">
			<form name="pwdModLsapForm" id="pwdModLsapForm" method="post"
				onsubmit="return false;">
				<input type="hidden" name="mbr_mng_no" id="mbr_mng_no" value="">
				<div class="title">비밀번호 변경</div>
				<div class="cont">
					<div id="oldPwdChgDiv" style="display: none;">
						<h3 class="pop_h3">고객님께서는 오랜 기간(180일) 비밀번호를 변경하지 않으셨습니다.</h3>
						<p class="desc">
							동일한 비밀번호를 장기간 사용할 경우 개인정보 도용 및 유출 등의 위험이 있습니다.<br> 비밀번호를
							변경해주세요.
						</p>
					</div>
					<div id="tmpPwdChgDiv" style="display: none;">
						<h3 class="pop_h3">스스로 지키는 개인정보! 비밀번호를 변경해주세요.</h3>
						<p class="desc">
							현재 고객님께서는 <span class="txt_red">임시로 발급된 비밀번호</span>를 사용하고 계십니다.<br>
							고객님의 소중한 개인정보를 안전하게 지키기 위해 비밀번호를 변경해 주세요.<br>개인정보 도용을 최대한
							방지하기 위해 <span class="txt_red">비밀번호 변경절차</span>를 거치신 후에만 서비스 이용이
							가능합니다.
						</p>
					</div>
					<p class="desc">
						<strong>[안전한 비밀번호 설정 방법] <span class="txt_red">영문,
								숫자 조합하여 8자리 이상</span></strong>
					</p>
					<div class="box_inputForm">
						<label for="usrOldPw" class="label">현재 비밀번호</label> <span
							class="box_label">
							<button type="button" class="transkey_btn" data-id="usrOldPw"
								onclick="transkeyShow(this)">가상키패드 입력</button> <input
							type="password" name="usrOldPw" id="usrOldPw" tabindex="-1"
							placeholder="현재 비밀번호를 입력하세요" class="input"
							onkeyup="fnIcoCheck();" data-tk-kbdtype="qwerty"
							onfocus="tk.onKeyboard(this);">
						</span> <span class="ico_complete" style="display: none;">가능</span>
						<!-- 사용가능 아이콘 -->
					</div>




					<div class="box_inputForm" id="pwdDiv">
						<label for="usrNewPwd" class="label">새 비밀번호</label> <span
							class="box_label">
							<button type="button" class="transkey_btn" data-id="usrNewPwd"
								onclick="transkeyShow(this)">가상키패드 입력</button> <input
							type="password" name="usrNewPwd" id="usrNewPwd" tabindex="-1"
							placeholder="영문,숫자 8자리 이상" class="input"
							onkeyup="fnPwdLenCheck(this);" onblur="fnPwdVldtCheck(this);"
							data-tk-kbdtype="qwerty" onfocus="tk.onKeyboard(this);">
						</span> <span class="ico_complete" style="display: none;">가능</span>
						<!-- 사용가능 아이콘 -->
					</div>




					<div class="box_inputForm" id="pwdCfmDiv">
						<label for="pwdCfmCheck" class="label">새 비밀번호 확인</label> <span
							class="box_label">
							<button type="button" class="transkey_btn" data-id="pwdCfmCheck"
								onclick="transkeyShow(this)">가상키패드 입력</button> <input
							type="password" name="pwdCfmCheck" id="pwdCfmCheck" tabindex="-1"
							placeholder="새 비밀번호를 재입력하세요" class="input"
							onkeyup="fnPwdCfmCheck(this);" onblur="fnPwdCfmCheck(this);"
							data-tk-kbdtype="qwerty" onfocus="tk.onKeyboard(this);">
						</span> <span class="ico_complete" style="display: none;">가능</span>
					</div>




					<ul>
						<li>비밀번호 변경 시 고속버스 모바일앱 에서도 동일하게 적용됩니다.</li>
					</ul>
					<p class="btn_squareBox" id="oldPwdChgP" style="display: none;">
						<button type="button" class="btn_confirm" onclick="fnUpdatePwd();">변경하기</button>
						<button type="button" class="btn_normal" onclick="nextChgPwd();">180일
							뒤에 변경하기</button>
					</p>
					<p class="btn_squareBox" id="tmpPwdChgP" style="display: none;">
						<button type="button" class="btn_confirm" onclick="fnUpdatePwd();">변경하기</button>
					</p>
					<div class="pop_banner_wrap">
						<span class="txt_banner">예매부터 탑승까지 원스탑 모바일 서비스!</span> <strong
							class="tit_ban">고속버스 모바일앱</strong> <span class="bg_ban mobileApp">고속버스
							모바일앱</span>
					</div>
				</div>
				<button data-remodal-action="close" class="remodal-close"
					onclick="logoutLgn();">
					<span class="sr-only">닫기</span>
				</button>
				<input type="hidden" id="hidfrmId" name="hidfrmId"
					value="pwdModLsapForm"><input type="hidden"
					id="transkeyUuid_pwdModLsapForm" name="transkeyUuid_pwdModLsapForm"
					value="9df453f5f197a4018e245e89cfab701e6ab26138f18b947641710bec47c943dd"><input
					type="hidden" id="transkey_usrOldPw_pwdModLsapForm"
					name="transkey_usrOldPw_pwdModLsapForm" value=""><input
					type="hidden" id="transkey_HM_usrOldPw_pwdModLsapForm"
					name="transkey_HM_usrOldPw_pwdModLsapForm" value=""><input
					type="hidden" id="transkey_usrNewPwd_pwdModLsapForm"
					name="transkey_usrNewPwd_pwdModLsapForm" value=""><input
					type="hidden" id="transkey_HM_usrNewPwd_pwdModLsapForm"
					name="transkey_HM_usrNewPwd_pwdModLsapForm" value=""><input
					type="hidden" id="transkey_pwdCfmCheck_pwdModLsapForm"
					name="transkey_pwdCfmCheck_pwdModLsapForm" value=""><input
					type="hidden" id="transkey_HM_pwdCfmCheck_pwdModLsapForm"
					name="transkey_HM_pwdCfmCheck_pwdModLsapForm" value="">
			</form>
		</div>
	</div>
	<div class="remodal-wrapper plogin remodal-is-closed"
		style="display: none;">
		<div class="remodal remodal-is-initialized plogin remodal-is-closed"
			data-remodal-id="popBohun1"
			data-remodal-options="closeOnOutsideClick: false, modifier: plogin"
			role="dialog" tabindex="-1">
			<div class="nation">
				<h2 class="nation_tit">보훈정보 입력</h2>
				<form name="bohnCheckForm" id="bohnCheckForm" class="nation_wrap">
					<input type="hidden" name="express" id="express" value="">
					<input type="hidden" name="bohnDeprCd" id="bohnDeprCd" value="010">
					<!-- 출발지코드 -->
					<input type="hidden" name="bohndDeprNm" id="bohnDeprNm"
						value="서울경부">
					<!-- 출발지명 -->
					<input type="hidden" name="bohnArvlCd" id="bohnArvlCd" value="200">
					<!-- 도착지코드 -->
					<input type="hidden" name="bohnArvlNm" id="bohnArvlNm" value="강릉">
					<!-- 도착지명 -->
					<input type="hidden" name="bohnDeprDt" id="bohnDeprDt"
						value="20250621">
					<!-- 출발일 -->
					<input type="hidden" name="bohnDeprTime" id="bohnDeprTime"
						value="072000">
					<!-- 출발시각 -->


					<table class="nation_table">
						<colgroup>
							<col class="first">
							<col class="second">
						</colgroup>
						<tbody>
							<tr>
								<td class=" t_border" bgcolor="#eeeeee" scope=""
									style="width: 160px"><label for="number">보훈번호</label></td>
								<td class=" t_border" colspan="3"
									style="width: 630px; text-align: left; padding-left: 20px;">
									<input type="text" name="number" id="number" maxlength="20"
									required="" placeholder="보훈번호를 입력해주세요" size="50">
								</td>

							</tr>
							<tr>
								<td class=" t_border" bgcolor="#eeeeee" scope=""><label
									for="birth">생년월일</label></td>
								<td class=" t_border" colspan="3"
									style="text-align: left; padding-left: 20px;"><input
									type="text" name="birth" id="birth" maxlength="8" required=""
									placeholder="생년월일을 입력해주세요" size="30"> <span
									class="input_txt"> * 생년월일 8자리 (예 : 19910831)</span></td>
							</tr>
							<tr>
								<td class=" t_border" bgcolor="#eeeeee" scope=""
									style="width: 160px"><label for="hpnumber">휴대폰 번호</label></td>
								<td class=" t_border" colspan="3"
									style="text-align: left; padding-left: 20px;"><input
									type="text" name="hpnumber" id="hpnumber" maxlength="13"
									required="" placeholder="휴대폰번호를 입력하세요" size="30"
									style="width: 200px"> <span class="input_txt"> *
										휴대폰번호 11자리, 숫자만 입력 하세요 (예 : 01012345678)</span></td>
							</tr>
							<tr>
								<td class=" t_border" bgcolor="#eeeeee" scope=""><label>동반자
										여부</label></td>
								<td class=" t_border" colspan="3"
									style="text-align: left; height: 30px; padding-left: 20px;">
									<input type="radio" value="N" name="companion_check"
									required="" id="check_N"><label for="check_N"><span
										class="input_txt">동반자 미포함</span></label> <input type="radio" value="Y"
									name="companion_check" required="" id="check_Y"
									style="margin-left: 20px;"><label for="check_Y"><span
										class="input_txt">동반자 포함</span></label>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="nation_infor">
						<ul>
							<li><span style="color: #000; font-size: 12px">•</span> 보훈번호
								인증 후 유공할인 및 무임을 사용하실 수 있습니다.</li>
							<li><span style="color: #000; font-size: 12px">•</span> 동반자
								할인은 '애국지사', '1급상이(장해)자' 보훈자에 한해 제공하며, 대상 권종과 같은 할인혜택을 받으실수 있습니다.
							</li>
							<li><span style="color: #000; font-size: 12px">•</span> 승차 시
								반드시 국가유공자 확인증을 지참하여 주시기 바랍니다.(확인 요청 시 제시)</li>
						</ul>
					</div>
					<div class="Qualification">
						<p>
							<input type="checkbox" name="agree1" id="agree1" value="Y"
								required=""> <label for="agree1"><strong
								style="vertical-align: top; font-size: 14px">운임 할인을 위한
									국가유공자 자격정보 수집/활용 동의(필수)</strong></label>
						</p>
					</div>
					<table class="nation_table agree">
						<tbody>
							<tr>
								<td bgcolor="#eeeeee" class=" t_border" colspan="2" scope="col"
									width="20%" style="font-weight: bold">수집항목</td>
								<td bgcolor="#eeeeee" class=" t_border" colspan="2" scope="col"
									width="20%" style="font-weight: bold">제공목적</td>
								<td bgcolor="#eeeeee" class=" t_border" colspan="2" scope="col"
									width="20%" style="font-weight: bold">이용기간</td>
							</tr>
							<tr>
								<td class=" t_border" colspan="2">생년월일, 보훈번호</td>
								<td class=" t_border" colspan="2">운임할인 적용(할인율 적용)</td>
								<td class=" t_border" colspan="2">목적 달성 후 즉시 파기</td>
							</tr>
						</tbody>
					</table>
					<div class="Qualification Qualification2">
						<p>
							<input type="checkbox" name="agree2" id="agree2" value="Y"
								required=""> <label for="agree2"><strong
								style="vertical-align: top; font-size: 14px">자격정보 제3자
									제공 동의(필수)</strong></label>
						</p>
					</div>
					<table class="nation_table agree">
						<tbody>
							<tr>
								<td bgcolor="#eeeeee" class=" t_border" colspan="2" scope="col"
									width="12%" style="font-weight: bold">제공항목</td>
								<td bgcolor="#eeeeee" class=" t_border" colspan="2" scope="col"
									width="12%" style="font-weight: bold">제공받는자</td>
								<td bgcolor="#eeeeee" class=" t_border" colspan="2" scope="col"
									width="18%" style="font-weight: bold">제공목적</td>
								<td bgcolor="#eeeeee" class=" t_border" colspan="2" scope="col"
									width="15%" style="font-weight: bold">이용기간</td>
							</tr>
							<tr>
								<td class=" t_border" colspan="2">생년월일, 보훈번호</td>
								<td class=" t_border" colspan="2">국가보훈처</td>
								<td class=" t_border" colspan="2">운임할인 적용(할인율 적용)</td>
								<td class=" t_border" colspan="2">목적 달성 후 즉시 파기</td>
							</tr>
						</tbody>
					</table>

					<p class="submit">
						<button class="cancel" value="취소" name="cancel"
							onclick="fnBohnCan()">취소</button>
						<button type="button" value="확인" name="submit"
							onclick="fnBohnOk()">확인</button>
					</p>
				</form>
				<div class="close" onclick="fnBohnCan()">
					<span class="close1"></span> <span class="close2"></span>
				</div>
			</div>
		</div>
	</div>
	<div class="remodal-wrapper plogin remodal-is-closed"
		style="display: none;">
		<div class="remodal remodal-is-initialized plogin remodal-is-closed"
			data-remodal-id="popNhis1"
			data-remodal-options="closeOnOutsideClick: false, modifier: plogin"
			role="dialog" tabindex="-1">
			<div class="nation">
				<h2 class="nation_tit">사원 정보 입력</h2>
				<form name="nhisCheckForm" id="nhisCheckForm" class="nation_wrap">

					<table class="nation_table">
						<colgroup>
							<col class="first">
							<col class="second">
						</colgroup>
						<tbody>
							<tr>
								<td class=" t_border" bgcolor="#eeeeee" scope=""
									style="width: 160px"><label for="nhis_number">사원번호</label></td>
								<td class=" t_border" colspan="3"
									style="width: 630px; text-align: left; padding-left: 20px;">
									<input type="text" name="number" id="nhis_number" maxlength="6"
									required="" placeholder="6자리로 입력해주세요 (예 : 123456)" size="50"
									style="width: 300px">
								</td>

							</tr>
							<tr>
								<td class=" t_border" bgcolor="#eeeeee" scope=""
									style="width: 160px"><label for="nhis_hpnumber">휴대폰
										번호</label></td>
								<td class=" t_border" colspan="3"
									style="width: 630px; text-align: left; padding-left: 20px;">
									<input type="text" name="hpnumber" id="nhis_hpnumber"
									maxlength="13" required="" placeholder="휴대폰번호를 입력하세요" size="30"
									style="width: 200px">
								</td>
							</tr>
						</tbody>
					</table>
					<div class="nation_infor">
						<ul>
							<li><span style="color: #000; font-size: 12px">•</span> 건보공단
								할인을 받기 위해서는 사원 번호 인증이 필요합니다.</li>
							<li><span style="color: #000; font-size: 12px">•</span> 승차 시
								반드시 사원증을 지참하여 주시기 바랍니다.(확인 요청 시 제시)</li>
						</ul>
					</div>
					<div class="Qualification">
						<p>
							<input type="checkbox" name="nhis_agree1" id="nhis_agree1"
								value="Y" required=""> <label for="nhis_agree1"><strong
								style="vertical-align: top; font-size: 14px">운임 할인을 위한
									건강보험공단 사원정보 수집/활용 동의(필수)</strong></label>
						</p>
					</div>
					<table class="nation_table agree">
						<tbody>
							<tr>
								<td bgcolor="#eeeeee" class=" t_border" colspan="2" scope="col"
									width="20%" style="font-weight: bold">수집항목</td>
								<td bgcolor="#eeeeee" class=" t_border" colspan="2" scope="col"
									width="20%" style="font-weight: bold">제공목적</td>
								<td bgcolor="#eeeeee" class=" t_border" colspan="2" scope="col"
									width="20%" style="font-weight: bold">이용기간</td>
							</tr>
							<tr>
								<td class=" t_border" colspan="2">사원번호, 휴대폰 번호</td>
								<td class=" t_border" colspan="2">운임할인 적용(할인율 적용)</td>
								<td class=" t_border" colspan="2">목적 달성 후 즉시 파기</td>
							</tr>
						</tbody>
					</table>
					<div class="Qualification Qualification2">
						<p>
							<input type="checkbox" name="nhis_agree2" id="nhis_agree2"
								value="Y" required=""> <label for="nhis_agree2"><strong
								style="vertical-align: top; font-size: 14px">사원정보 제3자
									제공 동의(필수)</strong></label>
						</p>
					</div>
					<table class="nation_table agree">
						<tbody>
							<tr>
								<td bgcolor="#eeeeee" class=" t_border" colspan="2" scope="col"
									width="12%" style="font-weight: bold">제공항목</td>
								<td bgcolor="#eeeeee" class=" t_border" colspan="2" scope="col"
									width="12%" style="font-weight: bold">제공받는자</td>
								<td bgcolor="#eeeeee" class=" t_border" colspan="2" scope="col"
									width="18%" style="font-weight: bold">제공목적</td>
								<td bgcolor="#eeeeee" class=" t_border" colspan="2" scope="col"
									width="15%" style="font-weight: bold">이용기간</td>
							</tr>
							<tr>
								<td class=" t_border" colspan="2">사원번호, 휴대폰 번호</td>
								<td class=" t_border" colspan="2">건강보험공단</td>
								<td class=" t_border" colspan="2">운임할인 적용(할인율 적용)</td>
								<td class=" t_border" colspan="2">목적 달성 후 즉시 파기</td>
							</tr>
						</tbody>
					</table>

					<p class="submit">
						<button class="cancel" value="취소" name="cancel"
							onclick="fnNhisCan()">취소</button>
						<button type="button" value="확인" name="submit"
							onclick="fnNhisOk()">확인</button>
					</p>
				</form>

				<div class="close" onclick="fnNhisCan()">
					<span class="close1"></span> <span class="close2"></span>
				</div>
			</div>
		</div>
	</div>

</body>
</html>