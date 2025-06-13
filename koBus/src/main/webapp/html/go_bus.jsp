<%@page import="com.util.ConnectionProvider"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>공지사항(목록) | 고객지원 | 고속버스통합예매</title>

<!-- CSS -->
<link rel="stylesheet" href="../media/style.css">
<link rel="stylesheet" href="../media/ui.jqgrid.custom.css">
<!-- <link rel="stylesheet" href="../media/jquery-ui.min.css"> -->
<!-- <link rel="stylesheet" href="../media/remodal.min.css"> -->

<!-- JS -->
<script src="../media/jquery-1.12.4.min.js"></script>
<script src="../media/jquery-ui.min.js"></script> 
<script src="../media/jquery.jqGrid.min.js"></script> 
<!-- <script src="../media/grid.locale-kr.js"></script> -->
<!-- <script src="../media/remodal.min.js"></script> -->

<script src="../media/common.js"></script>
<script src="../media/ui.js"></script>
<script src="../media/plugin.js"></script>
<script src="../media/security.js"></script>
<script src="../media/jquery.number.js"></script>
<script src="../media/new-kor-ui.js"></script>
<!-- <script src="../media/ReadNtcList.js"></script> -->

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

<!-- 작업 -->
<style>
.notice-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 12px 16px;
	border-bottom: 1px solid #333;
	color: #fff;
}

.notice-icon {
	margin-right: 10px;
	color: #f06; /* 강조 색 */
	font-size: 16px;
}

.notice-title {
	flex: 1;
	text-decoration: none;
	color: #fff;
	font-weight: 500;
}

.notice-date {
	min-width: 100px;
	text-align: right;
	color: #aaa;
	font-size: 14px;
}
</style>
<style>
.btn-wrap {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}
.btn {
  padding: 6px 14px;
  background: #114397;
  color: white;
  border-radius: 4px;
  text-decoration: none;
}

</style>
</head>


<!-- [리뉴얼] 페이지 개별 스크립트 신규 정의함 -->


