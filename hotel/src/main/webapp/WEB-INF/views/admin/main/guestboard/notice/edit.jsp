<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	text-align: center;
}
</style>

<script>

	function goSave(){
		editor.getById['gnotice_content'].exec('UPDATE_CONTENTS_FIELD',[]); // getById -> jindo라는 프레임워크에서 사용하는 것	
		frm.submit();
	}
	var editor; // 변수를 밖에 쓴 이유: 전역변수로 사용하기 위해서
	$(function(){
		editor = setEditor('gnotice_content'); // textarea id= content
	});
	
	
	function goBack(){
		history.back();
	}
</script>


</head>
<body>
	<div id="container">
		<div id="content">
			<div class="con_tit">
				<h2>게스트 관리 ▶ NOTICE ▶ 수정</h2>
			</div>
		</div>
	</div>
	<div class="sub">
		<div class="size">
			<div class="bbs">
				<form method="post" name="frm" id="frm" action="edit.do"
					enctype="multipart/form-data">
					<input type="hidden" name="gnotice_no" value="${data.gnotice_no}">
					<table class="board_write">
						<tbody>
							<div class="container">
								<ul class="list">
									<li class="item">
									<th>분류</th>
									<td class="choose"><span class="srchSelect"> 
									<select id="stype" name="gnotice_type" class="dSelect" title="검색분류 선택">
												<option value="1"
													<c:if test="${data.gnotice_type == 1}">selected</c:if>>
													안내</option>
												<option value="2"
													<c:if test="${data.gnotice_type == 2}">selected</c:if>>
													공지</option>
												<option value="3"
													<c:if test="${data.gnotice_type == 3}">selected</c:if>>
													이벤트</option>
												<option value="4"
													<c:if test="${data.gnotice_type == 4}">selected</c:if>>
													발표</option>
										</select>
									</span>
								</ul>
								</td>
								</li>
								<tr>
									<th>제목</th>
									<td><input type="text" name="gnotice_title" style="width: 90%" value="${data.gnotice_title}" /></td>
								</tr>
								<tr>
									<th>작성자</th>
									<td>관리자</td>
								</tr>
								<tr>
									<th>내용</th>
									<td><textarea name="gnotice_content" id="gnotice_content" style="width: 90%">${data.gnotice_content}</textarea></td>
								</tr>
								<tr>
									<th>첨부파일</th>
									<td><input type="file" name="filename" ></td>
								</tr>

							</div>
						</tbody>
					</table>
					<div class="btnSet">
					   <a class="btn" style="align:left; background-color:grey; border:2px solid grey " href="javascript:goBack();" >이전 </a>
                        <a class="btn" style="align:right;" href="javascript:goSave();">저장 </a>
						
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>