<%@ page trimDirectiveWhitespaces="true" language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 뒤로가기 눌렀을때 로그인 풀리는거 방지 : 캐시 무효화 코드, 모든 jsp파일에 추가해야함 -->
<%
	String auth = (String) session.getAttribute("auth");
%>
<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma","no-cache"); // HTTP 1.0
    response.setDateHeader ("Expires", 0); // Proxies
%>

<!DOCTYPE html>
<!-- saved from url=(0031)/main.do -->
<html lang="ko" class="pc">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">

<title>고속버스통합예매</title>

<link rel="shortcut icon"
	href="/images/favicon.ico">
<link rel="stylesheet" type="text/css"
	href="/koBus/css/common/ui.jqgrid.custom.css">
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script>
	$( function() {
		$( ".main-input-box main_box" ).tabs();

		// datepicker 날짜가 선택되었을 때 자동 검사
		$("#datepicker1, #datepicker2").on("change", function () {
			validateDates();
		});

		function formatDate(date) {
		var year = date.getFullYear();
		var month = ('0' + (date.getMonth() + 1)).slice(-2);
		var day = ('0' + date.getDate()).slice(-2);
		return year + '-' + month + '-' + day;
		}

		var today = new Date();
		var tomorrow = new Date();
		tomorrow.setDate(today.getDate() + 1); // 오늘 기준 +1일

		var formattedDate = formatDate(today);
		var formattedTomorrow = formatDate(tomorrow);

		$("#datepicker1").val(formattedDate);
		$("#datepicker2").val(formattedTomorrow);


		$("#datepicker1").datepicker({
			dateFormat: "yy-mm-dd",
			changeMonth: true,
			changeYear: true,
			showOn: "focus"
		});

		$("#datepicker2").datepicker({
			dateFormat: "yy-mm-dd",
			changeMonth: true,
			changeYear: true,
			showOn: "focus"
		});

		$("#startdate_btn").click(function() {
			$("#datepicker1").datepicker("show");
		});

		$("#enddate_btn").click(function() {
			$("#datepicker2").datepicker("show");
		});


	} );
	</script>


</script>
<script type="text/javascript" src="/koBus/js/common/ui.js"></script>
<script type="text/javascript" src="/koBus/js/common/plugin.js"></script>
<script type="text/javascript" src="/koBus/js/common/common.js"></script>

<script type="text/javascript" src="/koBus/js/common/jquery.number.js"></script>
<script type="text/javascript" src="/koBus/js/common/security.js"></script>


<link rel="stylesheet" type="text/css" href="/koBus/css/common/style.css">
<script type="text/javascript" src="/koBus/js/common/new-kor-ui.js"></script>
</head>



<!-- [리뉴얼] 페이지 개별 스크립트 신규 정의함 -->


<body class="main KO" style="">
	<!-- [리뉴얼] 스킵 네비게이션 신규 정의 -->
	<div class="pop_dimmed" style="display: none;"></div>
	<div class="noti_pop_wrap" style="display: block;">


		<!-- <div class="noti_pop type1" id="mainPopKO0" style="z-index: 950; left: 0px; top: 0px; display: none;">
				<div class="pop_top">
					<p class="pop_tit">취소수수료 변경 안내</p>
				</div>
				<div class="scroll-wrapper pop_cont_wrap scrollbar-inner" style="position: relative; max-height: 1413.67px;"><div class="pop_cont_wrap scrollbar-inner scroll-content" style="height: auto; margin-bottom: 0px; margin-right: 0px; max-height: 1413.67px;">
					<div class="pop_cont" style="overflow: auto; -webkit-overflow-scrolling: touch;"> -->
		<!-- <form action="/readMainPup.do" id="popForm0" name="popForm0" target="popIfr0">
							<input type="hidden" id="pupNo0" name="pupNo" value="20250417001"> 
						</form> -->
		<!-- <iframe name="popIfr0" frameborder="0" scrolling="no" width="100%" height="200" onload="resize(this);" title="" src="/koBus/images/saved_resource.html"></iframe> -->
		<!-- 취소수수료 변경 안내 -->
		<!-- <a name="popIfr" frameborder="0" scrolling="no" width="100%" height="200" onload="resize(this);" title="공지 링크" href="/koBus/images/saved_resource.html" target="_blank">취소수수료 변경 안내</a>
					</div>
				</div>
				<div class="scroll-element scroll-x"><div class="scroll-element_outer">
					<div class="scroll-element_size"></div><div class="scroll-element_track"></div>
					<div class="scroll-bar" style="width: 100px;"></div>
				</div>
			</div>
			<div class="scroll-element scroll-y">
				<div class="scroll-element_outer">
					<div class="scroll-element_size"></div>
					<div class="scroll-element_track"></div>
					<div class="scroll-bar" style="height: 100px;"></div>
				</div>
			</div>
		</div> -->
		<!-- 설문조사 팝업은 오늘하루보지않기 없애기예외처리 -->
		<!-- 				
				<div class="btns today-hidden-type">
					<div class="today-hidden-wrap">
						<input type="checkbox" id="chk_mainPopKO0" class="btn-today-hidden">
						<label for="chk_mainPopKO0">오늘 하루 보지 않기</label>
					</div>
					
					 
					  -->
		<!-- <button type="button" class="btnM btn_close one">오`늘 하루 보지 않기</button> 오늘하루 보지않기 버튼만 있을경우 class="one" -->
		<!-- </div>
				
				<a href="javascript:void(0)" class="pop_close" data-id="mainPopKO0"><span class="sr-only">닫기</span></a>
			</div>
		 -->


		<!-- <div class="noti_pop type2" id="mainPopKO1" style="z-index: 940; left: 320px; top: 0px; display: none;">
				<div class="pop_top">
					<p class="pop_tit">와이파이 서비스 안내</p>
				</div>
				<div class="scroll-wrapper pop_cont_wrap scrollbar-inner" style="position: relative; max-height: 1413.67px;"><div class="pop_cont_wrap scrollbar-inner scroll-content" style="height: auto; margin-bottom: 0px; margin-right: 0px; max-height: 1413.67px;">
					<div class="pop_cont" style="overflow: auto; -webkit-overflow-scrolling: touch;">
						<form action="/readMainPup.do" id="popForm1" name="popForm1" target="popIfr1">
							<input type="hidden" id="pupNo1" name="pupNo" value="20250327001"> 
						</form> -->
		<!-- <iframe name="popIfr1" frameborder="0" scrolling="no" width="100%" height="463" onload="resize(this);" title="와이파이 서비스 안내" src="/koBus/images/saved_resource(1).html"></iframe> -->
		<!-- </div>
				</div>
				<div class="scroll-element scroll-x">
					<div class="scroll-element_outer">
						<div class="scroll-element_size"></div>
						<div class="scroll-element_track"></div>
						<div class="scroll-bar" style="width: 100px;"></div>
					</div>
				</div>
				
				<div class="scroll-element scroll-y">
					<div class="scroll-element_outer">
						<div class="scroll-element_size"></div>
						<div class="scroll-element_track"></div>
						<div class="scroll-bar" style="height: 100px;"></div>
					</div>
				</div> -->
		<!-- 설문조사 팝업은 오늘하루보지않기 없애기예외처리 -->
		<!-- 				
				<div class="btns today-hidden-type">
					<div class="today-hidden-wrap">
						<input type="checkbox" id="chk_mainPopKO1" class="btn-today-hidden">
						<label for="chk_mainPopKO1">오늘 하루 보지 않기</label>
					</div>
					
					 
					  -->
		<!-- <button type="button" class="btnM btn_close one">오`늘 하루 보지 않기</button> 오늘하루 보지않기 버튼만 있을경우 class="one" -->
		<!-- </div>
				
				<a href="javascript:void(0)" class="pop_close" data-id="mainPopKO1"><span class="sr-only">닫기</span></a>
			</div>
		 -->


		<!-- <div class="noti_pop type3" id="mainPopKO2" style="z-index: 930; left: 640px; top: 0px; display: none;">
				<div class="pop_top">
					<p class="pop_tit">고속버스 승차홈 변경 안내</p>
				</div>
				<div class="scroll-wrapper pop_cont_wrap scrollbar-inner" style="position: relative; max-height: 1413.67px;"><div class="pop_cont_wrap scrollbar-inner scroll-content" style="height: auto; margin-bottom: 0px; margin-right: 0px; max-height: 1413.67px;">
					<div class="pop_cont" style="overflow: auto; -webkit-overflow-scrolling: touch;">
						<form action="/readMainPup.do" id="popForm2" name="popForm2" target="popIfr2">
							<input type="hidden" id="pupNo2" name="pupNo" value="20250304001"> 
						</form> -->
		<!-- <iframe name="popIfr2" frameborder="0" scrolling="no" width="100%" height="566" onload="resize(this);" title="고속버스 승차홈 변경 안내" src="/koBus/images/saved_resource(2).html"></iframe> -->
		<!-- </div>
				</div><div class="scroll-element scroll-x"><div class="scroll-element_outer"><div class="scroll-element_size"></div><div class="scroll-element_track"></div><div class="scroll-bar" style="width: 100px;"></div></div></div><div class="scroll-element scroll-y"><div class="scroll-element_outer"><div class="scroll-element_size"></div><div class="scroll-element_track"></div><div class="scroll-bar" style="height: 100px;"></div></div></div></div>
				 -->
		<!-- 설문조사 팝업은 오늘하루보지않기 없애기예외처리 -->

		<!-- <div class="btns today-hidden-type">
					<div class="today-hidden-wrap">
						<input type="checkbox" id="chk_mainPopKO2" class="btn-today-hidden">
						<label for="chk_mainPopKO2">오늘 하루 보지 않기</label>
					</div>
					
					 
					  -->
		<!-- <button type="button" class="btnM btn_close one">오`늘 하루 보지 않기</button> 오늘하루 보지않기 버튼만 있을경우 class="one" -->
		<!-- </div>
				
				<a href="javascript:void(0)" class="pop_close" data-id="mainPopKO2"><span class="sr-only">닫기</span></a>
			</div>
		
	 -->




		<!-- <div class="noti_pop type4" id="mainPopKO3" style="z-index: 920; left: 960px; top: 0px; display: none;">
				<div class="pop_top">
					<p class="pop_tit">정시출발 안내</p>
				</div>
				<div class="scroll-wrapper pop_cont_wrap scrollbar-inner" style="position: relative; max-height: 1413.67px;"><div class="pop_cont_wrap scrollbar-inner scroll-content" style="height: auto; margin-bottom: 0px; margin-right: 0px; max-height: 1413.67px;">
					<div class="pop_cont" style="overflow: auto; -webkit-overflow-scrolling: touch;">
						<form action="/readMainPup.do" id="popForm3" name="popForm3" target="popIfr3">
							<input type="hidden" id="pupNo3" name="pupNo" value="20170630003"> 
						</form> -->
		<!-- <iframe name="popIfr3" frameborder="0" scrolling="no" width="100%" height="248" onload="resize(this);" title="정시출발 안내" src="/koBus/images/saved_resource(3).html"></iframe> -->
		<!-- </div>
				</div><div class="scroll-element scroll-x"><div class="scroll-element_outer"><div class="scroll-element_size"></div><div class="scroll-element_track"></div><div class="scroll-bar" style="width: 100px;"></div></div></div><div class="scroll-element scroll-y"><div class="scroll-element_outer"><div class="scroll-element_size"></div><div class="scroll-element_track"></div><div class="scroll-bar" style="height: 100px;"></div></div></div></div>
				 -->
		<!-- 설문조사 팝업은 오늘하루보지않기 없애기예외처리 -->

		<!-- <div class="btns today-hidden-type">
					<div class="today-hidden-wrap">
						<input type="checkbox" id="chk_mainPopKO3" class="btn-today-hidden">
						<label for="chk_mainPopKO3">오늘 하루 보지 않기</label>
					</div>
					
					  -->

		<!-- <button type="button" class="btnM btn_close one">오`늘 하루 보지 않기</button> 오늘하루 보지않기 버튼만 있을경우 class="one" -->
		<!-- </div>
				
				<a href="javascript:void(0)" class="pop_close" data-id="mainPopKO3"><span class="sr-only">닫기</span></a>
			</div> -->


	</div>
	<nav id="skip">
		<ul>
			<li><a href="#new-kor-content">본문 바로가기</a></li>
			<li><a href="#new-kor-gnb">주메뉴 바로가기</a></li>
			<li><a href="#new-kor-footer">푸터 바로가기</a></li>
		</ul>
	</nav>

	<!-- 메인 클래스 : wrapper-main -->
	<div class="wrapper wrapper-kor wrapper-main full">


		<!-- header -->




		<script>
