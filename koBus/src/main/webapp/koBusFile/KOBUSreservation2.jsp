<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
System.out.println(">> deprDate: " + request.getParameter("deprDtmAll"));
System.out.println(">> deprName: " + request.getParameter("deprNm"));
System.out.println(">> arvlName: " + request.getParameter("arvlNm"));
System.out.println(">> busrank: " + request.getParameter("busClsCd"));
%>
<!DOCTYPE html>
<style>
   #datepicker1, #datepicker2 {
      display:none;
   }
</style>
<html class="pc" lang="ko">
<head>
<meta charset="utf-8" />
<meta
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"
	name="viewport" />
<meta content="IE=Edge" http-equiv="X-UA-Compatible" />
<title>예매정보입력(배차조회) | 고속버스예매 | 고속버스예매 | 고속버스통합예매</title>
<link href="/images/favicon.ico" rel="shortcut icon" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<script type="text/javascript">
	/*********************************************
	 * 상수
	 *********************************************/
</script>
<link href="/koBus/css/ui.jqgrid.custom.css" rel="stylesheet"
	type="text/css" />
<script src="/koBus/js/jquery-1.12.4.min.js" type="text/javascript"></script>

<script>
$(document).ready(function () {
    const deprCd = $("#deprCd").val();
    const arvlCd = $("#arvlCd").val();

    if (deprCd && arvlCd) {
        $.ajax({
            url: "<%=request.getContextPath()%>/getDuration.ajax",
            type: "GET",
            data: {
                ajax: "true",                 // ✔ 필수
                ajaxType: "getDuration",     // ✔ 정확히 입력
                deprCd: deprCd,
                arvlCd: arvlCd
            },
            dataType: "json",
            success: function (data) {
                if (data.duration !== undefined && data.duration > 0) {
                    const hours = Math.floor(data.duration / 60);
                    const minutes = data.duration % 60;
                    let timeText = "";
                    if (hours > 0) timeText += `${hours}시간 `;
                    if (minutes > 0) timeText += `${minutes}분 `;
                    timeText += "소요";
                    $("#takeDrtm").text(timeText);
                } else {
                    $("#takeDrtm").text("소요시간 없음");
                }
            },
            error: function () {
                $("#takeDrtm").text("조회 실패");
            }
        });
    }
});

</script>

<script type="text/javascript">
	//쿠키 가져오기
	function getCookie(name) {
		var nameOfCookie = name + "=";
		var x = 0;
		while (x <= document.cookie.length) {
			var y = (x + nameOfCookie.length);
			if (document.cookie.substring(x, y) == nameOfCookie) {
				if ((endOfCookie = document.cookie.indexOf(";", y)) == -1) {
					endOfCookie = document.cookie.length;
				}
				return unescape(document.cookie.substring(y, endOfCookie));
			}
			x = document.cookie.indexOf(" ", x) + 1;
			if (x == 0) {
				break;
			}
		}
		return "";
	}
	//쿠키 넣기
	function setCookie(name, value, expiredays) {
		var todayDate = new Date();
		todayDate.setDate(todayDate.getDate() + expiredays);
		document.cookie = name + "=" + escape(value) + "; path=/; expires="
				+ todayDate.toGMTString() + ";"
	}

	// 상단 네비게이션, 모바일 좌측, 모바일 하단 언어선택 설정
	var lngCdCookie = getCookie("LNG_CD");

	lngCdCookie = (lngCdCookie != null && lngCdCookie != undefined && lngCdCookie != "") ? lngCdCookie
			: "";
	var lngCd = (lngCdCookie == "EN" || lngCdCookie == "CN"
			|| lngCdCookie == "JP" || lngCdCookie == "KO") ? lngCdCookie : "KO";
	$(document)
			.ready(
					function() {
						if (navigator.userAgent.toUpperCase().indexOf("MSIE 5") >= 0
								|| navigator.userAgent.toUpperCase().indexOf(
										"MSIE 6") >= 0
								|| navigator.userAgent.toUpperCase().indexOf(
										"MSIE 7") >= 0
								|| navigator.userAgent.toUpperCase().indexOf(
										"MSIE 8") >= 0) {
							// IE 8 이하
							if (location.href.indexOf("/underIE8.do") < 0) {
								// IE 8 이하 페이지 아님
								location.href = "/underIE8.do";
								return false;
							}
						}
						if (window.innerWidth < 768) {
							setCookie("IS_MOBILE_YN_WIDTH", "Y", 365);
							if (lngCd == "KO"
									&& location.href.indexOf("/cmn/") < 0
									&& location.href.indexOf("/underIE8.do") < 0
									&& location.href
											.indexOf("/mrs/mrsrecppub.do") < 0
									&& location.href
											.indexOf("/mrs/mrsrecppub4.do") < 0
									&& location.href
											.indexOf("/mrs/mrsmbltck.do") < 0
									&& location.href
											.indexOf("/mrs/acntpympup.do") < 0
									&& // 계좌이체
									location.href.indexOf("/mrs/pay") < 0
									&& // 간편결제
									location.href
											.indexOf("/adtnprdnew/prchpt/adtnrecppubmbl.do") < 0
									&& location.href
											.indexOf("/adtnprdnew/frps/frpsPrchGdMbl.do") < 0
									&& location.href
											.indexOf("/mbrs/mbrsscsn.do") < 0) {
								location.href = "/mblIdx.do";
								return false;
							}
						} else {
							setCookie("IS_MOBILE_YN_WIDTH", "N", 365);
						}
						// 타이틀 수정
						if ($("h2").length > 0) {
							$("title").text(
									$("title").text() + " - "
											+ $("h2:eq(0)").text());
						}
						var $objBody = $("body");
						if (!($objBody.hasClass("KO")
								|| $objBody.hasClass("EN")
								|| $objBody.hasClass("CN") || $objBody
								.hasClass("JP"))) {
							$objBody.addClass(lngCd);
						}

						/* asis */
						$(
								"#lng_cd_navi option[value='" + lngCd
										+ "'],#lng_cd_foot option[value='"
										+ lngCd + "']").attr("selected",
								"selected");
						$("#lng_cd_navi,#lng_cd_foot")
								.unbind("change")
								.bind(
										"change",
										function() {
											var tempCd = this.value;
											lngCd = (tempCd != null
													&& tempCd != undefined
													&& tempCd != "" && (tempCd == "EN"
													|| tempCd == "CN"
													|| tempCd == "JP" || tempCd == "KO")) ? tempCd
													: "KO";
											setCookie("LNG_CD", lngCd, 1);
											lngCdCookie = lngCd;
											//document.location.reload();
											location.href = "/main.do";
										});
					});

	if (lngCd == "KO") {
		var dt = new Date(); //오늘날짜 전체
		var yyyy = dt.getFullYear(); //선택한 년도
		var mm = dt.getMonth() + 1; //선택한 월
		var mm2Len = Number(mm) < 10 ? "0" + mm : mm; // 선택ㅡㅜ?ㅌ월 ex:01 두글자로 변환
		var ddTo = Number(dt.getDate()) < 10 ? "0" + dt.getDate() : dt
				.getDate(); // 숫자형
		var yymmddD0 = yyyy + "" + mm2Len + "" + ddTo; //오늘날짜

		var url = window.location.pathname;

		if (yymmddD0 < 20200128) {
			if (url == "/main.do")
				location.href = "/mainExp.do";
		}
	}
</script>
<script src="/koBus/js/ui.js?v=0102" type="text/javascript"></script>
<script src="/koBus/js/plugin.js" type="text/javascript"></script>
<script src="/koBus/js/common.js?v=0102.1" type="text/javascript"></script>
<script src="/koBus/js/jquery/jquery.number.js" type="text/javascript"></script>
<script src="/koBus/js/security.js?v=0.3" type="text/javascript"></script>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link href="/koBus/css/kor/style.css" rel="stylesheet" type="text/css" />
<script src="/koBus/js/kor/new-kor-ui.js?v=0102.0"
	type="text/javascript"></script>
