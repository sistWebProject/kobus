<%@page import="com.util.ConnectionProvider"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>공지사항(목록) | 고객지원 | 고속버스통합예매</title>

<!-- CSS -->
<link rel="stylesheet" href="/koBus/media/style.css">
<link rel="stylesheet" href="/koBus/media/ui.jqgrid.custom.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" />

<!-- JS -->
<script src="/koBus/media/jquery-1.12.4.min.js"></script>
<script src="/koBus/media/jquery-ui.min.js"></script>
<script src="/koBus/media/jquery.jqGrid.min.js"></script>

<script src="/koBus/media/common.js"></script>
<script src="/koBus/media/ui.js"></script>
<script src="/koBus/media/plugin.js"></script>
<script src="/koBus/media/security.js"></script>
<script src="/koBus/media/jquery.number.js"></script>
<script src="/koBus/media/new-kor-ui.js"></script>


<title>자주하는 질문 | 고객지원 | 고속버스통합예매</title>




<link rel="shortcut icon"
	href="https://www.kobus.co.kr/images/favicon.ico">



<script type="text/javascript">
	/*********************************************
	 * 상수
	 *********************************************/
</script>


<link rel="stylesheet" type="text/css"
	href="/koBus/media/ui.jqgrid.custom.css">

<script type="text/javascript"
	src="/koBus/media/jquery-1.12.4.min.js"></script>
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
<script type="text/javascript"
	src="/koBus/media/ui.js"></script>
<script type="text/javascript"
	src="/koBus/media/plugin.js"></script>
<script type="text/javascript"
	src="/koBus/media/common.js"></script>

<script type="text/javascript"
	src="/koBus/media/jquery.number.js"></script>
<script type="text/javascript"
	src="/koBus/media/security.js"></script>


<link rel="stylesheet" type="text/css"
	href="/koBus/media/style.css">
<script type="text/javascript"
	src="/koBus/media/new-kor-ui.js"></script>
</head>




<!-- [리뉴얼] 페이지 개별 스크립트 신규 정의함 -->