<body class="KO">
	<!-- [리뉴얼] 스킵 네비게이션 신규 정의 -->
	<nav id="skip">
		<ul>
			<li><a href="">본문 바로가기</a></li>
			<li><a href="">주메뉴 바로가기</a></li>
			<li><a href="">푸터 바로가기</a></li>
		</ul>
	</nav>

	<!-- 메인 클래스 : wrapper-main -->
	<div class="wrapper wrapper-kor wrapper-sub">

		<!-- quick -->

		<!-- 퀵메뉴 : 서브페이지에만 적용 작업2-->
		<nav id="new-kor-quickmenu">
			<ul class="quickmenu-list">
				<li><a href=""> <span class="ico"><img
							src="../media/ico-quick-menu01.png"
							alt=""></span> <span class="text">고속버스 예매</span>
				</a></li>
				<li><a href=""> <span class="ico"><img
							src="../media/ico-quick-menu02.png"
							alt=""></span> <span class="text">예매확인</span>
				</a></li>
				<li><a href=""> <span class="ico"><img
							src="../media/ico-quick-menu03.png"
							alt=""></span> <span class="text">도착시간 안내</span>
				</a></li>
				<li><a href=""> <span class="ico"><img
							src="../media/ico-quick-menu04.png"
							alt=""></span> <span class="text">프리패스 구매</span>
				</a></li>
				<li><a href=""> <span class="ico"><img
							src="../media/ico-quick-menu05.png"
							alt=""></span> <span class="text">정기권 구매</span>
				</a></li>
				<li class="to-top"><a href="javascript:void(0)"> <span
						class="ico"><img
							src="../media/ico-to-top.png" alt=""></span>
						<span class="text">TOP</span>
				</a></li>
			</ul>
		</nav>


		<!-- header -->


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
		<header id="new-kor-header">
			<div class="top-menu-area">
				<div class="container">
					<h1 id="logo">
						<a href=""> <img
							src="../media/logo.png"
							alt="KOBUS 전국고속버스운송사업조합">
						</a>
					</h1>
					<nav class="util-menus">

						<ul class="util-list">

							<li><a href="" class="login">로그인</a></li>
							<li><a href="">회원가입</a></li>

							<li><a href="">마이페이지</a></li>
							<li><a href="">결제내역조회</a></li>
							<li><a href="">사이트맵</a></li>
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
									<li><a href="">시간표 조회</a></li>
									<li><a href="">도착시간 안내</a></li>
								</ul></li>


							<li><a href="javascript:void(0)">프리패스/정기권</a>
								<ul>
									<li><a href="">프리패스 여행권</a></li>
									<li><a href="">정기권</a></li>
									<li><a href="">상품 구매내역</a></li>
								</ul></li>


							<li><a href="javascript:void(0)">이용안내</a>
								<ul>
									<li><a href="">예매 안내</a></li>
									<li><a href="">결제수단 안내</a></li>
									<li><a href="">승차권 환불안내</a></li>
									<li><a href="">프리미엄 마일리지</a></li>

									<li><a href="">휴게소 환승안내</a></li>
									<li><a href="">고속버스 터미널</a></li>
									<li><a href="">고속버스 운송회사</a></li>
								</ul></li>
							<li><a href="javascript:void(0)">고객지원</a>
								<ul>
									<li><a href="">공지사항</a></li>
									<li><a href="">자주찾는 질문</a></li>
									<li><a href="">유실물센터 안내</a></li>
								</ul></li>
						</ul>
					</div>
					<div class="links">
						<!-- <a href="https://www.tmoney.co.kr" class="btn btn-tmoney" title="새창" target="_blank">
					<img src="/images/kor/layout/ico-tmoney-app.png" alt="" />고속버스 티머니
					<i class="ico ico-arrow-new-window"></i>
				</a> -->

						<a href="" class="btn btn-job" title="새창" target="_blank"> <img
							src="../media/ico-job-offer.png" alt="">승무사원
							모집 <i class="ico ico-arrow-new-window"></i>
						</a>
					</div>
					<div class="bg-layer">
						<a href="" title="새창" class="gnb-baaner"> <iframe
								src="../media/_ad-tubebox-002GNB.html"
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
								aria-expanded="false"> <span class="text">고객지원</span><i
								class="ico ico-dropdown-arrow"></i></a>

							<ul class="dropdown-list">

								<li><a href="">고속버스예매</a></li>

								<li><a href="">운행정보</a></li>


								<li><a href="">프리패스/정기권</a></li>


								<li><a href="">이용안내</a></li>


								<li class="selected"><a href="javascript:void(0)"
									title="선택됨">고객지원</a></li>


								<li><a href="">전국고속버스운송사업조합</a></li>


								<li><a href="">터미널사업자협회</a></li>

							</ul>
						</div>
					</li>

					<li>
						<div class="dropdown-wrap breadcrumb-select">


							<a href="javascript:void(0)" class="btn-dropdown" title="하위메뉴 선택"
								aria-expanded="false"> <span class="text">공지사항</span><i
								class="ico ico-dropdown-arrow"></i></a>


							<ul class="dropdown-list">


								<li class="selected"><a href="javascript:void(0)"
									title="선택됨">공지사항</a></li>

								<li><a href="">자주하는 질문</a></li>

								<li><a href="">유실물센터 안내</a></li>

							</ul>
						</div>
					</li>
				</ol>

			</div>
		</nav>


		<article id="new-kor-content">


			<!-- <script type="text/javascript" src="new_media/ReadNtcList.js"></script> -->

			<div class="title_wrap customerT" style="display: none;">


				<a href="" class="back">back</a> <a href="" class="mo_toggle">메뉴</a>


				<h2>공지사항</h2>
			</div>


			<!-- 타이틀 -->

			<div class="content-body customer">
				<div class="container">

					<form id="inqrForm" name="inqrForm" method="post">
						<input type="hidden" id="ntcNo" name="ntcNo"> <input
							type="hidden" id="pageIdx" name="pageIdx" value="1">
						<div class="noti_wrap hide_mo">
							<p class="noti">고속버스 홈페이지의 새로운 소식을 확인하세요.</p>
						</div>
						<div class="search_wrap type2">
							<p class="search_box">
								<input type="text" id="srchNtcTlNm" name="srchNtcTlNm"
									placeholder="검색어를 입력하세요" title="검색어를 입력하세요" value=""
									onkeydown="fnSubmit();">
								<button type="button" onclick="fnSrchBtnClick();">검색</button>
							</p>
						</div>
						<div class="board_list">
							<ul>

								<!-- 작업 -->
								<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

								<div class="btn-wrap">
									<a id="list" href="noticeList.do" class="btn">List</a> <a
										id="write" href="noticeWrite.do" class="btn">글쓰기</a>
								</div>

								<c:forEach var="dto" items="${list}">
									<li class="notice-row"><span class="notice-icon">📌</span>
										<a href="noticeView.do?notID=${dto.notID}" class="notice-title">${dto.topic}</a>
										<span class="notice-date">${dto.notDate}</span></li>
								</c:forEach>




							</ul>
						</div>
					</form>
					<!-- paging -->
					<p class="paging_wrap">
						<span class="paging"> <a href="javascript:void(0)"
							onclick="paginationClick(1); return false;" class="first"><span
								class="sr-only">처음 목록</span></a><a href="javascript:void(0)"
							onclick="paginationClick(1); return false;" class="prev"><span
								class="sr-only">이전 목록</span></a><strong aria-current="page">1</strong><a
							href="javascript:void(0)"
							onclick="paginationClick(2); return false;">2</a><a
							href="javascript:void(0)"
							onclick="paginationClick(3); return false;">3</a><a
							href="javascript:void(0)"
							onclick="paginationClick(4); return false;">4</a><a
							href="javascript:void(0)"
							onclick="paginationClick(5); return false;">5</a><a
							href="javascript:void(0)"
							onclick="paginationClick(6); return false;">6</a><a
							href="javascript:void(0)"
							onclick="paginationClick(7); return false;">7</a><a
							href="javascript:void(0)"
							onclick="paginationClick(8); return false;">8</a><a
							href="javascript:void(0)"
							onclick="paginationClick(9); return false;">9</a><a
							href="javascript:void(0)"
							onclick="paginationClick(10); return false;">10</a><a
							href="javascript:void(0)"
							onclick="paginationClick(11); return false;" class="next"><span
								class="sr-only">다음 목록</span></a><a href="javascript:void(0)"
							onclick="paginationClick(14); return false;" class="end"><span
								class="sr-only">마지막 목록</span></a>

						</span>
					</p>
					<!-- //paging -->
				</div>

			</div>

		</article>

		<!-- footer -->


		<!-- 푸터 -->
		<footer id="new-kor-footer">
			<div class="container">
				<div class="footer-top-cont">
					<ul class="express-bus-company-list">
						<li><a href="" target="_blank" title="새창"><img
								src="../media/logo-kumho-express.png"
								alt="금호고속"></a></li>
						<li><a href="" target="_blank" title="새창"><img
								src="../media/logo-dongbu-express.png"
								alt="동부고속"></a></li>
						<li><a href="" target="_blank" title="새창"><img
								src="../media/logo-sokrisan-express.png"
								alt="속리산고속"></a></li>
						<li><a href="" target="_blank" title="새창"><img
								src="../media/logo-dongyang-express.png"
								alt="동양고속"></a></li>
						<li><a href="" target="_blank" title="새창"><img
								src="../media/logo-samhwa-express.png"
								alt="삼화고속"></a></li>
						<li><a href="" target="_blank" title="새창"><img
								src="../media/logo-joongang-express.png"
								alt="중앙고속"></a></li>
						<li><a href="" target="_blank" title="새창"><img
								src="../media/logo-chunil-express.png"
								alt="천일고속"></a></li>
						<li><a href="" target="_blank" title="새창"><img
								src="../media/logo-hanil-express.png"
								alt="한일고속"></a></li>
					</ul>
					<!-- dropdown-top 클래스 추가 시, 드롭다운 목록 위로 노출 -->
					<div class="dropdown-wrap dropdown-top related-sites-select">
						<a href="javascript:void(0)" class="btn-dropdown" title="관련사이트 이동"
							aria-expanded="false"><span class="text">관련사이트</span><i
							class="ico ico-arrow-down"></i></a>
						<ul class="dropdown-list">
							<li class="selected"><a href="" target="_blank" title="새창">장애인
									휠체어 사이트</a></li>
							<li><a href="" target="_blank" title="새창">국가대중교통정보센터</a></li>
							<li><a href="" target="_blank" title="새창">인천장애인콜택시</a></li>
							<li><a href="" target="_blank" title="새창">센트럴시티터미널</a></li>
							<li><a href="" target="_blank" title="새창">시외버스 통합예매시스템</a></li>
						</ul>
					</div>
				</div>
				<div class="footer-bottom-cont">
					<address class="address">
						<ul class="policy-list">
							<li><a href="">서비스 이용약관</a></li>
							<li><a href="" class="text-bold">개인정보 처리방침</a></li>
							<li><a href="">고속버스 운송약관</a></li>
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
						<li><a href="" target="_blank" title="새창"><img
								src="../media/logo-accessibility2.png"
								alt="(사)한국장애인단체총연합회 한국웹접근성인증평가원 웹 접근성 우수사이트 인증마크(WA인증마크)"
								height="40"></a></li>
						<li><a href="" title="이사장 인사말 바로가기"><img
								src="../media/logo-kobus.png"
								alt="KOBUS 전국고속버스운송사업조합"></a></li>
						<li><a href="" title="협회장 인사말 바로가기"><img
								src="../media/logo-npvtba-express.png"
								alt="전국여객자동차터미널사업자협회"></a></li>
					</ul>
				</div>
			</div>
		</footer>

	</div>