</head>
<!-- [리뉴얼] 페이지 개별 스크립트 신규 정의함 -->

<!-- &lt;%
    String departureDateStr = request.getParameter("departureDate");
    if (departureDateStr != null) {
        // 여기에 나중에 SQL 조회나 기타 로직 추가 가능
        out.println("선택한 날짜: " + departureDateStr);
    }
%&gt; -->


<script>
	$(document).ready(function() {
		var langCd = 'KO';
		var langLi = $(".dropdown-wrap.lang-select .dropdown-list li");
		$.each(langLi, function(ix, el) {
			var langItem = $(el).children('a');
			var lang = langItem.data('lang');
			if (langCd == lang) {
				dropdown_process(langItem);
			}
		});

		$('.title_wrap').hide();
	});
</script>
<!-- 헤더 -->
<%@ include file="common/header.jsp"%>
<!-- 브레드크럼 -->
<nav id="new-kor-breadcrumb">
	<div class="container">
		<ol class="breadcrumb-list">
			<li><i class="ico ico-home"></i><span class="sr-only">홈</span></li>
			<li>
				<div class="dropdown-wrap breadcrumb-select">
					<a aria-expanded="false" class="btn-dropdown"
						href="javascript:void(0)" title="대메뉴 선택"> <span class="text">고속버스예매</span><i
						class="ico ico-dropdown-arrow"></i></a>
					<ul class="dropdown-list">
						<li class="selected"><a href="javascript:void(0)" title="선택됨">고속버스예매</a></li>
						<li><a href="/oprninf/alcninqr/oprnAlcnPage.do">운행정보</a></li>
						<li><a href="/adtnprdnew/frps/frpsPrchGd.do">프리패스/정기권</a></li>
						<li><a href="/ugd/mrsgd/Mrsgd.do">이용안내</a></li>
						<li><a href="/cscn/ntcmttr/readNtcList.do">고객지원</a></li>
						<li><a href="/ugd/bustrop/Bustrop.do">전국고속버스운송사업조합</a></li>
						<li><a href="/ugd/trmlbizr/Trmlbizr.do">터미널사업자협회</a></li>
					</ul>
				</div>
			</li>
			<li>
				<div class="dropdown-wrap breadcrumb-select">
					<a aria-expanded="false" class="btn-dropdown"
						href="javascript:void(0)" title="하위메뉴 선택"> <span class="text">고속버스예매</span><i
						class="ico ico-dropdown-arrow"></i></a>
					<ul class="dropdown-list">
						<li class="selected"><a href="javascript:void(0)" title="선택됨">고속버스예매</a></li>
						<li><a href="/mrs/mrscfm.do">예매확인/취소/변경</a></li>
						<li><a href="/mrs/mrsrecplist.do">영수증발행</a></li>
					</ul>
				</div>
			</li>
		</ol>
	</div>
