<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<div class="low" style="display: inline-block; width: 650px;">
		<c:forEach var="list" items="${hotelList }" varStatus="idx">
			<div class="container_list" style="
					<c:if test="${idx.count == 1 || idx.count % 2 != 0}">border-right: 0.5px solid rgba(0,0,0,.1);</c:if>
					<c:if test="${idx.count < 2 && idx.last }"> height: 400px;</c:if>
					<c:if test="${!idx.last }">border-bottom: 0.5px solid rgba(0,0,0,.1); </c:if>
					<c:if test="${idx.count > 2 }">padding-top: 5px;</c:if>">
				<div>
					<div class="list_hotel" style="border: 1px;">
						<a href="/hotel/main/hotelView.do" style="text-decoration: none;">
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