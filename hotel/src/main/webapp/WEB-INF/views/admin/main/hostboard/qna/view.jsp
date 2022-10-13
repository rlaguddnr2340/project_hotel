<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/admin/include/headHtml.jsp"%>
<%@ include file="/WEB-INF/views/admin/include/top.jsp"%>
<%@ page import="java.net.*"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
<meta name="format-detection"
	content="telephone=no, address=no, email=no">
<meta name="keywords" content="">
<meta name="description" content="">
<title>Q&A</title>

<!-- 아래부분 공통이니까 include -->
<link rel="stylesheet" href="/hotel/css/reset.css" />
<link rel="stylesheet" href="/hotel/css/contents.css" />

<script src="/hotel/smarteditor/js/HuskyEZCreator.js"></script>
<script src="/hotel/js/function.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style>
* {
	box-sizing: border-box;
}

th {
	width: 10%;
	text-align : center;
}

.container {
	background-color: light grey;
	padding: 50px;
	border: 20px solid purple;
	margin: 20px;
}

.Title {
	font-style: bold;
}

#text {
	display: none;
	font-size: 20px;
	background-color: pink;
}

.downbtn {
	width: 25px;
	height: 25px;
	float: right;
}

.slide  img {
	display: block;
	width: 1280px;
	height: 450px;
}
</style>

<script>
	// 목록가기
	function goList() {
		location.href = "/hotel/admin/main/hostboard/qna/list.do?stype=${param.stype}&sword=${param.sword}";
	}
	// 삭제하기
	function goDel(hboard_no) {
		if (confirm('정말 삭제하시겠습니까?')) {
			location.href = 'delete.do?hboard_no=' + hboard_no;
		}
	}
</script>

</head>
<body>
	<div id="container">
		<div id="content">
			<div class="con_tit">
				<h2>호스트 관리 ▶ Q&A ▶ 상세보기</h2>
			</div>
		</div>
	</div>
	<div class="sub">
		<div class="size">
			<div class="bbs">
				<form method="get" name="frm" id="frm" action="view.do"
					enctype="multipart/form-data">
					<input type="hidden" name="hboard_no" value="${data.hboard_no}">
					<table class="board_write">
						<tbody>
							<div class="title">
								<tr>
									<th>문의유형</th>
									<td style="text-align: left">
										<c:if test="${data.hboard_type==6 }">[입점]</c:if> 
										<c:if test="${data.hboard_type==7 }">[광고/제휴]</c:if> 
										<c:if test="${data.hboard_type==8 }">[이용회원]</c:if> 
										<c:if test="${data.hboard_type==9 }">[이용/기타]</c:if>
									</td>
									<th>등록일자</th>
									<td class="date" style="width: 30%">
									<fmt:formatDate	value="${data.hboard_regdate}" pattern="yyyy-MM-dd hh:mm:ss" /></td>
								</tr>
								<tr>
									<th>제목</th>
									<td name="hboard_title">${data.hboard_title}</td>
									<th>수정일자</th>
									<td colspan='2' class="date" style="width: 30%">
									<fmt:formatDate	value="${data.hboard_updatedate}" pattern="yyyy-MM-dd hh:mm:ss" /></td>
								</tr>
								<tr>
									<th>작성자</th>
									<td>${data.host_name}</td>
									<th>첨부파일</th>
									<td colspan="2">
									<a href="/hotel/download.jsp?oName=${URLEncoder.encode(data.filename_org, 'UTF-8')}&sName=${data.filename_real}" target="_blank"> ${data.filename_org } </a>
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td name="hboard_content" colspan="3" style="width: 600px; height: 300px">${data.hboard_content}</td>
								</tr>
							</div>
						</tbody>
					
						<tbody>
							<div class="title">
							
							<!-- 답글란 시작 -->
								<table class="board_write" style="margin-top: 20px">
									<div class="title">
										<c:if test="${!empty data.hboard_reply}">
											<tr>
												<th>답변날짜</th>
												<td name="hboard_replyupdatedate" colspan="3"><fmt:formatDate
														value="${data.hboard_replyupdatedate}"
														pattern="yyyy-MM-dd hh:mm:ss" /></td>
											</tr>
											<tr>
												<th>답변내용</th>
												<td name="hboard_reply" colspan="3"
													style="width: 600px; height: 300px">${data.hboard_reply}</td>
											</tr>
										</c:if>
									</div>
								</table>
								<!-- 답글란 끝 -->
							
					<div class="btnSet" style="text-align: right;">
						<a href="answer.do?hboard_no=${data.hboard_no}" class="btn">답변등록 및 수정</a>
						<a href="javascript:goList();" class="btn"
							style="text-align: right">목록 </a>
					</div>
				</form>
			</div>
		</div>
	</div>
</head>
</body>
</html>