</nav>
<article id="new-kor-content">
	<script src="/koBus/js/kor/mrs/tckmrs/AlcnSrch.js?v=0102"
		type="text/javascript"></script>
	<form action="/mrs/alcnSrch.do" id="alcnSrchFrm" method="post"
		name="alcnSrchFrm">
		<input id="deprCd" name="deprCd" type="hidden" value="032" />
		<!-- 출발지코드 -->
		<!-- <input id="deprNm" name="deprNm" type="hidden" value="동서울" /> -->
		<input id="deprNm" name="deprNm" type="hidden" value="<%= request.getParameter("deprNm") %>" />
		<!-- 출발지명 -->
		<input id="arvlCd" name="arvlCd" type="hidden" value="220" />
		<!-- 도착지코드 -->
		<!-- <input id="arvlNm" name="arvlNm" type="hidden" value="삼척" /> -->
		<input id="arvlNm" name="arvlNm" type="hidden" value="<%= request.getParameter("arvlNm") %>" />
		<!-- 도착지명 -->
		<input id="tfrCd" name="tfrCd" type="hidden" value="" />
		<!-- 환승지코드 -->
		<input id="tfrNm" name="tfrNm" type="hidden" value="" />
		<!-- 환승지명 -->
		<input id="tfrArvlFullNm" name="tfrArvlFullNm" type="hidden" value="" />
		<!-- 환승지포함 도착지 명 -->
		<input id="pathDvs" name="pathDvs" type="hidden" value="sngl" />
		<!-- 직통sngl,환승trtr,왕복rtrp -->
		<input id="pathStep" name="pathStep" type="hidden" value="1" />
		<!-- 왕복,환승 가는편순번 -->
		<!-- <input id="deprDtm" name="deprDtm" type="hidden" value="20250617" /> -->
		<input id="deprDtm" name="deprDtm" type="hidden" value="<%= request.getParameter("deprDtm") %>" />
		<!-- 가는날(편도,왕복) -->
		<input id="deprDtmAll" name="deprDtmAll" type="hidden" value="<%= request.getParameter("deprDtmAll") %>" />
		<!-- 가는날(편도,왕복) -->
		<input id="arvlDtm" name="arvlDtm" type="hidden" value="" />
		<!-- 오는날(왕복) -->
		<input id="arvlDtmAll" name="arvlDtmAll" type="hidden"
			value="2025. 6. 17. 화" />
		<!-- 오는날(왕복) -->
		<input id="busClsCd" name="busClsCd" type="hidden" value="<%= request.getParameter("busClsCd") %>" />
		<!-- 버스등급 -->
		<input id="takeDrtmOrg" name="takeDrtmOrg" type="hidden" value="200" />
		<!-- 소요시간 -->
		<input id="distOrg" name="distOrg" type="hidden" value="260.8" />
		<!-- 거리 -->
		<input id="rtrpChc" name="rtrpChc" type="hidden" value="1" />
		<!-- 왕편 복편 설정 -->
		<input id="timeLinkMin" name="timeLinkMin" type="hidden" value="05" />
		<!-- 시간링크 최소값 -->
		<input id="timeLinkMax" name="timeLinkMax" type="hidden" value="19" />
		<!-- 식간링크 최대값 -->
		<!-- 출발일자:deprDtm or arvlDtm, 출발터미널번호:deprCd, 도착터미널번호:arvlCd  -->
		<input id="deprTime" name="deprTime" type="hidden" value="" />
		<!-- 출발시각 -->
		<input id="alcnDeprTime" name="alcnDeprTime" type="hidden" value="" />
		<!-- 배차출발시각 -->
		<input id="alcnDeprTrmlNo" name="alcnDeprTrmlNo" type="hidden"
			value="" />
		<!-- 배차출발터미널 -->
		<input id="alcnArvlTrmlNo" name="alcnArvlTrmlNo" type="hidden"
			value="" />
		<!-- 배차도착터미널 -->
		<input id="indVBusClsCd" name="indVBusClsCd" type="hidden" value="" />
		<!-- 선택한버스등급 -->
		<input id="cacmCd" name="cacmCd" type="hidden" value="" />
		<!-- 운수사코드 -->
		<!-- 왕복시 왕편데이터  -->
		<input id="prmmDcDvsCd" name="prmmDcDvsCd" type="hidden" value="" />
		<!-- 우등형할인코드 -->
		<input id="rtrpDtl1" name="rtrpDtl1" type="hidden" value="" />
		<!-- 왕복시 왕편데이터 -->
		<input id="pcpyNoAll1" name="pcpyNoAll1" type="hidden" value="" />
		<!-- 왕복시 왕편좌석선점번호 -->
		<input id="satsNoAll1" name="satsNoAll1" type="hidden" value="" />
		<!-- 왕복시 왕편좌석선점번호 -->
		<input id="alcnTrmlNoInfo" name="alcnTrmlNoInfo" type="hidden"
			value="" />
		<!-- 왕편출도착지 터미널코드 -->
		<!-- 사전데이터 체크용  -->
		<input id="deprDtmOrg" name="deprDtmOrg" type="hidden"
			value="20250617" />
		<!-- 가는날(편도,왕복) -->
		<input id="deprDtmAllOrg" name="deprDtmAllOrg" type="hidden"
			value="2025. 6. 17. 화" />
		<!-- 가는날(편도,왕복) -->
		<input id="arvlDtmOrg" name="arvlDtmOrg" type="hidden"
			value="20250617" />
		<!-- 오는날(왕복) -->
		<input id="arvlDtmAllOrg" name="arvlDtmAllOrg" type="hidden"
			value="2025. 6. 17. 화" />
		<!-- 오는날(왕복) -->
		<input id="rtrpStep2DtYn" name="rtrpStep2DtYn" type="hidden" value="Y" />
		<!-- 오늘날 데이터 여부 -->
		<input id="prvtBbizEmpAcmtRt" name="prvtBbizEmpAcmtRt" type="hidden"
			value="" />
		<!-- 국민차장제 여부 -->
		<input id="chldSftySatsYn" name="chldSftySatsYn" type="hidden"
			value="" />
		<!-- 유아카시트 여부 -->
		<input id="dsprSatsYn" name="dsprSatsYn" type="hidden" value="" />
		<!-- 휠체어 가능 여부 -->
		<!-- 2020-01-17 yahan -->
		<input id="spexp" name="spexp" type="hidden" value="" />
		<!-- 특송플래그 -->
		<!-- 20200327 yahan	 -->
		<input id="dcDvsCd" name="dcDvsCd" type="hidden" value="" />
		<!-- 할인구분코드 -->
		<input id="extrComp" name="extrComp" type="hidden" value="" />
		<!-- 거래처코드 -->
		<input id="stdDtm" name="stdDtm" type="hidden" value="" /> <input
			id="endDtm" name="endDtm" type="hidden" value="" />
		<!-- 20241008 웹접근성 -->
		<input id="reloadStatus" name="reloadStatus" type="hidden" value="" />
	</form>
	<div class="title_wrap in_process ticketingT" style="display: none;">
		<a class="back" href="#">back</a> <a class="mo_toggle" href="#">메뉴</a>
		<h2>고속버스예매</h2>
		<ol class="process">
			<li class="active">예매정보입력</li>
			<li>결제정보입력</li>
			<li class="last">예매완료</li>
		</ol>
	</div>
	<!-- 타이틀 -->
	<div class="content-header"
		data-page-title="예매정보입력(배차조회) | 고속버스예매 | 고속버스예매 | 고속버스통합예매">
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
			<iframe class="ad-frame ad-frame-title"
				src="/koBus/html2/_ad-tubebox-002TITLE.html"
				title="프레임 (전화번호안심 로그인)"></iframe>
		</div>
	</div>
	<div class="content-body">
		<div class="container">
			<h3>배차조회</h3>
			<div class="buscheck_wrap clfix">
				<!-- 좌측 infoBox -->
				<div class="infoBox">
					<!-- <p class="date" id="alcnDeprDtm">2025. 6. 17. 화</p> -->
					<p class="date" id="alcnDeprDtm"><%= request.getParameter("deprDtm") %></p>
					<!-- //왕복시 노출 추가 2017-02-10 -->
					<div class="route_wrap" id="alcnRotInfo">
						<div class="inner">
							<dl class="roundBox departure kor">
								<dt>출발</dt>
								<!-- <dd id="alcnDeprTmlNm">동서울</dd> -->
								<dd id="alcnDeprTmlNm"><%= request.getParameter("deprNm") %></dd>
							</dl>
							<dl class="roundBox arrive kor">
								<dt>도착</dt>
								<!-- <dd id="alcnArvlTmlNm">삼척</dd> -->
								<dd id="alcnArvlTmlNm"><%= request.getParameter("arvlNm") %></dd>
							</dl>
						</div>
						<div class="detail_info">
							<!-- <span id="takeDrtm">3시간 20분 소요</span> <span id="dist">260.8
								Km</span> -->
							<span id="takeDrtm">소요시간 표시</span>
						</div>
						<div class="btn_r">
							<a class="btn btn_modify white" href="javascript:void(0)"
								onclick="fnUpdRot()" title="노선조회 화면으로 이동">수정</a>
						</div>
					</div>
					<div class="price_info bottom" id="alcnPriceInf">
						<p class="stit">
							요금정보<span>(일반요금)</span>
						</p>
						<dl>
							<dt class="">우등</dt>
							<dd>29,500 원</dd>
							<dt class="">고속</dt>
							<dd>22,700 원</dd>
							<dt class="">심야우등</dt>
							<dd>35,400 원</dd>
							<dt class="">심야고속</dt>
							<dd>27,200 원</dd>
							<dt class="">프리미엄</dt>
							<dd>38,300 원</dd>
							<dt class="">심야프리미엄</dt>
							<dd>39,000 원</dd>
						</dl>
					</div>
				</div>
				<!-- //좌측 infoBox -->
				<!-- 우측 detailBox -->
				<div class="detailBox">
					<div class="detailBox_head col3">
						<div class="box_refresh">
							<button class="btn btn_refresh" id="reloadBtn" type="button">
								<span class="ico_refresh"><span class="sr-only">새로고침</span></span>
							</button>
						</div>
						<!-- <div class="head_date">
								<span class="date_cont" id="rideDate"></span>
								<input type="text" id="busDate11" readonly>
								<span class="calender" ></span>
							</div> -->
						<div class="head_date">
							<input class="hasDatepicker" id="busDate11" readonly=""
								tabindex="-1" type="text" />
							<button class="datepicker-btn" type="button">
								<img alt="날짜 선택 달력" class="ui-datepicker-trigger"
									src="/koBus/images/page/ico_calender.png" />
							</button>
							<label class="date_cont" for="busDate11" id="rideDate">2025.
								6. 17. 화</label>
						</div>
					</div>
					<div class="detailBox_body clfix">
						<ul class="time">
							<li class="night"><a class="" data-time="01"
								href="javascript:void(0)" title="해당 시간대 배차 확인">1</a></li>
							<li class="night"><a class="" data-time="03"
								href="javascript:void(0)" title="해당 시간대 배차 확인">3</a></li>
							<li class="night"><a class="" data-time="05"
								href="javascript:void(0)" title="해당 시간대 배차 확인">5</a></li>
							<li class="daytime"><a class="" data-time="07"
								href="javascript:void(0)" title="해당 시간대 배차 확인">7</a></li>
							<li class="daytime"><a class="" data-time="09"
								href="javascript:void(0)" title="해당 시간대 배차 확인">9</a></li>
							<li class="daytime"><a class="" data-time="11"
								href="javascript:void(0)" title="해당 시간대 배차 확인">11</a></li>
							<li class="daytime"><a class="" data-time="13"
								href="javascript:void(0)" title="해당 시간대 배차 확인">13</a></li>
							<li class="daytime"><a class="" data-time="15"
								href="javascript:void(0)" title="해당 시간대 배차 확인">15</a></li>
							<li class="daytime"><a class="" data-time="17"
								href="javascript:void(0)" title="해당 시간대 배차 확인">17</a></li>
							<li class="daytime"><a class="" data-time="19"
								href="javascript:void(0)" title="해당 시간대 배차 확인">19</a></li>
							<li class="night"><a class="" data-time="21"
								href="javascript:void(0)" title="해당 시간대 배차 확인">21</a></li>
							<li class="night"><a class="" data-time="23"
								href="javascript:void(0)" title="해당 시간대 배차 확인">23</a></li>
						</ul>
						<div aria-label="배차조회에 대한 목록이며 출발, 고속사, 등급, 할인, 잔여석, 상태 정보 제공"
							class="bustime_wrap" role="table">
							<p class="bustime_head" role="row">
								<span class="start_time" id="start_time_header"
									role="columnheader">출발</span> <span class="bus_info"
									id="bus_info_header" role="columnheader">고속사/등급</span>
								<!-- tablet / mobile 사이즈에서 보임 -->
								<span class="bus_com" id="bus_com_header" role="columnheader">고속사</span>
								<!-- pc 사이즈에서만 보임 -->
								<span class="grade" id="grade_header" role="columnheader"
									style="">등급</span>
								<!-- pc 사이즈에서만 보임 -->
								<span class="temp" id="temp_header" role="columnheader">할인</span>
								<span class="remain" id="remain_header" role="columnheader">잔여석</span>
								<span class="status" id="status_header" role="columnheader"><span
									class="sr-only">상태</span></span>
							</p>
							<div aria-rowindex="1" class="bus_time" role="row">
								<!-- 동양고속 class="dyexpress" 삼화고속 class="samhwa" 중앙고속 class="jabus" 금호고속 class="kumho" 천일고속 class="chunil" 한일고속 class="hanil" 동부고속 class="dongbu" 금호속리산고속 class="songnisan" 코버스 class="kobus" -->
								<!-- yahan 20201019 응답값 기준으로 변경 -->
								<!-- 서울경부-구미 (노선 분리 되어있지 않아 출발시간으로 체크) -->
								<!-- 평택용이동-서울경부,평택대-서울경부 (출발지표기) -->
								<!-- 동대구(801)-용인(150) (19.09.09) -->
								<div class="noti" id="notiNoToday">
									<!-- 현시점 기준 출발 5분~60분 남은 차량의 경우 배차정보는 노출하되 예매진행 불가처리하여 고속버스 모바일앱 안내 노출 -->
									<p>
										<span class="accent">출발예정 60분전</span> 배차 차량은 고속버스 모바일앱을 통하여
										예매할 수 있습니다.<br />
										<span class="show_pc">곧 출발하는 버스탑승을 하시려면 지금 바로 고속버스
											모바일앱으로 접속하세요.</span><br /> 임시차량은 공동운수협정차량이 운행될 수도 있습니다.
									</p>
									<!-- <a href="http://www.epassmobile.co.kr" class="btnS btn_normal" target="_blank">고속버스 모바일앱</a> -->
								</div>
								<!-- 2021 05 / 10 class 추가  -->
								<!-- <p class="noselect premium all_bus" data-time="09"> -->
								<!-- 선택할수 목록(1. 시간이 지났을경우, 2. 잔여좌석이 0일경우) 에 class = 'noselect', 등급이 프리미엄일 경우 class = "premium" -->
								<p class="" data-time="05" role="row">
									<a class="" href="javascript:void(0)"
										onclick="fnSatsChc('<%= request.getParameter("deprDtm") %>','064500','064500','032','220','1','02','0','Y','N','032','220','N','N','N','N');">
										<span aria-labelledby="start_time_header" class="start_time"
										role="cell">06 : 45</span> <span class="bus_info"> <span
											class="dongbu">(주)동부고속</span> <span class="grade_mo">우등</span>
									</span> <!-- tablet / mobile 사이즈에서 보임 --> <span
										aria-labelledby="bus_com_header" class="bus_com" role="cell"><span
											class="dongbu">(주)동부고속</span></span> <!-- pc 사이즈에서만 보임 --> <span
										aria-labelledby="grade_header" class="grade" role="cell">우등
											<span class="via"> </span>
									</span>
									<!-- pc 사이즈에서만 보임 --> <span aria-labelledby="temp_header"
										class="temp" role="cell"> <span class="sale_color">6%
												할인</span> (27,800원)

									</span> <span aria-labelledby="remain_header" class="remain"
										role="cell">28 석</span> <span aria-labelledby="status_header"
										class="status" role="cell"> <span
											class="accent btn_arrow">선택</span> <!-- fnSatsChc(deprTime,alcnDeprTime,alcnDeprTrmlNo,alcnArvlTrmlNo,indVBusClsCd,cacmCd) -->
									</span>
									</a>
								</p>
								<!-- yahan 20201019 응답값 기준으로 변경 -->
								<!-- 서울경부-구미 (노선 분리 되어있지 않아 출발시간으로 체크) -->
								<!-- 평택용이동-서울경부,평택대-서울경부 (출발지표기) -->
								<!-- 동대구(801)-용인(150) (19.09.09) -->
								<!-- 2021 05 / 10 class 추가  -->
								<!-- <p class="noselect premium all_bus" data-time="09"> -->
								<!-- 선택할수 목록(1. 시간이 지났을경우, 2. 잔여좌석이 0일경우) 에 class = 'noselect', 등급이 프리미엄일 경우 class = "premium" -->
								<p class="premium" data-time="07" role="row">
									<span class="label"><span class="sr-only">프리미엄</span></span> <a
										class="" href="javascript:void(0)"
										onclick="fnSatsChc('<%= request.getParameter("deprDtm") %>','072000','072000','032','220','7','02','0','Y','N','032','220','N','N','N','N');">
										<span aria-labelledby="start_time_header" class="start_time"
										role="cell">07 : 20</span> <span class="bus_info"> <span
											class="dongbu">(주)동부고속</span> <span class="grade_mo">프리미엄</span>
									</span> <!-- tablet / mobile 사이즈에서 보임 --> <span
										aria-labelledby="bus_com_header" class="bus_com" role="cell"><span
											class="dongbu">(주)동부고속</span></span> <!-- pc 사이즈에서만 보임 --> <span
										aria-labelledby="grade_header" class="grade" role="cell">프리미엄
											<span class="via"> </span>
									</span>
									<!-- pc 사이즈에서만 보임 --> <span aria-labelledby="temp_header"
										class="temp" role="cell"> <span class="sale_color">15%
												할인</span> (32,500원)

									</span> <span aria-labelledby="remain_header" class="remain"
										role="cell">20 석</span> <span aria-labelledby="status_header"
										class="status" role="cell"> <span
											class="accent btn_arrow">선택</span> <!-- fnSatsChc(deprTime,alcnDeprTime,alcnDeprTrmlNo,alcnArvlTrmlNo,indVBusClsCd,cacmCd) -->
									</span>
									</a>
								</p>
								<!-- yahan 20201019 응답값 기준으로 변경 -->
								<!-- 서울경부-구미 (노선 분리 되어있지 않아 출발시간으로 체크) -->
								<!-- 평택용이동-서울경부,평택대-서울경부 (출발지표기) -->
								<!-- 동대구(801)-용인(150) (19.09.09) -->
								<!-- 2021 05 / 10 class 추가  -->
								<!-- <p class="noselect premium all_bus" data-time="09"> -->
								<!-- 선택할수 목록(1. 시간이 지났을경우, 2. 잔여좌석이 0일경우) 에 class = 'noselect', 등급이 프리미엄일 경우 class = "premium" -->
								<p class="" data-time="" role="row">
									<a class="" href="javascript:void(0)"
										onclick="fnSatsChc('<%= request.getParameter("deprDtm") %>','085000','085000','032','220','2','02','0','Y','N','032','220','N','N','N','N');">
										<span aria-labelledby="start_time_header" class="start_time"
										role="cell">08 : 50</span> <span class="bus_info"> <span
											class="dongbu">(주)동부고속</span> <span class="grade_mo">고속</span>
									</span> <!-- tablet / mobile 사이즈에서 보임 --> <span
										aria-labelledby="bus_com_header" class="bus_com" role="cell"><span
											class="dongbu">(주)동부고속</span></span> <!-- pc 사이즈에서만 보임 --> <span
										aria-labelledby="grade_header" class="grade" role="cell">고속
											<span class="via"> </span>
									</span>
									<!-- pc 사이즈에서만 보임 --> <span aria-labelledby="temp_header"
										class="temp" role="cell"> <span class="sale_color">17%
												할인</span> (18,800원)

									</span> <span aria-labelledby="remain_header" class="remain"
										role="cell">28 석</span> <span aria-labelledby="status_header"
										class="status" role="cell"> <span
											class="accent btn_arrow">선택</span> <!-- fnSatsChc(deprTime,alcnDeprTime,alcnDeprTrmlNo,alcnArvlTrmlNo,indVBusClsCd,cacmCd) -->
									</span>
									</a>
								</p>
								<!-- yahan 20201019 응답값 기준으로 변경 -->
								<!-- 서울경부-구미 (노선 분리 되어있지 않아 출발시간으로 체크) -->
								<!-- 평택용이동-서울경부,평택대-서울경부 (출발지표기) -->
								<!-- 동대구(801)-용인(150) (19.09.09) -->
								<!-- 2021 05 / 10 class 추가  -->
								<!-- <p class="noselect premium all_bus" data-time="09"> -->
								<!-- 선택할수 목록(1. 시간이 지났을경우, 2. 잔여좌석이 0일경우) 에 class = 'noselect', 등급이 프리미엄일 경우 class = "premium" -->
								<p class="" data-time="11" role="row">
									<a class="" href="javascript:void(0)"
										onclick="fnSatsChc('<%= request.getParameter("deprDtm") %>','113000','113000','032','220','2','02','0','Y','N','032','220','N','N','N','N');">
										<span aria-labelledby="start_time_header" class="start_time"
										role="cell">11 : 30</span> <span class="bus_info"> <span
											class="dongbu">(주)동부고속</span> <span class="grade_mo">고속</span>
									</span> <!-- tablet / mobile 사이즈에서 보임 --> <span
										aria-labelledby="bus_com_header" class="bus_com" role="cell"><span
											class="dongbu">(주)동부고속</span></span> <!-- pc 사이즈에서만 보임 --> <span
										aria-labelledby="grade_header" class="grade" role="cell">고속
											<span class="via"> </span>
									</span>
									<!-- pc 사이즈에서만 보임 --> <span aria-labelledby="temp_header"
										class="temp" role="cell"> <span class="sale_color">17%
												할인</span> (18,800원)

									</span> <span aria-labelledby="remain_header" class="remain"
										role="cell">28 석</span> <span aria-labelledby="status_header"
										class="status" role="cell"> <span
											class="accent btn_arrow">선택</span> <!-- fnSatsChc(deprTime,alcnDeprTime,alcnDeprTrmlNo,alcnArvlTrmlNo,indVBusClsCd,cacmCd) -->
									</span>
									</a>
								</p>
								<!-- yahan 20201019 응답값 기준으로 변경 -->
								<!-- 서울경부-구미 (노선 분리 되어있지 않아 출발시간으로 체크) -->
								<!-- 평택용이동-서울경부,평택대-서울경부 (출발지표기) -->
								<!-- 동대구(801)-용인(150) (19.09.09) -->
								<!-- 2021 05 / 10 class 추가  -->
								<!-- <p class="noselect premium all_bus" data-time="09"> -->
								<!-- 선택할수 목록(1. 시간이 지났을경우, 2. 잔여좌석이 0일경우) 에 class = 'noselect', 등급이 프리미엄일 경우 class = "premium" -->
								<p class="" data-time="13" role="row">
									<a class="" href="javascript:void(0)"
										onclick="fnSatsChc('20250617','130000','130000','032','220','1','02','0','Y','N','032','220','N','N','N','N');">
										<span aria-labelledby="start_time_header" class="start_time"
										role="cell">13 : 00</span> <span class="bus_info"> <span
											class="dongbu">(주)동부고속</span> <span class="grade_mo">우등</span>
									</span> <!-- tablet / mobile 사이즈에서 보임 --> <span
										aria-labelledby="bus_com_header" class="bus_com" role="cell"><span
											class="dongbu">(주)동부고속</span></span> <!-- pc 사이즈에서만 보임 --> <span
										aria-labelledby="grade_header" class="grade" role="cell">우등
											<span class="via"> </span>
									</span>
									<!-- pc 사이즈에서만 보임 --> <span aria-labelledby="temp_header"
										class="temp" role="cell"> <span class="sale_color">6%
												할인</span> (27,800원)

									</span> <span aria-labelledby="remain_header" class="remain"
										role="cell">26 석</span> <span aria-labelledby="status_header"
										class="status" role="cell"> <span
											class="accent btn_arrow">선택</span> <!-- fnSatsChc(deprTime,alcnDeprTime,alcnDeprTrmlNo,alcnArvlTrmlNo,indVBusClsCd,cacmCd) -->
									</span>
									</a>
								</p>
								<!-- yahan 20201019 응답값 기준으로 변경 -->
								<!-- 서울경부-구미 (노선 분리 되어있지 않아 출발시간으로 체크) -->
								<!-- 평택용이동-서울경부,평택대-서울경부 (출발지표기) -->
								<!-- 동대구(801)-용인(150) (19.09.09) -->
								<!-- 2021 05 / 10 class 추가  -->
								<!-- <p class="noselect premium all_bus" data-time="09"> -->
								<!-- 선택할수 목록(1. 시간이 지났을경우, 2. 잔여좌석이 0일경우) 에 class = 'noselect', 등급이 프리미엄일 경우 class = "premium" -->
								<p class="premium" data-time="" role="row">
									<span class="label"><span class="sr-only">프리미엄</span></span> <a
										class="" href="javascript:void(0)"
										onclick="fnSatsChc('20250617','145000','145000','032','220','7','02','0','Y','N','032','220','N','N','N','N');">
										<span aria-labelledby="start_time_header" class="start_time"
										role="cell">14 : 50</span> <span class="bus_info"> <span
											class="dongbu">(주)동부고속</span> <span class="grade_mo">프리미엄</span>
									</span> <!-- tablet / mobile 사이즈에서 보임 --> <span
										aria-labelledby="bus_com_header" class="bus_com" role="cell"><span
											class="dongbu">(주)동부고속</span></span> <!-- pc 사이즈에서만 보임 --> <span
										aria-labelledby="grade_header" class="grade" role="cell">프리미엄
											<span class="via"> </span>
									</span>
									<!-- pc 사이즈에서만 보임 --> <span aria-labelledby="temp_header"
										class="temp" role="cell"> <span class="sale_color">15%
												할인</span> (32,500원)

									</span> <span aria-labelledby="remain_header" class="remain"
										role="cell">20 석</span> <span aria-labelledby="status_header"
										class="status" role="cell"> <span
											class="accent btn_arrow">선택</span> <!-- fnSatsChc(deprTime,alcnDeprTime,alcnDeprTrmlNo,alcnArvlTrmlNo,indVBusClsCd,cacmCd) -->
									</span>
									</a>
								</p>
								<!-- yahan 20201019 응답값 기준으로 변경 -->
								<!-- 서울경부-구미 (노선 분리 되어있지 않아 출발시간으로 체크) -->
								<!-- 평택용이동-서울경부,평택대-서울경부 (출발지표기) -->
								<!-- 동대구(801)-용인(150) (19.09.09) -->
								<!-- 2021 05 / 10 class 추가  -->
								<!-- <p class="noselect premium all_bus" data-time="09"> -->
								<!-- 선택할수 목록(1. 시간이 지났을경우, 2. 잔여좌석이 0일경우) 에 class = 'noselect', 등급이 프리미엄일 경우 class = "premium" -->
								<p class="" data-time="15" role="row">
									<a class="" href="javascript:void(0)"
										onclick="fnSatsChc('20250617','163500','163500','032','220','2','02','0','Y','N','032','220','N','N','N','N');">
										<span aria-labelledby="start_time_header" class="start_time"
										role="cell">16 : 35</span> <span class="bus_info"> <span
											class="dongbu">(주)동부고속</span> <span class="grade_mo">고속</span>
									</span> <!-- tablet / mobile 사이즈에서 보임 --> <span
										aria-labelledby="bus_com_header" class="bus_com" role="cell"><span
											class="dongbu">(주)동부고속</span></span> <!-- pc 사이즈에서만 보임 --> <span
										aria-labelledby="grade_header" class="grade" role="cell">고속
											<span class="via"> </span>
									</span>
									<!-- pc 사이즈에서만 보임 --> <span aria-labelledby="temp_header"
										class="temp" role="cell"> <span class="sale_color">17%
												할인</span> (18,800원)

									</span> <span aria-labelledby="remain_header" class="remain"
										role="cell">26 석</span> <span aria-labelledby="status_header"
										class="status" role="cell"> <span
											class="accent btn_arrow">선택</span> <!-- fnSatsChc(deprTime,alcnDeprTime,alcnDeprTrmlNo,alcnArvlTrmlNo,indVBusClsCd,cacmCd) -->
									</span>
									</a>
								</p>
								<!-- yahan 20201019 응답값 기준으로 변경 -->
								<!-- 서울경부-구미 (노선 분리 되어있지 않아 출발시간으로 체크) -->
								<!-- 평택용이동-서울경부,평택대-서울경부 (출발지표기) -->
								<!-- 동대구(801)-용인(150) (19.09.09) -->
								<!-- 2021 05 / 10 class 추가  -->
								<!-- <p class="noselect premium all_bus" data-time="09"> -->
								<!-- 선택할수 목록(1. 시간이 지났을경우, 2. 잔여좌석이 0일경우) 에 class = 'noselect', 등급이 프리미엄일 경우 class = "premium" -->
								<p class="" data-time="17" role="row">
									<a class="" href="javascript:void(0)"
										onclick="fnSatsChc('20250617','172000','172000','032','220','1','02','0','Y','N','032','220','N','N','N','N');">
										<span aria-labelledby="start_time_header" class="start_time"
										role="cell">17 : 20</span> <span class="bus_info"> <span
											class="dongbu">(주)동부고속</span> <span class="grade_mo">우등</span>
									</span> <!-- tablet / mobile 사이즈에서 보임 --> <span
										aria-labelledby="bus_com_header" class="bus_com" role="cell"><span
											class="dongbu">(주)동부고속</span></span> <!-- pc 사이즈에서만 보임 --> <span
										aria-labelledby="grade_header" class="grade" role="cell">우등
											<span class="via"> </span>
									</span>
									<!-- pc 사이즈에서만 보임 --> <span aria-labelledby="temp_header"
										class="temp" role="cell"> <span class="sale_color">6%
												할인</span> (27,800원)

									</span> <span aria-labelledby="remain_header" class="remain"
										role="cell">28 석</span> <span aria-labelledby="status_header"
										class="status" role="cell"> <span
											class="accent btn_arrow">선택</span> <!-- fnSatsChc(deprTime,alcnDeprTime,alcnDeprTrmlNo,alcnArvlTrmlNo,indVBusClsCd,cacmCd) -->
									</span>
									</a>
								</p>
								<!-- yahan 20201019 응답값 기준으로 변경 -->
								<!-- 서울경부-구미 (노선 분리 되어있지 않아 출발시간으로 체크) -->
								<!-- 평택용이동-서울경부,평택대-서울경부 (출발지표기) -->
								<!-- 동대구(801)-용인(150) (19.09.09) -->
								<!-- 2021 05 / 10 class 추가  -->
								<!-- <p class="noselect premium all_bus" data-time="09"> -->
								<!-- 선택할수 목록(1. 시간이 지났을경우, 2. 잔여좌석이 0일경우) 에 class = 'noselect', 등급이 프리미엄일 경우 class = "premium" -->
								<p class="premium" data-time="" role="row">
									<span class="label"><span class="sr-only">프리미엄</span></span> <a
										class="" href="javascript:void(0)"
										onclick="fnSatsChc('20250617','184000','184000','032','220','7','02','0','Y','N','032','220','N','N','N','N');">
										<span aria-labelledby="start_time_header" class="start_time"
										role="cell">18 : 40</span> <span class="bus_info"> <span
											class="dongbu">(주)동부고속</span> <span class="grade_mo">프리미엄</span>
									</span> <!-- tablet / mobile 사이즈에서 보임 --> <span
										aria-labelledby="bus_com_header" class="bus_com" role="cell"><span
											class="dongbu">(주)동부고속</span></span> <!-- pc 사이즈에서만 보임 --> <span
										aria-labelledby="grade_header" class="grade" role="cell">프리미엄
											<span class="via"> </span>
									</span>
									<!-- pc 사이즈에서만 보임 --> <span aria-labelledby="temp_header"
										class="temp" role="cell"> <span class="sale_color">15%
												할인</span> (32,500원)

									</span> <span aria-labelledby="remain_header" class="remain"
										role="cell">20 석</span> <span aria-labelledby="status_header"
										class="status" role="cell"> <span
											class="accent btn_arrow">선택</span> <!-- fnSatsChc(deprTime,alcnDeprTime,alcnDeprTrmlNo,alcnArvlTrmlNo,indVBusClsCd,cacmCd) -->
									</span>
									</a>
								</p>
								<!-- yahan 20201019 응답값 기준으로 변경 -->
								<!-- 서울경부-구미 (노선 분리 되어있지 않아 출발시간으로 체크) -->
								<!-- 평택용이동-서울경부,평택대-서울경부 (출발지표기) -->
								<!-- 동대구(801)-용인(150) (19.09.09) -->
								<!-- 2021 05 / 10 class 추가  -->
								<!-- <p class="noselect premium all_bus" data-time="09"> -->
								<!-- 선택할수 목록(1. 시간이 지났을경우, 2. 잔여좌석이 0일경우) 에 class = 'noselect', 등급이 프리미엄일 경우 class = "premium" -->
								<p class="" data-time="19" role="row">
									<a class="" href="javascript:void(0)"
										onclick="fnSatsChc('20250617','195000','195000','032','220','2','02','0','Y','N','032','220','N','N','N','N');">
										<span aria-labelledby="start_time_header" class="start_time"
										role="cell">19 : 50</span> <span class="bus_info"> <span
											class="dongbu">(주)동부고속</span> <span class="grade_mo">고속</span>
									</span> <!-- tablet / mobile 사이즈에서 보임 --> <span
										aria-labelledby="bus_com_header" class="bus_com" role="cell"><span
											class="dongbu">(주)동부고속</span></span> <!-- pc 사이즈에서만 보임 --> <span
										aria-labelledby="grade_header" class="grade" role="cell">고속
											<span class="via"> </span>
									</span>
									<!-- pc 사이즈에서만 보임 --> <span aria-labelledby="temp_header"
										class="temp" role="cell"> <span class="sale_color">17%
												할인</span> (18,800원)

									</span> <span aria-labelledby="remain_header" class="remain"
										role="cell">27 석</span> <span aria-labelledby="status_header"
										class="status" role="cell"> <span
											class="accent btn_arrow">선택</span> <!-- fnSatsChc(deprTime,alcnDeprTime,alcnDeprTrmlNo,alcnArvlTrmlNo,indVBusClsCd,cacmCd) -->
									</span>
									</a>
								</p>
							</div>
						</div>
					</div>
				</div>
				<!-- //우측 detailBox -->
			</div>
			<div class="section">
				<ul class="desc_list">
					<li>심야 고속ㆍ우등ㆍ프리미엄의 요금은 당일 22:00부터 익일 04:00사이 출발차량</li>
					<li>마일리지 구매 승차권은 프리미엄/편도 노선(일부노선 제외)에 한정하며 각 1매씩 예매 가능(*회원대상)</li>
					<li>유아 카시트 가능( <img alt=""
						src="/koBus/images/kor/page/ico_child_on.png" style="width: 13px" />
						) 표시된 차량에만 유아 카시트 장착 가능 (본인 소유의 유아 카시트 준비)
					</li>
					<li>소요(도착)시간은 도로 사정에 따라 지연될 수 있음</li>
					<!-- 190925 추가 -->
					<li>휠체어 탑승 가능( <img alt=""
						src="/koBus/images/kor/page/ico_wheel_on.png" style="width: 13px" />
						) 표시된 차량에만 휠체어 동반 탑승 가능 (전동식 휠체어만 탑승 가능)
					</li>
					<li>휠체어 좌석 예매는 wkobus 사이트에서 예매 가능하며, 휠체어 좌석 예매는 출발일로 부터 3일
						전까지만 가능<br />(*휠체어 좌석 예매가 없을 시 출발일 이틀 전부터 일반석 예매 가능)
					</li>
					<!-- // 190925 추가 -->
				</ul>
			</div>
		</div>
	</div>
	<!-- 요금보기 -->
