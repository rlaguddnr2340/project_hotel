<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  <head>
    <meta charset="utf-8" />
    <title>Hotel Detail</title>
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"
    />
	<link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"
    />
    <link href="/hotel/css/hotel/roomView.css" rel="stylesheet" type="text/css">
    <style>
	    $#ui-datepicker-div{
			position: fixed;
		}
    </style>
  </head>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<script>
	$(function() {
		$( "#startdate" ).datepicker({
   		 	dateFormat: 'yy-mm-dd' //Input Display Format 변경
                ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
                ,changeYear: true //콤보박스에서 년 선택 가능
                ,changeMonth: true //콤보박스에서 월 선택 가능                
                ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
                ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
                ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
                ,minDate: 0 //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                ,maxDate: "+30Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
                ,beforeShow: function(input) {
           	   		var i_offset = $(input).offset();
           	   		setTimeout (function(){
           	   			$('#ui-datepicker-div').css({'position': 'fixed'})
           	   		 })
           	   	 }
   	 	});
		
	   	 $('#startdate').datepicker('setDate', 'today');
	   	 
	   	 $( "#enddate" ).datepicker({
	   		 dateFormat: 'yy-mm-dd' //Input Display Format 변경
	                ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	                ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	                ,changeYear: true //콤보박스에서 년 선택 가능
	                ,changeMonth: true //콤보박스에서 월 선택 가능                
	                ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	                ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	                ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
	                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
         ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
         ,minDate: "+1D" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
         ,maxDate: "+30Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후) 
	   	 ,beforeShow: function(input) {
	   		 var i_offset = $(input).offset();
	   		 setTimeout (function(){
	   			 $('#ui-datepicker-div').css({'position': 'fixed'})
	   		 })
	   	 }
 });
	 $('#enddate').datepicker('setDate', 'today+1');
	 $('#enddate').val().replace("-","");
		   	 //console.log(typeof((Number)($('#enddate').val().replace(/-/g,""))));
		   	 //var startdate=(Number)($('#startdate').val().replace(/-/g,""));
		   	 //var enddate=(Number)($('#enddate').val().replace(/-/g,""));
			reservecheck();
		});

