<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/H_header.jsp"%>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>


<style>
.dSelect {
	height : 100%;
	text-align : left;
}

th {
	width: 10%;
	text-align : center;
}
</style>

<script>
	function goSave(){
		editor.getById['hboard_content'].exec('UPDATE_CONTENTS_FIELD',[]); // getById -> jindo라는 프레임워크에서 사용하는 것	
		frm.submit();
	}
	var editor; // 변수를 밖에 쓴 이유: 전역변수로 사용하기 위해서
	$(function(){
		editor = setEditor('hboard_content'); // textarea id= content
	});
    	</script>


</head>
<body>
	<br>
	<br>
	<div class="sub">
		<div class="size">
			<h3 class="sub_title" style="text-align: left">Q&A</h3>
		
		
			<br>
			<h3 class="sub_title" style="text-align: left">새 문의글 작성</h3>
			<br>
			<div class="bbs">
				<form method="post" name="frm" id="frm" action="write.do" enctype="multipart/form-data">
					<input type="hidden" name="host_no" value="${loginInfo2.host_no}">
					<table class="board_write">
						<tbody>
							<div class="container">
								<ul class="list">
									<li class="item">
										<th>문의유형</th>
										</span>
										<td class="choose">
										<span class="srchSelect"> <select id="stype" name="hboard_type" class="dSelect" title="검색분류 선택">
												<option name="hboard_type" value="6">입점 문의</option>
												<option name="hboard_type" value="7">광고/제휴 문의</option>
												<option name="hboard_type" value="8">이용회원 문의</option>
												<option name="hboard_type" value="9">이용/기타 문의</option>
										</select>
									</li>
							<tr>
								<th>제목</th>
								<td><input name="hboard_title" id="hboard_title" type="text" style="width: 90%"></td>
							</tr>
							<tr>
								<th>작성자</th>
									<td ><input type ="text" id="host_name"  name="host_name" value="${loginInfo2.host_name}" readonly="readonly"></td>
							</tr>
							<tr>
								<th>문의내용</th>
								<td><textarea name="hboard_content" id="hboard_content" style="width: 90%"></textarea></td>
							</tr>
					
							<tr>
								<th>첨부파일</th>
								<td><input type="file" name="filename"></td>
							</tr>
							</ul>
							</div>
						</tbody>
					</table>
				   <div class="btnSet"  >
                        <a class="btn" style="align:left; background-color:grey; border:2px solid grey " href="javascript:goBack();" >이전 </a>
                        <a class="btn" style="align:right;" href="javascript:goSave();">저장 </a>
                    </div>
				</form>
			</div>
			
		</div>
	</div>

</body>
</html>