</article>
<!-- footer -->
<!-- 푸터 -->
<footer id="new-kor-footer">
	<div class="container">
		<div class="footer-top-cont">
			<ul class="express-bus-company-list">
				<li><a href="http://www.kumhobuslines.co.kr" target="_blank"
					title="새창"><img alt="금호고속"
						src="/koBus/images/kor/layout/logo-kumho-express.png" /></a></li>
				<li><a href="http://www.dongbubus.com" target="_blank"
					title="새창"><img alt="동부고속"
						src="/koBus/images/kor/layout/logo-dongbu-express.png" /></a></li>
				<li><a href="http://www.songnisanbuslines.co.kr"
					target="_blank" title="새창"><img alt="속리산고속"
						src="/koBus/images/kor/layout/logo-sokrisan-express.png" /></a></li>
				<li><a href="http://www.dyexpress.co.kr" target="_blank"
					title="새창"><img alt="동양고속"
						src="/koBus/images/kor/layout/logo-dongyang-express.png" /></a></li>
				<li><a href="http://www.samhwaexpress.co.kr" target="_blank"
					title="새창"><img alt="삼화고속"
						src="/koBus/images/kor/layout/logo-samhwa-express.png" /></a></li>
				<li><a href="http://www.jabus.co.kr" target="_blank" title="새창"><img
						alt="중앙고속"
						src="/koBus/images/kor/layout/logo-joongang-express.png" /></a></li>
				<li><a href="http://www.chunilexpress.co.kr" target="_blank"
					title="새창"><img alt="천일고속"
						src="/koBus/images/kor/layout/logo-chunil-express.png" /></a></li>
				<li><a href="http://www.hanilexpress.co.kr" target="_blank"
					title="새창"><img alt="한일고속"
						src="/koBus/images/kor/layout/logo-hanil-express.png" /></a></li>
			</ul>
			<!-- dropdown-top 클래스 추가 시, 드롭다운 목록 위로 노출 -->
			<div class="dropdown-wrap dropdown-top related-sites-select">
				<a aria-expanded="false" class="btn-dropdown"
					href="javascript:void(0)" title="관련사이트 이동"><span class="text">관련사이트</span><i
					class="ico ico-arrow-down"></i></a>
				<ul class="dropdown-list">
					<li class="selected"><a href="/wchr/main.do" target="_blank"
						title="새창">장애인 휠체어 사이트</a></li>
					<li><a href="https://www.tago.go.kr" target="_blank"
						title="새창">국가대중교통정보센터</a></li>
					<li><a href="https://www.intis.or.kr" target="_blank"
						title="새창">인천장애인콜택시</a></li>
					<li><a href="http://www.shinsegaecentralcity.com"
						target="_blank" title="새창">센트럴시티터미널</a></li>
					<li><a href="https://txbus.t-money.co.kr" target="_blank"
						title="새창">시외버스 통합예매시스템</a></li>
				</ul>
			</div>
		</div>
		<div class="footer-bottom-cont">
			<address class="address">
				<ul class="policy-list">
					<li><a href="/etc/svcstpl/SvcStpl.do">서비스 이용약관</a></li>
					<li><a class="text-bold" href="/etc/indlstpl/IndlStpl.do">개인정보
							처리방침</a></li>
					<li><a href="/etc/busstpl/BusStpl.do">고속버스 운송약관</a></li>
					<li><a href="http://www.tmoney.co.kr" target="_blank"
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
						alt="(사)한국장애인단체총연합회 한국웹접근성인증평가원 웹 접근성 우수사이트 인증마크(WA인증마크)"
						height="40" src="/koBus/images/kor/layout/logo-accessibility2.png" /></a>
				</li>
				<li><a href="/ugd/bustrop/Bustrop.do" title="이사장 인사말 바로가기"><img
						alt="KOBUS 전국고속버스운송사업조합"
						src="/koBus/images/kor/layout/logo-kobus.png" /></a></li>
				<li><a href="/ugd/trmlbizr/Trmlbizr.do" title="협회장 인사말 바로가기"><img
						alt="전국여객자동차터미널사업자협회"
						src="/koBus/images/kor/layout/logo-npvtba-express.png" /></a></li>
			</ul>
		</div>
	</div>
