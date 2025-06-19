<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html class="pc" lang="ko">
<head>
<meta charset="utf-8" />
<meta
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"
	name="viewport" />
<meta content="IE=Edge" http-equiv="X-UA-Compatible" />
<title>회원가입(본인인증) | 고속버스통합예매</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="/images/favicon.ico" rel="shortcut icon" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<link href="/koBus/css/common/ui.jqgrid.custom.css" rel="stylesheet"
	type="text/css" />







<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link href="/koBus/css/common/style.css" rel="stylesheet" type="text/css" />
</head>
<!-- [리뉴얼] 페이지 개별 스크립트 신규 정의함 -->
<body class="KO">
	<!-- [리뉴얼] 스킵 네비게이션 신규 정의 -->
	<nav id="skip">
		<ul>
			<li><a href="#new-kor-content">본문 바로가기</a></li>
			<li><a href="#new-kor-gnb">주메뉴 바로가기</a></li>
			<li><a href="#new-kor-footer">푸터 바로가기</a></li>
		</ul>
	</nav>
	<!-- 메인 클래스 : wrapper-main -->
	<div class="wrapper wrapper-kor wrapper-sub">
		<!-- quick -->
		<!-- 퀵메뉴 : 서브페이지에만 적용 -->
		<nav id="new-kor-quickmenu">
			<ul class="quickmenu-list">
				<li><a href="/mrs/rotinf.do"> <span class="ico"><img
							alt="" src="/koBus/images/kor/layout/ico-quick-menu01.png" /></span> <span
						class="text">고속버스 예매</span>
				</a></li>
				<li><a href="/mrs/mrscfm.do"> <span class="ico"><img
							alt="" src="/koBus/images/kor/layout/ico-quick-menu02.png" /></span> <span
						class="text">예매확인</span>
				</a></li>
				<li><a href="/oprninf/arscgd/oprnArscGd.do"> <span
						class="ico"><img alt=""
							src="/koBus/images/kor/layout/ico-quick-menu03.png" /></span> <span
						class="text">도착시간 안내</span>
				</a></li>
				<li><a href="/adtnprdnew/frps/frpsPrchGd.do"> <span
						class="ico"><img alt=""
							src="/koBus/images/kor/layout/ico-quick-menu04.png" /></span> <span
						class="text">프리패스 구매</span>
				</a></li>
				<li><a href="/adtnprdnew/pass/passPrchGd.do"> <span
						class="ico"><img alt=""
							src="/koBus/images/kor/layout/ico-quick-menu05.png" /></span> <span
						class="text">정기권 구매</span>
				</a></li>
				<li class="to-top"><a href="#"> <span class="ico"><img
							alt="" src="/koBus/images/kor/layout/ico-to-top.png" /></span> <span
						class="text">TOP</span>
				</a></li>
			</ul>
		</nav>
		
		<!-- TOP 버튼 누르면 맨위로 이동 -->
		<script>
			$("#new-kor-quickmenu > ul > li.to-top > a > span.text").on("click", function (){
				$("html, body").animate({ scrollTop: 0 }, "slow");
			});
		</script>
		<!-- header -->

		<!-- 헤더 -->
		<header id="new-kor-header">
			<div class="top-menu-area">
				<div class="container">
					<h1 id="logo">
						<a href="/main.do"> <img alt="KOBUS 전국고속버스운송사업조합"
							src="/koBus/images/kor/layout/logo.png" />
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
							<li><a href="#">고속버스예매</a>
								<ul>
									<li><a href="/mrs/rotinf.do">고속버스 예매</a></li>
									<li><a href="/mrs/mrscfm.do">예매확인/취소/변경</a></li>
									<li><a href="/mrs/mrsrecplist.do">영수증발행</a></li>
								</ul></li>
							<li><a href="#">운행정보</a>
								<ul>
									<li><a href="/oprninf/alcninqr/oprnAlcnPage.do">시간표 조회</a></li>
									<li><a href="/oprninf/arscgd/oprnArscGd.do">도착시간 안내</a></li>
								</ul></li>
							<li><a href="#">프리패스/정기권</a>
								<ul>
									<li><a href="/adtnprdnew/frps/frpsPrchGd.do">프리패스 여행권</a></li>
									<li><a href="/adtnprdnew/pass/passPrchGd.do">정기권</a></li>
									<li><a href="/adtnprdnew/prchpt/prdPrchPt.do">상품 구매내역</a></li>
								</ul></li>
							<li><a href="#">이용안내</a>
								<ul>
									<li><a href="/ugd/mrsgd/Mrsgd.do">예매 안내</a></li>
									<li><a href="/ugd/mrsgd/MrdgdPrch.do">결제수단 안내</a></li>
									<li><a href="/ugd/rygd/Rygd.do">승차권 환불안내</a></li>
									<li><a href="/ugd/mlggd/Mlggd.do">프리미엄 마일리지</a></li>
									<li><a href="/ugd/trtrgd/Trtrgd.do">휴게소 환승안내</a></li>
									<li><a href="/ugd/trmlgd/Trmlgd.do">고속버스 터미널</a></li>
									<li><a href="/ugd/cacmgd/Cacmgd.do">고속버스 운송회사</a></li>
								</ul></li>
							<li><a href="#">고객지원</a>
								<ul>
									<li><a href="/cscn/ntcmttr/readNtcList.do">공지사항</a></li>
									<li><a href="/cscn/qna/readQnaList.do">자주찾는 질문</a></li>
									<li><a href="/cscn/lossClnc/readLossClncList.do">유실물센터
											안내</a></li>
								</ul></li>
						</ul>
					</div>
					<div class="links">
						<!-- <a href="https://www.tmoney.co.kr" class="btn btn-tmoney" title="새창" target="_blank">
					<img src="/koBus/images/kor/layout/ico-tmoney-app.png" alt="" />고속버스 티머니
					<i class="ico ico-arrow-new-window"></i>
				</a> -->
						<a class="btn btn-job" href="/cscn/jobmttr/readJobList.do"
							target="_blank" title="새창"> <img alt=""
							src="/koBus/images/kor/layout/ico-job-offer.png" />승무사원 모집 <i
							class="ico ico-arrow-new-window"></i>
						</a>
					</div>
					<div class="bg-layer">
						<a class="gnb-baaner"
							href="https://safeconnect.co.kr/sfconn/login/csc_pc?et=psn249R01&amp;ptrSvcSn=psn249"
							title="새창"> <iframe class="ad-frame"
								src="/koBus/html2/_ad-tubebox-002GNB.html"
								title="프레임 (전화번호안심 로그인)"></iframe>
						</a>
					</div>
				</div>
			</nav>
		</header>
		<!-- breadcrumb -->
		<!-- 브레드크럼 -->
		<nav id="new-kor-breadcrumb">
			<div class="container"></div>
		</nav>
		<article id="new-kor-content">

			<div class="loading" style="height: 623px; top: 180px;">
				<p class="load" style="margin-left: -53px;"></p>
			</div>
			<div class="title_wrap in_process joinT" style="display: none;">
				<a class="back" href="#">back</a> <a class="mo_toggle" href="#">메뉴</a>
				<h2>회원가입</h2>
				<ol class="process step04">
					<li>약관동의</li>
					<li class="active">본인인증</li>
					<li>정보입력</li>
					<li class="last">가입완료</li>
				</ol>
			</div>
			<!-- 타이틀 -->
			<div class="content-header" data-page-title="회원가입(본인인증) | 고속버스통합예매">
				<div class="container">
					<div class="title-area">
						<h2 class="page-title">회원가입</h2>
						<ol class="process">
							<li><span class="num">1</span> 약관동의</li>
							<li class="active" title="현재 단계"><span class="num">2</span>
								본인인증</li>
							<li><span class="num">3</span> 정보입력</li>
							<li><span class="num">4</span> 가입완료</li>
						</ol>
					</div>
				</div>
			</div>
			<div class="content-body">
				<div class="container">
					<div class="noti_wrap taL">
						<p class="noti">본인인증을 위한 휴대폰번호를 입력해주세요.</p>
					</div>
					<form method="get" name="askAuthNoForm">
						<div class="border-box box_changeNum">
							<div class="inner">
								<div class="box_inputForm">
									<label class="label" for="usrHp">휴대폰번호</label> <span
										class="box_label"> <input class="input" id="usrHp"
										name="usrHp" placeholder="휴대폰번호를 입력하세요" type="text" />
									</span>		
								</div>
							</div>
						</div>
						<p class="btns col1">
							<button type="submit" id="submitBtn"><a class="btnL btn_confirm ready" href="" id="btn_confirm">인증번호 발송</a></button>						
							<!-- ready class 있음 -->
						</p>
						<br>
						<div>
							<p id="alert" style="text-align: center;"></p>
						</div>
					</form>
				
					<!-- 인증번호 발송 후 -->
					<div id="AuthNoFormId" style="display: none;">
						<div class="border-box box_changeNum marT30">
							<form method="post" name="frmAuthNoForm">
								<div class="inner">
									<div class="box_inputForm">
										<label class="label" for="aouNo">인증번호</label> <span
											class="box_label"> <input class="input" id="aouNo"
											name="aouNo" placeholder="인증번호를 입력하세요" type="text" /> <input
											class="input" id="s_ID03" name="usrNewHp" type="hidden" />
										</span>
									</div>
									<div class="box_limit">
										<span class="txt_limit" id="countDown"></span>
										<button class="btnS btn_normal white mobNone" name="reHpAouNo"
											type="button">인증번호 재발송</button>
									</div>
								</div>
							</form>
						</div>
						<p class="btns col1">
							<a class="btnL btn_confirm ready mobBlock" href="#">인증번호 재발송</a>
							<a class="btnL btn_confirm ready" href="#" id="confirmBtn">확인</a>
							<p id="numCheck" style="text-align: center;"></p>
							<!-- ready class 있음 -->
						</p>
					</div>
					
					<!-- 인증번호 발송 버튼 누르면 숨어있는 인증번호 입력하는 div태그 나오기 -->
					<!-- 전화번호 유효성 검사 완료후 인증번호 발송 누르면, 입력받은 휴대폰에 인증번호 보내기 -->
					<script>
						let CertificationOkCode = "";
						let inputPhoneNum="";
						let phoneNum="";
						$("#submitBtn").on("click", function (e){
							e.preventDefault(); // a링크 태그 새로고침 방지
							
							inputPhoneNum = $("#usrHp").val();
							phoneNum = inputPhoneNum.trim();
							console.log("입력번호: " + phoneNum);
							// 전화번호 유효성 검사 : '-' 없이 입력'
							var regExp = /^01[0|1|6|7|8|9]-?\d{3,4}-?\d{4}$/; 
							if (!regExp.test(inputPhoneNum)) {
								$("#alert").text("올바른 전화번호를 입력해 주세요").css("color", "red");
							}else{
								let url = `/koBus/telCertificationNum.do?phoneNum=\${phoneNum}`;
								$.ajax({
									url: url,
									type:"GET",
									cache:false,
									dataType:"text",
									success : function (data){
										if (data == "error") {
											console.log("값을 제대로 가져오지 못하였습니다.");
										} else {
											console.log("success!!");
											$("#alert").hide();
											$("#AuthNoFormId").show(); 
											CertificationOkCode = data;
										}	
									}	
								});
								console.log("인증번호: " + CertificationOkCode);
							}
						});
						
						// 확인버튼 눌렀을때 함수
						$("#confirmBtn").on("click", function (event){
							event.preventDefault(); // a링크 새로고침 방지
							console.log("다음페이지에 넘겨줄 입력번호 : " + phoneNum);
							
							// 확인버튼을 눌렀을때 휴대폰으로 전송한 인증번호와 입력한 인증번호가 맞는지 확인하는 코딩작성.....
							if($("#aouNo").val().length <= 0){
								alert("인증번호를 입력해 주세요");
								event.preventDefault();
							}
							else if($("#aouNo").val() === CertificationOkCode){
								alert("확인이 완료되었습니다.")
								location.href = `/koBus/koBusFile/joinEnterInfo.jsp?phoneNum=\${phoneNum}`;
							}
							else{
								alert("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
								event.preventDefault();
							}
						});
					</script>
					
					<!-- //인증번호 발송 후 -->
					<form name="hpAouIdForm">
						<input class="input" id="hpAouId" name="hpAouId" type="hidden"
							value="" />
					</form>
				</div>
			</div>
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
						<li><a href="http://www.jabus.co.kr" target="_blank"
							title="새창"><img alt="중앙고속"
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
						<a aria-expanded="false" class="btn-dropdown" href="#"
							title="관련사이트 이동"><span class="text">관련사이트</span><i
							class="ico ico-arrow-down"></i></a>
						<ul class="dropdown-list" style="display: none;">
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
								height="40"
								src="/koBus/images/kor/layout/logo-accessibility2.png" /></a></li>
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
		<div class="remodal remodal-is-initialized remodal-is-closed"
			data-remodal-id="popConfirm"
			data-remodal-options="closeOnOutsideClick: false" role="dialog"
			tabindex="-1">
			<div class="cont">
				<p class="txt">
					<span class="accent">알림</span><br />
				</p>
			</div>
			<div class="btns">
				<!-- 버튼이 1개일경우 class="col1" 추가 -->
				<button class="remodal-confirm" data-remodal-action="confirm"
					type="button">로그인</button>
				<button class="remodal-confirm" data-remodal-action="confirm"
					type="button">신규회원가입</button>
			</div>
			<button class="remodal-close" data-remodal-action="close"
				type="button">
				<span class="sr-only">닫기</span>
			</button>
		</div>
	</div>
</body>
</html>