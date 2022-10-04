<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/G_header.jsp" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 찜 목록</title>
<link rel="stylesheet" href="/hotel/css/reset.css"/>
<link rel="stylesheet" href="/hotel/css/contents.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</head>

<script>



	function getFav(){//댓글의 페이지 번호를 받음
		$.ajax({
			type:"GET",
			url : "../fav/list.do",
			async:false,
			data : {
				guest_no : ${loginInfo.guest_no}
			},
			
			success : function(res){
				$("#favListArea").html(res);
			}
		});//END_AJAX
	}
	
	$(function() {
		
		getFav();
		
		$(".like").on("click", function(){
			var id = $(this).data("name");
			var gno = $(this).data("gno");
			var hno = $(this).data("hno");
			
			like(id, gno, hno, $(this));
			
		
		})//click event-end
	})//$(function(){})-end
	
	
	function like(id_name, guest_no, hotel_no, obj){
		$.ajax({
			type: "GET",
			url: "../fav/"+id_name,
			data: {guest_no:guest_no,
				   hotel_no:hotel_no},
			error:function(er){
				alert("ERROR");
			},
			success: function(res){
				if(id_name == 'del'){
					obj.attr("src","/hotel/image/mypage/emptyHeart.png");
					obj.data("name",'fav');
				}else{
					obj.attr("src","/hotel/image/mypage/heart.png");
					obj.data("name",'del');
				}
			}
			
			
			
		});//ajax-end
	}
	
</script>

<body style="padding:50px;">
	<div style="text-align: center; padding:75px;">
		<h1 >내 찜 목록쓰</h1>
	</div>

	<div id="favListArea" style="margin-bottom: 100px;"> </div>

</body>
</html>