</footer>
</div>
<div class="remodal-overlay remodal-is-closed" style="display: none;"></div>
<div class="remodal-wrapper remodal-is-closed" style="display: none;">
	<div class="remodal pop_price remodal-is-initialized remodal-is-closed"
		data-remodal-id="popPrice" role="dialog" tabindex="-1">
		<p class="tbl_tit">요금보기</p>
		<div class="cont">
			<div class="tbl_type1">
				<table>
					<caption>요금에 대한 표이며 운임, 구분, 일반요금 정보 제공</caption>
					<colgroup>
						<col style="width: 22%" />
						<col style="width: 50%" />
						<col style="width: auto;" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">운임</th>
							<th scope="col">구분</th>
							<th scope="col">일반요금</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td rowspan="9"></td>
							<td>프리미엄</td>
							<td class="sum">원</td>
						</tr>
						<tr>
							<td>우등고속</td>
							<td class="sum">원</td>
						</tr>
						<tr>
							<td>일반고속</td>
							<td class="sum">원</td>
						</tr>
						<tr>
							<td>심야프리미엄</td>
							<td class="sum">원</td>
						</tr>
						<tr>
							<td>심야우등</td>
							<td class="sum">원</td>
						</tr>
						<tr>
							<td>심야고속</td>
							<td class="sum">원</td>
						</tr>
						<tr>
							<td>할증프리미엄</td>
							<td class="sum">원</td>
						</tr>
						<tr>
							<td>할증우등</td>
							<td class="sum">원</td>
						</tr>
						<tr>
							<td>할증고속</td>
							<td class="sum">원</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="btns">
			<button class="btnL btn_close" data-remodal-action="cancel"
				type="button">닫기</button>
		</div>
	</div>