</body>
<whale-quicksearch translate="no" style="visibility: visible;">
<template shadowrootmode="closed">
	<style></style>
	<div class="anchor"></div>
	<div class="quicksearch" data-version="a704a9c"></div>
</template>
</whale-quicksearch>
<widget-window
	style="opacity: 1; background-color: rgb(255, 255, 255); border: 1px solid rgb(135, 132, 129); width: auto; height: auto; display: none;">
<template shadowrootmode="open">
	<style>
* {
	margin: 0;
	padding: 0;
	user-select: none
}

#content {
	display: grid;
	grid-template-rows: 40px calc(100% - 55px) 15px;
	height: 100%;
	grid-template-columns: 100%;
	box-sizing: border-box
}

#header {
	overflow: hidden;
	z-index: 2000;
	height: 40px;
	margin-bottom: -1px;
	font-family: Helvetica, sans-serif;
	font-size: 12px;
	line-height: 1.25em;
	box-sizing: border-box;
	cursor: move
}

#header h1 {
	margin-left: 10px;
	height: 39px;
	font-weight: normal;
	color: #878481;
	position: relative;
	display: inline-block;
	white-space: nowrap;
	box-sizing: border-box;
	padding: 14px 5px;
	font-size: 12px;
	letter-spacing: -0.05em;
	font-weight: normal;
	align-content: center
}