$(document).ready(function () {
	var langCd = 'KO';
	var langLi = $(".dropdown-wrap.lang-select .dropdown-list li");
	
	$('.title_wrap').hide();
});
</script>

		<!-- 헤더 -->
		<header id="new-kor-header">
			<div class="top-menu-area">
				<div class="container">
					<h1 id="logo">
						<a href="javascript:void(0);"> <img
							src="/koBus/images/logo.png" alt="KOBUS 전국고속버스운송사업조합">
						</a>
					</h1>
					<nav class="util-menus">
						<ul class="util-list">

							<c:choose>
								<c:when test="${empty auth}">
									<li><a class="login" href="/koBus/koBusFile/logonMain.jsp">로그인</a></li>
									<li><a href="/koBus/koBusFile/joinMain.jsp">회원가입</a></li>
								</c:when>
								<c:otherwise>
									<li>${auth} | </li> 
									<li><a class="logout" href="/koBus/logOut.do">로그아웃</a></li>
								</c:otherwise>
							</c:choose>
							<li><a
								href="/koBus/koBusFile/logonMyPage.jsp">마이페이지</a></li>
							<li><a
								href="javascript:void(0);">결제내역조회</a></li>
							<li><a href="javascript:void(0);">사이트맵</a></li>
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
							<li><a href="/koBus/kobus_seat.do">고속버스예매</a>
								<ul>
									<li><a href="javascript:void(0);">고속버스
											예매</a></li>
									<li><a href="javascript:void(0);">예매확인/취소/변경</a>
									</li>
									<li><a href="javascript:void(0);">영수증발행</a>
									</li>
								</ul></li>
							<li><a href="javascript:void(0)">운행정보</a>
								<ul>
									<li><a
										href="javascript:void(0);">시간표
											조회</a></li>
									<li><a
										href="javascript:void(0);">도착시간
											안내</a></li>
								</ul></li>


							<li><a href="javascript:void(0)">프리패스/정기권</a>
								<ul>
									<li><a
										href="javascript:void(0);">프리패스
											여행권</a></li>
									<li><a
										href="javascript:void(0);">정기권</a></li>
									<li><a
										href="javascript:void(0);">상품
											구매내역</a></li>
								</ul></li>


							<li><a href="javascript:void(0)">이용안내</a>
								<ul>
									<li><a href="javascript:void(0);">예매
											안내</a></li>
									<li><a
										href="javascript:void(0);">결제수단
											안내</a></li>
									<li><a href="javascript:void(0);">승차권
											환불안내</a></li>
									<li><a href="javascript:void(0);">프리미엄
											마일리지</a></li>

									<li><a href="/ugd/trtrgd/Trtrgd.do">휴게소
											환승안내</a></li>
									<li><a href="/ugd/trmlgd/Trmlgd.do">고속버스
											터미널</a></li>
									<li><a href="/ugd/cacmgd/Cacmgd.do">고속버스
											운송회사</a></li>
								</ul></li>
							<li><a href="javascript:void(0)">고객지원</a>
								<ul>
									<li><a
										href="/cscn/ntcmttr/readNtcList.do">공지사항</a></li>
									<li><a
										href="/cscn/qna/readQnaList.do">자주찾는
											질문</a></li>
									<li><a
										href="/cscn/lossClnc/readLossClncList.do">유실물센터
											안내</a></li>
								</ul></li>
						</ul>
					</div>
					<div class="links">
						<!-- <a href="https://www.tmoney.co.kr" class="btn btn-tmoney" title="새창" target="_blank">
					<img src="/images/kor/layout/ico-tmoney-app.png" alt="" />고속버스 티머니
					<i class="ico ico-arrow-new-window"></i>
				</a> -->

						<a href="/cscn/jobmttr/readJobList.do"
							class="btn btn-job" title="새창" target="_blank"> <img
							src="/koBus/images/ico-job-offer.png" alt="">승무사원 모집 <i
							class="ico ico-arrow-new-window"></i>
						</a>
					</div>
					<div class="bg-layer">
						<a
							href="https://safeconnect.co.kr/sfconn/login/csc_pc?et=psn249R01&amp;ptrSvcSn=psn249"
							title="새창" class="gnb-baaner"> <img
							src="/koBus/images/003-GNB.png" alt="ID 찾을 필요 없이, 전화번호 로그인!">
							<!-- <iframe src="/koBus/images/_ad-tubebox-002GNB.html" title="프레임 (전화번호안심 로그인)" class="ad-frame"></iframe> -->
						</a>
					</div>
				</div>
			</nav>
		</header>

		<script type="text/javascript" src="/koBus/js/MainNew.js"></script>
		<script type="text/javascript" src="/koBus/js/Main.js"></script>
		<script type="text/javascript" src="/koBus/js/left.js"></script>

		<script type="text/javascript" src="/koBus/js/common/RotInfPup.js"></script>
		<script type="text/javascript" src="/koBus/js/common/RotInf.js"></script>
		<script type="text/javascript" src="/koBus/js/MrsCfmLgn.js"></script>

		<!-- 20200617 yahan -->
		<!-- <script type="text/javascript" src="/koBus/js/transkey.js"></script>
<script type="text/javascript" src="/koBus/js/TranskeyLibPack_op.js"></script> -->
		<script type="text/javascript" src="/koBus/js/rsa_oaep-min.js"></script>
		<script type="text/javascript" src="/koBus/js/jsbn-min2.js"></script>
		<script type="text/javascript" src="/koBus/js/typedarray.js"></script>
		<!-- <script type="text/javascript" src="/koBus/js/transkeyServlet"></script>
<script type="text/javascript" src="/koBus/js/transkeyServlet(1)"></script>
<link rel="stylesheet" type="text/css" href="/koBus/js/transkey.css">  -->
		<script>
//	$(function(){ initTranskey('lgnFrm'); })
// 	function setTranskey(obj, formId){
// 		if(!$("#lgnTab").hasClass("on")){
// 			return;
// 		}
// 		if ($('#hidfrmId').val() != formId){
// 			initTranskey(formId);
// 		}
		