</div>
<div
	class="ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all hasDatepicker"
	id="ui-datepicker-div" tabindex="0">
	<div
		class="ui-datepicker-header ui-widget-header ui-helper-clearfix ui-corner-all">
		<a class="ui-datepicker-prev ui-corner-all ui-state-disabled"
			title="이전달"><span class="ui-icon ui-icon-circle-triangle-w">이전달</span></a><a
			class="ui-datepicker-next ui-corner-all" data-event="click"
			data-handler="next" title="다음달"><span
			class="ui-icon ui-icon-circle-triangle-e">다음달</span></a>
		<div class="ui-datepicker-title">
			<span class="ui-datepicker-year">2025</span>. <span
				class="ui-datepicker-month">6</span>
		</div>
	</div>
	<table class="ui-datepicker-calendar">
		<caption>날짜 선택 달력</caption>
		<thead>
			<tr>
				<th class="ui-datepicker-week-end" scope="col"><span
					title="일요일">일</span></th>
				<th scope="col"><span title="월요일">월</span></th>
				<th scope="col"><span title="화요일">화</span></th>
				<th scope="col"><span title="수요일">수</span></th>
				<th scope="col"><span title="목요일">목</span></th>
				<th scope="col"><span title="금요일">금</span></th>
				<th class="ui-datepicker-week-end" scope="col"><span
					title="토요일">토</span></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td
					class="ui-datepicker-week-end ui-datepicker-unselectable ui-state-disabled"><span
					class="ui-state-default">1</span></td>
				<td class="ui-datepicker-unselectable ui-state-disabled"><span
					class="ui-state-default">2</span></td>
				<td class="ui-datepicker-unselectable ui-state-disabled"><span
					class="ui-state-default">3</span></td>
				<td class="ui-datepicker-unselectable ui-state-disabled"><span
					class="ui-state-default">4</span></td>
				<td class="ui-datepicker-unselectable ui-state-disabled"><span
					class="ui-state-default">5</span></td>
				<td class="ui-datepicker-unselectable ui-state-disabled"><span
					class="ui-state-default">6</span></td>
				<td class="ui-datepicker-week-end ui-datepicker-today"
					data-event="click" data-handler="selectDay" data-month="5"
					data-year="2025"><a
					class="ui-state-default ui-state-highlight" href="#">7</a></td>
			</tr>
			<tr>
				<td class="ui-datepicker-week-end" data-event="click"
					data-handler="selectDay" data-month="5" data-year="2025"><a
					class="ui-state-default" href="#">8</a></td>
				<td class="" data-event="click" data-handler="selectDay"
					data-month="5" data-year="2025"><a class="ui-state-default"
					href="#">9</a></td>
				<td class="" data-event="click" data-handler="selectDay"
					data-month="5" data-year="2025"><a class="ui-state-default"
					href="#">10</a></td>
				<td class="" data-event="click" data-handler="selectDay"
					data-month="5" data-year="2025"><a class="ui-state-default"
					href="#">11</a></td>
				<td class="" data-event="click" data-handler="selectDay"
					data-month="5" data-year="2025"><a class="ui-state-default"
					href="#">12</a></td>
				<td class="" data-event="click" data-handler="selectDay"
					data-month="5" data-year="2025"><a class="ui-state-default"
					href="#">13</a></td>
				<td class="ui-datepicker-week-end" data-event="click"
					data-handler="selectDay" data-month="5" data-year="2025"><a
					class="ui-state-default" href="#">14</a></td>
			</tr>
			<tr>
				<td class="ui-datepicker-week-end" data-event="click"
					data-handler="selectDay" data-month="5" data-year="2025"><a
					class="ui-state-default" href="#">15</a></td>
				<td class="" data-event="click" data-handler="selectDay"
					data-month="5" data-year="2025"><a class="ui-state-default"
					href="#">16</a></td>
				<td class="ui-datepicker-current-day" data-event="click"
					data-handler="selectDay" data-month="5" data-year="2025"><a
					class="ui-state-default ui-state-active" href="#">17</a></td>
				<td class="" data-event="click" data-handler="selectDay"
					data-month="5" data-year="2025"><a class="ui-state-default"
					href="#">18</a></td>
				<td class="" data-event="click" data-handler="selectDay"
					data-month="5" data-year="2025"><a class="ui-state-default"
					href="#">19</a></td>
				<td class="" data-event="click" data-handler="selectDay"
					data-month="5" data-year="2025"><a class="ui-state-default"
					href="#">20</a></td>
				<td class="ui-datepicker-week-end" data-event="click"
					data-handler="selectDay" data-month="5" data-year="2025"><a
					class="ui-state-default" href="#">21</a></td>
			</tr>
			<tr>
				<td class="ui-datepicker-week-end" data-event="click"
					data-handler="selectDay" data-month="5" data-year="2025"><a
					class="ui-state-default" href="#">22</a></td>
				<td class="" data-event="click" data-handler="selectDay"
					data-month="5" data-year="2025"><a class="ui-state-default"
					href="#">23</a></td>
				<td class="" data-event="click" data-handler="selectDay"
					data-month="5" data-year="2025"><a class="ui-state-default"
					href="#">24</a></td>
				<td class="" data-event="click" data-handler="selectDay"
					data-month="5" data-year="2025"><a class="ui-state-default"
					href="#">25</a></td>
				<td class="" data-event="click" data-handler="selectDay"
					data-month="5" data-year="2025"><a class="ui-state-default"
					href="#">26</a></td>
				<td class="" data-event="click" data-handler="selectDay"
					data-month="5" data-year="2025"><a class="ui-state-default"
					href="#">27</a></td>
				<td class="ui-datepicker-week-end" data-event="click"
					data-handler="selectDay" data-month="5" data-year="2025"><a
					class="ui-state-default" href="#">28</a></td>
			</tr>
			<tr>
				<td class="ui-datepicker-week-end" data-event="click"
					data-handler="selectDay" data-month="5" data-year="2025"><a
					class="ui-state-default" href="#">29</a></td>
				<td class="" data-event="click" data-handler="selectDay"
					data-month="5" data-year="2025"><a class="ui-state-default"
					href="#">30</a></td>
				<td
					class="ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled"> </td>
				<td
					class="ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled"> </td>
				<td
					class="ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled"> </td>
				<td
					class="ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled"> </td>
				<td
					class="ui-datepicker-week-end ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled"> </td>
			</tr>
		</tbody>
	</table>
	<div
		class="ui-datepicker-inline ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all"
		style="display: block;">
		<div
			class="ui-datepicker-header ui-widget-header ui-helper-clearfix ui-corner-all">
			<a class="ui-datepicker-prev ui-corner-all" data-event="click"
				data-handler="prev" title="이전달"><span
				class="ui-icon ui-icon-circle-triangle-w">이전달</span></a><a
				class="ui-datepicker-next ui-corner-all" data-event="click"
				data-handler="next" title="다음달"><span
				class="ui-icon ui-icon-circle-triangle-e">다음달</span></a>
			<div class="ui-datepicker-title">
				<span class="ui-datepicker-year">2025</span>. <span
					class="ui-datepicker-month">6</span>
			</div>
		</div>
		<table class="ui-datepicker-calendar">
			<caption>날짜 선택 달력</caption>
			<thead>
				<tr>
					<th class="ui-datepicker-week-end" scope="col"><span
						title="일요일">일</span></th>
					<th scope="col"><span title="월요일">월</span></th>
					<th scope="col"><span title="화요일">화</span></th>
					<th scope="col"><span title="수요일">수</span></th>
					<th scope="col"><span title="목요일">목</span></th>
					<th scope="col"><span title="금요일">금</span></th>
					<th class="ui-datepicker-week-end" scope="col"><span
						title="토요일">토</span></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="ui-datepicker-week-end" data-event="click"
						data-handler="selectDay" data-month="5" data-year="2025"><a
						class="ui-state-default" href="#">1</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">2</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">3</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">4</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">5</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">6</a></td>
					<td
						class="ui-datepicker-week-end ui-datepicker-days-cell-over ui-datepicker-today ui-datepicker-current-day ui-datepicker-today"
						data-event="click" data-handler="selectDay" data-month="5"
						data-year="2025" title="오늘"><a
						class="ui-state-default ui-state-highlight ui-state-active ui-state-hover"
						href="#">7</a></td>
				</tr>
				<tr>
					<td class="ui-datepicker-week-end" data-event="click"
						data-handler="selectDay" data-month="5" data-year="2025"><a
						class="ui-state-default" href="#">8</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">9</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">10</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">11</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">12</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">13</a></td>
					<td class="ui-datepicker-week-end" data-event="click"
						data-handler="selectDay" data-month="5" data-year="2025"><a
						class="ui-state-default" href="#">14</a></td>
				</tr>
				<tr>
					<td class="ui-datepicker-week-end" data-event="click"
						data-handler="selectDay" data-month="5" data-year="2025"><a
						class="ui-state-default" href="#">15</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">16</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">17</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">18</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">19</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">20</a></td>
					<td class="ui-datepicker-week-end" data-event="click"
						data-handler="selectDay" data-month="5" data-year="2025"><a
						class="ui-state-default" href="#">21</a></td>
				</tr>
				<tr>
					<td class="ui-datepicker-week-end" data-event="click"
						data-handler="selectDay" data-month="5" data-year="2025"><a
						class="ui-state-default" href="#">22</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">23</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">24</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">25</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">26</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">27</a></td>
					<td class="ui-datepicker-week-end" data-event="click"
						data-handler="selectDay" data-month="5" data-year="2025"><a
						class="ui-state-default" href="#">28</a></td>
				</tr>
				<tr>
					<td class="ui-datepicker-week-end" data-event="click"
						data-handler="selectDay" data-month="5" data-year="2025"><a
						class="ui-state-default" href="#">29</a></td>
					<td class="" data-event="click" data-handler="selectDay"
						data-month="5" data-year="2025"><a class="ui-state-default"
						href="#">30</a></td>
					<td
						class="ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled"> </td>
					<td
						class="ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled"> </td>
					<td
						class="ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled"> </td>
					<td
						class="ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled"> </td>
					<td
						class="ui-datepicker-week-end ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled"> </td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>