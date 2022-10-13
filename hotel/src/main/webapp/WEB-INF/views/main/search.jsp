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
    <link href="/hotel/css/hotel/serachView.css" rel="stylesheet" type="text/css">
    <!-- Demo styles -->
    <script type="text/javascript">
    	function goSubmit() {
    		if($("#searchWord").val()=='' && $("#selectbox_state").val()=='0'){
				alert('찾으시고자하는 호텔의 이름 작성 또는 지역을 선택해주세요.');
				return false;
    		}
    			$('#search_box_form').submit();
    	}
    </script>
  </head>

  <body>
  <%@ include file="/WEB-INF/views/includes/G_header.jsp"  %>
  <div class="search_box">
	<form class="search_box_form" id="search_box_form" action="/hotel/main/search.do">
		<input type="text" size="50%" height="40px" id="searchWord" name="searchWord" value="${hotelVO.searchWord}" ><br>

		<div class ="location_box">
			<div class ="location_box_select" style="margin-top: 2px;">
				<select name ="selectbox_state" id="selectbox_state" onchange="optionChange()">
					<option value ="0">시/도</option>
					<c:forEach var ="state" items="${state}">
					<option value ="${state.state_code}" <c:if test="${state.state_code == param.selectbox_state}">selected</c:if>>${state.state_name}</option>
					</c:forEach>
				</select>
				
				<select name ="selectbox_district" id="selectbox_district" >
					<option value ="0">시/군/구</option>
					<c:forEach var="district" items="${district}" >
					<option value ="${district.district_code }"<c:if test="${district.district_code == param.selectbox_district}">selected</c:if>>${district.district_name }</option>
					</c:forEach> 
				</select>
				
				<input type="button" value="검색" onclick="goSubmit();">
			</div>
		</div>
	</form><br>
	</div>
	<c:if test="${hotelVO.searchWord !=''}">
	<span id="input_searchWord">입력한 검색어: ${hotelVO.searchWord}</span>
	</c:if>
	<c:if test="${hotelList.size() > 1}">
	<div class="selectbox_sort">
		<select name="sortType" id="sortType" onchange="sortList()">
			<option value="" selected>---</option>
			<option value="scoreList">평점순</option>
			<option value="lowPrice">낮은 가격순</option>
			<option value="review">리뷰순</option>
			<option value="favorite">좋아요순</option>
		</select>
	</div>
	</c:if>
	<div id="background">
	<div id="searchArea" class="container list_body" style="width: 1000px;">
		<div class="low">
		<c:if test="${empty hotelList}">
			<div class="first" colspan="8">등록된 호텔이 없습니다.</div>
		</c:if>
			<c:forEach var="list" items="${hotelList }" varStatus="idx">
				<div class="container_list" style="
					<c:if test="${idx.count == 1 || idx.count % 2 != 0}">border-right: 0.5px solid rgba(0,0,0,.1);</c:if>
					<c:if test="${idx.count < 2 && idx.last }"> height: 400px;</c:if>
					<c:if test="${!idx.last || idx < idx.end}">border-bottom: 0.5px solid rgba(0,0,0,.1);</c:if>
					<c:if test="${idx.count > 2 }">padding-top: 5px;</c:if>">
					<div>
						<div class="list_hotel" style="border: 1px;">
							<a href="/hotel/main/hotelView.do?hotel_no=${list.hotel_no }" style="text-decoration: none;">
								<div class="hotel_img"><img alt="이미지오류" src="/hotel/upload/${list.filename}" width="250" height="200"></div>
								<div style="color: #000000;">
									<div><strong>${list.hotel_name}</strong></div>
									<div class="star-ratings" style="text-align: center; display: inline-block; font-size: 20px;">
										<div class="star-ratings-fill space-x-2 text-lg" style="width: ${list.avgScore/5*100}%;">
											<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
										</div>
										<div class="star-ratings-base space-x-2 text-lg">
											<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
										</div>
									</div><strong>(${list.avgScore})</strong><br>
									<span style="font-size: 15px;">최저가:  <fmt:formatNumber value="${list.lowPrice }" pattern="#,###"/> ~</span><br>
									<span style="font-size: 15px;">리뷰 수: ${list.totalReview}, 좋아요 수: ${list.totalLike}</span>
								</div>
							</a>
						</div>
					</div>
					<div>
						<div>${list.hotel_content}</div>
					</div>
				</div>
			<c:if test="${idx.count % 2 == 0 && !idx.last}">
		</div>
		<div class="low" style="display: inline-block; width: 650px;">
			</c:if>
			</c:forEach>
		</div>
	</div>
	</div>
	
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
				if($("#selectbox_state").val() != ""){
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
	function sortList() {
		$.ajax({
			url : "sortType.do",
			type : "POST",
			data : {
					sortType : $("#sortType").val(),
					searchWord : $("#searchWord").val(),
					selectbox_state : $("#selectbox_state").val(),
					selectbox_district : $("#selectbox_district").val()
				},
			success : function(result) {
					$('#searchArea').html(result);
				}
		})
	}
	</script>
</body>