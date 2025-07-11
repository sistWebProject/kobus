<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html class="pc" lang="ko">
<head>
<meta charset="utf-8" />
<link rel="shortcut icon" type="image/x-icon"
	href="/koBus/media/favicon.ico">
<meta
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"
	name="viewport" />
<meta content="IE=Edge" http-equiv="X-UA-Compatible" />
<title>회원가입(약관동의) | 고속버스통합예매</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="/koBus/images/favicon.ico" rel="shortcut icon" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<link href="/koBus/css/common/ui.jqgrid.custom.css" rel="stylesheet"
	type="text/css" />







<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link href="/koBus/css/common/style.css" rel="stylesheet" type="text/css" />
</head>
<%@ include file="common/header.jsp" %>
		<!-- breadcrumb -->
		<!-- 브레드크럼 -->
		<nav id="new-kor-breadcrumb">
			<div class="container"></div>
		</nav>
		<article id="new-kor-content">

			<div class="title_wrap in_process joinT" style="display: none;">
				<a class="back" href="#">back</a> <a class="mo_toggle" href="#">메뉴</a>
				<h2>회원가입</h2>
				<ol class="process step04">
					<li class="active">약관동의</li>
					<li>본인인증</li>
					<li>정보입력</li>
					<li class="last">가입완료</li>
				</ol>
			</div>
			<!-- 타이틀 -->
			<div class="content-header" data-page-title="회원가입(약관동의) | 고속버스통합예매">
				<div class="container">
					<div class="title-area">
						<h2 class="page-title">회원가입</h2>
						<ol class="process">
							<li class="active" title="현재 단계"><span class="num">1</span>
								약관동의</li>
							<li><span class="num">2</span> 본인인증</li>
							<li><span class="num">3</span> 정보입력</li>
							<li><span class="num">4</span> 가입완료</li>
						</ol>
					</div>
				</div>
			</div>
			<div class="content-body page_payment">
				<div class="container">
					<div class="noti_wrap taL">
						<p class="noti">
							고속버스 통합 예매 홈페이지에서 제공하는 다양한 서비스를 이용하기 위하여 <span class="pc_block">고객님의
								동의가 필요합니다.</span>
						</p>
						<p class="noti">
							<span style="color: red">본 서비스는 만 14세 이상만 이용이 가능하며,</span> 서비스 이용
							전 아래 사항을 <span class="pc_block">확인하시고 동의하여 주시기 바랍니다.</span>
						</p>
					</div>
					<div class="section">
						<div class="agreement_wrap">
							<div class="agreement_tit">
								<h4 class="first">
									개인정보 수집 및 이용동의<span class="txt_essential">(필수)</span>
								</h4>
							</div>
							<div class="scroll-wrapper agreement_cont scrollbar-inner"
								style="position: relative;">
								<div
									class="agreement_cont scrollbar-inner scroll-content scroll-scrolly_visible"
									style="height: auto; margin-bottom: 0px; margin-right: 0px; max-height: 118px;">
									<iframe frameborder="0" height="187" scrolling="no"
										
										title="개인정보 수집 및 이용동의" width="100%"></iframe>
								</div>
								<div class="scroll-element scroll-x scroll-scrolly_visible">
									<div class="scroll-element_outer">
										<div class="scroll-element_size"></div>
										<div class="scroll-element_track"></div>
										<div class="scroll-bar" style="width: 88px;"></div>
									</div>
								</div>
								<div class="scroll-element scroll-y scroll-scrolly_visible">
									<div class="scroll-element_outer">
										<div class="scroll-element_size"></div>
										<div class="scroll-element_track"></div>
										<div class="scroll-bar" style="height: 66px; top: 0px;"></div>
									</div>
								</div>
							</div>
							<span class="custom_check chk_blue"> <input id="agree1"
								type="checkbox" /> <label for="agree1">동의</label>
							</span>
						</div>
						<div class="agreement_wrap">
							<div class="agreement_tit">
								<h4>
									서비스 이용약관 동의<span class="txt_essential">(필수)</span>
								</h4>
							</div>
							<div class="scroll-wrapper agreement_cont scrollbar-inner"
								style="position: relative;">
								<div
									class="agreement_cont scrollbar-inner scroll-content scroll-scrolly_visible"
									style="height: auto; margin-bottom: 0px; margin-right: 0px; max-height: 118px;">
									<iframe frameborder="0" height="2387" scrolling="no"
										title="서비스 이용약관 동의"
										width="100%"></iframe>
								</div>
								<div class="scroll-element scroll-x scroll-scrolly_visible">
									<div class="scroll-element_outer">
										<div class="scroll-element_size"></div>
										<div class="scroll-element_track"></div>
										<div class="scroll-bar" style="width: 88px;"></div>
									</div>
								</div>
								<div class="scroll-element scroll-y scroll-scrolly_visible">
									<div class="scroll-element_outer">
										<div class="scroll-element_size"></div>
										<div class="scroll-element_track"></div>
										<div class="scroll-bar" style="height: 5px; top: 0px;"></div>
									</div>
								</div>
							</div>
							<span class="custom_check chk_blue"> <input id="agree2"
								type="checkbox" /> <label for="agree2">동의</label>
							</span>
						</div>
						<p class="agree_all chk_bor">
							<span class="custom_check chk_purple"> <input
								id="checkAll" type="checkbox" /> <label for="checkAll">전체
									약관에 동의합니다.</label>
							</span>
						</p>
					</div>
					<p class="btns col2">
						<a class="btnL btn_confirm ready" id="dontAgree" href="/koBus/main.do;">동의하지않음</a> 
						<a class="btnL btn_confirm" id="finalAgree">동의함</a>
					</p>
				</div>
			</div>
		</article>
		<!-- footer -->
		
		<script>
			// [js]
			// agree1,2 누르면 체크버튼 생기게하기
			/*
			const ckbAll = document.querySelector("input[id=checkAll]");
			const ckbs = document.querySelectorAll(".section input[id^=agree]");
			
			ckbAll.onclick = function (){
				// console.log("all check");
				for (var i = 0; i < ckbs.length; i++) {
					ckbs[i].checked = this.checked;
				} // for
			}
			
			for (var i = 0; i < ckbs.length; i++) {
				ckbs[i].onclick = function (){
					let isckbsAllChecked = true;
					for (var i = 0; i < ckbs.length; i++) {
						isckbsAllChecked = ckbs[i].checked;
						if(!isckbsAllChecked) break;
					} // for
				}
			} // for
			*/
			// [jquery] - 동의하지 않음
			$("#dontAgree").on("click", function (event){
				alert("모두 동의를해야 회원가입이 가능합니다.");
				event.preventDefault();
			});
			
			// [jquery] - 동의함
			let wholeCkbs = $(":checkbox:not(#checkAll)").length;
			
			$("#checkAll").on("click", function() {
				$(":checkbox:not(#checkAll)").prop("checked", $(this).prop("checked"));
			});

			$(":checkbox:not(#checkAll)").on("click", function() {
				let ckbs = $(":checkbox:not(#checkAll):checked").length;
				console.log(ckbs);
				$("#checkAll").prop("checked", ckbs == wholeCkbs ? true : false);
			});
			
			$("#finalAgree").on("click", function (event){
				let ckbs = $(":checkbox:not(#checkAll):checked").length;
				if (wholeCkbs != ckbs) {
					alert("모두 동의해 주세요!");
					event.preventDefault();
				} else {
					alert("동의가 완료되었습니다.");
					location.href = "/koBus/page/joinVerification.do";
				}
			});
			
		</script>
		
		
		
		
		
		
		
		
		
		
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
						<a aria-expanded="false" class="btn-dropdown"
							href="javascript:void(0)" title="관련사이트 이동"><span class="text">관련사이트</span><i
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
	<div
		style="left: -1000px; overflow: scroll; position: absolute; top: -1000px; border: none; box-sizing: content-box; height: 200px; margin: 0px; padding: 0px; width: 200px;">
		<div
			style="border: none; box-sizing: content-box; height: 200px; margin: 0px; padding: 0px; width: 200px;"></div>
	</div>
</body>
</html>