#header #opacity-bar {
	-webkit-appearance: none;
	position: absolute;
	right: 35px;
	top: 18px;
	width: 50px;
	margin-right: 10px
}

#header #opacity-bar:focus {
	outline: none
}

#header #opacity-bar::-webkit-slider-runnable-track {
	width: 100%;
	height: 3px;
	cursor: pointer;
	border-radius: 2px;
	background: #878481
}

#header #opacity-bar::-webkit-slider-thumb {
	border: 0px;
	border-radius: 100%;
	height: 10px;
	width: 10px;
	background: #c3c2c0;
	cursor: pointer;
	-webkit-appearance: none;
	margin-top: -3px
}

.window-close {
	position: absolute;
	right: 0;
	top: 0;
	padding: 10px;
	cursor: pointer
}

.window-close:hover {
	filter: brightness(0%)
}

#header:active::before {
	position: fixed;
	content: "";
	top: 0;
	left: 0;
	width: 100vw;
	height: 100vh;
	background-color: rgba(0, 0, 0, 0)
}

table#main {
	overflow: hidden;
	width: 100%;
	height: 100%;
	min-height: 44px;
	grid-template-rows: 30px calc(100% - 30px);
	box-sizing: border-box;
	display: grid;
	border-spacing: 2px;
	position: relative
}

