<%@ page trimDirectiveWhitespaces="true" language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!-- saved from url=(0031)/main.do -->
<html lang="ko" class="pc">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">

<title>고속버스통합예매</title>

<link rel="shortcut icon" href="/images/favicon.ico">
<link rel="stylesheet" type="text/css"
	href="/koBus/css/common/ui.jqgrid.custom.css">
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script>
	$(function() {

		$("#startdate_btn").click(function() {
			$("#datepicker1").datepicker("show");
		});

		$("#enddate_btn").click(function() {
			$("#datepicker2").datepicker("show");
		});

	});
</script>

<style>
#datepicker1, #datepicker2 {
	display: none;
}
</style>


<script type="text/javascript" src="/koBus/js/common/ui.js"></script>
<script type="text/javascript" src="/koBus/js/common/plugin.js"></script>
<script type="text/javascript" src="/koBus/js/common/common.js"></script>

<script type="text/javascript" src="/koBus/js/common/jquery.number.js"></script>
<script type="text/javascript" src="/koBus/js/common/security.js"></script>


<link rel="stylesheet" type="text/css"
	href="/koBus/css/common/style.css">
<script type="text/javascript" src="/koBus/js/common/new-kor-ui.js"></script>

<script type="text/javascript" src="/koBus/js/common/RotInfPup.js"></script>
<script type="text/javascript" src="/koBus/js/common/RotInf.js"></script>
<script type="text/javascript" src="/koBus/js/MrsCfmLgn.js"></script>

