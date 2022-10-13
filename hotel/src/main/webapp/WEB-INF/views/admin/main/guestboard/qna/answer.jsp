<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/admin/include/headHtml.jsp"%>
<%@ include file="/WEB-INF/views/admin/include/top.jsp"%>


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
.dSelect {
	height: 100%;
	text-align: left;
}

th {
	width: 10%;
	text-align : center;
}

</style>

<script> 
	function goSave(){
		editor.getById['gboard_reply'].exec('UPDATE_CONTENTS_FIELD',[]); // getById -> jindo라는 프레임워크에서 사용하는 것	
		frm.submit();
	}
	
	var editor; // 변수를 밖에 쓴 이유: 전역변수로 사용하기 위해서
	$(function(){
		editor = setEditor('gboard_reply'); // textarea id= content
	});

	function goBack() {
		history.back();
	};
</script>


</head>
<body>
	<div id="container">
		<div id="content">
			<div class="con_tit">
				<h2>게스트 관리 ▶ Q&A ▶ 답변 등록</h2>
			</div>
		</div>
	</div>
	<div class="sub">
		<div class="size">
			<div class="bbs">
				<form method="post" name="frm" id="frm" action="answer.do"
					enctype="multipart/form-data">
					<input type="hidden" name="gboard_no" value="${data.gboard_no}">
					<tr>
						<th>문의번호 : ${data.gboard_no }</th>
					</tr>
					
					<table class="board_write">
						<tbody>
							<div class="container">
								<ul class="list">
									<li class="item">
									<th>문의유형</th>
									</span>
									<td style="text-align: left">
										<c:if test="${data.gboard_type==1 }">[예약]</c:if> 
										<c:if test="${data.gboard_type==2 }">[결제]</c:if> 
										<c:if test="${data.gboard_type==3 }">[숙소]</c:if> 
										<c:if test="${data.gboard_type==4 }">[포인트/쿠폰]</c:if> 
										<c:if test="${data.gboard_type==5 }">[이용/기타]</c:if></td>
									</select>
									</li>
							<tr>
								<th>이메일</th>
								<td>${loginInfo.guest_email}</td>
							</tr>
							<tr>
								<th>제목</th>
								<td>${data.gboard_title }</td>
							</tr>
							<tr>
								<th>작성자</th>
								<td>${data.guest_name}</td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td><a
									href="/hotel/download.jsp?oName=${URLEncoder.encode(data.filename_org, 'UTF-8')}&sName=${data.filename_real}"
									target="_blank"> ${data.filename_org } </a>
								</td>
							</tr>
								<th>문의내용</th>
								<td style="width: 600px; height:300px">${data.gboard_content}</td>
							</tr>
							<tr>
								<th>답변</th>
								<td colspan="3"><textarea id="gboard_reply" name="gboard_reply" placeholder="답글 작성란입니다." style="width: 100%"></textarea></td>
							</tr>
							</ul>
							</div>

						</tbody>
					</table>
					<div class="btnSet">
						<a class="btn" style="align: left; background-color: grey; border: 2px solid grey" href="javascript:goBack();">이전 </a> <a class="btn"
							style="align: right;" href="javascript:goSave();">등록 </a>
					</div>
				</form>
			</div>

		</div>
	</div>

</body>
</html>