//페이지 이동시 중복체크
	function reservecheck(){
		 $.ajax({
			url : "/hotel/reserve/reservecheck.do",
			type : "post",
			data : {
				room_no : ${param.room_no},
				hotel_no : ${param.hotel_no}, //
				startdate : $('#startdate').val(),
				enddate : $('#enddate').val()
			}
		 }).done(function (res){
	   	 	 //console.log(startdate);
	   	 	 //console.log(enddate);
	   	 	 //console.log(enddate-startdate);
	   	 	 
	   	 	 console.log($("#startdate").val());
		   	 console.log($("#enddate").val());
			 var startdate=new Date($("#startdate").val().split('-'));
			 var enddate=new Date($("#enddate").val().split('-'));
			 var dif = enddate-startdate;
			 var day = 24*60*60*1000;
			 var diffdate=(dif/day);
		   	 console.log(diffdate);
	   	 	 
		   	 if(diffdate<0){
				 $("#calcprice").val('0');
		   	 }else{
		   		 var totalprice = (diffdate)*${roomInfo.room_price };
		   		 console.log(totalprice);
			 	$("#calcprice").val(totalprice.toLocaleString('ko-KR'));
		   	 }
		   	 
		   	 if($("#enddate").val()=='' || $("#startdate").val()==''){
		   		$("#calcprice").val('0');
		   	 }
		   	 
			 if(res !=0){
				 $("#reservebtn").val("예약 불가");
				 $("#reservebtn").css("background-color","gray");
		    	 $("#reservebtn").attr("disabled", true);
			 }
			 else{
				 if(startdate < enddate){
				 	$("#reservebtn").val("예약");
				 	$("#reservebtn").css("background-color","#FF3366");
				 	$("#reservebtn").attr("disabled", false);
				 }
				 else{
					 $('#enddate').val("");
					 $("#reservebtn").val("예약 불가");
					 $("#reservebtn").attr("background-color","gray");
			    	 $("#reservebtn").attr("disabled", true);
				 }
			 }
		})
	}
	
	function kakaomap(data){
		var popupX = (window.screen.width / 2) - (550 / 2);
		var popupY= (window.screen.height /2) - (350 / 2);
		window.open("/hotel/main/map.do?hotel_no="+data, "map", 'status=no, height=350, width=550, left='+ popupX + ', top='+ popupY); 
	}
	

	</script>
	
  <%@ include file="/WEB-INF/views/includes/G_header.jsp"  %>
  <body>

	<div class ="detail_full_screen">
		<div id="room_screen" style="vertical-align: middle;">
	  		<div class="roomName">${roomInfo.room_name}</div>
		  	<div class="swiper mySwiper" id="Low" style="display: inline-block; height: 350px">
		  		<div class="swiper-wrapper" >
				  	<c:forEach var="roomImage" items="${roomImage}">
				  		<div class="swiper-slide" id="imgBox"><img alt="사진없음" src="/hotel/upload/${roomImage.filename_real}"></div>
				  	</c:forEach>
		  		</div>
		  		<div class="swiper-button-next"></div>
			    <div class="swiper-button-prev"></div>
			    <div class="swiper-pagination"></div>
	  		</div>
	  		<div id="room_infoScreen" style="vertical-align: middle; display: inline-block;">
				<div class="star-ratings" style="display: inline-block;">
					<div class="star-ratings-fill space-x-2 text-lg" style="width: ${roomInfo.avgScore/5*100}%;">
						<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
					</div>
				<div class="star-ratings-base space-x-2 text-lg">
					<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
				</div>
				<span style="color: #f3f3f3;">(${roomInfo.avgScore })</span>
				</div>
				<form action="/hotel/reserve/reserve.do" method="post">
					<h4>체크인 날짜 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;체크아웃 날짜</h4>
		  			<input type="text" name="startdate" id="startdate"  onchange="reservecheck()" autocomplete="off">
		  			<input type="text" name="enddate" id="enddate"  onchange="reservecheck()" autocomplete="off">
		  			<input type="hidden" name="hotel_no" id="hotel_no" value="${param.hotel_no }">
		  			<input type="hidden" name="room_no" id="room_no" value="${param.room_no }">
		  			<input type="hidden" name="guest_no" id="guest_no" value="${loginInfo.guest_no }">
		  			<br><hr>
		  			<div>
		  				<input type="button" style="margin-bottom: 20px; width: 370px" id="map" onclick="kakaomap(${param.hotel_no});" value="위치확인하기">
		  			</div>
		  			
		  			<b>총 가격</b>&nbsp;
		  			<input type="text"  id="calcprice" style="outline: 0; border:none; font-size: 1.3em" readonly="readonly" value="">
 		  			<br><br>
					<div id="reserveBtn" style="display: inline-block; ">
		  				<input type="submit" style="width:368px; border-radius:50px; color:white;  background-color: #FF3366;" id="reservebtn" value="">
		  			</div>
	  			</form>
			</div>
	  	<div class="middleBox" style="text-align: center;">
	  		<span>객실 안내/예약</span>
	  	</div>
		</div>
  	</div>
  	<div class="roomInfoDiv">
	  	<div class="contentBox" >
	  		<pre>${roomInfo.room_content}</pre>
	  	</div>
	  	<div class="serviceBox" style="display: inline-block;">
	  		<div id="roomInfoBox price">1박 가격 : 
	  			<fmt:formatNumber value="${roomInfo.room_price }" pattern="#,###"/> 
	  		</div>
	  	</div>
  	</div>
  	<div class="reviewDiv">
  		<div id="reviewInfo" style="border: 1px solid black; text-align: center; ">
  			<span style="border: 1px solid #d3d3d3;">총 리뷰 수: ${roomInfo.totalReview}</span>
  			<span>해당객실의 리뷰입니다.</span>
  		</div>
  		<c:forEach var="review" items="${review }">
  		<div class="reviewBox" style="border: 1px solid #d3d3d3;">
  			<div id="review_Title">
  				제목 : ${review.review_title }
  			</div>
  			<div id="review_Content">
  				내용 : ${review.review_content}
  			</div>
  		</div>
  		</c:forEach>
  	</div>
  	
  	
  	
  	
    <!-- Swiper JS -->
    <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>

    <!-- Initialize Swiper -->
    <script>
      var swiper = new Swiper(".mySwiper", {
        cssMode: true,
        loop: true,
        navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
        pagination: {
          loop: true,
          el: ".swiper-pagination",
        },
        mousewheel: true,
        keyboard: true,
      });
    </script>


  </body>