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
    <link href="/hotel/css/hotel/hotelView.css" rel="stylesheet" type="text/css">
    

  </head>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a5d133f411d7216df47f409d9f8b79bd"></script>
	<!-- 카카오톡 공유하기 -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<style>
	.link-icon { position: relative; display: inline-flex; width:50px; height:50px;  font-size: 14px; font-weight: 500; color: #333; margin-right: 10px; top:20px;}
	.link-icon.kakao { background-image: url(/hotel/image/boardPic/icon-kakao.png); background-repeat: no-repeat; }
	</style>

  <%@ include file="/WEB-INF/views/includes/G_header.jsp"  %>
  <!-- 찜하기 제이쿼리 -->
  <script src="/hotel/script/heart.js"></script>

  <body>
	<div class ="detail_full_screen">
		<div id="hotel_screen">
	  		<div class="hotelName">
	  			<span>${hotel.hotel_name}</span>
			</div>	  	
			<!-- "찜하기" 구현-->
				  	<a id="btnKakao" class="link-icon kakao" href="javascript:shareKakao();"></a>			
			  		<c:if test="${!empty rev }">
						<img class="like"  data-name="del" data-gno="${rev.guest_no}" data-hno="${rev.hotel_no}" src="/hotel/image/mypage/heart.png" style="width:50px; height: 50px;  margin:0;" >
			  		</c:if>
			  		<c:if test="${empty rev }">
						<img class="like"  data-name="fav" data-gno="${loginInfo.guest_no }" data-hno="${hotel.hotel_no}" src="/hotel/image/mypage/emptyHeart.png" style="width:50px; height: 50px;  margin:0;" >
			  		</c:if>
			<!-- END-"찜하기"-->		

	  		<!-- 별점찍기 구현-->
	  		<div id="star-heart">
		  		<div class="star-ratings" style="text-align: center; display: inline-block; left: 327px;">
					<div class="star-ratings-fill space-x-2 text-lg" style="width: ${hotel.avgScore/5*100}%;">
						<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
					</div>
					<div class="star-ratings-base space-x-2 text-lg">
						<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
					</div>
					<span>(${hotel.avgScore })</span>			  		
	  			</div>
			</div>
	  		<!-- END 별점찍기 -->
	  		

	  		

		  	<div class="swiper mySwiper" id="Low" style="display: inline-block; height: 350px;">
		  		<div class="swiper-wrapper" >
				  	<c:forEach var="hotelImage" items="${hotelImage}">
				  		<div class="swiper-slide" id="imgBox"><img alt="사진없음" src="/hotel/upload/${hotelImage.filename_real}"></div>
				  	</c:forEach>
		  		</div>
		  		<div class="swiper-button-next"></div>
			    <div class="swiper-button-prev"></div>
			    <div class="swiper-pagination"></div>
			</div>

			<div id="map" style="width:500px;height:250px;display: inline-block;vertical-align: middle"></div>


	  		<div class="middleBox" style="text-align: center;">
	  			<span>객실 안내/예약</span>
	  		</div>
  		</div>
  		
  		<!-- 객실리스트 -->
  		<div class="room_Screen">
  			<c:forEach var="roomList" items="${room}">
  			<div class="lowDiv">
		  		<div class="swiper mySwiper" id="Low" style="display: inline-block;">
	      			<div class="swiper-wrapper" >
	      				<c:forEach var="roomImage" items="${roomList.imageList}">
	        			<div class="swiper-slide" id="imgBox"><img alt="객실이미지" src="/hotel/upload/${roomImage.filename_real}"></div>
	        			</c:forEach>
	      			</div>
			      	<div class="swiper-button-next"></div>
			      	<div class="swiper-button-prev"></div>
			      	<div class="swiper-pagination"></div>
	    		</div> 
		    	<div id="infoBox" style="display: inline-block;">
		    		<div id="infoContent"><span>객실명: </span><span style="font-weight: bold;">${roomList.room_name}</span></div>
		    		<div id="infoContent"><span>객실비용: </span><span style="font-weight: bold;"><fmt:formatNumber value="${roomList.room_price}" pattern="#,###"/></span></div>
		    		<div id="infoContent"><span style="font-weight: bold; ">서비스 및 편의시설 </span><span ><pre id="infoContent2">${roomList.room_content}</pre></span></div>
		    		<div id="reservBtn"><input type="button" onclick="location.href='/hotel/main/roomView.do?room_no=${roomList.room_no}&hotel_no=${hotel.hotel_no }'" value="객실정보 확인 및 예약" style="margin-left: 330px;"></div>
				</div>
			</div>		
			</c:forEach> 
		</div>
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
	<script>
		console.log(${hotel.lat})
		var container = document.getElementById('map');
		var options = {
						center: new kakao.maps.LatLng(${hotel.lat}, ${hotel.lot}),
						level: 3
					  };
		var map = new kakao.maps.Map(container, options);
		var markerPosition  = new kakao.maps.LatLng(${hotel.lat}, ${hotel.lot}); 
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
	</script>	
	
	<script>

	// 카카오톡 공유
		Kakao.init('7316461b564393db0543f1e130e426e9'); // 앱 키
	$(function shareKakao() {
		Kakao.Share.createDefaultButton({
					container : '#btnKakao',
					objectType : 'feed',
					content : {
						title : '${data.gnotice_title }',
						description : '${data.gnotice_content}',
						imageUrl : 'http://localhost:8080/hotel/image/boardPic/notice.png',
						link : {
							mobileWebUrl : 'http://localhost:8080/hotel/guestboard/view.do?gnotice_no=${data.gnotice_no}',
							webUrl : 'http://localhost:8080/hotel/guestboard/view.do?gnotice_no=${data.gnotice_no}',
						}
					}
				})
	})
	</script>
  </body>