table#main thead {
	border-bottom: 1px solid #eee;
	margin: 0 5px
}

table#main thead tr {
	display: grid;
	grid-template-columns: auto 75px 65px 75px;
	font-size: 12px;
	line-height: 1.7em;
	font-family: sans-serif
}

table#main thead tr th {
	clip: auto;
	height: 34px;
	line-height: 34px;
	font-size: 12px;
	color: #878481;
	position: static !important;
	font-weight: normal
}

table#main tbody {
	overflow-y: scroll;
	height: 100%;
	text-align: center
}

table#main tbody::-webkit-scrollbar {
	width: 5px
}

table#main tbody::-webkit-scrollbar-thumb {
	background-color: rgba(135, 132, 129, .4);
	border-radius: 5px
}

table#main tbody tr {
	display: grid;
	height: 22px;
	grid-template-columns: auto 75px 65px 75px;
	font-size: 12px;
	line-height: 1.7em;
	font-family: sans-serif
}

table#main tbody tr td {
	padding-top: 2px;
	font-size: 12px;
	line-height: 1.7em;
	font-family: sans-serif;
	color: #666;
	border-bottom: 1px solid #eee
}

table#main tbody tr td:first-child {
	text-align: left;
	padding-left: 15px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	margin-left: 5px
}

table#main tbody tr td:nth-child(2) {
	text-align: right;
	font-size: 11px
}

table#main tbody tr td:nth-child(3) {
	text-align: right;
	font-size: 11px
}

table#main tbody tr td:nth-child(3).lower-stock {
	color: #017eff
}

table#main tbody tr td:nth-child(3).upper-stock {
	color: #e12301
}

table#main tbody tr td:nth-child(4) {
	font-family: sans-serif;
	position: relative
}

table#main tbody tr td:nth-child(4) span {
	position: absolute;
	width: 55px;
	height: 22px;
	right: 15px;
	text-align: right;
	font-size: 11px
}

table#main tbody tr td:nth-child(4) span.lower-stock {
	color: #017eff
}

table#main tbody tr td:nth-child(4) span.upper-stock {
	color: #e12301
}

.icon {
	width: 8px;
	margin-right: 3px;
	display: inline-block;
	vertical-align: middle;
	overflow: hidden
}

*::-webkit-scrollbar:not(tbody) {
	width: 0
}
</style>
	<div id="content">
		<div id="header">
			<h1 id="widget-title">undefined</h1>
			<input id="opacity-bar" type="range" min="1" max="100"
				style="opacity: 0.31;"> <span class="window-close"
				style="opacity: 0.31;"><img alt="미니위젯 닫기"
				class="window-close"
				src="chrome-extension://loboidpmlojcalnkgelcncghllmkiico/img/close.svg"
				width="20" height="20" style="opacity: 0.31;"></span>
		</div>
		<table id="main">
			<thead>
				<tr>
					<th>종목</th>
					<th>시세</th>
					<th>전일비</th>
					<th>등락률</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
		<div id="footer"></div>
	</div>
</template>
</widget-window>
</html>