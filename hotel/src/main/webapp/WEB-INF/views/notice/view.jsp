<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<script>
    	function goSave(){
    		frm.submit();
    	}

    	
    	function goEdit(){
    		location.href = "hotel/notice/edit.do";
    	}
    </script>

</head>
<body>
	<div class="sub">
		<div class="size">
			<h3 class="sub_title" style="text-align: left">공지사항</h3>
			<div class="bbs">
				<form method="get" name="frm" id="frm" action="hotel/notice/view.do"
					enctype="multipart/form-data">
						<input type="hidden" name="gnotice_no" value="${data.gnotice_no}"> 
					<!--  <input type="hidden" name="admin_no" value="${loginInfo.no}"> -->
					<table class="board_write">
						<div class="title">
						
						<tbody>
							<tr>
							
								<th>제목</th><td>${data.gnotice_title}</td>
								<th>등록일자</th> <td class="date" style="width: 150px"><fmt:formatDate value="${data.gnotice_regdate}" pattern="yyyy-MM-dd hh:mm:ss" /></td>
							
							</tr>
							
							<tr>
							</tr>
							<tr>
								<th>작성자</th>
								<td>관리자</td>
								<th>수정일자</th>
								
								<td class="date" style="width: 150px"><fmt:formatDate
										value="${data.gnotice_regdate}" pattern="yyyy-MM-dd hh:mm:ss" /></td>
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td>${data.gnotice_content}</td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td><input type="file" name="filename"></td>
							</tr>
						</tbody>
						</div>
					</table>
					
					<div class="btnSet" style="text-align: right;">
						<a class="btn" href="javascript:goEdit();">수정</a>
					<td class="btnSet" style="text-align: right;">
						<a class="btn" href="javascript:goSave();">저장 </a>
					</td>
					<td class="btnSet" style="text-align: right;">
						<a class="btn" href="javascript:goDelete();">삭제 </a> <!-- 비밀번호로 본인확인 -->
					</td>
				</form>
			</div>
		</div>
	</div>

</body>
</html>