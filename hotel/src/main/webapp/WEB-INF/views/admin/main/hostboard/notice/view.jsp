<%@ page language="java" 	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/admin/include/headHtml.jsp" %>
<%@ include file="/WEB-INF/views/admin/include/top.jsp" %>
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
<title>게시판 등록</title>

<!-- 아래부분 공통이니까 include -->
<link rel="stylesheet" href="/hotel/css/reset.css" />
<link rel="stylesheet" href="/hotel/css/contents.css" />

<script src="/hotel/smarteditor/js/HuskyEZCreator.js"></script>
<script src="/hotel/js/function.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
th {
	width: 10%;
	text-align:center;
}
td {
	width: 200px;
}

.date {
	width: 40%;
}
</style>
<script>
	// 목록가기
	function goList() {
		location.href = "list.do?stype=${param.stype}&sword=${param.sword}";
	}

	// 삭제하기
	function goDelete(hnotice_no){
		alert("정말 삭제하시겠습니까?");
		location.href ="/hotel/admin/main/hostboard/notice/delete.do?hnotice_no="+hnotice_no;
	}
	
</script>

</head>
<body>
    <div id="container">
			<div id="content">
				<div class="con_tit">
					<h2>호스트 관리 ▶ NOTICE ▶ 상세보기</h2>
				</div>
			</div>
	</div>
	<div class="sub">
		<div class="size">

			<div class="bbs">
				<form method="get" name="frm" id="frm" action="view.do" enctype="multipart/form-data">
					<input type="hidden" name="hnotice_no" value="${data.hnotice_no}">
					
					<table class="board_write">
						<div class="title">
						<tr>
							<th>분류</th>
							<td name="hnotice_type" style="text-align:left; width:50px;">
								<c:if test="${data.hnotice_type == 1}">[안내]	</c:if>
								<c:if test="${data.hnotice_type == 2}">[공지]	</c:if>
								<c:if test="${data.hnotice_type == 3}">[이벤트]</c:if>
								<c:if test="${data.hnotice_type == 4}">[발표]	</c:if>
							</td>
							
							<th>등록일자</th>
							<td class="date" >
							<fmt:formatDate value="${data.hnotice_regdate}" pattern="yyyy-MM-dd hh:mm:ss" /></td>
						</tr>
						<tr>
						
							<th>제목</th>
							<td>${data.hnotice_title }</td>
							<th>수정일자</th>
							<td class="date"><fmt:formatDate value="${data.hnotice_updatedate}" pattern="yyyy-MM-dd hh:mm:ss" /></td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>관리자</td>
							<th>첨부파일</th>
							<td colspan="2">
							<a href ="/hotel/download.jsp?oName=${URLEncoder.encode(data.filename_org, 'UTF-8')}&sName=${data.filename_real}" target="_blank">
									${data.filename_org }
								</a>
								</td>
						</tr>
						<tr>
							<th>내용</th>
							<td colspan="3" style="width: 600px; height:300px">${data.hnotice_content}</td>
						</tr>
						</div>
					</table>
					<div class="btnSet" style="text-align: right;">
						<a  class="btn" href="edit.do?hnotice_no=${data.hnotice_no }">수정</a>
						<a class="btn" href="javascript:goDelete(${data.hnotice_no});">삭제 </a>
						<a class="btn" href="javascript:goList();">목록 </a>
					</div>
					
					<br><br><br>
					<hr style="display: block; margin:1rem 0; color: inherit; opacity:.25;">
					<div class="pagebox">
						<div>
							<p><a href="view.do?hnotice_no=${prev.hnotice_no}">이전글 | 
							<c:if test="${prev.hnotice_type == 1}">
								[안내] ${prev.hnotice_title }
							</c:if>
							<c:if test="${prev.hnotice_type == 2}">
								[공지] ${prev.hnotice_title }
							</c:if>
							<c:if test="${prev.hnotice_type == 3}">
								[이벤트] ${prev.hnotice_title }
							</c:if>
							<c:if test="${prev.hnotice_type == 4}">
								[발표] ${prev.hnotice_title }
							</c:if>
							</a></p>							
						</div>
					<hr style="display: block; margin:1rem 0; color: inherit; opacity:.25;">
						<div>
							<p><a href="view.do?hnotice_no=${next.hnotice_no}">다음글 | 
							<c:if test="${next.hnotice_type == 1}">
								[안내] ${next.hnotice_title }
							</c:if>
							<c:if test="${next.hnotice_type == 2}">
								[공지] ${next.hnotice_title }
							</c:if>
							<c:if test="${next.hnotice_type == 3}">
								[이벤트] ${next.hnotice_title }
							</c:if>
							<c:if test="${next.hnotice_type == 4}">
								[발표] ${next.hnotice_title }
							</c:if>
							</a></p>
						</div>
					<hr style="display: block; margin:1rem 0; color: inherit; opacity:.25;">
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>