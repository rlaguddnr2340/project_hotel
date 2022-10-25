<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  <head>
    <meta charset="utf-8" />
    <title>Swiper demo</title>
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"
    />
      <!-- Link Swiper's CSS  -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"
    />
    <link href="/hotel/css/hotel/swiperHotel.css" rel="stylesheet" type="text/css">
    <!-- Demo styles -->
    <style>

	</style>

    <script type="text/javascript">
    	function goSubmit() {
    		if($("#searchWord").val()=='' && $("#selectbox_state").val()=='0'){
				alert('찾으시고자하는 호텔의 이름 작성 또는 지역을 선택해주세요.');
				return false;
    		}
    	}
    </script>

  </head>

  <body>
  <%@ include file="/WEB-INF/views/includes/G_header.jsp"  %>
  <div class="search_box">
	<form class="search_box_form" action="/hotel/main/search.do" method="get" onsubmit="return goSubmit();">
		<input type="text" size="50%" height="40px" id="searchWord" name="searchWord" placeholder="호텔이름을 입력하세요" ><br>
		
		<div class ="location_box">
			<div class ="location_box_select">
				<span style="align-items: flex-end;">지역 카테고리를 선택하세요.</span>
				<select name ="selectbox_state" id="selectbox_state" onchange="optionChange()">
					<option value ="0" selected>시/도</option>
					<c:forEach var ="state" items="${list}">
					<option value ="${state.state_code}" >${state.state_name}</option>
					</c:forEach>
				</select>
				
				<select name ="selectbox_district" id="selectbox_district" >
					<option value ="0" selected>시/군/구</option>
				</select>
				
				<input type="submit" value="검색" id="searchBtn">
				</div>
			</div>
	</form><br>
	</div>
	<div id="background">
    <!-- Swiper seoul -->
	<h2 align="center">서울상품</h2>
	<div class="swiper mySwiper_s">
		<div class="swiper-wrapper">
			<c:forEach var="SH" items="${data.listSeoul }">
			<div class="swiper-slide" >
				<a href="/hotel/main/hotelView.do?hotel_no=${SH.hotel_no}" style="text-decoration: none;">
						<div class="hotel01"><img alt="서울이미지오류" src="/hotel/upload/${SH.filename}" width="100px" height="100px">
						</div>
					<div style="font-size: 15px; color: black">
						<div><strong>${SH.hotel_name}</strong></div>
						<div class="star-ratings" style="text-align: center; display: inline-block;">
							<div class="star-ratings-fill space-x-2 text-lg" style="width: ${SH.avgScore/5*100}%;">
								<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
							</div>
							<div class="star-ratings-base space-x-2 text-lg">
								<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
							</div>
						</div>(${SH.avgScore})<br>
						<span>최저가:  <fmt:formatNumber value="${SH.lowPrice }" pattern="#,###"/> ~</span><br>
						<span>리뷰 수: ${SH.totalReview}, 좋아요 수: ${SH.totalLike}</span>
					</div>					
				</a>
			</div>
			</c:forEach>
		</div>
		<div class="swiper-button-next"></div>
		<div class="swiper-button-prev"></div>
	</div>
	
	<h2 align="center">인천상품</h2>
    <!-- Swiper incheon -->
	<div class="swiper mySwiper_i ">
		<div class="swiper-wrapper">
			<c:forEach var="IH" items="${data.listIncheon }">
			<div class="swiper-slide">
				<a href="/hotel/main/hotelView.do?hotel_no=${IH.hotel_no}" style="text-decoration: none;">
						<div id="hotel01"><img alt="인천이미지오류" src="/hotel/upload/${IH.filename}" width="200px" height="200px">
						</div>
					<div style="font-size: 15px; color: black; ">
					<div><strong>${IH.hotel_name}</strong></div>
						<div class="star-ratings" style="text-align: center; display: inline-block;">
							<div class="star-ratings-fill space-x-2 text-lg" style="width: ${IH.avgScore/5*100}%;">
								<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
							</div>
							<div class="star-ratings-base space-x-2 text-lg">
								<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
							</div>
						</div>(${IH.avgScore})<br>
						<span>최저가:  <fmt:formatNumber value="${IH.lowPrice }" pattern="#,###"/>~</span><br>
						<span>리뷰 수: ${IH.totalReview}, 좋아요 수: ${IH.totalLike}</span>
					</div>					
				</a>
			</div>
			</c:forEach>
		</div>
		<div class="swiper-button-next"></div>
		<div class="swiper-button-prev"></div>
	</div>
	
	<h2 align="center">경기상품</h2>
    <!-- Swiper kyeonggi -->
	<div class="swiper mySwiper_k">
		<div class="swiper-wrapper">
			<c:forEach var="KH" items="${data.listKyeonggi }">
			<div class="swiper-slide">
				<a href="/hotel/main/hotelView.do?hotel_no=${KH.hotel_no}" style="text-decoration: none;">
						<div class="hotel01">
							<img alt="경기이미지오류" src="/hotel/upload/${KH.filename}" width="200px" height="200px">
						</div>
					<div style="font-size: 15px; color: black;">
						<div><strong>${KH.hotel_name}</strong></div>
						<div class="star-ratings" style="text-align: center; display: inline-block;">
							<div class="star-ratings-fill space-x-2 text-lg" style="width: ${KH.avgScore/5*100}%;">
								<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
							</div>
							<div class="star-ratings-base space-x-2 text-lg">
								<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
							</div>
						</div> (${KH.avgScore})<br>
						<span>최저가:  <fmt:formatNumber value="${KH.lowPrice }" pattern="#,###"/> ~</span></br>
						<span>리뷰 수: ${KH.totalReview}, 좋아요 수: ${KH.totalLike}</span>
					</div>					
				</a>
			</div>
			</c:forEach>
		</div>
		<div class="swiper-button-next"></div>
		<div class="swiper-button-prev"></div>
	</div>
</div>
	<!-- Swiper JS -->
    <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<!-- 동적셀렉트 -->
	<script>
	function optionChange() {
		$.ajax({
			url : "district.do",
			type : "POST",
			data : {
					state_code : $("#selectbox_state").val()
				},
			success : function(result) {
				var str = "<option value =" + 0 + " selected>시/군/구</option>";
				if($("#selectbox_state").val() != 0){
					$.each(result, function(i){
	                   str += "<option value = ";
	                   str +=  + result[i].district_code +""; 
	                   str +=  ">" +result[i].district_name+"</option>"
	                });
				} else {
						str = "<option value =" + 0 + " selected>시/군/구</option>";
					}
					$("#selectbox_district").empty($("#selectbox_district").val());
                    $("#selectbox_district").append(str);
				}
		})
	}
	</script>
	
    <!-- Initialize Swiper -->
   <script>
   document.addEventListener("DOMContentLoaded", function(){
	   
      var swiper = new Swiper(".swiper", {
    	  loop: true,
    	  sildesPerView: 3,
    	  slidesPerGroup: 3,
    	  spaceBetween: 24,
          navigation: {
	          nextEl: ".swiper-button-next",
	          prevEl: ".swiper-button-prev",
        },
        breakpoints: {
        	1280: {
        		loop: true,
        		slidesPerView: 3,
        		slidesPerGroup: 3,
        	},
        }
      });
   });
    </script>
  </body>
</html>