</head>
<%@ include file="common/header.jsp" %>

		<!-- breadcrumb -->

		<nav id="new-kor-breadcrumb">
			<div class="container">

				<ol class="breadcrumb-list">
					<li><i class="ico ico-home"></i><span class="sr-only">홈</span></li>

					<li>
						<div class="dropdown-wrap breadcrumb-select">





							<a href="javascript:void(0)" class="btn-dropdown" title="대메뉴 선택"
								aria-expanded="false"> <span class="text">운행정보</span><i
								class="ico ico-dropdown-arrow"></i></a>













							<ul class="dropdown-list" style="display: none;">






								<li><a href="https://www.kobus.co.kr/mrs/rotinf.do">고속버스예매</a></li>










								<li class="selected"><a href="javascript:void(0)"
									title="선택됨">운행정보</a></li>






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
								aria-expanded="false"> <span class="text">시간표 조회</span><i
								class="ico ico-dropdown-arrow"></i></a>
							<ul class="dropdown-list" style="display: none;">
								<li class="selected"><a href="javascript:void(0)"
									title="선택됨">시간표 조회</a></li>
								<li><a
									href="https://www.kobus.co.kr/oprninf/arscgd/oprnArscGd.do">도착시간
										안내</a></li>
							</ul>
						</div>
					</li>
				</ol>

			</div>
		</nav>


		<article id="new-kor-content" class="full">

			<script type="text/javascript"
				src="/koBus/js/OprnAlcnInqr.js"></script>
			<script type="text/javascript"
				src="/koBus/js/OprnAlcnInqrPup.js"></script>

			<!-- 출/도착지 선택 레이어팝업 -->


			<form name="rotInfFrm" id="rotInfFrm" method="post"
				action="https://www.kobus.co.kr/oprninf/alcninqr/readAlcnSrch.ajax">
				<input type="hidden" name="deprCd" id="deprCd" value="">
				<!-- 출발지코드 -->
				<input type="hidden" name="deprNm" id="deprNm" value="">
				<!-- 출발지명 -->
				<input type="hidden" name="arvlCd" id="arvlCd" value="">
				<!-- 도착지코드 -->
				<input type="hidden" name="arvlNm" id="arvlNm" value="">
				<!-- 도착지명 -->
				<input type="hidden" name="crchDeprArvlYn" id="crchDeprArvlYn"
					value="N">
				<!-- 출도착지 스왑여부 -->
				<input type="hidden" name="deprDtm" id="deprDtm" value="20250616">
				<!-- 가는날(편도,왕복) -->
				<input type="hidden" name="busClsCd" id="busClsCd" value="0">
				<!-- 버스등급 -->
				<input type="hidden" name="prmmDcYn" id="prmmDcYn" value="N">
				<!-- 시외우등할인대상노선 -->
			</form>
			<div class="title_wrap drivingInfoT" style="display: none;">

				<a href="https://www.kobus.co.kr/oprninf/alcninqr/oprnAlcnPage.do#"
					class="back">back</a> <a
					href="https://www.kobus.co.kr/oprninf/alcninqr/oprnAlcnPage.do#"
					class="mo_toggle">메뉴</a>


				<h2>시간표조회</h2>
			</div>


			<!-- 타이틀 -->
			<div class="content-header" data-page-title="시간표조회 | 운행정보 | 고속버스통합예매">
				<div class="container">
					<div class="title-area">
						<h2 class="page-title">시간표조회</h2>
					</div>
				</div>
			</div>

			<div class="content-body time_table">
				<div class="container">

					<!-- <a href="javascript:void(0)"  class="bnr_app bnr_pc">모바일에서도 언제 어디서나 도착시간 조회! <strong>고속버스 모바일앱</strong></a> -->
					<div class="bnr_app bnr_pc">
						모바일에서도 언제 어디서나 도착시간 조회! <strong>고속버스 모바일앱</strong>
					</div>
					<div class="route_box clfix">
						<ul class="place">
							<li><a href="javascript:void(0)" id="readDeprInfoList"
								onclick="fnReadDeprInfoList(event);"> <span class="name">출발지</span>
									<p class="text empty">
										<span class="empty_txt">선택</span><span class="val_txt"
											id="deprNmSpn"></span>
									</p> <!-- 값이 있을경우 p에 'empty' class가 없음 -->
							</a>
								<p class="btn_change" onclick="fnCrchDeprArvl();">출,도착지 교체</p></li>
							<li><a href="javascript:void(0)" id="readArvlInfoList"
								onclick="fnReadArvlInfoList(event);"> <span class="name">도착지</span>
									<p class="text empty">
										<span class="empty_txt">선택</span><span class="val_txt"
											id="arvlNmSpn"></span>
									</p> <!-- 값이 없을경우 p에 'empty' class가 있음 -->
							</a></li>
						</ul>
						<ul class="date">
							<li>
								<div class="date_picker_wrap">
									<span class="name">가는날</span> <input type="text"
										id="datepicker1" tabindex="-1" title="가는날"
										readonly="true">
									<!-- <button type="button" class="datepicker-btn"
										id="startdate_btn">
										<img class="ui-datepicker-trigger"
											src="/koBus/images/ico_calender.png" alt="가는날 선택 달력">
									</button> -->
									<label for="datepicker1" class="text_date text_date1">2025. 6. 7. 토</label>
									<span class="date_wrap"> <a
										href="javascript:void(0)" id="deprThddChc"
										class="active"
										onclick="fnYyDtmStup(0,'text_date1','0');" title="선택됨">오늘</a>
										<a href="javascript:void(0)" id="deprNxdChc"
										onclick="fnYyDtmStup(1,'text_date1','0');">내일</a>
									</span>
								</div>
							</li>
						</ul>
						<div class="box_inputForm click_box inselect">
							<strong class="name">등급</strong>
							<!-- 170117 class명 추가 -->


							<!-- 웹 접근성 개선 셀렉트 박스 UI -->

							<div class="dropdown-wrap select-default">
								<a href="javascript:void(0)" class="btn-dropdown"
									title="출발터미널 선택" aria-expanded="false"> <span class="text">전체등급</span></a>
								<ul class="dropdown-list" style="display: none;">
									<li><a href="javascript:fnBusClsCd(&#39;0&#39;)">전체등급</a></li>
									<li><a href="javascript:fnBusClsCd(&#39;7&#39;)">프리미엄</a></li>
									<li><a href="javascript:fnBusClsCd(&#39;1&#39;)">우등</a></li>
									<li><a href="javascript:fnBusClsCd(&#39;2&#39;)">일반</a></li>
								</ul>
							</div>

						</div>
						<p class="check" id="alcnSrchBtn">
							<button type="button" class="btn_confirm ready"
								onclick="fnAlcnSrch();">조회하기</button>
						</p>
					</div>

					<!-- 조회결과 -->
					<div class="drive_info_wrap" name="readAlcnInqr" id="readAlcnInqr"
						style="display: none;">
						<p class="drive_info accent" id="takeDrtm"></p>
						<div class="detailBox">
							<div class="detailBox_body clfix">
								<ul class="time" id="timelistChk">
								</ul>
								<div class="bustime_wrap" role="table"
									aria-label="시간표조회에 대한 목록이며 출발, 고속사, 등급, 어른요금, 초등생요금, 중고생요금, 잔여석/총좌석 정보 제공">
									<p class="bustime_head" role="row">
										<span id="start_time_header" class="start_time"
											role="columnheader">출발시각</span>
										<!-- 170119 텍스트수정 -->
										<span id="bus_info_header" class="bus_info"
											role="columnheader">고속사/등급</span>
										<!-- tablet / mobile 사이즈에서 보임 -->
										<span id="bus_com_header" class="bus_com" role="columnheader">고속사</span>
										<!-- pc 사이즈에서만 보임 -->
										<span id="grade_header" class="grade" role="columnheader">등급</span>
										<!-- pc 사이즈에서만 보임 -->
										<span id="adult_haeder" class="adult" role="columnheader">어른요금</span>
										<span id="child_header" class="child" role="columnheader">초등생요금</span>
										<span id="youth_header" class="youth" role="columnheader">
											중고생요금</span> <span id="remain_header" class="remain"
											role="columnheader">잔여석 <span class="total_seat">/
												총 좌석</span></span>
									</p>

									<div class="bus_time" id="alcnList" role="row"
										aria-rowindex="1">
										<!-- 동양고속 class="dyexpress" 삼화고속 class="samhwa" 중앙고속 class="jabus" 금호고속 class="kumho" 천일고속 class="chunil" 한일고속 class="hanil" 동부고속 class="dongbu" 금호속리산고속 class="songnisan" 코버스 class="kobus" -->
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- // 조회결과 -->
					<div class="section">
						<ul class="desc_list">
							<li>실시간 운행상태 조회를 위해서는 <a
								href="https://www.kobus.co.kr/oprninf/arscgd/oprnArscGd.do"
								class="accent">도착시간 안내 메뉴</a>를 이용하시기 바랍니다.
							</li>
							<li>심야 고속ㆍ우등ㆍ프리미엄의 요금은 당일 22:00부터 익일 04:00사이 출발차량</li>
						</ul>
					</div>
					<!-- <a href="javascript:void(0)" class="bnr_app bnr_mo">모바일에서도 언제 어디서나 도착시간 조회! <strong>고속버스 모바일앱</strong></a> -->
					<!-- 1103 -->
					<div class="bnr_app bnr_mo">
						모바일에서도 언제 어디서나 도착시간 조회! <strong>고속버스 모바일앱</strong>
					</div>
				</div>

			</div>

		</article>

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
					
					getRotLinInf(regionCode);
					

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
</body>
</html>