<body class="KO">
	<!-- [리뉴얼] 스킵 네비게이션 신규 정의 -->
	<nav id="skip">
		<ul>
			<li><a
				href="https://www.kobus.co.kr/cscn/qna/readQnaList.do#new-kor-content">본문
					바로가기</a></li>
			<li><a
				href="https://www.kobus.co.kr/cscn/qna/readQnaList.do#new-kor-gnb">주메뉴
					바로가기</a></li>
			<li><a
				href="https://www.kobus.co.kr/cscn/qna/readQnaList.do#new-kor-footer">푸터
					바로가기</a></li>
		</ul>
	</nav>

	<!-- 메인 클래스 : wrapper-main -->
	<div class="wrapper wrapper-kor wrapper-sub">




		<!-- 퀵메뉴 : 서브페이지에만 적용 -->
		<nav id="new-kor-quickmenu">
			<ul class="quickmenu-list">
				<li><a href="https://www.kobus.co.kr/mrs/rotinf.do"> <span
						class="ico"><img
							src="/koBus/media/ico-quick-menu01.png"
							alt=""></span> <span class="text">고속버스 예매</span>
				</a></li>
				<li><a href="https://www.kobus.co.kr/mrs/mrscfm.do"> <span
						class="ico"><img
							src="/koBus/media/ico-quick-menu02.png"
							alt=""></span> <span class="text">예매확인</span>
				</a></li>
				<li><a
					href="https://www.kobus.co.kr/oprninf/arscgd/oprnArscGd.do"> <span
						class="ico"><img
							src="/koBus/media/ico-quick-menu03.png"
							alt=""></span> <span class="text">도착시간 안내</span>
				</a></li>
				<li><a
					href="https://www.kobus.co.kr/adtnprdnew/frps/frpsPrchGd.do"> <span
						class="ico"><img
							src="/koBus/media/ico-quick-menu04.png"
							alt=""></span> <span class="text">프리패스 구매</span>
				</a></li>
				<li><a
					href="https://www.kobus.co.kr/adtnprdnew/pass/passPrchGd.do"> <span
						class="ico"><img
							src="/koBus/media/ico-quick-menu05.png"
							alt=""></span> <span class="text">정기권 구매</span>
				</a></li>
				<li class="to-top"><a href="javascript:void(0)"> <span
						class="ico"><img
							src="/koBus/media/ico-to-top.png" alt=""></span>
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
						<a href="https://www.kobus.co.kr/main.do"> <img
							src="/koBus/media/logo.png"
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
							src="/koBus/media/ico-job-offer.png" alt="">승무사원
							모집 <i class="ico ico-arrow-new-window"></i>
						</a>
					</div>
					<div class="bg-layer">
						<a
							href="https://safeconnect.co.kr/sfconn/login/csc_pc?et=psn249R01&amp;ptrSvcSn=psn249"
							title="새창" class="gnb-baaner"> <iframe
								src="/koBus/media/_ad-tubebox-002GNB.html"
								title="프레임 (전화번호안심 로그인)" class="ad-frame"></iframe>
						</a>
					</div>
				</div>
			</nav>
		</header>



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


				<li><a href="https://www.kobus.co.kr/mrs/rotinf.do">고속버스예매</a></li>

	<li><a
									href="https://www.kobus.co.kr/oprninf/alcninqr/oprnAlcnPage.do">운행정보</a></li>
					<li><a
									href="https://www.kobus.co.kr/adtnprdnew/frps/frpsPrchGd.do">프리패스/정기권</a></li>


								<li><a href="https://www.kobus.co.kr/ugd/mrsgd/Mrsgd.do">이용안내</a></li>




								<li class="selected"><a href="javascript:void(0)"
									title="선택됨">고객지원</a></li>






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
								aria-expanded="false"> <span class="text">자주하는 질문</span><i
								class="ico ico-dropdown-arrow"></i></a>






							<ul class="dropdown-list">











								<li><a
									href="https://www.kobus.co.kr/cscn/ntcmttr/readNtcList.do">공지사항</a></li>



								<li class="selected"><a href="javascript:void(0)"
									title="선택됨">자주하는 질문</a></li>



								<li><a
									href="https://www.kobus.co.kr/cscn/lossClnc/readLossClncList.do">유실물센터
										안내</a></li>






							</ul>
						</div>
					</li>
				</ol>

			</div>
		</nav>


		<article id="new-kor-content">



			<script type="text/javascript"
				src="/koBus/media/ReadQnaList.js"></script>

			<div id="contents" style="padding-top: 0px;">
				<div class="title_wrap customerT" style="display: none;">





					<a href="https://www.kobus.co.kr/cscn/qna/readQnaList.do#"
						class="back">back</a> <a
						href="https://www.kobus.co.kr/cscn/qna/readQnaList.do#"
						class="mo_toggle">메뉴</a>


					<h2>자주하는 질문</h2>
				</div>


				<!-- 타이틀 -->
				<div class="content-header"
					data-page-title="자주하는 질문 | 고객지원 | 고속버스통합예매">
					<div class="container">
						<div class="title-area">
							<h2 class="page-title">자주하는 질문</h2>
						</div>
					</div>
				</div>





				<div class="content-body customer">
					<div class="container">

						<div class="noti_wrap hide_mo">
							<p class="noti">고객님들이 자주 문의하시는 질문과 답변내용입니다.</p>
						</div>
						<div class="search_wrap type2 custom_input">
							<div class="box_inputForm click_box inselect">


								<!-- 웹 접근성 개선 셀렉트 박스 UI -->

								<div class="dropdown-wrap select-default">
									<a href="javascript:void(0)" class="btn-dropdown"
										title="질문 구분 선택" aria-expanded="false"> <span class="text">전체</span></a>
									<ul class="dropdown-list">

										<li><a href="javascript:fnQnaListSet(0)">전체</a></li>

										<li><a href="javascript:fnQnaListSet(1)">예매</a></li>

										<li><a href="javascript:fnQnaListSet(2)">조회/변경/취소</a></li>

										<li><a href="javascript:fnQnaListSet(3)">결제</a></li>

										<li><a href="javascript:fnQnaListSet(4)">홈티켓</a></li>

										<li><a href="javascript:fnQnaListSet(5)">고속버스 운행</a></li>

										<li><a href="javascript:fnQnaListSet(6)">회원</a></li>

										<li><a href="javascript:fnQnaListSet(7)">기타</a></li>

									</ul>
								</div>

							</div>
						</div>
						<dl class="faq">
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>예매 가능 기간 및 명절 연휴 예매 기간은 언제입니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										예매 가능일자와 관련하여 따로 정해진 기간은 없으며, 배차 정보가 입력되어 있는 경우에 조회/예매가 가능합니다.<br>배차정보는
										각 출발지 터미널에서 입력합니다. 다음달 배차정보는 전월 20일경에 입력하고 있으나, 출발지 터미널에 따라
										기간이 달라질 수 있습니다. <br>
										<br>명절의 경우 접속과다로 인한 부하를 방지하기 위하여 특송기간 전용 홈페이지로 전환하여 운영하지만
										예매 기간은 동일하게 적용됩니다.<br>
										<br>배차정보에 관한 더 자세한 사항은 출발지 터미널에 문의해주시기 바랍니다.<br>
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>노선조회시 "배차정보가 존재하지 않습니다."라는 문구가 나타납니다.
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										배차정보가 아직 입력되어 있지 않은 상태이며, 배차 정보가 입력되어 있어야만 조회/예매가 가능합니다. <br>배차정보는
										각 출발지 터미널에서 입력합니다. 다음달 배차정보는 전월 20일경에 입력하고 있으나, 출발지 터미널에 따라
										기간이 달라질 수 있습니다. <br>배차정보에 관한 더 자세한 사항은 출발지 터미널에 문의해주시기
										바랍니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>"이 구간은 홈페이지 예매가 불가능 합니다."라는 문구가 나타납니다.
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										일부 소도시 터미널은 신용카드 발권을 도입하지 않고 있습니다. 전산센터 입장에서는 신용카드 발권 도입을 권유하고
										있지만 터미널의 권한이라 임의로 바꿀 수 없는 사항 입니다. <br>이러한 구간의 경우 홈페이지를 통한
										예매는 불가하고, 터미널에 직접 방문하셔서 승차권을 발권하셔야 합니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>홈페이지 예매 후 터미널 창구에서의 승차권 발권은 어떻게 할 수
									있습니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>카드결제를 통한 예매의 경우 예매시 사용하신 카드를 지참하셔야 하며, 기타 결제수단을 통한 예매의
										경우에는 본인 휴대폰번호와 생년월일 정보를 창구에서 말씀하시면 승차권 발권이 가능합니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>고객센터의 상담원 연결을 통한 예매가 가능 합니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>예매는 홈페이지, 모바일, 터미널에서 본인이 직접 하셔야 하며, 상담원 연결을 통한 예매는
										불가합니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>예매시 "카드인증실패" 문구가 나타납니다.
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										카드에 대한 문제나 정보입력상에 오류가 있을 경우 예매 진행이 어려울 수 있습니다. <br>연체,
										카드사용중지, 사용한도초과, 주민번호오류, 유효기간 입력오류 등의 경우가 있을 수 있으며, 이에 대한 자세한
										사항은 해당 카드사를 통해 확인해주시기 바랍니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>예매한 승차권은 어떻게 발권할 수 있습니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										예매하신 승차권 발권은 예매에 사용한 카드를 소지 후 출발시간 이전에 해당 터미널 매표창구에서 발권할 수
										있습니다.<br>발권시 예매에 사용한 카드를 제시하시면 바로 발권이 가능합니다. 또한 왕복으로 예매를
										하시면 해당 터미널에서 왕복 발권도 가능합니다. 다만 출발지나 도착지 외의 터미널에서의 발권은 불가합니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>예매 가능 시간은 언제입니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>예매에 특별히 정해진 시간은 없으며, 해당 출발지 터미널의 배차정보가 입력되어 있으면 홈페이지 또는
										고속버스모바일앱을 통해 예매가 가능합니다. &lt;br&gt;</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>고속버스 승차권도 할인 요금을 적용 받을 수 있습니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>고속버스 요금할인은 일반적으로 아동/중고생으로 구분되어 있으나 예외적으로 일부 고속사의 노선별
										운영정책에 따라 대학생 할인 요금이 적용되는 노선이 있으며, 고속버스 요금할인 정책은 노선별, 구간별로
										고속사마다 다르게 운영되고 있습니다. 홈페이지에서 할인 요금이 적용되는 노선은 예매 좌석 선택 시 권종이
										표기되어 있는 것으로 확인하실 수 있습니다. 예매하시는 노선이 할인 적용 노선일 경우 검표 시 학생증(청소년증)
										제시를 요청할 수 있으므로 탑승시 반드시 학생증(청소년증)을 지참하시기 바랍니다. 학생증(청소년증) 미 지참 시
										일반요금으로 부과될 수 있습니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>한번에 예매 가능한 승차권 매수는 어떻게 됩니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>1회 최대 예매 매수는 6매입니다.(일부 시외우등 노선에 한정하여 10매까지 예매가능)</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>환승지에서 다른 차량으로 환승하는 노선을 예매하고 싶습니다.
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										홈페이지에서 예매 진행 시 "환승" 구분을 선택 후 출발지/도착지를 설정하여 조회하시기 바랍니다.<br>먼저
										[출발지→환승지] 노선에 대한 예매가 진행되며, 완료 후 이어서 [환승지→도착지]노선 예매가 가능합니다.<br>환승
										노선을 예매하시면 중간 환승지에서 다른 차량으로 환승이 필요하니 참고하시기 바랍니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>홈페이지에서 예매 후 고속버스모바일앱에서 승차권 조회 및 사용이
									가능합니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										홈페이지에서 예매 진행 시 "모바일티켓"으로 예매할 수 있습니다.<br>"모바일티켓"으로 예매하셔야만
										모바일앱에서 조회 및 사용이 가능하며 "일반티켓"으로 예매하시면 모바일앱에서는 조회되지 않으니 참고하시기
										바랍니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>예매사항의 변경시 날짜 변경이 불가한 이유는 무엇입니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>무분별한 날짜 변경으로 인한 승차권 부족 현상을 방지하기 위하여 예매 변경 시 날짜 변경이 불가하도록
										제한하고 있으니 양해 부탁드립니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>예매한 승차권의 시간 변경은 어떻게 할 수 있습니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										시간변경은 동일 날짜/노선에 한하여 차량 출발시간 1시간 이전까지 시간변경 기능을 통해 가능합니다.(1회 가능)<br>시간변경
										기능은 [예매확인]→[예매 확인/취소/변경] 메뉴에서 확인하실 수 있습니다.<br>
										<br>시간변경 기능의 절차는 기존 예매한 티켓을 취소 후 재결제 하는 방식으로 이루어지며, 해당
										기능을 통해 재결제할 경우 수수료가 부과되지 않습니다.<br>
										<br>차량 출발 1시간 이내 티켓이라면, 예매 취소 후 다시 예매하셔야 합니다.<br>
										<br>예매 취소 후 재예매를 하실 경우 "고속버스운송약관"에 따라 취소 수수료 부과 및 좌석 부족으로
										승차권 예매가 불가할 수 있는 점 양해부탁드립니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>승차권의 영수증 발급은 어떻게 할 수 있습니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										승차권 예매 후 바로 영수증 출력이 가능합니다.<br>영수증은 [예매확인]→[예매 확인/취소/변경]
										메뉴로 이동하여 확인하실 수 있으며, 홈페이지에서 예매하지 않은 승차권 영수증의 경우 [예매확인]→[영수증
										발행] 메뉴로 이동하여 확인하시기 바랍니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>예매한 승차권의 내역 조회가 불가합니다.
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										고객님께서 비회원으로 예매하신 승차권을 회원 가입하여 예매 승차권을 조회하시면 조회가 불가합니다. 비회원으로
										예매하신 경우 예매한 휴대폰 번호+ 비밀번호 4자리 입력 후 예매 내역을 확인할 수 있습니다.<br>
										<br>내역 조회가 되지 않을 경우 이용 터미널 매표소로 문의해주시기 바랍니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>홈페이지에서 승차권 취소 후 완료시점이 궁금합니다.
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										승차권을 예매하신 후 당일 취소 하실 경우 대부분의 신용카드사에서는 승인 취소 문자가 발송되고 있습니다. 그러나
										예매일과 취소일이 다를 경우 약 3~5일 가량 소요됩니다.<br>
										<br>취소 수수료가 부과되는 경우 취소 수수료 재정산일이 소요되어 취소 처리 기간이 3~5일가량
										소요될 수 있으며, 만약 취소 일자에 잔액부족 또는 승인한도 부족으로 수수료가 결제되지 못했다면 취소가 지연될
										수 있습니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>예매에 사용한 카드의 분실/갱신으로 인해 카드번호가 바뀌었을 경우
									예매한 승차권은 어떻게 발권할 수 있습니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										예매에 사용한 분실카드나 갱신 전 카드번호를 꼭 인지하셔야 합니다. <br>터미널에서 분실/갱신 전
										카드로 예매된 사항을 취소하시고 그 표를 다시 신규카드나 현금으로 발권하실 수 있습니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>예매한 사람이 아닌 타인이 카드를 소지하고 있을 경우 터미널에서 예매한
									표를 발권을받을 수 있습니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>현행법상 신용카드는 타인에게 대여, 양도를 할수 없으므로 발권이 불가능합니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>체크카드와 선불성 신용카드를 통한 예매가 가능합니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										신용카드(Check, Plus, Virtual)와 선불성카드의 경우, 발권 후 환불이나 취소시 해당 카드의
										특성상 자동전산처리가 불가하여 고객의 피해사항 발생 소지가 있어 카드 예매 서비스가 불가합니다.<br>(단,
										예매가 가능한 카드는 사용할 수 있는 카드입니다)
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>카드번호와 비밀번호를 알면 예매에 사용한 카드가 없어도 발권이
									가능합니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>예매에 사용한 카드를 소지하지 않고 카드 번호와 비밀번호만 인지하고 있을 경우에는 발권이
										불가능합니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>터미널에서 카드로 발권 후 환불/취소를 했는데 카드요금이
									청구되었습니다.
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										-카드로 승차권을 구매한 당일 환불이나 취소를 할 경우 : <br>카드 사용내역 조회시 카드매표
										구매사항이 사용내역에 포함되지 않습니다. <br>-카드로 승차권을 구매한 당일 이후 환불이나 취소를
										하시는 경우 :<br>카드사의 취소처리가 취소일로부터 3-4일정도 소요됩니다. 1주일 정도 후에
										사용내역을 조회하시면 정상적(미청구)으로 처리가 되어 있습니다.<br>
										<br>취소 처리기간 중 결제기준일자가 중간에 끼어있게되면 청구서에는 청구가 되나 결제출금시에는
										환불/취소 금액 만큼이 미반영되며, 카드에 따라서는 다음달에 환불/취소 금액 만큼을 감액 청구합니다. 위 결제
										사항은 사용카드사에 문의하시면 됩니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>신용카드 정보의 보안 적용 방식에 대해 궁금합니다.
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										신용카드정보는 128-bit SSL(Secure Socket Layer)을 통해 암호화되어 전송됩니다.<br>인증서는
										가장 지명도 있는 인증기관인 VeriSign으로부터 받았으며, 예매하신 모든 정보는 외부에서 접근이 불가합니다.
										<br>예매시 결제정보 입력 부분에서 URL이 ""https://xxx.xxx"" 로 바뀌면 SSL이
										이미 적용되어 있는 것이니 안심하고 사용하시기 바랍니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>승차권 예매시 이용 가능한 결제 수단은 어떤 것들이 있습니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>홈페이지에서 승차권 예매시 카드결제, 계좌이체, 부가상품(프리패스)의 결제수단을 이용하실 수
										있습니다.&lt;br&gt;결제 수단에 대한 자세한 사항은 [이용안내]→[결제수단 안내] 메뉴에서 확인
										가능합니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>계좌이체를 통한 승차권 예매 후 터미널에서 발권을 하려면 어떻게 해야
									합니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>계좌이체 예매 후 승차권을 터미널에서 발권할 경우에는 예매 당시 입력한 휴대폰번호(회원의 경우 가입
										시 입력한 휴대폰번호)와 생년월일(법인은 사업자 등록번호)가 필요합니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>계좌이체 예매 후 취소/환불할 경우 처리 기간은 어떻게 됩니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>계좌이체 예매 취소시 즉시 예매 당시의 출금계좌로 입금되나 장애 발생 시 최대 한 시간까지 입금이
										지연될 수 있습니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>계좌이체 예매시 현금영수증 발급이 가능합니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>계좌이체 예매시 현금영수증 발급정보(휴대폰번호 또는 사업자 등록 번호, 현금영수증 카드 번호)를 통해
										현금영수증을 발급받으실 수 있습니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>계좌이체 예매 가능 시간은 어떻게 됩니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										계좌이체 예매시 개인 계좌의 경우 365일 24시간 이용 가능하나, 법인 계좌일 경우 평일 및 토요일에는 오전
										8시부터 오후 10시까지 이용 가능하며 공휴일에는 사용이 불가합니다.<br>또한 은행 및 증권사에 따라
										이용 가능 서비스 시간이 달라질 수 있습니다. 이에 대한 내용은 [이용안내]→[결제수단 안내]에서 확인하실 수
										있습니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>고속버스 홈티켓 발행 후 사용하지 못한 승차권의 환불이 가능합니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>해당 차량이 출발된 이후의 승차권 환불은 차량출발 후 도착예정시간까지 출발지 터미널 및 홈페이지에서
										가능합니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>고속버스 홈티켓을 출력 후 분실했습니다.
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										홈페이지에 접속하시면 홈티켓 재발행이 가능합니다. 프린터가 연결된 PC에서 홈페이지 접속 후 재발행 하시기
										바랍니다.<br>모바일 환경에서 접속시 홈티켓 발행기능이 제한되오니 참고하시기 바랍니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>고속버스노선, 운행횟수 증설 및 신설, 불편사항은 어디에 문의해야
									합니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>고속버스 운행에 관한 모든 사항은 고속사에서 결정 및 관리하고 있으므로, 해당노선의 고속회사
										홈페이지나 담당부서에 문의하셔야 합니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>마일리지(프리미엄) 적립 방식에 대해 궁금합니다.
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>· 고속사에서 제공하는 마일리지(프리미엄)는 프리미엄 고속버스 이용 시마다 승차권 금액의 2%가
										포인트로 적립됩니다. * 적립일로부터 2년이 경과될 경우 해당 마일리지(프리미엄)는 자동 소멸합니다. ·
										프리미엄 요금할인 노선과 비회원 및 터미널 현장 예매로 이용하였을 경우 적립되지 않습니다. · 프리미엄
										마일리지는 D+2일 이후 적립 건을 확인하실 수 있습니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>고속버스 예매를 위해서 회원가입이 필수입니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>홈페이지에서 예매시 비회원으로 예매 가능합니다.회원으로 예매하시면 홈페이지뿐 아니라 모바일앱에서도
										승차권, 결제 내역이 공유되며 마일리지(프리미엄)적립 등 다양한 혜택과 편의성이 제공됩니다.고속버스
										통합홈페이지는 티머니 통합회원 계정으로 로그인 가능합니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>아이디, 비밀번호가 기억이 나지 않습니다.
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>아이디, 비밀번호를 잊으셨을 경우, [로그인]→[아이디찾기]/[비밀번호찾기] 메뉴를 통해 회원정보를
										조회하실 수 있습니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>회원정보의 변경이 가능합니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>로그인 후 [마이페이지]에서 비밀번호와 휴대폰번호 변경이 가능합니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>회원을 탈퇴하고 싶습니다.
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>로그인 후 [마이페이지]에 접속후 회원탈퇴 버튼을 선택하여 진행하시기 바랍니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>[서울경부], [서울호남(센트럴)], [동서울]은 각각 어느
									터미널입니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										서울 강남고속버스터미널은 경부선과 호남선(센트럴시티)으로 건물이 나누어져 있습니다. <br>출발지 선택
										시 [서울경부]는 서울강남고속버스경부선 터미널이며, [서울호남(센트럴)]은 서울강남고속버스호남선 터미널입니다.
										[동서울]은 지하철 2호선 강변역에 위치한 터미널입니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>애완동물과 함께 고속버스 탑승이 가능합니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>다른 여객에게 위해를 끼치거나 불쾌감을 줄 우려가 있는 동물은 탑승이 불가하며 장애인보조견 및
										애완동물 동반 탑승시 전용운반상자를 이용해야 합니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>홈페이지, 모바일 예매시 문제가 발생 시 어디에 문의해야 합니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										통합고객센터로 문의하시기 바랍니다.<br>문의처 : 1644-9030 (평일 09시 ~ 18시,
										장애/오류 접수 24시간)
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>터미널에 대한 개선사항이나 건의사항은 어디에 문의해야 합니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										전국의 고속버스 터미널은 각각의 사업장으로 별도로 존재합니다. <br>따라서 매표원의 불친절이나
										터미널들 대한 건의 사항은 각각의 터미널에 문의를 하셔야 합니다.
									</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>이용한 차량에 물건을 놓고 내렸을 경우 찾을 수 있는 방법이 있는 지
									궁금합니다.
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>분실물과 유실물은 고속버스 운송회사별 각 지역센터에서 운영되고 있으며, 운송회사 연락처는
										[고객센터]→[유실물 센터 안내] 메뉴에서 확인 가능합니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>홈페이지에서 예매 한건에 대해 어플에서 승차권 변경 또는 취소가
									가능한가요?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>고객님 홈페이지에서 예매 하신건은 홈페이지 또는 창구에서 승차권 변경또는 취소가 가능하며 모바일
										환경에서는 진행되지 않습니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>모바일에서 인터넷 접속하면 홈페이지 접속이 안되는데요. 어떻게 해요?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>고객님, 모바일 웹은 개인 정보 보호와 고객님의 손실을 막기 위해 사용이 되지 않습니다. 고속 버스
										모바일 어플을 설치 하셔서 안전하게 사용하시기 바라며, 일부 노선에 대해서는 홈페이지에서만 예매 가능하고, 해당
										승차권의 변경 또는 취소는 홈페이지에서만 가능합니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>예전에 코버스 홈페이지에서는 예약되던 노선들이 지금 홈페이지에서는 예매
									안되는데요.언제 되나요?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>노선은 순차적으로 오픈을 하고 있습니다. 고객님들의 안전한 전자 승차권 사용을 위해 지속적으로 노력
										하고 있사오니, 양해 해 주시기 바랍니다.</p>
								</div>
							</dd>
							<dt>
								<button type="button" aria-expanded="false">
									<span class="q">Q</span>예매 승차권의 취소 수수료는 어떻게 부과됩니까?
								</button>
							</dt>
							<dd style="display: none;">
								<span class="a">A</span>
								<div class="answer">
									<p>
										고속버스 승차권 취소 수수료 정책은 공지사항의 ‘고속버스 취소수수료 변경 안내’ 게시글을 참조바랍니다.<br>
										<br>※ 차량 출발 후 도착 전까지 홈페이지 및 출발지 터미널에서 취소가 가능하며, 차량 도착
										이후에는 100% 위약금이 발생합니다. (모든 티켓 동일)<br>※ 예매 취소 및 환급에 대한 규정은
										고속버스 운송약관에 따르며, 자세한 사항은 고속버스 운송약관을 통해서 확인하실 수 있습니다.
									</p>
								</div>
							</dd>
						</dl>
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
							title="새창"><img
								src="./자주하는 질문 _ 고객지원 _ 고속버스통합예매_files/logo-kumho-express.png"
								alt="금호고속"></a></li>
						<li><a href="http://www.dongbubus.com/" target="_blank"
							title="새창"><img
								src="./자주하는 질문 _ 고객지원 _ 고속버스통합예매_files/logo-dongbu-express.png"
								alt="동부고속"></a></li>
						<li><a href="http://www.songnisanbuslines.co.kr/"
							target="_blank" title="새창"><img
								src="./자주하는 질문 _ 고객지원 _ 고속버스통합예매_files/logo-sokrisan-express.png"
								alt="속리산고속"></a></li>
						<li><a href="http://www.dyexpress.co.kr/" target="_blank"
							title="새창"><img
								src="./자주하는 질문 _ 고객지원 _ 고속버스통합예매_files/logo-dongyang-express.png"
								alt="동양고속"></a></li>
						<li><a href="http://www.samhwaexpress.co.kr/" target="_blank"
							title="새창"><img
								src="./자주하는 질문 _ 고객지원 _ 고속버스통합예매_files/logo-samhwa-express.png"
								alt="삼화고속"></a></li>
						<li><a href="http://www.jabus.co.kr/" target="_blank"
							title="새창"><img
								src="./자주하는 질문 _ 고객지원 _ 고속버스통합예매_files/logo-joongang-express.png"
								alt="중앙고속"></a></li>
						<li><a href="http://www.chunilexpress.co.kr/" target="_blank"
							title="새창"><img
								src="./자주하는 질문 _ 고객지원 _ 고속버스통합예매_files/logo-chunil-express.png"
								alt="천일고속"></a></li>
						<li><a href="http://www.hanilexpress.co.kr/" target="_blank"
							title="새창"><img
								src="./자주하는 질문 _ 고객지원 _ 고속버스통합예매_files/logo-hanil-express.png"
								alt="한일고속"></a></li>
					</ul>
					<!-- dropdown-top 클래스 추가 시, 드롭다운 목록 위로 노출 -->
					<div class="dropdown-wrap dropdown-top related-sites-select">
						<a href="javascript:void(0)" class="btn-dropdown" title="관련사이트 이동"
							aria-expanded="false"><span class="text">관련사이트</span><i
							class="ico ico-arrow-down"></i></a>
						<ul class="dropdown-list">
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
								src="./자주하는 질문 _ 고객지원 _ 고속버스통합예매_files/logo-accessibility2.png"
								alt="(사)한국장애인단체총연합회 한국웹접근성인증평가원 웹 접근성 우수사이트 인증마크(WA인증마크)"
								height="40"></a></li>
						<li><a href="https://www.kobus.co.kr/ugd/bustrop/Bustrop.do"
							title="이사장 인사말 바로가기"><img
								src="./자주하는 질문 _ 고객지원 _ 고속버스통합예매_files/logo-kobus.png"
								alt="KOBUS 전국고속버스운송사업조합"></a></li>
						<li><a
							href="https://www.kobus.co.kr/ugd/trmlbizr/Trmlbizr.do"
							title="협회장 인사말 바로가기"><img
								src="./자주하는 질문 _ 고객지원 _ 고속버스통합예매_files/logo-npvtba-express.png"
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
	<div class="quicksearch" data-version="2161329"></div>
</template>
</whale-quicksearch>
<widget-window
	style="opacity: 1; background-color: rgb(255, 255, 255); border: 1px solid rgb(135, 132, 129); left: calc(50% - 195px); top: calc(50% - 250px); width: auto; height: auto; display: none;">
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