// 		if ($(obj).attr('id') == 'card_number03' || $(obj).attr('id') == 'card_number04'){
// 			if ($('#card_number01').val().length != 4 || $('#card_number02').val().length != 4){
// 				$('#card_number01').focus();
// 				alert('카드번호를 순서대로 입력해 주세요.');
// 				return;
// 			} 
// 		}
// 		setTimeout(function(){
// 			tk.onKeyboard(obj);
// 		}, 100);
// 	}
// </script>

		<!-- 출/도착지 선택 레이어팝업 -->


		<form name="rotInfFrm" id="rotInfFrm" method="post"
			action="/mrs/alcnSrch.do">
			<input type="hidden" name="deprCd" id="deprCd" value="">
			<!-- 출발지코드 -->
			<input type="hidden" name="deprNm" id="deprNm" value="">
			<!-- 출발지명 -->
			<input type="hidden" name="arvlCd" id="arvlCd" value="">
			<!-- 도착지코드 -->
			<input type="hidden" name="arvlNm" id="arvlNm" value="">
			<!-- 도착지명 -->
			<input type="hidden" name="tfrCd" id="tfrCd" value="">
			<!-- 환승지코드 -->
			<input type="hidden" name="tfrNm" id="tfrNm" value="">
			<!-- 환승지명 -->
			<input type="hidden" name="tfrArvlFullNm" id="tfrArvlFullNm" value="">
			<!-- 환승지포함 도착지 명 -->
			<input type="hidden" name="pathDvs" id="pathDvs" value="sngl">
			<!-- 직통sngl,환승trtr,왕복rtrp -->
			<input type="hidden" name="pathStep" id="pathStep" value="1">
			<!-- 왕복,환승 가는편순번 -->
			<input type="hidden" name="crchDeprArvlYn" id="crchDeprArvlYn"
				value="N">
			<!-- 출도착지 스왑여부 -->
			<input type="hidden" name="deprDtm" id="deprDtm" value="20250607">
			<!-- 가는날(편도,왕복) -->
			<input type="hidden" name="deprDtmAll" id="deprDtmAll"
				value="2025. 6. 7. 토">
			<!-- 가는날(편도,왕복) -->
			<input type="hidden" name="arvlDtm" id="arvlDtm" value="20250607">
			<!-- 오는날(왕복) -->
			<input type="hidden" name="arvlDtmAll" id="arvlDtmAll"
				value="2025. 6. 7. 토">
			<!-- 오는날(왕복) -->
			<input type="hidden" name="busClsCd" id="busClsCd" value="0">
			<!-- 버스등급 -->
			<input type="hidden" name="abnrData" id="abnrData" value="">
			<!-- 결과값여부 -->
			<input type="hidden" name="prmmDcYn" id="prmmDcYn" value="N">
			<!-- 시외우등할인대상노선 -->
		</form>
		<input type="hidden" name="mainYn" id="mainYn" value="Y">
		<!-- // 170110 수정 -->
		<div class="loading" id="loading"
			style="height: 1206px; top: 75px; display: none;">
			<p class="load" style="margin-left: -53px;"></p>
		</div>



		<article id="new-kor-content">
			<!-- 본문 영역 -->
			<h2 class="sr-only">메인 본문</h2>

			<!-- PC/Tablet -->
			<div class="d-up-md">
				<div class="keyvisual-area">
					<div class="container">
						<p class="slogan">즐거운 여행의 시작과 끝, 프리미엄 버스와 함께!</p>
						<div class="main-input-box main_box">
							<h3 class="sr-only">고속버스 예매 및 예매 확인</h3>
							<ul class="tab-menu-list">
								<li class="on"><a href="#tab-content1" title="선택됨"><span
										class="text">고속버스예매</span></a></li>
								<li id="lgnTab"><a href="#tab-content2"><span
										class="text">예매확인</span></a></li>
							</ul>
							<div class="tab-content">
								<div id="tab-content1" style="display: block;">
									<!-- as-is 마크업 구조 그대로 사용함 -->
									<div class="main_box">
										<div class="main_cont" style="display: block;">
											<div class="route_box">
												<div class="tab_wrap tab_type1" id="rtrpYnAll">
													<ul class="tabs col2">
														<li class="oneway active" id="snglRotAll"><a
															href="javascript:void(0)"
															onclick="fnPathDvsChk('snglRot');" title="선택됨">편도</a>
															<p class="radio_area">
																<span class="custom_radio"
																	onclick="fnPathDvsChk('sngl')"> <input
																	type="radio" id="r1" name="route" checked="checked">
																	<label for="r1">직통</label>
																</span> <span class="custom_radio"
																	onclick="fnPathDvsChk('trtr')"> <input
																	type="radio" id="r2" name="route"> <label
																	for="r2">환승</label>
																</span>
															</p></li>
														<li class="roundtrip" id="rtrpRotAll"><a
															href="javascript:void(0)" onclick="fnPathDvsChk('rtrp')">왕복</a>
														</li>
													</ul>
													<div class="tab_cont">
														<ul class="place">
															<li><a href="javascript:void(0)"
																id="readDeprInfoList"
																onclick="fnReadDeprInfoList(event);"> <span
																	class="name">출발지</span>
																	<p class="text empty">
																		<span class="empty_txt">선택</span><span class="val_txt"
																			id="deprNmSpn"></span>
																	</p> <!-- 값이 있을경우 'empty' class가 없음 -->
															</a>id="datepicker <!-- [2024 마크업 수정] -->
																<button type="button" class="btn_change"
																	onclick="fnCrchDeprArvl();" id="chgDeprArvl"
																	style="display: block;">
																	<span class="sr-only">출발지, 도착지 교체</span>
																</button> <!-- // [2024 마크업 수정] --></li>
															<li><a href="javascript:void(0)"
																id="readArvlInfoList"
																onclick="fnReadArvlInfoList(event);"> <span
																	class="name">도착지</span>
																	<p class="text empty">
																		<span class="empty_txt">선택</span><span class="val_txt"
																			id="arvlNmSpn"></span>
																	</p> <!-- 값이 없을경우 'empty' class가 있음 -->
															</a></li>
														</ul>
														<ul class="date">
															<li>
																<div class="date_picker_wrap">
																	<span class="name">가는날</span> <input type="text"
																		id="datepicker1" tabindex="-1" title="가는날"
																		readonly="true">
																	<button type="button" class="datepicker-btn"
																		id="startdate_btn">
																		<img class="ui-datepicker-trigger"
																			src="/koBus/images/ico_calender.png" alt="가는날 선택 달력">
																	</button>
																	<!-- <label for="datepicker1" class="text_date text_date1">2025. 6. 7. 토</label> -->
																	<span class="date_wrap"> <a
																		href="javascript:void(0)" id="deprThddChc"
																		class="active"
																		onclick="fnYyDtmStup(0,'text_date1','0');" title="선택됨">오늘</a>
																		<a href="javascript:void(0)" id="deprNxdChc"
																		onclick="fnYyDtmStup(1,'text_date1','0');">내일</a>
																	</span>
																</div>
															</li>
															<li class="return">
																<div class="date_picker_wrap">
																	<span class="name">오는날</span>
																	<!-- [2024 마크업 수정] -->
																	<input type="text" id="datepicker2" tabindex="-1"
																		title="오는날" readonly="">
																	<button type="button" class="datepicker-btn"
																		id="enddate_btn">
																		<img class="ui-datepicker-trigger"
																			src="/koBus/images/ico_calender.png" alt="오는날 선택 달력">
																	</button>
																	<span class="date_wrap"> <a
																		href="javascript:void(0)" id="arvlThddChc"
																		class="active"
																		onclick="fnYyDtmStup(0,'text_date2','0');" title="선택됨">오늘</a>
																		<a href="javascript:void(0)" id="arvlNxdChc"
																		onclick="fnYyDtmStup(1,'text_date2','0');">내일</a>
																	</span>
																</div>
															</li>
														</ul>
														<div class="grade">
															<span class="name">등급</span>
															<p>
																<span class="custom_radio gradeAll"
																	style="margin-left: 11.3333px;"> <input
																	type="radio" id="busClsCd0" name="busClsCdR"
																	onclick="fnBusClsCd(this)" value="0" checked="checked">
																	<label for="busClsCd0">전체</label>
																</span> <span class="custom_radio grade1"
																	style="margin-left: 11.3333px;"> <input
																	type="radio" id="busClsCd7" name="busClsCdR"
																	onclick="fnBusClsCd(this)" value="7"> <label
																	for="busClsCd7">프리미엄</label>
																</span> <span class="custom_radio grade2"
																	style="margin-left: 11.3333px;"> <input
																	type="radio" id="busClsCd1" name="busClsCdR"
																	onclick="fnBusClsCd(this)" value="1"> <label
																	for="busClsCd1">우등</label>
																</span> <span class="custom_radio grade3"
																	style="margin-left: 11.3333px;"> <input
																	type="radio" id="busClsCd5" name="busClsCdR"
																	onclick="fnBusClsCd(this)" value="2"> <label
																	for="busClsCd5">일반</label>
																</span>
															</p>
														</div>
														<p class="check" id="alcnSrchBtn">
															<button type="button"
																class="btn_confirm ready btn_pop_focus"
																onclick="fnAlcnSrchBef();">조회하기</button>
														</p>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- // as-is 마크업 구조 그대로 사용함 -->
								</div>
								<div id="tab-content2" style="display: none;">

									<!-- 로그인 -->

									<div class="main_box">
										<div class="ticket_login custom_input clfix">
											<form id="lgnFrm" name="lgnFrm">
												<input type="hidden" id="returnUrl" name="returnUrl"
													value="/mrs/mrscfm.do?vltlCnt=Y"> <input
													type="hidden" id="popUpDvs" name="popUpDvs" value="N">
												<div class="member">
													<div class="login_title clfix tooltip_wrap">
														<h3>회원 로그인</h3>
														<p class="guide-text">고속버스모바일APP의 회원 아이디와 비밀번호로 이용이
															가능합니다.</p>
													</div>
													<div class="box_inputForm">
														<label for="usrId" class="label">아이디</label> <span
															class="box_label"> <input type="text" name="usrId"
															id="usrId" placeholder="아이디를 입력하세요" class="input">
														</span>
													</div>
													<div class="box_inputForm">
														<label for="usrPwd" class="label">비밀번호</label> <span
															class="box_label">
															<button type="button" class="transkey_btn"
																data-id="usrPwd" onclick="transkeyShow(this)">가상키패드
																입력</button> <input type="password" name="usrPwd"
															placeholder="비밀번호를 입력하세요" id="usrPwd" tabindex="-1"
															class="input" onkeydown="fnUsrSubmit();"
															data-tk-kbdtype="qwerty"
															onfocus="setTranskey(this, 'lgnFrm');">
														</span>
													</div>


													<button type="button" class="btnL btn_confirm ready"
														id="usrLgnBtn" onclick="fnlogin();">로그인</button>
													<!-- [2024 마크업 수정] -->
													<ul class="login_menu">
														<li><a
															href="/mbrs/lgn/lgnSearchId.do">아이디
																찾기</a></li>
														<li><a
															href="/mbrs/lgn/lgnSearchPwd.do">비밀번호찾기</a></li>
														<li><a
															href="/mbrs/mbrsjoin/mbrsJoin.do">회원가입</a></li>
													</ul>
													<!-- // [2024 마크업 수정] -->
												</div>
											</form>
											<form id="lgnNonUsrFrm" name="lgnNonUsrFrm">
												<div class="no_member">
													<div class="login_title clfix tooltip_wrap">
														<h3>비회원 예매확인</h3>
														<p class="guide-text">예매 시 입력하신 정보를 정확하게 입력해주세요.</p>
														<p></p>
													</div>
													<div class="box_bg_input">
														<!-- [2024 마크업 수정] -->
														<ul class="input_tab clearfix">
															<li class="on"><a href="javascript:void(0)"
																title="선택됨">휴대폰 번호로 찾기</a></li>
															<li class="find_card_num"><a
																href="javascript:void(0)">카드번호로 찾기</a></li>
														</ul>
														<!-- // [2024 마크업 수정] -->
														<div class="phone">
															<div class="send">
																<div class="box_inputForm_nonmember">
																	<label for="nonMbrsHp" class="label">휴대폰 번호</label> <span
																		class="box_label"> <input type="text"
																		name="nonMbrsHp" placeholder="휴대폰 번호를 입력하세요"
																		id="nonMbrsHp" class="input" maxlength="11"
																		onkeyup="fnNumCheck(this);">
																	</span>
																</div>
																<button type="button"
																	class="input_btn_nonmember send_btn">
																	인증번호<br>발송
																</button>
															</div>
															<div class="resend">
																<div class="box_inputForm_nonmember resend">
																	<strong class="send_txt">인증번호가 발송 완료되었습니다.</strong>
																</div>
																<button type="button"
																	class="input_btn_nonmember resend_btn">
																	인증번호<br>재발송
																</button>
															</div>
															<div class="phone_01">
																<div class="box_inputForm_nonmember">
																	<label for="nonMbrsAuthNo" class="label">수신된
																		인증번호</label> <span class="box_label"> <input
																		type="text" name="nonMbrsAuthNo"
																		placeholder="인증번호를 입력하세요" id="nonMbrsAuthNo"
																		maxlength="6" onkeyup="fnNumCheck(this);"
																		class="input">
																	</span>
																</div>
																<button type="button"
																	class="input_btn_nonmember check_phone">확인</button>


																<p
																	style="padding-left: 10px; text-align: left; display: inline-block;">
																	<input type="checkbox" name="sms_yn" id="sms_yn"
																		value="Y"> <label for="sms_yn">SMS로
																		인증번호 받기</label>
																</p>
															</div>


															<div class="phone_02">
																<div class="box_inputForm ph_complete ht21">
																	<strong class="ph_complete_txt ">인증이 완료되었습니다.</strong>
																	<input type="hidden" name="nonMbrsAuthYn"
																		id="nonMbrsAuthYn">
																</div>

																<!-- [2024 마크업 수정] -->
																<ul class="pay_tab clearfix pay_wrap01">
																	<li class="on"><a href="javascript:void(0)"
																		title="선택됨">신용카드 예매 티켓</a></li>
																	<li class="easy_tab01"><a
																		href="javascript:void(0)">간편결제 예매 티켓</a></li>
																</ul>
																<!-- // [2024 마크업 수정] -->
																<div class="credit">
																	<div class="box_inputForm ph_complete">
																		<label for="birthday1" class="label">생년월일(YYMMDD)</label>
																		<span class="box_label"> <input type="text"
																			name="birthday1" id="birthday1"
																			placeholder="생년월일 6자리를 입력하세요" maxlength="10"
																			onkeyup="fnNumCheck(this);" class="input">
																		</span>
																	</div>
																	<p class="notice_gray">
																		<span>※</span> 법인카드로 결제한 경우 사업자번호(10자리)를 입력하세요
																	</p>
																</div>
																<div class="easy_pay">
																	<div class="box_inputForm ph_complete">
																		<label for="start_date1" class="label">출발일(YYYYMMDD)</label>
																		<span class="box_label"> <input type="text"
																			name="start_date1" placeholder="출발일 8자리를 입력하세요"
																			id="start_date1" maxlength="8"
																			onkeyup="fnNumCheck(this);" class="input">
																		</span>
																	</div>
																	<p class="notice_gray">
																		<span>※</span> 스마일페이/티머니페이/페이코로 결제 한 경우 <br>
																		생년월일(6자리)대신 출발일(8자리)을 입력하세요.
																	</p>
																</div>
															</div>
														</div>
														<div class="card">
															<div class="phone_02">
																<div>
																	<div class="box_inputForm">
																		<strong class="send_txt label">카드번호</strong> <span
																			class="box_label clearfix"> <input type="text"
																			name="card_number01" id="card_number01"
																			title="카드번호 첫 번째 4자리 입력" class="input01"
																			maxlength="4"
																			onkeydown="this.value = onlyNumPlus(this.value);"
																			onkeyup="fnChkNext(this,'card_number02')"> <span
																			class="hyp">-</span> <input type="text"
																			name="card_number02" id="card_number02"
																			title="카드번호 두 번째 4자리 입력" class="input01"
																			maxlength="4"
																			onkeydown="this.value = onlyNumPlus(this.value);"
																			onkeyup="fnChkNext(this,'card_number03')"> <span
																			class="hyp">-</span>
																			<button type="button" class="transkey_btn number03"
																				data-id="card_number03" onclick="transkeyShow(this)">가상키패드</button>
																			<input type="password" name="card_number03"
																			id="card_number03" tabindex="-1"
																			title="카드번호 세 번째 4자리 입력" class="input01"
																			maxlength="4"
																			onkeydown="this.value = onlyNumPlus(this.value);"
																			onkeyup="fnChkNext(this,'card_number04')"
																			data-tk-kbdtype="number"
																			onfocus="setTranskey(this, 'lgnNonUsrFrm');">
																			<span class="hyp">-</span>
																			<button type="button" class="transkey_btn number04"
																				data-id="card_number04" onclick="transkeyShow(this)">가상키패드</button>
																			<input type="password" name="card_number04"
																			id="card_number04" tabindex="-1"
																			title="카드번호 네 번째 4자리 입력" class="input01"
																			maxlength="4"
																			onkeydown="this.value = onlyNumPlus(this.value);"
																			onblur="" data-tk-kbdtype="number"
																			onfocus="setTranskey(this, 'lgnNonUsrFrm');">
																		</span>
																	</div>


																</div>

																<!-- [2024 마크업 수정] -->
																<ul class="pay_tab clearfix pay_wrap02">
																	<li class="on"><a href="javascript:void(0)"
																		title="선택됨">신용카드 예매 티켓</a></li>
																	<li class="easy_tab02"><a
																		href="javascript:void(0)">간편결제 예매 티켓</a></li>
																</ul>
																<!-- // [2024 마크업 수정] -->

																<div class="credit">
																	<div class="box_inputForm">
																		<label for="birthday2" class="label">생년월일(YYMMDD)</label>
																		<span class="box_label"> <input type="text"
																			name="birthday2" placeholder="생년월일 6자리를 입력하세요"
																			id="birthday2" maxlength="10"
																			onkeyup="fnNumCheck(this);" class="input">
																		</span>
																	</div>
																	<p class="notice_gray">
																		<span>※</span> 법인카드로 결제한 경우 사업자번호(10자리)를 입력하세요
																	</p>
																</div>
																<div class="easy_pay">
																	<div class="box_inputForm">
																		<label for="start_date2" class="label">출발일(YYYYMMDD)</label>
																		<span class="box_label"> <input type="text"
																			name="start_date2" placeholder="출발일 8자리를 입력하세요"
																			id="start_date2" maxlength="8"
																			onkeyup="fnIcoCheck(this),fnNumCheck(this);"
																			class="input">
																		</span>
																	</div>
																	<p class="notice_gray">
																		<span>※</span> 스마일페이/티머니페이/페이코로 결제 한 경우 <br>
																		생년월일(6자리)대신 출발일(8자리)을 입력하세요.
																	</p>
																</div>
															</div>
														</div>

														<!-- 기존에 .box_bg_input 바깥에 위치, .box_bg_input 내부로 위치 이동 -->
														<div class="bottom_btn">
															<button type="button"
																onclick="javascript:fnNonUsr_Search();"
																class="btnL btn_confirm ready""="">조회하기</button>
														</div>
													</div>
												</div>
												<!-- 비회원예매폼 수정 -->

												<input type="hidden" id="popUpDvs2" name="popUpDvs"
													value="N"> <input type="hidden" id="returnUrl2"
													name="returnUrl" value="/mrs/mrscfm.do"> <input
													type="hidden" id="vltlCnt" name="vltlCnt" value="Y">
												<input type="hidden" id="cal_flg1" name="cal_flg1" value="0">
												<input type="hidden" id="cal_flg2" name="cal_flg2" value="1">
											</form>

											<script>
												/* 비회원 예매프로세스 휴대폰번호찾기 1-1  */
												$(".send_btn").on("click", function(){
													if ($("#nonMbrsHp").val().length < 10){
														alert("휴대폰 번호를 확인해주세요.");
														$('#nonMbrsHp').focus();
														return;
													}
													
													$("#loading").show();
													$("#nonMbrsAuthYn").val("N");
													
													var sms_yn = $("#sms_yn").prop("checked");
													
													$.ajax({	
												        url      : "/mbrs/lgn/askAuthNoNonUser.ajax",
												        type     : "post",
												        data     : {
												        	hp_no : $("#nonMbrsHp").val(),
												        	sms_yn : (sms_yn) ? 'Y' : 'N',
												        },
												        dataType : "json",
												        async    : true,
												        success  : function(lgnNonUsrMap){
												        	$("#loading").hide();
												        	
												        	if (lgnNonUsrMap.resultStatus == "Y"){
													        	alert("인증번호가 전송되었습니다.");
													        	$("#nonMbrsAuthNo").val('');
													        	$("#nonMbrsAuthNo").focus();
													        	$(".send_btn").html('인증번호<br>재발송');
													        	
												        	} else {
												        		alert("인증번호 전송에 실패하였습니다. \n\n잠시 후 다시 이용하여 주시기 바랍니다.");
												        	}
												        },
												        error : function (e){
												        	$("#loading").hide();
												            alert("잠시 후 다시 이용하여 주시기 바랍니다.");
												            return;
												        }
													});
													
												});
												/* 비회원 예매프로세스 휴대폰번호찾기 1-2  */
												$(".resend_btn").on("click", function(){
													$(".send").show(); //발송
													$(".resend").hide(); //재발송
												});
												/* 비회원 예매프로세스 휴대폰번호찾기 1-3 -> 2   */
												$(".check_phone").on("click", function(){
													
													if ($("#nonMbrsHp").val().length < 10){
														alert("휴대폰 번호를 확인해주세요.");
														$('#nonMbrsHp').focus();
														return;
													}
													if ($("#nonMbrsAuthNo").val().length < 6){
														alert("인증번호를 확인해주세요.");
														$('#nonMbrsAuthNo').focus();
														return;
													}
													
													$("#loading").show();
													$("#nonMbrsAuthYn").val("N");
													
													$.ajax({	
												        url      : "/mbrs/lgn/insertAuthNonUserInfo.ajax",
												        type     : "post",
												        data     : {
												        	hp_no : $("#nonMbrsHp").val(),
												        	aou_no : $("#nonMbrsAuthNo").val(),
												        	in_type : '1'
												        },
												        dataType : "json",
												        async    : true,
												        success  : function(lgnNonUsrMap){
												        	$("#loading").hide();
												        	
												        	if (lgnNonUsrMap.resultStatus == "Y"){
													        	alert("인증되었습니다.");
													        	
																$(".resend").hide(); //발송
																$(".send").hide(); //재발송
																$(".phone_01").hide(); 
																$(".phone_02").show();
																$(".ph_complete").show();
																$("#nonMbrsAuthYn").val("Y");
												        	} else {
												        		alert("인증에 실패하였습니다. \n\n인증번호를 확인하여 주시기 바랍니다.");
												        	}
												        },
												        error : function (e){
												        	$("#loading").hide();
												            alert("잠시 후 다시 이용하여 주시기 바랍니다.");
												            return;
												        }
													});
													
												});
												/* 비회원 예매프로세스  2-2, 3-2  */
												$(".pay_wrap01 p").on("click",function(){
													$(".pay_wrap01 p").removeClass("on");
													$(this).toggleClass("on");
													if($(".easy_tab01").hasClass("on")){
														$(".easy_pay").show();
														$(".credit").hide();
														$("#cal_flg2").val('2');
													}else{
														$(".credit").show();
														$(".easy_pay").hide();
														$("#cal_flg2").val('1');
													}
												});
												/* 비회원 예매프로세스  2-2, 3-2  */
												$(".input_tab  p").on("click",function(){
													$(".input_tab p").removeClass("on");
													$(this).toggleClass("on");
													if($(".find_card_num").hasClass("on")){
														$(".card").show();
														$(".phone").hide();
														$("#cal_flg1").val('2');
													}else{
														$(".phone").show();
														$(".card").hide();
														$("#cal_flg1").val('0');
													}
												});
												
												$(".pay_wrap02 p").on("click",function(){
													$(".pay_wrap02 p").removeClass("on");
													$(this).toggleClass("on");
													if($(".easy_tab02").hasClass("on")){
														$(".easy_pay").show();
														$(".credit").hide();
														$("#cal_flg2").val('2');
													}else{
														$(".credit").show();
														$(".easy_pay").hide();
														$("#cal_flg2").val('1');
													}
												});
												function fnChkNext(obj,nextFld){
													//if($(obj).val().length == 4){
													//	$("#"+nextFld).val('');
													//	$("#"+nextFld).focus();
													//}
												}
												function fnNonUsr_Search(){
													var cal_flg1 = Number($("#cal_flg1").val());
													var cal_flg2 = Number($("#cal_flg2").val());
													var card_number = $("#card_number01").val() +""+ $("#card_number02").val() +""+ $("#card_number03").val() +""+ $("#card_number04").val();
													if(cal_flg1 == 0 && $("#nonMbrsAuthYn").val() != "Y"){
														alert("비회원 인증이 필요합니다. 휴대폰 번호와 수신된 인증번호를 정확하게 입력해주세요.");
														$('#nonMbrsHp').focus();
														return;
													}
													if (cal_flg1 == 0 && $("#nonMbrsHp").val() == ''){
														alert('휴대폰 번호를 확인해주세요.');
														$('#nonMbrsHp').focus();
														return;
													}
													if (cal_flg1 == 0 && cal_flg2 == 1 && $("#birthday1").val().length != 6 && $("#birthday1").val().length != 10){
														alert('생년월일을 확인해주세요.');
														$("#birthday1").focus();
														return;
													}
													if (cal_flg1 == 0 && cal_flg2 == 2 && $("#start_date1").val().length != 8){
														alert('출발일을 확인해주세요.');
														$("#start_date1").focus();
														return;
													}
													if (cal_flg1 == 2 && card_number.length < 15){
														alert('카드번호 16자리를 정확하게 입력해주세요.');
														$("#card_number01").focus();
														return;
													}
													if (cal_flg1 == 2 && cal_flg2 == 1 && $("#birthday2").val().length != 6 && $("#birthday2").val().length != 10){
														alert('생년월일 6자리를 입력해주세요.');
														$("#birthday2").focus();
														return;
													}
													if (cal_flg1 == 2 && cal_flg2 == 2 && $("#start_date2").val().length != 8){
														alert('출발일 8자리를 입력해주세요.');
														$("#start_date2").focus();
														return;
													}
					
													if (cal_flg1 == 2){
														if (ajaxDecode('card_number03') == false) { return; }
														if (ajaxDecode('card_number04') == false) { return; }
													}
													
													var returnUrl = $('#lgnNonUsrFrm #returnUrl2').val();
													if(returnUrl != ""){
														$('#lgnNonUsrFrm').attr('method', 'post');
														$('#lgnNonUsrFrm').attr('action', returnUrl);
														$('#lgnNonUsrFrm').submit();
													 }else{
														location.href = "/main.do";
													 }
												}
											</script>

										</div>

									</div>

									<!-- // 로그인 -->


								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="main-content">
					<div class="container">
						<!-- 광고 배너 추후 추가 예정 -->
						<div class="banner-group type-row-A">
							<!-- <iframe src="/koBus/images/_ad-tubebox-001A.html" title="프레임 (휴대폰안심 서비스)" class="ad-frame"></iframe> -->
						</div>

						<div class="content-row links-small">
							<a href="/adtnprdnew/frps/frpsPrchGd.do"
								class="item item-yellow"> <strong>프리패스 여행권 구매</strong>
								<p>대한민국 구석구석을 자유롭게</p> <img
								src="/koBus/images/img-links-small-item01.png" alt="">
							</a> <a href="/adtnprdnew/pass/passPrchGd.do"
								class="item item-yellow"> <strong>정기권 구매</strong>
								<p>매일 가는 목적지를 저렴하게</p> <img
								src="/koBus/images/img-links-small-item02.png" alt="">
							</a> <a href="/oprninf/arscgd/oprnArscGd.do"
								class="item item-blue"> <strong>도착시간 안내</strong>
								<p>운행중인 버스정보를 확인해요</p> <img
								src="/koBus/images/img-links-small-item03.png" alt="">
							</a> <a
								href="/oprninf/alcninqr/oprnAlcnPage.do"
								class="item item-blue"> <strong>시간표 조회</strong>
								<p>배차시간을 편리하게 확인해요</p> <img
								src="/koBus/images/img-links-small-item04.png" alt="">
							</a>
						</div>





						<div class="content-row links-big">

							<div class="item item-green">
								<span>프리미엄 골드 익스프레스</span> <strong>도로 위 비즈니스 클래스<br>
									프리미엄 고속버스
								</strong> <img src="/koBus/images/img-links-big-item01.png" alt="">
							</div>
							<a href="https://www.zerodayexpress.com/b2cpublic/main.page"
								target="_blank" title="새창" class="item item-blue"> <span>ZERODAY
									EXPRESS</span> <strong>고속버스 당일배송<br> 온라인 택배신청
							</strong> <img src="/koBus/images/img-links-big-item02.png" alt="">
							</a> <a
								href="/cscn/lossClnc/readLossClncList.do"
								target="_blank" title="새창" class="item item-purple"> <span>고객센터</span>
								<strong>유실물 센터</strong> <img
								src="/koBus/images/img-lost-article.png" alt="">
							</a>
						</div>



						<div class="banner-group type-row-C banner-and-lost-article">
							<!-- <iframe src="/koBus/images/banner-kumho-market.html" title="프레임 (금호팔도마켓 이벤트 새창 링크)" class="ad-frame"></iframe> -->
							<!-- <iframe src="/koBus/images/banner-hanil-modernprestige.html" title="프레임 (한일고속 회원전용 이벤트 새창 링크)" class="ad-frame"></iframe> -->
							<a href="/ugd/mlggd/Mlggd.do"
								class="item item-lost-article" target="_blank" title="새창"> <span>이용안내</span>
								<strong>프리미엄 마일리지</strong> <img
								src="/koBus/images/ico-premium-mileage.png" alt="">
							</a>
						</div>

						<div class="content-row">
							<div class="info-area">
								<h3>이용안내</h3>
								<ul class="info-list">
									<li><a href="/ugd/mrsgd/Mrsgd.do">
											<span>예매안내</span>
									</a></li>
									<li><a href="/ugd/trtrgd/Trtrgd.do">
											<span>환승안내</span>
									</a></li>
									<li><a href="/ugd/trmlgd/Trmlgd.do">
											<span>터미널 안내</span>
									</a></li>
								</ul>
							</div>
							<div class="notice-area">
								<h3>공지사항</h3>
								<div class="notice">
									<div class="bx-wrapper"
										style="max-width: 100%; margin: 0px auto;">
										<div class="bx-viewport"
											style="width: 100%; overflow: hidden; position: relative; height: 33px;">
											<ul class="bxslider" id="noticeViewNew"
												style="width: 1115%; position: relative; transition-duration: 1s; transform: translate3d(-2155px, 0px, 0px);">
												<li
													style="float: left; list-style: none; position: relative; width: 431px;"
													class="bx-clone"><a href="javascript:;"
													onclick="fnGoReadPage(20250314001);">
														<p class="title">심야 요금 요율 변경 안내</p> <span class="date">2025.03.14</span>
												</a></li>
												<li
													style="float: left; list-style: none; position: relative; width: 431px;">
													<a href="javascript:;" onclick="fnGoReadPage(20250321001);">
														<p class="title">개인정보 처리방침 약관 개정 안내</p> <span class="date">2025.03.21</span>
												</a>
												</li>
												<li
													style="float: left; list-style: none; position: relative; width: 431px;">
													<a href="javascript:;" onclick="fnGoReadPage(20250313001);">
														<p class="title">서비스 이용약관 약관 개정 안내</p> <span class="date">2025.03.13</span>
												</a>
												</li>
												<li
													style="float: left; list-style: none; position: relative; width: 431px;">
													<a href="javascript:;" onclick="fnGoReadPage(20240528001);">
														<p class="title">반려동물 동반탑승 안내</p> <span class="date">2024.05.28</span>
												</a>
												</li>
												<li
													style="float: left; list-style: none; position: relative; width: 431px;">
													<a href="javascript:;" onclick="fnGoReadPage(20191125001);">
														<p class="title">프리미엄 고속버스 마일리지 소멸 유효기간 안내</p> <span
														class="date">2019.11.22</span>
												</a>
												</li>
												<li
													style="float: left; list-style: none; position: relative; width: 431px;">
													<a href="javascript:;" onclick="fnGoReadPage(20190822001);">
														<p class="title">노쇼방지를 위한 동일카드 예매 횟수 변경 안내</p> <span
														class="date">2019.08.22</span>
												</a>
												</li>
												<li
													style="float: left; list-style: none; position: relative; width: 431px;">
													<a href="javascript:;" onclick="fnGoReadPage(20190809001);">
														<p class="title">■ 고객센터 점심시간 운영 안내</p> <span class="date">2019.08.09</span>
												</a>
												</li>
												<li
													style="float: left; list-style: none; position: relative; width: 431px;">
													<a href="javascript:;" onclick="fnGoReadPage(20250417001);">
														<p class="title">고속버스 취소수수료 변경 안내</p> <span class="date">2025.04.17</span>
												</a>
												</li>
												<li
													style="float: left; list-style: none; position: relative; width: 431px;">
													<a href="javascript:;" onclick="fnGoReadPage(20250404001);">
														<p class="title">전자금융거래 이용약관 개정 안내</p> <span class="date">2025.02.25</span>
												</a>
												</li>
												<li
													style="float: left; list-style: none; position: relative; width: 431px;">
													<a href="javascript:;" onclick="fnGoReadPage(20250314001);">
														<p class="title">심야 요금 요율 변경 안내</p> <span class="date">2025.03.14</span>
												</a>
												</li>
												<li
													style="float: left; list-style: none; position: relative; width: 431px;"
													class="bx-clone"><a href="javascript:;"
													onclick="fnGoReadPage(20250321001);">
														<p class="title">개인정보 처리방침 약관 개정 안내</p> <span class="date">2025.03.21</span>
												</a></li>
											</ul>
										</div>
									</div>
									<div class="slider-controls">
										<button type="button" id="prev" class="btn btn-prev">
											<i class="ico ico-slide-prev-gray"></i><span class="sr-only">이전</span>
										</button>
										<button type="button" id="toggle" class="btn btn-pause">
											<i class="ico ico-slide-pause-gray"></i><span class="sr-only">멈춤</span>
										</button>
										<button type="button" id="next" class="btn btn-next">
											<i class="ico ico-slide-next-gray"></i><span class="sr-only">다음</span>
										</button>
									</div>
								</div>
								<a href="/cscn/ntcmttr/readNtcList.do"
									class="btn-more">더보기 <i class="ico ico-more"></i></a>

								<form name="leftForm" id="leftForm">
									<input type="hidden" id="leftNtcNo" name="ntcNo">
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Mobile -->
			<div class="d-down-sm">
				<!-- as-is 마크업 구조 그대로 사용함 -->
				<div class="mo_menu_wrap">
					<div class="mo_menu">
						<ul>
							<li class="menu1"><a
								href="/mrs/rotinf.do">고속버스 예매</a></li>

							<li class="menu2"><a
								href="/mrs/mrscfmlgnchec.do">예매 확인 </a></li>

							<li class="menu3"><a
								href="/oprninf/arscgd/oprnArscGd.do">도착시간안내</a></li>
						</ul>
					</div>
					<div class="main">
						<p class="mo_util">
							<a
								href="/oprninf/alcninqr/oprnAlcnPage.do"
								class="util1" style="width: 33.33%">시간표조회</a> <a
								href="/ugd/mrsgd/Mrsgd.do" class="util2"
								style="width: 33.33%">이용안내</a>
							<!-- <a href="/cscn/ntcmttr/readNtcList.do" class="util3" style="width:33.33%;">고객센터</a> -->
							<a href="/mbrs/mbrspage/myPageMain.do"
								class="util4" style="width: 33.33%">마이페이지</a>
						</p>
					</div>
				</div>

				<div class="bnr_box bnr3">
					<div class="main_bus">
						<a href="javascript:void(0)"> <span class="stit">프리미엄
								골드 익스프레스</span>
							<p>
								도로 위 비즈니스 클래스 프리미엄 고속버스<span class="block"></span>
							</p>
						</a>
					</div>
					<div class="main_molit">
						<a href="https://www.zerodayexpress.com/" target="_blank"> <span
							class="stit">ZERODAY EXPRESS</span>
							<p>
								고속버스 당일배송 온라인 택배신청<span class="block"></span>
							</p>
						</a>
					</div>
					<div class="main_app">
						<a
							href="https://www.shinhancard.com/conts/person/card_info/dream/credit/oil/1413166_46596.jsp?EntryLoc1=TM2876&amp;EntryLoc2=2867&amp;empSeq=4"
							target="_blank"> <span class="stit">All Pass 신한카드 출시</span>
							<p>
								고속/시외버스 앱 결제시 30% 할인<span class="block"></span>
							</p>
						</a>
					</div>

					<div class="main_info">
						<span class="stit">이용안내</span>
						<ul class="clifx">
							<li class="info1" style="width: 33.333%"><a
								href="/ugd/mrsgd/Mrsgd.do">예매안내</a></li>
							<li class="info2" style="width: 33.333%"><a
								href="/ugd/trtrgd/Trtrgd.do">환승안내</a></li>
							<li class="info4" style="width: 33.333%"><a
								href="/ugd/trmlgd/Trmlgd.do">터미널안내</a></li>
							<!-- <li class="info3"><a href="/ugd/cacmgd/CacmgdSale.do">할인안내</a></li> -->
						</ul>
					</div>
				</div>
				<!-- // as-is 마크업 구조 그대로 사용함 -->
			</div>

			<!-- // 본문 영역 -->
		</article>



		<!-- 취소수수료안내 팝업 -->



		<!-- // 공지팝업 -->
		<input type="hidden" id="pupListLen" name="pupListLen" value="4">


		<!-- // 공지팝업 -->


		<!-- 시외노선 우등형 할인 안내 -->



		<!-- 노선조회안내 팝업 - 서울~강릉 - 190227 추가 -->

		<!-- 노선조회안내 팝업 - 동서울~강릉 - 190227 추가 -->

		<!-- 노선조회안내 팝업 - 수원~삼척 - 190227 추가 -->

		<!-- 노선조회안내 팝업 - 서울경부~동해 - 190227 추가 -->

		<!-- 노선조회안내 팝업 속초 - 190227 추가 -->


		<!-- 노선조회안내 팝업 원주 - 190926 추가 -->


		<!-- 광양 임시터미널 안내 - 191031 추가 -->


		<!-- footer -->



		<!-- 푸터 -->
		<footer id="new-kor-footer">
			<div class="container">
				<div class="footer-top-cont">
					<ul class="express-bus-company-list">
						<li><a href="http://www.kumhobuslines.co.kr/" target="_blank"
							title="새창"><img src="/koBus/images/logo-kumho-express.png"
								alt="금호고속"></a></li>
						<li><a href="http://www.dongbubus.com/" target="_blank"
							title="새창"><img src="/koBus/images/logo-dongbu-express.png"
								alt="동부고속"></a></li>
						<li><a href="http://www.songnisanbuslines.co.kr/"
							target="_blank" title="새창"><img
								src="/koBus/images/logo-sokrisan-express.png" alt="속리산고속"></a>
						</li>
						<li><a href="http://www.dyexpress.co.kr/" target="_blank"
							title="새창"><img src="/koBus/images/logo-dongyang-express.png"
								alt="동양고속"></a></li>
						<li><a href="http://www.samhwaexpress.co.kr/" target="_blank"
							title="새창"><img src="/koBus/images/logo-samhwa-express.png"
								alt="삼화고속"></a></li>
						<li><a href="http://www.jabus.co.kr/" target="_blank"
							title="새창"><img src="/koBus/images/logo-joongang-express.png"
								alt="중앙고속"></a></li>
						<li><a href="http://www.chunilexpress.co.kr/" target="_blank"
							title="새창"><img src="/koBus/images/logo-chunil-express.png"
								alt="천일고속"></a></li>
						<li><a href="http://www.hanilexpress.co.kr/" target="_blank"
							title="새창"><img src="/koBus/images/logo-hanil-express.png"
								alt="한일고속"></a></li>
					</ul>
					<!-- dropdown-top 클래스 추가 시, 드롭다운 목록 위로 노출 -->
					<div class="dropdown-wrap dropdown-top related-sites-select">
						<a href="javascript:void(0)" class="btn-dropdown" title="관련사이트 이동"
							aria-expanded="false"><span class="text">관련사이트</span><i
							class="ico ico-arrow-down"></i></a>
						<ul class="dropdown-list" style="display: none;">
							<li class="selected"><a
								href="/wchr/main.do" target="_blank"
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
							<li><a href="/etc/svcstpl/SvcStpl.do">서비스
									이용약관</a></li>
							<li><a
								href="/etc/indlstpl/IndlStpl.do"
								class="text-bold">개인정보 처리방침</a></li>
							<li><a href="/etc/busstpl/BusStpl.do">고속버스
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
						<li><a href="/ugd/bustrop/Bustrop.do"
							title="이사장 인사말 바로가기"><img src="/koBus/images/logo-kobus.png"
								alt="KOBUS 전국고속버스운송사업조합"></a></li>
						<li><a
							href="/ugd/trmlbizr/Trmlbizr.do"
							title="협회장 인사말 바로가기"><img
								src="/koBus/images/logo-npvtba-express.png" alt="전국여객자동차터미널사업자협회"></a>
						</li>
					</ul>
				</div>
			</div>
		</footer>

	</div>


	<div
		style="left: -1000px; overflow: scroll; position: absolute; top: -1000px; border: none; box-sizing: content-box; height: 200px; margin: 0px; padding: 0px; width: 200px;">
		<div
			style="border: none; box-sizing: content-box; height: 200px; margin: 0px; padding: 0px; width: 200px;"></div>
	</div>
	<div class="remodal-overlay remodal-is-closed" style="display: none;"></div>
	<div class="remodal-wrapper remodal-is-closed" style="display: none;">
		<div
			class="remodal pop_place full remodal-is-initialized remodal-is-closed"
			data-remodal-id="popPlace" role="dialog" tabindex="-1">


			<div class="title">
				<h2 id="popTitle">출/도착지 선택</h2>
			</div>
			<div class="cont">
				<div class="search_wrap" style="display: none;">
					<p>
						<!--  class="focus" -->
					<div class="easy-autocomplete" style="width: 100px;">
						<input type="text" id="terminalSearch" title="터미널/지역 이름 검색"
							placeholder="터미널/지역 이름을 검색하세요" autocomplete="off">
						<div class="easy-autocomplete-container"
							id="eac-container-terminalSearch">
							<ul></ul>
						</div>
					</div>
					<span class="btn">검색</span>
					</p>
				</div>
				<div class="start_wrap" id="imptDepr" style="display: block;">
					<h3 class="stit">주요출발지</h3>
					<div class="tags">
						<button type="button" onclick="fnDeprChc('010','서울경부')"
							name="imptDeprNm" value="010">서울경부</button>
						<button type="button" onclick="fnDeprChc('021','센트럴시티(서울)')"
							name="imptDeprNm" value="021" class="over">센트럴시티(서울)</button>
						<button type="button" onclick="fnDeprChc('500','광주(유·스퀘어)')"
							name="imptDeprNm" value="500">광주(유·스퀘어)</button>
						<!--  class="active" -->
						<button type="button" onclick="fnDeprChc('700','부산')"
							name="imptDeprNm" value="700">부산</button>
						<button type="button" onclick="fnDeprChc('703','부산사상')"
							name="imptDeprNm" value="703">부산사상</button>
						<button type="button" onclick="fnDeprChc('032','동서울')"
							name="imptDeprNm" value="032">동서울</button>
						<button type="button" onclick="fnDeprChc('300','대전복합')"
							name="imptDeprNm" value="300">대전복합</button>
						<button type="button" onclick="fnDeprChc('602','전주')"
							name="imptDeprNm" value="602">전주</button>
						<button type="button" onclick="fnDeprChc('360','유성')"
							name="imptDeprNm" value="360">유성</button>
						<button type="button" onclick="fnDeprChc('310','천안')"
							name="imptDeprNm" value="310">천안</button>
						<button type="button" onclick="fnDeprChc('801','동대구')"
							name="imptDeprNm" value="801">동대구</button>
						<button type="button" onclick="fnDeprChc('120','성남(분당)')"
							name="imptDeprNm" value="120">성남(분당)</button>
					</div>
				</div>
				<div class="terminal_wrap">
					<h3 class="stit">지역별 터미널</h3>
					<div class="ternimal_box">
						<div class="scroll-wrapper area_scroll scrollbar-inner"
							style="position: relative;">
							<div class="area_scroll scrollbar-inner scroll-content"
								style="height: 420px; margin-bottom: 0px; margin-right: 0px; max-height: none;">
								<!-- <ul class="area_list">
								<li class="active" id="areaListAll"><span onclick="fnDeprArvlViewList('all');">전체</span></li>
								<li><span onclick="fnDeprArvlViewList('11');">서울</span></li>
								<li><span onclick="fnDeprArvlViewList('28');">인천/경기</span></li>
								<li><span onclick="fnDeprArvlViewList('42');">강원</span></li>
								<li><span onclick="fnDeprArvlViewList('30');">대전/충남</span></li>
								<li><span onclick="fnDeprArvlViewList('43');">충북</span></li>
								<li><span onclick="fnDeprArvlViewList('29');">광주/전남</span></li>
								<li><span onclick="fnDeprArvlViewList('45');">전북</span></li>
								<li><span onclick="fnDeprArvlViewList('26');">부산/경남</span></li>
								<li><span onclick="fnDeprArvlViewList('27');">대구/경북</span></li>
							</ul> -->
								<ul class="area_list">
									<li class="active" id="areaListAll"><button type="button"
											onclick="fnDeprArvlViewList('all');" title="선택됨">전체</button></li>
									<li><button type="button"
											onclick="fnDeprArvlViewList('11');">서울</button></li>
									<li><button type="button"
											onclick="fnDeprArvlViewList('28');">인천/경기</button></li>
									<li><button type="button"
											onclick="fnDeprArvlViewList('42');">강원</button></li>
									<li><button type="button"
											onclick="fnDeprArvlViewList('30');">대전/충남</button></li>
									<li><button type="button"
											onclick="fnDeprArvlViewList('43');">충북</button></li>
									<li><button type="button"
											onclick="fnDeprArvlViewList('29');">광주/전남</button></li>
									<li><button type="button"
											onclick="fnDeprArvlViewList('45');">전북</button></li>
									<li><button type="button"
											onclick="fnDeprArvlViewList('26');">부산/경남</button></li>
									<li><button type="button"
											onclick="fnDeprArvlViewList('27');">대구/경북</button></li>
								</ul>
							</div>
							<div class="scroll-element scroll-x">
								<div class="scroll-element_outer">
									<div class="scroll-element_size"></div>
									<div class="scroll-element_track"></div>
									<div class="scroll-bar"></div>
								</div>
							</div>
							<div class="scroll-element scroll-y">
								<div class="scroll-element_outer">
									<div class="scroll-element_size"></div>
									<div class="scroll-element_track"></div>
									<div class="scroll-bar"></div>
								</div>
							</div>
						</div>
						<div class="terminal_list" id="terminalList">
							<h4 class="sr-only">전체</h4>
							<div class="scroll-wrapper terminal_scroll scrollbar-inner"
								style="position: relative;">
								<div class="terminal_scroll scrollbar-inner scroll-content"
									style="height: 420px; margin-bottom: 0px; margin-right: 0px; max-height: none;">
									<ul class="clear" id="tableTrmList">
										<!-- <li class="over"><button type="button" onclick="fnDeprChc('200','강릉');">강릉</button></li><li><button type="button" onclick="fnDeprChc('535','강진');">강진</button></li><li><button type="button" onclick="fnDeprChc('852','경북도청');">경북도청</button></li><li><button type="button" onclick="fnDeprChc('815','경주');">경주</button></li><li><button type="button" onclick="fnDeprChc('201','경포해변');">경포해변</button></li><li><button type="button" onclick="fnDeprChc('355','고대조치원');">고대조치원</button></li><li><button type="button" onclick="fnDeprChc('116','고양백석');">고양백석</button></li><li><button type="button" onclick="fnDeprChc('635','고창');">고창</button></li><li><button type="button" onclick="fnDeprChc('540','고흥');">고흥</button></li><li><button type="button" onclick="fnDeprChc('320','공주');">공주</button></li><li><button type="button" onclick="fnDeprChc('520','광양');">광양</button></li><li><button type="button" onclick="fnDeprChc('500','광주(유·스퀘어)');">광주(유·스퀘어)</button></li><li><button type="button" onclick="fnDeprChc('503','광주비아');">광주비아</button></li><li><button type="button" onclick="fnDeprChc('422','교통대');">교통대</button></li><li><button type="button" onclick="fnDeprChc('519','구례');">구례</button></li><li><button type="button" onclick="fnDeprChc('169','구리');">구리</button></li><li><button type="button" onclick="fnDeprChc('810','구미');">구미</button></li><li><button type="button" onclick="fnDeprChc('610','군산');">군산</button></li><li><button type="button" onclick="fnDeprChc('330','금산');">금산</button></li><li><button type="button" onclick="fnDeprChc('620','김제');">김제</button></li><li><button type="button" onclick="fnDeprChc('735','김해');">김해</button></li><li><button type="button" onclick="fnDeprChc('736','김해장유');">김해장유</button></li><li><button type="button" onclick="fnDeprChc('530','나주');">나주</button></li><li><button type="button" onclick="fnDeprChc('531','나주혁신');">나주혁신</button></li><li><button type="button" onclick="fnDeprChc('824','낙동강(휴)상행');">낙동강(휴)상행</button></li><li><button type="button" onclick="fnDeprChc('823','낙동강(휴)하행');">낙동강(휴)하행</button></li><li><button type="button" onclick="fnDeprChc('625','남원');">남원</button></li><li><button type="button" onclick="fnDeprChc('390','내포');">내포</button></li><li><button type="button" onclick="fnDeprChc('545','녹동');">녹동</button></li><li><button type="button" onclick="fnDeprChc('370','논산');">논산</button></li><li><button type="button" onclick="fnDeprChc('587','능주');">능주</button></li><li><button type="button" onclick="fnDeprChc('582','담양');">담양</button></li><li><button type="button" onclick="fnDeprChc('312','당진');">당진</button></li><li><button type="button" onclick="fnDeprChc('388','당진기지시');">당진기지시</button></li><li><button type="button" onclick="fnDeprChc('807','대구용계');">대구용계</button></li><li><button type="button" onclick="fnDeprChc('307','대전도룡');">대전도룡</button></li><li><button type="button" onclick="fnDeprChc('300','대전복합');">대전복합</button></li><li><button type="button" onclick="fnDeprChc('305','대전청사(샘머리)');">대전청사(샘머리)</button></li><li><button type="button" onclick="fnDeprChc('399','덕산스파');">덕산스파</button></li><li><button type="button" onclick="fnDeprChc('525','동광양(중마)');">동광양(중마)</button></li><li><button type="button" onclick="fnDeprChc('801','동대구');">동대구</button></li><li><button type="button" onclick="fnDeprChc('032','동서울');">동서울</button></li><li><button type="button" onclick="fnDeprChc('210','동해');">동해</button></li><li><button type="button" onclick="fnDeprChc('705','마산');">마산</button></li><li><button type="button" onclick="fnDeprChc('706','마산내서');">마산내서</button></li><li><button type="button" onclick="fnDeprChc('505','목포');">목포</button></li><li><button type="button" onclick="fnDeprChc('550','무안');">무안</button></li><li><button type="button" onclick="fnDeprChc('337','배방정류소');">배방정류소</button></li><li><button type="button" onclick="fnDeprChc('555','벌교');">벌교</button></li><li><button type="button" onclick="fnDeprChc('395','보령');">보령</button></li><li><button type="button" onclick="fnDeprChc('554','보성');">보성</button></li><li><button type="button" onclick="fnDeprChc('700','부산');">부산</button></li><li><button type="button" onclick="fnDeprChc('220','삼척');">삼척</button></li><li><button type="button" onclick="fnDeprChc('221','삼척해변');">삼척해변</button></li><li><button type="button" onclick="fnDeprChc('825','상주');">상주</button></li><li><button type="button" onclick="fnDeprChc('805','서대구');">서대구</button></li><li><button type="button" onclick="fnDeprChc('703','서부산(사상)');">서부산(사상)</button></li><li><button type="button" onclick="fnDeprChc('393','서산');">서산</button></li><li><button type="button" onclick="fnDeprChc('010','서울경부');">서울경부</button></li><li><button type="button" onclick="fnDeprChc('419','서충주');">서충주</button></li><li><button type="button" onclick="fnDeprChc('347','선문대');">선문대</button></li><li><button type="button" onclick="fnDeprChc('813','선산(휴)상행');">선산(휴)상행</button></li><li><button type="button" onclick="fnDeprChc('812','선산(휴)하행');">선산(휴)하행</button></li><li><button type="button" onclick="fnDeprChc('529','섬진강(휴)상행');">섬진강(휴)상행</button></li><li><button type="button" onclick="fnDeprChc('528','섬진강(휴)하행');">섬진강(휴)하행</button></li><li><button type="button" onclick="fnDeprChc('120','성남(분당)');">성남(분당)</button></li><li><button type="button" onclick="fnDeprChc('361','세종국무조정실');">세종국무조정실</button></li><li><button type="button" onclick="fnDeprChc('362','세종시청');">세종시청</button></li><li><button type="button" onclick="fnDeprChc('351','세종연구단지');">세종연구단지</button></li><li><button type="button" onclick="fnDeprChc('353','세종청사');">세종청사</button></li><li><button type="button" onclick="fnDeprChc('352','세종터미널');">세종터미널</button></li><li><button type="button" onclick="fnDeprChc('021','센트럴시티(서울)');">센트럴시티(서울)</button></li><li><button type="button" onclick="fnDeprChc('230','속초');">속초</button></li><li><button type="button" onclick="fnDeprChc('110','수원');">수원</button></li><li><button type="button" onclick="fnDeprChc('645','순창');">순창</button></li><li><button type="button" onclick="fnDeprChc('515','순천');">순천</button></li><li><button type="button" onclick="fnDeprChc('513','순천신대지구');">순천신대지구</button></li><li><button type="button" onclick="fnDeprChc('195','시흥(시화)');">시흥(시화)</button></li><li><button type="button" onclick="fnDeprChc('114','신갈시외(두진A)');">신갈시외(두진A)</button></li><li><button type="button" onclick="fnDeprChc('119','신갈영덕(고속도로)');">신갈영덕(고속도로)</button></li><li><button type="button" onclick="fnDeprChc('512','신대');">신대</button></li><li><button type="button" onclick="fnDeprChc('344','아산둔포');">아산둔포</button></li><li><button type="button" onclick="fnDeprChc('341','아산서부(호서대)');">아산서부(호서대)</button></li><li><button type="button" onclick="fnDeprChc('336','아산시외');">아산시외</button></li><li><button type="button" onclick="fnDeprChc('340','아산온양');">아산온양</button></li><li><button type="button" onclick="fnDeprChc('342','아산탕정사무소');">아산탕정사무소</button></li><li><button type="button" onclick="fnDeprChc('338','아산테크노밸리');">아산테크노밸리</button></li><li><button type="button" onclick="fnDeprChc('840','안동');">안동</button></li><li><button type="button" onclick="fnDeprChc('396','안면도');">안면도</button></li><li><button type="button" onclick="fnDeprChc('190','안산');">안산</button></li><li><button type="button" onclick="fnDeprChc('130','안성');">안성</button></li><li><button type="button" onclick="fnDeprChc('133','안성공도');">안성공도</button></li><li><button type="button" onclick="fnDeprChc('137','안성대림');">안성대림</button></li><li><button type="button" onclick="fnDeprChc('131','안성중대');">안성중대</button></li><li><button type="button" onclick="fnDeprChc('132','안성풍림');">안성풍림</button></li><li><button type="button" onclick="fnDeprChc('134','안성한경');">안성한경</button></li><li><button type="button" onclick="fnDeprChc('138','안성회관');">안성회관</button></li><li><button type="button" onclick="fnDeprChc('177','안중');">안중</button></li><li><button type="button" onclick="fnDeprChc('176','안중오거리');">안중오거리</button></li><li><button type="button" onclick="fnDeprChc('619','애통리');">애통리</button></li><li><button type="button" onclick="fnDeprChc('270','양양');">양양</button></li><li><button type="button" onclick="fnDeprChc('510','여수');">여수</button></li><li><button type="button" onclick="fnDeprChc('140','여주');">여주</button></li><li><button type="button" onclick="fnDeprChc('139','여주대');">여주대</button></li><li><button type="button" onclick="fnDeprChc('141','여주프리미엄아울렛');">여주프리미엄아울렛</button></li><li><button type="button" onclick="fnDeprChc('509','여천');">여천</button></li><li><button type="button" onclick="fnDeprChc('380','연무대');">연무대</button></li><li><button type="button" onclick="fnDeprChc('560','영광');">영광</button></li><li><button type="button" onclick="fnDeprChc('843','영덕');">영덕</button></li><li><button type="button" onclick="fnDeprChc('570','영암');">영암</button></li><li><button type="button" onclick="fnDeprChc('272','영월');">영월</button></li><li><button type="button" onclick="fnDeprChc('835','영주');">영주</button></li><li><button type="button" onclick="fnDeprChc('845','영천');">영천</button></li><li><button type="button" onclick="fnDeprChc('846','영천망정동');">영천망정동</button></li><li><button type="button" onclick="fnDeprChc('112','영통');">영통</button></li><li><button type="button" onclick="fnDeprChc('398','예산');">예산</button></li><li><button type="button" onclick="fnDeprChc('851','예천');">예천</button></li><li><button type="button" onclick="fnDeprChc('127','오산');">오산</button></li><li><button type="button" onclick="fnDeprChc('588','옥과');">옥과</button></li><li><button type="button" onclick="fnDeprChc('575','완도');">완도</button></li><li><button type="button" onclick="fnDeprChc('150','용인');">용인</button></li><li><button type="button" onclick="fnDeprChc('161','용인기흥역');">용인기흥역</button></li><li><button type="button" onclick="fnDeprChc('111','용인신갈(고가밑)');">용인신갈(고가밑)</button></li><li><button type="button" onclick="fnDeprChc('149','용인유림');">용인유림</button></li><li><button type="button" onclick="fnDeprChc('715','울산');">울산</button></li><li><button type="button" onclick="fnDeprChc('716','울산신복');">울산신복</button></li><li><button type="button" onclick="fnDeprChc('578','원동');">원동</button></li><li><button type="button" onclick="fnDeprChc('240','원주');">원주</button></li><li><button type="button" onclick="fnDeprChc('246','원주기업도시');">원주기업도시</button></li><li><button type="button" onclick="fnDeprChc('245','원주문막');">원주문막</button></li><li><button type="button" onclick="fnDeprChc('244','원주혁신');">원주혁신</button></li><li><button type="button" onclick="fnDeprChc('360','유성');">유성</button></li><li><button type="button" onclick="fnDeprChc('170','의정부');">의정부</button></li><li><button type="button" onclick="fnDeprChc('160','이천');">이천</button></li><li><button type="button" onclick="fnDeprChc('172','이천부발(신하리)');">이천부발(신하리)</button></li><li><button type="button" onclick="fnDeprChc('615','익산');">익산</button></li><li><button type="button" onclick="fnDeprChc('616','익산팔봉');">익산팔봉</button></li><li><button type="button" onclick="fnDeprChc('325','인삼랜드(휴)상행');">인삼랜드(휴)상행</button></li><li><button type="button" onclick="fnDeprChc('324','인삼랜드(휴)하행');">인삼랜드(휴)하행</button></li><li><button type="button" onclick="fnDeprChc('100','인천');">인천</button></li><li><button type="button" onclick="fnDeprChc('105','인천공항T1');">인천공항T1</button></li><li><button type="button" onclick="fnDeprChc('117','인천공항T2');">인천공항T2</button></li><li><button type="button" onclick="fnDeprChc('622','자치인재원');">자치인재원</button></li><li><button type="button" onclick="fnDeprChc('583','장성');">장성</button></li><li><button type="button" onclick="fnDeprChc('580','장흥');">장흥</button></li><li><button type="button" onclick="fnDeprChc('621','전북혁신');">전북혁신</button></li><li><button type="button" onclick="fnDeprChc('602','전주고속터미널');">전주고속터미널</button></li><li><button type="button" onclick="fnDeprChc('605','전주호남제일문');">전주호남제일문</button></li><li><button type="button" onclick="fnDeprChc('850','점촌');">점촌</button></li><li><button type="button" onclick="fnDeprChc('392','정산');">정산</button></li><li><button type="button" onclick="fnDeprChc('316','정안(휴)상행');">정안(휴)상행</button></li><li><button type="button" onclick="fnDeprChc('315','정안(휴)하행');">정안(휴)하행</button></li><li><button type="button" onclick="fnDeprChc('630','정읍');">정읍</button></li><li><button type="button" onclick="fnDeprChc('450','제천');">제천</button></li><li><button type="button" onclick="fnDeprChc('449','제천하소');">제천하소</button></li><li><button type="button" onclick="fnDeprChc('350','조치원');">조치원</button></li><li><button type="button" onclick="fnDeprChc('202','주문진');">주문진</button></li><li><button type="button" onclick="fnDeprChc('118','죽전');">죽전</button></li><li><button type="button" onclick="fnDeprChc('585','지도');">지도</button></li><li><button type="button" onclick="fnDeprChc('590','진도');">진도</button></li><li><button type="button" onclick="fnDeprChc('722','진주');">진주</button></li><li><button type="button" onclick="fnDeprChc('723','진주개양');">진주개양</button></li><li><button type="button" onclick="fnDeprChc('724','진주혁신');">진주혁신</button></li><li><button type="button" onclick="fnDeprChc('704','진해');">진해</button></li><li><button type="button" onclick="fnDeprChc('397','창기리');">창기리</button></li><li><button type="button" onclick="fnDeprChc('710','창원');">창원</button></li><li><button type="button" onclick="fnDeprChc('711','창원역');">창원역</button></li><li><button type="button" onclick="fnDeprChc('310','천안');">천안</button></li><li><button type="button" onclick="fnDeprChc('346','천안3공단');">천안3공단</button></li><li><button type="button" onclick="fnDeprChc('343','천안아산역');">천안아산역</button></li><li><button type="button" onclick="fnDeprChc('391','청양');">청양</button></li><li><button type="button" onclick="fnDeprChc('401','청주(센트럴)');">청주(센트럴)</button></li><li><button type="button" onclick="fnDeprChc('400','청주고속터미널');">청주고속터미널</button></li><li><button type="button" onclick="fnDeprChc('407','청주공항');">청주공항</button></li><li><button type="button" onclick="fnDeprChc('405','청주대정류소');">청주대정류소</button></li><li><button type="button" onclick="fnDeprChc('406','청주북부');">청주북부</button></li><li><button type="button" onclick="fnDeprChc('250','춘천');">춘천</button></li><li><button type="button" onclick="fnDeprChc('420','충주');">충주</button></li><li><button type="button" onclick="fnDeprChc('349','탕정삼성LCD');">탕정삼성LCD</button></li><li><button type="button" onclick="fnDeprChc('394','태안');">태안</button></li><li><button type="button" onclick="fnDeprChc('730','통영');">통영</button></li><li><button type="button" onclick="fnDeprChc('180','평택');">평택</button></li><li><button type="button" onclick="fnDeprChc('175','평택대');">평택대</button></li><li><button type="button" onclick="fnDeprChc('174','평택용이동');">평택용이동</button></li><li><button type="button" onclick="fnDeprChc('830','포항');">포항</button></li><li><button type="button" onclick="fnDeprChc('828','포항시청');">포항시청</button></li><li><button type="button" onclick="fnDeprChc('834','풍기');">풍기</button></li><li><button type="button" onclick="fnDeprChc('581','함평');">함평</button></li><li><button type="button" onclick="fnDeprChc('595','해남');">해남</button></li><li><button type="button" onclick="fnDeprChc('552','해제');">해제</button></li><li><button type="button" onclick="fnDeprChc('354','홍대조치원');">홍대조치원</button></li><li><button type="button" onclick="fnDeprChc('389','홍성');">홍성</button></li><li><button type="button" onclick="fnDeprChc('586','화순');">화순</button></li><li><button type="button" onclick="fnDeprChc('440','황간');">황간</button></li><li><button type="button" onclick="fnDeprChc('239','횡성(휴)상행');">횡성(휴)상행</button></li><li><button type="button" onclick="fnDeprChc('238','횡성(휴)하행');">횡성(휴)하행</button></li><li><button type="button" onclick="fnDeprChc('634','흥덕');">흥덕</button></li> -->
									</ul>
								</div>
								<div class="scroll-element scroll-x">
									<div class="scroll-element_outer">
										<div class="scroll-element_size"></div>
										<div class="scroll-element_track"></div>
										<div class="scroll-bar"></div>
									</div>
								</div>
								<div class="scroll-element scroll-y">
									<div class="scroll-element_outer">
										<div class="scroll-element_size"></div>
										<div class="scroll-element_track"></div>
										<div class="scroll-bar"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>


				<div class="place">
					<!-- focus -->
					<ul>
						<li id="popDeprChc" class="focuson">
							<!--  class="focuson" -->
							<div class="start-title">
								<span class="stit">출발지</span>
								<p class="text empty">
									<span class="val_txt" id="popDeprNmSpn"></span>
								</p>
							</div>
						</li>
						<li id="popArvlChc">
							<div class="end-title">
								<span class="stit">도착지</span>
								<p class="text empty">
									<span class="val_txt" id="popArvlNmSpn"></span>
								</p>
							</div>
						</li>
					</ul>
					<!-- <button type="button" class="btn_change" onclick="fnCrchDeprArvl();" id="chgDeprArvl">
						<span class="sr-only">출발지, 도착지 교체</span>
					</button> -->
				</div>
			</div>
			<div class="btns">
				<button type="button" data-remodal-action="confirm"
					class="remodal-confirm ready" id="cfmBtn" onclick="fncfmBtnChc()">선택완료</button>
			</div>
			<button type="button" data-remodal-action="close"
				class="remodal-close">
				<span class="sr-only">닫기</span>
			</button>
		</div>
	</div>
	<div class="remodal-wrapper remodal-is-closed" style="display: none;">
		<div class="remodal pop_fee remodal-is-initialized remodal-is-closed"
			data-remodal-id="popFee" role="dialog" tabindex="-1">

			<script>
				$("#readDeprInfoList, #readArvlInfoList").on("click", function () {
					fnDeprArvlViewList('all');
					$("#areaListAll").addClass("active");
				})
				
				function fnDeprArvlViewList(regionCode) {

					$("#areaListAll").removeClass("active");
					$(this).addClass("active");
					

					// 지역 코드별 역 목록
					const terminalMap = {
						"all": ["강릉", "강진", "경북도청", "고성", "광주", "광주터미널", "구미", "군산", "김제", "김천", 
								"김해", "남원", "논산", "대구", "대전", "동서울", "마산", "목포", "무안", "부산", "부천", "사천", 
								"서대전", "서울", "서울남부터미널", "성남", "속초", "순천", "안산", "양산", "양양", "여수", "영광", 
								"영덕", "영산포", "영암", "오산", "완도", "용인", "울산", "익산", "인천", "전주", "제주", "진도", 
								"진주", "창원", "천안", "청주", "춘천", "충주", "통영", "포항", "해남", "홍성", "화순"],
						"11": ["동서울", "서울경부", "센트럴시티(서울)"],
						"28": ["인천", "계양", "부평"],
						"42": ["춘천", "원주"],
						"30": ["대전", "천안", "청주"],
						"43": ["대구", "동성로", "칠곡"],
						"29": ["부산", "서면", "울산삼산"],
						"45": ["창원", "진주"],
						"26": ["광주상무", "목포", "제주"],
						"27": ["광주상무", "목포", "제주"]
					};

					const terminalList = [
						  { code: "200", name: "강릉" },
						  { code: "535", name: "강진" },
						  { code: "852", name: "경북도청" },
						  { code: "815", name: "경주" },
						  { code: "201", name: "경포해변" },
						  { code: "355", name: "고대조치원" },
						  { code: "116", name: "고양백석" },
						  { code: "635", name: "고창" },
						  { code: "540", name: "고흥" },
						  { code: "320", name: "공주" },
						  { code: "520", name: "광양" },
						  { code: "500", name: "광주(유·스퀘어)" },
						  { code: "503", name: "광주비아" },
						  { code: "422", name: "교통대" },
						  { code: "519", name: "구례" },
						  { code: "169", name: "구리" },
						  { code: "810", name: "구미" },
						  { code: "610", name: "군산" },
						  { code: "330", name: "금산" },
						  { code: "620", name: "김제" },
						  { code: "735", name: "김해" },
						  { code: "736", name: "김해장유" },
						  { code: "530", name: "나주" },
						  { code: "531", name: "나주혁신" },
						  { code: "824", name: "낙동강(휴)상행" },
						  { code: "823", name: "낙동강(휴)하행" },
						  { code: "625", name: "남원" },
						  { code: "390", name: "내포" },
						  { code: "545", name: "녹동" },
						  { code: "370", name: "논산" },
						  { code: "587", name: "능주" },
						  { code: "582", name: "담양" },
						  { code: "312", name: "당진" },
						  { code: "388", name: "당진기지시" },
						  { code: "807", name: "대구용계" },
						  { code: "307", name: "대전도룡" },
						  { code: "300", name: "대전복합" },
						  { code: "305", name: "대전청사(샘머리)" },
						  { code: "399", name: "덕산스파" },
						  { code: "525", name: "동광양(중마)" },
						  { code: "801", name: "동대구" },
						  { code: "032", name: "동서울" },
						  { code: "210", name: "동해" },
						  { code: "705", name: "마산" },
						  { code: "706", name: "마산내서" },
						  { code: "505", name: "목포" },
						  { code: "550", name: "무안" },
						  { code: "337", name: "배방정류소" },
						  { code: "555", name: "벌교" },
						  { code: "395", name: "보령" },
						  { code: "554", name: "보성" },
						  { code: "700", name: "부산" },
						  { code: "220", name: "삼척" },
						  { code: "221", name: "삼척해변" },
						  { code: "825", name: "상주" },
						  { code: "805", name: "서대구" },
						  { code: "703", name: "서부산(사상)" },
						  { code: "393", name: "서산" },
						  { code: "010", name: "서울경부" },
						  { code: "419", name: "서충주" },
						  { code: "347", name: "선문대" },
						  { code: "813", name: "선산(휴)상행" },
						  { code: "812", name: "선산(휴)하행" },
						  { code: "900", name: "고성" },
						  { code: "901", name: "광주" },
						  { code: "902", name: "광주터미널" },
						  { code: "904", name: "김천" },
						  { code: "906", name: "대구" },
						  { code: "907", name: "대전" },
						  { code: "909", name: "사천" },
						  { code: "910", name: "서대전" },
						  { code: "911", name: "서울" },
						  { code: "912", name: "서울남부터미널" },
						  { code: "913", name: "성남" },
						  { code: "914", name: "속초" },
						  { code: "915", name: "순천" },
						  { code: "916", name: "안산" },
						  { code: "917", name: "양산" },
						  { code: "918", name: "양양" },
						  { code: "919", name: "여수" },
						  { code: "920", name: "영광" },
						  { code: "921", name: "영덕" },
						  { code: "922", name: "영산포" },
						  { code: "923", name: "영암" },
						  { code: "924", name: "오산" },
						  { code: "925", name: "완도" },
						  { code: "926", name: "용인" },
						  { code: "928", name: "익산" },
						  { code: "930", name: "전주" },
						  { code: "931", name: "제주" },
						  { code: "932", name: "진도" },
						  { code: "933", name: "진주" },
						  { code: "934", name: "창원" },
						  { code: "935", name: "천안" },
						  { code: "936", name: "청주" },
						  { code: "937", name: "춘천" },
						  { code: "938", name: "충주" },
						  { code: "939", name: "통영" },
						  { code: "940", name: "포항" },
						  { code: "941", name: "해남" },
						  { code: "942", name: "홍성" },
						  { code: "943", name: "화순" },
						  { code: "012", name: "센트럴시티(서울)" },
						  { code: "013", name: "계양" },
						  { code: "014", name: "부평" },
						  { code: "015", name: "원주" },
						  { code: "018", name: "동성로" },
						  { code: "019", name: "칠곡" },
						  { code: "020", name: "서면" },
						  { code: "023", name: "광주상무" }
						];


					// 선택한 지역의 극장 목록 가져오기
					const terminals = terminalMap[regionCode] || [];

					// ul 내부 내용 교체
					function getCodeByName(name) {
						const terminal = terminalList.find(t => t.name === name);
						return terminal ? terminal.code : "";
					}


					// ul 내부 내용 생성 (code와 name 모두 넘김)
					const listHtml = terminals.map(name => {
						const code = getCodeByName(name);
						return `<li><button type="button" onclick="fnDeprChc('\${code}','\${name}');">\${name}</button></li>`;
					}).join("");
					
					$("#tableTrmList").html(listHtml);
				}

				let isSelectingDepr = true;

				$("#readDeprInfoList").on("click", function() {
					isSelectingDepr = true;
				});

				$("#readArvlInfoList").on("click", function() {
					isSelectingDepr = false;
				});


				let arvlCode = null;
				let arvlName = null;
				let deprCode = null;
				let deprName = null;

				function fnDeprChc(code, name) {
					let selectedCode = code;
					let selectedName = name;
					

					if (isSelectingDepr) {
						// 출발지 선택 시
						deprCode = code;
						deprName = name;

						$("#popDeprNmSpn").text(deprName);
						$("#deprCd").val(deprCode);
					} else {
						// 도착지 선택 시
						arvlCode = code;
						arvlName = name;

						$("#popArvlNmSpn").text(arvlName);
						$("#arvlCd").val(arvlCode);
					}


				}

				// function fncfmBtnChc() {

				// 	if (isSelectingDepr) {
				// 		$("#readDeprInfoList > p").removeClass("empty");
				// 		$("#deprNmSpn").text(deprName);
				// 	} else {
				// 		$("#readArvlInfoList > p").removeClass("empty");
				// 		$("#arvlNmSpn").text(arvlName);
				// 	}
				// }

			</script>


			<div class="title">
				<h2>취소수수료 안내</h2>
			</div>
			<div class="cont">
				<div class="tbl_type1">
					<table class="MsoNormalTable __se_tbl table_type2" border="0"
						cellspacing="0" cellpadding="0" _se2_tbl_template="14">
						<caption>승차권 취소수수료에 대한 정보 제공</caption>
						<colgroup>
							<col style="width: 40%;">
							<col style="width: 20%;">
							<col style="width: 20%;">
							<col style="width: 20%;">
						</colgroup>
						<thead>
							<tr>
								<th class=" undraggable" colspan="4" scope="col">
									<p align="center" class="MsoNormal">
										<b><span>개정(25.5.1일부터)</span></b>
									</p>
								</th>
							</tr>
							<tr>
								<th class=" undraggable" scope="col">
									<p align="center" class="MsoNormal">
										<b><span style="color: #000; font-size: 10pt;">구분</span></b>
									</p>
								</th>
								<th class=" undraggable" scope="col">
									<p align="center" class="MsoNormal">
										<b><span style="color: #000; font-size: 10pt;">월~목</span></b>
									</p>
								</th>
								<th class=" undraggable" scope="col">
									<p align="center" class="MsoNormal">
										<b><span style="color: #000; font-size: 10pt;">금~일<br>공휴일
										</span></b>
									</p>
								</th>
								<th class=" undraggable" scope="col">
									<p align="center" class="MsoNormal">
										<b><span style="color: #000; font-size: 10pt;">명절<br>(설,추석)
										</span></b>
									</p>
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>2일전</span>
										</p>
								</b></td>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>0%</span>
										</p>
								</b></td>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>0%</span>
										</p>
								</b></td>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>0%</span>
										</p>
								</b></td>
							</tr>
							<tr>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>1일전 ~ 3시간 이전</span>
										</p>
								</b></td>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>5%</span>
										</p>
								</b></td>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>7.50%</span>
										</p>
								</b></td>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>10%</span>
										</p>
								</b></td>
							</tr>
							<tr class="type2">
								<td><b>
										<p align="center" class="MsoNormal">
											<span>3시간 미만 ~ 출발 전</span>
										</p>
								</b></td>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>10%</span>
										</p>
								</b></td>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>15%</span>
										</p>
								</b></td>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>20%</span>
										</p>
								</b></td>
							</tr>
							<tr>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>출발 후 ~ 도착예정시간 이전</span>
										</p>
								</b></td>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>25년: 50%<br>26년 : 60%<br>27년 : 70%
											</span>
										</p>
								</b></td>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>25년: 50%<br>26년 : 60%<br>27년 : 70%
											</span>
										</p>
								</b></td>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>25년: 50%<br>26년 : 60%<br>27년 : 70%
											</span>
										</p>
								</b></td>
							</tr>
							<tr>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>도착예정시간 초과</span>
										</p>
								</b></td>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>100%</span>
										</p>
								</b></td>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>100%</span>
										</p>
								</b></td>
								<td><b>
										<p align="center" class="MsoNormal">
											<span>100%</span>
										</p>
								</b></td>
							</tr>
						</tbody>
					</table>
					<p style="font-size: 14px; color: #000; margin-top: 15px;">* 명절
						취소수수료 기준은 설/추석 전전일, 전일, 당일 및 다음날에 적용합니다.</p>
					<p style="font-size: 14px; color: #000;">* 출발 이후부터 도착예정시간까지의
						취소수수료 기준은 `25년 5월1일부터 `26년 4월30일까지는 50%, `26년 5월1일부터 `27년 4월30일까지는
						60%, `27년 5월1일부터는 70%를 적용한다.</p>
					<p style="font-size: 14px; color: #000;">* 지정차 출발 당일에 승차권을 발행한
						경우는 발행시점 기준 1시간 이내까지 취소수수료 미부과 (단, 지정차 출발 이후에는 승차권 발행시점과 상관없이
						취소수수료 부과)</p>
				</div>
				<ul class="desc_list">
					<li>당일출발 차량의 경우 출발시간 1시간 전까지 홈페이지 예매가 가능하며 1시간 미만 출발임박 차량의 예매를
						원하시면 <span class="txt_puple">[고속버스 모바일앱]</span>에서 예매하시기 바랍니다.
					</li>
					<li>1회 최대 예매 매수는 6매입니다.(일부 시외우등 노선에 한정하여 10매까지 예매가능)</li>
					<li>일반고속 청소년(중, 고등학생 등) 할인은 터미널 현장에서 신분확인 절차 시 학생증, 청소년증,
						주민등록증 이외 나이를 확인할 수 있는 증서(운전면허증, 여권 등)를 제시해야만 할인 적용을 받을 수 있으니 탑승시 꼭
						소지하여 주시기 바랍니다.</li>
					<li>할인 승차권 부정 사용 시 운임의 10배 부가운임을 요구할 수 있습니다.</li>
					<li>사용하지 않은 모든 승차권은 지정차 출발 후 도착예정시간이 지나면 환불하실 수 없습니다.</li>
					<li>취소수수료 산정은 날짜를 기준(시간 기준이 아님)으로 합니다.</li>
					<li>홈페이지 예매 후 창구에서 발권 시 예매에 사용한 신용카드를 반드시 지참하셔야 합니다.</li>
				</ul>
			</div>
			<div class="btns">
				<a href="javascript:void(0)" data-remodal-action="cancel"
					class="remodal-cancel">취소</a> <a href="javascript:void(0)"
					data-remodal-action="confirm" class="remodal-confirm"
					onclick="fnPopFeeAgrm();">동의</a>
			</div>
			<button type="button" data-remodal-action="close"
				class="remodal-close">
				<span class="sr-only">닫기</span>
			</button>
		</div>
	</div>
	<div class="remodal-wrapper remodal-is-closed" style="display: none;">
		<div id="ctyPrmmDcInf"
			class="remodal pop_gradeinfo remodal-is-initialized remodal-is-closed"
			data-remodal-id="popGradeinfo" role="dialog" tabindex="-1">
			<!--  -->
			<div class="title">
				<h2>시외노선 우등형 할인 안내</h2>
			</div>
			<div class="cont">
				<p class="tbl_desc">
					예매하시려는 노선은 우등 형 할인혜택이 제공되는 시외노선입니다.<br>우등등급에 한정하여 예매 시 할인이
					제공되며 상세조건은 아래와 같습니다.
				</p>
				<div class="tbl_type1">
					<table>
						<caption>시외노선 우등형 할인 안내</caption>
						<colgroup>
							<col style="width: 15%;">
							<col style="width: auto">
							<col style="width: 30%;">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">구분</th>
								<th scope="col">내용</th>
								<th scope="col">할인율</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">사전예매</th>
								<td>
									<ul class="desc_list">
										<li>차량 출발일 2일(48시간) 전까지 예매한 경우</li>
										<li>최대 예매 승차권수는 10매로 제한</li>
									</ul>
								</td>
								<td><span class="accent show_mo">할인율 : </span>우등버스 정상요금의
									10%</td>
							</tr>
							<tr>
								<th scope="row">단체예매</th>
								<td>
									<ul class="desc_list">
										<li>단체승객(5인 이상 10인 이하)이 승차권을 사전 예매한 경우</li>
										<li>최대 예매 승차권수는 10매로 제한</li>
									</ul>
								</td>
								<td><span class="accent show_mo">할인율 : </span>우등버스 정상요금의
									10%</td>
							</tr>
							<tr>
								<th scope="row">왕복예매</th>
								<td>
									<ul class="desc_list">
										<li>동일 노선/구간의 왕복 승차권을 예매한 경우</li>
										<li>왕복 각각 동일한 할인율을 적용</li>
										<li>최대 예매 승차권수는 10매로 제한</li>
									</ul>
								</td>
								<td><span class="accent show_mo">할인율 : </span>우등버스 정상요금의
									10%<span class="line_block">(편도 각 10%)</span></td>
							</tr>



						</tbody>
					</table>
				</div>
				<ul class="desc_list">
					<li>할인혜택은 성인 승차권 예매 기준입니다. (아동/중고생은 제외)</li>
					<li>사전에 홈페이지와 모바일앱 예매를 이용한 승객에게만 적용됩니다.(터미널 현장 발권은 대상제외. 단,
						뒷좌석 예매는 예외)</li>
					<li>명절 연휴 특송기간(설, 추석 등)은 할인이 적용되지 않습니다.</li>
					<li>할인 적용된 우등버스 요금이 일반ㆍ직행 버스 요금보다 낮을 경우, 일반ㆍ직행 버스 요금을 적용하게
						됩니다.</li>
					<li>왕복할인/단체할인을 적용하여 홈페이지 예매 완료 시 매수변경이 불가하니 유의하시기 바랍니다.</li>
					<li>할인 적용 시에는 신용카드결제만 가능합니다.</li>
				</ul>
			</div>
			<div class="btns">
				<button type="button" data-remodal-action="cancel"
					class="remodal-cancel">취소</button>
				<button type="button" class="remodal-confirm"
					data-remodal-action="confirm" onclick="fnRotAdPopup();">예매진행</button>
			</div>
			<button type="button" data-remodal-action="close"
				class="remodal-close">
				<span class="sr-only">닫기</span>
			</button>
		</div>
	</div>
	<div class="remodal-wrapper remodal-is-closed" style="display: none;">
		<div
			class="remodal pop_route remodal-is-initialized remodal-is-closed"
			data-remodal-id="popRoute1" role="dialog" tabindex="-1">
			<div class="title">
				<h2>노선조회안내</h2>
			</div>
			<div class="cont">
				<ul class="txt">
					<!-- 			<li><strong>1. 요금할인</strong> -->
					<!-- 				<ul class="desc_list"> -->
					<!-- 					<li>요금인상 없이 종전 요금 이용</li> -->
					<!-- 				</ul> -->
					<!-- 			</li> -->
					<li><strong>1. 제휴할인 서비스</strong>
						<ul class="desc_list">
							<li>강릉지역 렌터카 및 맛집, 카페 등 이용할인</li>
							<li><a
								href="/cscn/ntcmttr/readNtc.do?ntcNo=20190226001"
								title="새창열림" target="_blank" class="accent">이용방법 및 업체 상세보기
									&gt;</a></li>
						</ul></li>
					<li><strong>2. 프리미엄 버스 확대 운행</strong>
						<ul class="desc_list">
							<li>월~목 10%, 금~일 5% 할인 시행 중</li>
							<!-- <li>주말 이용 시 마일리지 미 적립</li> -->
						</ul></li>
				</ul>
			</div>
			<div class="btns">
				<button type="button" data-remodal-action="confirm"
					class="remodal-confirm" onclick="fnRotVldChc();">확인</button>
			</div>
			<button type="button" data-remodal-action="close"
				class="remodal-close">
				<span class="sr-only">닫기</span>
			</button>
		</div>
	</div>
	<div class="remodal-wrapper remodal-is-closed" style="display: none;">
		<div
			class="remodal pop_route remodal-is-initialized remodal-is-closed"
			data-remodal-id="popRoute2" role="dialog" tabindex="-1">
			<div class="title">
				<h2>노선조회안내</h2>
			</div>
			<div class="cont">
				<ul class="txt">
					<!-- 			<li><strong>1. 요금 변경 안내</strong> -->
					<!-- 				<ul class="desc_list"> -->
					<!-- 					<li>2020년 7월 10일부터 변경된 할인율 적용</li> -->
					<!-- 				</ul> -->
					<!-- 			</li> -->
					<!-- 			<li><strong>1. 요금할인</strong> -->
					<!-- 				<ul class="desc_list"> -->
					<!-- 					<li>평균 25% 요금할인으로 이용</li> -->
					<!-- 				</ul> -->
					<!-- 			</li> -->
					<li><strong>제휴할인 서비스</strong>
						<ul class="desc_list">
							<li>강릉지역 렌터카 및 맛집, 카페 등 이용할인</li>
							<li><a
								href="/cscn/ntcmttr/readNtc.do?ntcNo=20190226001"
								title="새창열림" target="_blank" class="accent">이용방법 및 업체 상세보기
									&gt;</a><br> '코버스' 홈페이지 공지사항<br> '강원도 노선업무 제휴 업체 리스트' 참조</li>
						</ul></li>
					<li id="popRoute2_txt" style="display: none;"><strong>롯데렌터카
							업무제휴</strong>
						<ul class="desc_list">
							<li>해당 노선 이용시 롯데렌터카 렌트비 50% 할인!<br>(2018년 11월 15일부터)
							</li>
							<li>문의 : 033) 642-8000(강릉), 033) 632-8000(속초)</li>
							<li>많은 이용 바랍니다. 감사합니다.</li>
						</ul></li>
				</ul>
			</div>
			<div class="btns">
				<button type="button" data-remodal-action="confirm"
					class="remodal-confirm" onclick="fnRotVldChc();">확인</button>
			</div>
			<button type="button" data-remodal-action="close"
				class="remodal-close">
				<span class="sr-only">닫기</span>
			</button>
		</div>
	</div>
	<div class="remodal-wrapper remodal-is-closed" style="display: none;">
		<div
			class="remodal pop_route remodal-is-initialized remodal-is-closed"
			data-remodal-id="popRoute3" role="dialog" tabindex="-1">
			<div class="title">
				<h2>노선조회안내</h2>
			</div>
			<div class="cont">
				<ul class="txt">
					<li><strong>제휴할인 서비스</strong>
						<ul class="desc_list">
							<li><span id="arvlNmSpan3"></span>지역 렌터카 이용할인</li>
							<li><a
								href="/cscn/ntcmttr/readNtc.do?ntcNo=20190226001"
								title="새창열림" target="_blank" class="accent">이용방법 및 업체 상세보기
									&gt;</a></li>
						</ul></li>
				</ul>
			</div>
			<div class="btns">
				<button type="button" data-remodal-action="confirm"
					class="remodal-confirm" onclick="fnRotVldChc();">확인</button>
			</div>
			<button type="button" data-remodal-action="close"
				class="remodal-close">
				<span class="sr-only">닫기</span>
			</button>
		</div>
	</div>
	<div class="remodal-wrapper remodal-is-closed" style="display: none;">
		<div
			class="remodal pop_route remodal-is-initialized remodal-is-closed"
			data-remodal-id="popRoute4" role="dialog" tabindex="-1">
			<div class="title">
				<h2>노선조회안내</h2>
			</div>
			<div class="cont">
				<ul class="txt">
					<li><strong>1. 프리미엄 버스 운행 개시</strong>
						<ul class="desc_list">
							<li>최고급 버스를 15% 할인된 금액으로 상시 이용 가능</li>
							<li>주말 이용 시 마일리지 미적립</li>
						</ul></li>
					<li><strong>2. 제휴할인 서비스</strong>
						<ul class="desc_list">
							<li><span id="arvlNmSpan4"></span>지역 렌터카 이용할인</li>
							<li><a
								href="/cscn/ntcmttr/readNtc.do?ntcNo=20190226001"
								title="새창열림" target="_blank" class="accent">이용방법 및 업체 상세보기
									&gt;</a></li>
						</ul></li>
				</ul>
			</div>
			<div class="btns">
				<button type="button" data-remodal-action="confirm"
					class="remodal-confirm" onclick="fnRotVldChc();">확인</button>
			</div>
			<button type="button" data-remodal-action="close"
				class="remodal-close">
				<span class="sr-only">닫기</span>
			</button>
		</div>
	</div>
	<div class="remodal-wrapper remodal-is-closed" style="display: none;">
		<div
			class="remodal pop_route remodal-is-initialized remodal-is-closed"
			data-remodal-id="popRoute5" role="dialog" tabindex="-1">
			<div class="title">
				<h2>노선조회안내</h2>
			</div>
			<div class="cont">
				<ul class="txt">
					<li><strong>제휴할인 서비스</strong>
						<ul class="desc_list">
							<li>속초지역 렌터카 및 맛집, 카페 등 이용할인</li>
							<li><a
								href="/cscn/ntcmttr/readNtc.do?ntcNo=20190226001"
								title="새창열림" target="_blank" class="accent">이용방법 및 업체 상세보기
									&gt;</a></li>
						</ul></li>
					<li><strong>롯데렌터카 업무제휴</strong>
						<ul class="desc_list">
							<li>해당 노선 이용시 롯데렌터카 렌트비 50% 할인!<br>(2018년 11월 15일부터)
							</li>
							<li>문의 : 033) 642-8000(강릉), 033) 632-8000(속초)</li>
							<li>많은 이용 바랍니다. 감사합니다.</li>
						</ul></li>
				</ul>
			</div>
			<div class="btns">
				<button type="button" data-remodal-action="confirm"
					class="remodal-confirm" onclick="fnRotVldChc();">확인</button>
			</div>
			<button type="button" data-remodal-action="close"
				class="remodal-close">
				<span class="sr-only">닫기</span>
			</button>
		</div>
	</div>
	<div class="remodal-wrapper remodal-is-closed" style="display: none;">
		<div
			class="remodal pop_route remodal-is-initialized remodal-is-closed"
			data-remodal-id="popRoute6" role="dialog" tabindex="-1">
			<div class="title">
				<h2>제휴할인 서비스</h2>
			</div>
			<div class="cont">
				<ul class="txt">
					<li><strong>제휴할인 서비스</strong>
						<ul class="desc_list">
							<li>원주지역 렌터카 및 영화, 식당 등 이용할인</li>
							<li><a
								href="/cscn/ntcmttr/readNtc.do?ntcNo=20190226001"
								title="새창열림" target="_blank" class="accent">이용방법 및 업체 상세보기
									&gt;</a></li>
						</ul></li>
				</ul>
			</div>
			<div class="btns">
				<button type="button" data-remodal-action="confirm"
					class="remodal-confirm" onclick="fnRotVldChc();">확인</button>
			</div>
			<button type="button" data-remodal-action="close"
				class="remodal-close">
				<span class="sr-only">닫기</span>
			</button>
		</div>
	</div>
	<div class="remodal-wrapper remodal-is-closed" style="display: none;">
		<div
			class="remodal pop_route remodal-is-initialized remodal-is-closed"
			data-remodal-id="popTmpTml" role="dialog" tabindex="-1">
			<div class="title">
				<h2>광양 임시터미널 안내</h2>
			</div>
			<div class="cont">
				<ul class="txt">
					<li><strong>광양 임시터미널(인동숲 주차장) 안내</strong>
						<p style="margin-top: 10px;">
							<img src="/koBus/images/pop_img01.png"
								alt="광양임시터미널 - 타이어뱅크와 국민은행 사이 옆길 진입도" width="640">
						</p></li>
					<li><strong>광양 임시터미널 승차홈</strong>
						<p>
							<img src="/koBus/images/pop_img02.png"
								alt="광양임시터미널 승차홈별 지역(상세 다음 참고)" width="640">
						</p>
						<div class="sr-only">
							<ul>
								<li>1승차홈 : 서울(센트럴), 동서울, 대전, 청주, 통영</li>
								<li>2승차홈 : 광주, 목포, 인천공항</li>
								<li>3승차홈 : 동광양, 대구/부천, 성남/수원, 안산/안양, 인천/전주</li>
								<li>4승차홈 : 경주, 노포, 동래, 부산사상, 포항</li>
								<li>5승차홈 : 김해, 남해, 마산, 울산, 진교, 진주</li>
								<li>6승차홈 : 광영/녹동, 순천/여천, 여수/완도, 태인도, 해남</li>
							</ul>
						</div>
						<p></p></li>
				</ul>
			</div>
			<div class="btns">
				<button type="button" data-remodal-action="confirm"
					class="remodal-confirm" onclick="fnRotVldChc();">확인</button>
			</div>
			<button type="button" data-remodal-action="close"
				class="remodal-close">
				<span class="sr-only">닫기</span>
			</button>
		</div>
	</div>
</body>
</html>