<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon"
	href="/koBus/media/favicon.ico">
<link rel="stylesheet" href="/koBus/media/style.css">
<link rel="stylesheet" href="/koBus/media/ui.jqgrid.custom.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" />

<title>유실물센터 안내(상세) | 고객지원 | 고속버스통합예매</title>
<style>
.ico-dropdown-arrow {
	display: inline-block;
	width: 20px;
	height: 20px;
	background-image: url("/koBus/media/ico-dropdown-arrow@2x.png");
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	text-indent: -9999px;
	vertical-align: middle;
	transform: rotate(180deg);
	transition: transform 0.3s ease;
}

.btn-dropdown.open .ico-dropdown-arrow {
	transform: rotate(0deg);
}

/* breadcrumb */
.breadcrumb-list>li {
	position: relative;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.btn-dropdown {
	font-size: 16px;
	background: none;
	border: none;
	cursor: pointer;
	padding: 4px 8px;
	display: inline-flex;
	align-items: center;
	gap: 6px;
	font-family: "Pretendard", sans-serif;
}

.dropdown-list {
	position: absolute;
	top: 100%;
	left: 0;
	margin-top: 5px;
	background: white;
	border: 1px solid transparent;
	display: none;
	flex-direction: column;
	z-index: 100;
	box-shadow: none;
}

.dropdown-list li.selected>a {
	font-weight: bold;
}

.dropdown-list li>a {
	display: flex;
	align-items: center;
	height: 40px;
	padding: 0 12px;
	text-decoration: none;
	box-sizing: border-box;
	font-size: 14px;
	font-family: "Pretendard", sans-serif;
	line-height: 1.4;
}

.dropdown-list li>a:hover {
	background: none;
}

/* 유실물 안내 박스 */
.com_info.clfix {
	line-height: 1.4;
	margin: 0 auto 25px;
	zoom: 1;
	display: table;
	width: 100%;
	padding: 20px;
	border: 1px solid transparent;
	box-sizing: border-box;
	font-family: "Pretendard", sans-serif;
	font-size: 15px;
	line-height: 1.6;
	border-radius: 6px;
	max-width: 1080px;
}

/* 가운데 정렬된 표 */
.tbl_type1.responsive.col2 {
	-webkit-text-size-adjust: none;
	font-size: 16px;
	letter-spacing: 0;
	font-family: "Pretendard GOV Variable", "Pretendard GOV", sans-serif;
	line-height: 1.4;
	box-sizing: border-box;
	margin: 0 auto;
	padding: 40px 20px 60px;
	border-top: 1px solid transparent;
	min-height: calc(100vh - 399px);
	max-width: 1080px;
}

.tbl_type1.responsive.col2 table {
	width: 100%;
	border-collapse: collapse;
	background: white;
}

.tbl_type1.responsive.col2 caption {
	padding: 10px 0;
	font-weight: 600;
	text-align: left;
}

.tbl_type1.responsive.col2 th, .tbl_type1.responsive.col2 td {
	padding: 14px 10px;
	text-align: left;
	font-size: 15px;
	line-height: 1.5;
	word-break: keep-all;
}

.tbl_type1.responsive.col2 th {
	font-weight: 600;
}
</style>

</head>
<body>
	<%@ include file="../koBusFile/common/header.jsp"%>

	<nav id="new-kor-breadcrumb">
		<div class="container">

			<ol class="breadcrumb-list">
				<li><i class="ico ico-home"></i><span class="sr-only">홈</span></li>

				<li>
					<div class="dropdown-wrap breadcrumb-select">


						<a href="javascript:void(0)" class="btn-dropdown" title="대메뉴 선택"
							aria-expanded="false"> <span class="text">고객지원</span><i
							class="ico ico-dropdown-arrow"></i></a>



						<ul class="dropdown-list" style="display: none;">

							<li><a href="/mrs/rotinf.do">고속버스예매</a></li>

							<li><a href="/oprninf/alcninqr/oprnAlcnPage.do">운행정보</a></li>

							<li><a href="/adtnprdnew/frps/frpsPrchGd.do">프리패스/정기권</a></li>

							<li><a href="/ugd/mrsgd/Mrsgd.do">이용안내</a></li>



							<li class="selected"><a href="javascript:void(0)"
								title="선택됨">고객지원</a></li>

							<li><a href="/ugd/bustrop/Bustrop.do">전국고속버스운송사업조합</a></li>

							<li><a href="/ugd/trmlbizr/Trmlbizr.do">터미널사업자협회</a></li>

						</ul>
					</div>
				</li>

				<li>
					<div class="dropdown-wrap breadcrumb-select">


						<a href="javascript:void(0)" class="btn-dropdown" title="하위메뉴 선택"
							aria-expanded="false"> <span class="text">유실물센터 안내</span><i
							class="ico ico-dropdown-arrow"></i></a>


						<ul class="dropdown-list" style="display: none;">


							<li><a href="/koBus/html/boardList.do">게시판</a></li>

							<li><a href="/koBus/html/goBusFaq.do">자주찾는 질문</a></li>

							<li class="selected"><a href="javascript:void(0)"
								title="선택됨">유실물센터 안내</a></li>


						</ul>
					</div>
				</li>
			</ol>

		</div>
	</nav>
	<div class="com_info clfix">
		<p class="img">
			<img src="/koBus/media/lost_com5_s.png" alt="CHUNIL EXPRESS"
				class="hide_mo">
			<!-- 170227 수정 -->
			<img src="/koBus/media/lost_comL5.png" alt="CHUNIL EXPRESS"
				class="show_mo">
			<!-- 170227 수정 -->
		</p>
		<p class="info">충북 청주시 흥덕 가경 1416</p>
	</div>
	<div class="tbl_type1 responsive col2">
		<table>
			<caption>유실물 센터 목록이며 영업소, 주소, 전화번호 정보 제공</caption>
			<colgroup>
				<col style="width: 20%;">
				<col style="width: 40%;">
				<col style="width: auto">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">영업소</th>
					<th scope="col">주소</th>
					<th scope="col">전화번호</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="branch">청주</td>
					<td class="addr">충북 청주시 흥덕구 2순환로 1229</td>
					<td class="tel"><span>043-230-1657</span></td>
				</tr>

				<tr>
					<td class="branch">조치원</td>
					<td class="addr">세종특별자치시 조치원읍 조치원로 54 2동</td>
					<td class="tel"><span>044-865-8066</span></td>
				</tr>
			</tbody>
		</table>
	</div>
	<script>
  document.addEventListener("DOMContentLoaded", function () {
    const buttons = document.querySelectorAll(".btn-dropdown");

    buttons.forEach((btn) => {
      btn.addEventListener("click", function (e) {
        e.preventDefault();

        const dropdown = btn.closest(".breadcrumb-select").querySelector(".dropdown-list");

        // 모든 드롭다운 닫기
        document.querySelectorAll(".dropdown-list").forEach((list) => {
          if (list !== dropdown) list.style.display = "none";
        });

        document.querySelectorAll(".btn-dropdown").forEach((b) => {
          if (b !== btn) b.classList.remove("open");
        });

        // toggle 현재 메뉴
        const isOpen = dropdown.style.display === "block";
        dropdown.style.display = isOpen ? "none" : "block";
        btn.classList.toggle("open", !isOpen);
      });
    });

    // 외부 클릭 시 닫기
    document.addEventListener("click", function (e) {
      if (!e.target.closest(".breadcrumb-select")) {
        document.querySelectorAll(".dropdown-list").forEach((list) => {
          list.style.display = "none";
        });
        document.querySelectorAll(".btn-dropdown").forEach((btn) => {
          btn.classList.remove("open");
        });
      }
    });
  });
</script>


</body>
<%@ include file="../koBusFile/common/footer.jsp"%>
</html>