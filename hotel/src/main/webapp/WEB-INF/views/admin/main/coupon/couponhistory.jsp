<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/WEB-INF/views/admin/include/headHtml.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

</head>
<script>

</script>
<body> 
<div id="wrap">
	<!-- canvas -->
	<div id="canvas">
		<!-- S T A R T :: headerArea-->
		<%@ include file="/WEB-INF/views/admin/include/top.jsp" %>
		<!-- E N D :: headerArea--> 
		
		<!-- S T A R T :: containerArea-->
		<div id="container">
			<div id="content">
				<div class="con_tit">
					<h2>게스트관리 - [목록]</h2>
				</div>
				<!-- //con_tit -->
				<div class="con">
					<!-- 내용 : s -->
					<div id="bbs">
						<div id="blist">
							<p><span><strong>총 ${couponpaging.totalCount}개</strong>  |  ${couponVO.page }/${couponpaging.totalPage }페이지</span></p>
							<form name="frm" id="frm"  method="post">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" summary="관리자 관리목록입니다.">
								<colgroup>
									<col class="*" />
									<col class="*" />
									<col class="*" />
									<col class="*" />
									<col class="*" />
									<col class="*" />
									<col class="*" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">쿠폰번호</th> 
										<th scope="col">가격</th> 
										<th scope="col">아이디</th>
										<th scope="col">발급일자</th> 
										<th scope="col">만료일자</th> 
										<th scope="col">상태유무</th> 
										<th scope="col">상태변경</th> 
									</tr>
								</thead>
								<tbody>
								<c:forEach var="coupon" items="${couponpaging.list}" varStatus="status">
									<tr>	
										<td>${couponpaging.totalCount - status.index - ((couponVO.page - 1) * couponVO.pageRow)}</td>
										<td>${coupon.coupon_no}</td>
										<td>${coupon.coupon_price}</td>
										<td>${coupon.guest_no}</td>
										<td>${coupon.coupon_date}</td>
										<td>${coupon.expdate}</td>
										<td>
											<c:if test="${coupon.use_status == 1}">사용</c:if>
											<c:if test="${coupon.use_status == 0}">미사용</c:if>
										</td>
										<td>
											<c:if test="${coupon.use_status == 0}">
												<button>발급취소 </button>
											</c:if>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
							</form>
							
							<!--//btn-->
							<!-- 페이징 처리 -->
							<div class="page">
								<!-- 이전페이지 -->
								<c:if test="${couponpaging.prev == true }">
									<a href="guestlist.do?page=${couponpaging.startPage - 1 }&stype=${param.stype}&sword=${param.sword}"><</a>
								</c:if>
								<!-- 페이지별 -->
									<c:forEach var="p" begin="${couponpaging.startPage}" end="${couponpaging.endPage }">
										<a href='guestlist.do?page=${p}&stype=${param.stype}&sword=${param.sword}&page=${param.page}' 
										<c:if test="${couponVO.page == p }"> 
											class='current'
										</c:if>>${p }</a>
									</c:forEach>
								<!-- 다음페이지 -->
								<c:if test="${couponpaging.next == true }">
									<a href="guestlist.do?page=${couponpaging.endPage + 1 }&stype=${param.stype}&sword=${param.sword}&page=${param.page}">></a>
								</c:if>
							</div> 
							<!-- 페이지처리 -->
							<form name="searchForm" id="searchForm" action="guestlist.do"  method="get">
								<div class="search">
									<select name="stype" title="검색을 선택해주세요">
										<option value="guest_id" <c:if test="${param.stype eq 'guest_id'}">selected</c:if>>아이디</option>
										<option value="guest_name" <c:if test="${param.stype eq 'guest_name'}">selected</c:if>>이름</option>
									</select>
									<input type="text" id="sword" name="sword" value="${param.sword}" title="검색할 내용을 입력해주세요" />
									<input type="image" src="<%=request.getContextPath()%>/image/admin/btn_search.gif" class="sbtn" alt="검색" />
								</div>
							</form> 
							<!-- //search --> 
						</div>
						<!-- //blist -->
					</div>
					<!-- //bbs --> 
					<!-- 내용 : e -->
				</div>
				<!--//con -->
			</div>
			<!--//content -->
		</div>
		<!--//container --> 
		<!-- E N D :: containerArea-->
	</div>
	<!--//canvas -->
</div>
<!--//wrap -->

</body>
</html>