<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="/WEB-INF/views/includes/G_header.jsp" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>예약내역</title>
    <link rel="stylesheet" href="/hotel/css/reset.css"/>
    <link rel="stylesheet" href="/hotel/css/contents.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</head>
<script>
function cancel(imp,used_point){
	console.log(imp);
	console.log(used_point);
	$.ajax({
		url : "/hotel/cancel/cancel.do",
		type: "post",
		data : {imp_uid : imp,
				guest_no : ${loginInfo.guest_no},
				used_point : used_point
		},
		success : function(res){
			console.log(res);
			if(res.substring(8,9) !=0){
				alert("실패했습니다.")
			}
			else{
				alert("성공했습니다.");
				window.location.reload();
			}
		}
	});
}

function accountcancel(reserv_no){
	console.log(reserv_no);
	$.ajax({
		url : "/hotel/cancel/payaccountcancle.do",
		type: "post",
		data : {reserv_no : reserv_no,
				guest_no : ${loginInfo.guest_no},
				totalpoint : ${totalpoint}
		},
		success : function(res){
			console.log(res);
				alert("성공했습니다.");
				window.location.reload();
		}
	});
}

</script>

<body>  
    <!-- room 정보  -->
            <div class="sub">
            <div class="size">
    
                <div class="bbs">
	                <h3 class="sub_title">나의 예약 내역</h3>
                    <table class="list">
                    <p><span><strong>총 ${data.totalCount}개</strong>  |  ${roomVO.page}/${data.totalPage}페이지</span></p>
                        <caption>my rooms</caption>
                        <colgroup>
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                        </colgroup>
                        <thead style="text-align:center;">
                            <tr>
                                <th>번호</th>
                                <th>예약일자</th>
                                <th>예약자</th>
                                <th>호텔</th>
                                <th>객실</th>
                                <th>결제금액</th>
                                <th>사용포인트</th>
                                <th>예약상태</th>
                                <th>이용상태</th>
                                <th>취소하기</th>
                                <th>리뷰</th>
                            </tr>
                        </thead>
                        <tbody>
							
							<c:if test="${empty data.list}">
	                            <tr>
	                                <td class="first" colspan="11">예약 내역이 없습니다.</td>
	                            </tr>
							</c:if>
							
								
							<c:forEach items="${data.list}" var="row" varStatus="loop">
		                            <tr><!-- 글번호 총갯수 - 인덱스 -(현재페이지 번호 - 1)*페이지당 갯수///다시보자-->
		                                <td>
		                                	${data.totalCount - loop.index -(roomVO.page-1)*roomVO.pageRow}
		                                </td>
		                                
		                                <td class="txt_l">
		                                	<fmt:formatDate value="" pattern=""/>
		                                	<fmt:parseDate value=""  pattern="yy-MM-dd"/>
		                                  ${row.startdate} ~ ${row.enddate }
		                                </td>
		                                
		                                <td class="txt_l">
		                                  ${row.rev_name }
		                                </td>
		                                <td class="txt_l">
		                                   ${row.hotel_name}
		                                </td>
		                                
		                                <td>
		                                	${row.number}
		                                </td>
		                                
		                                
		                                <td class="writer">
		                                    ${row.total_price} 
		                                </td>
		                                <td class="writer">
		                                    ${row.used_point} 
		                                </td>
		                                <td >
		                                	<c:if test="${row.rev_status ==0 }">예약완료 </c:if>
		                                	<c:if test="${row.rev_status ==1 }">예약취소</c:if>
		                                </td>
		                                
		                                <td>
			                                 <c:if test="${row.rev_status ==1 && (row.use_status == 0 || row.use_status == 1)}">-</c:if>
			                                 <c:if test="${row.rev_status == 0 && row.use_status == 0}">이용전</c:if>
			                                 <c:if test="${row.use_status == 1 }">이용완료</c:if>
			                                 <c:if test="${row.rev_status ==1 && row.use_status == 2}">규정위반(취소)</c:if>
		                                </td>
		                                
		                                <td>
		                                	<c:if test="${row.rev_status ==0 && row.use_status == 0 && row.pay_status !=0}">
		                                		<input type="button" onclick="cancel('${row.imp_uid}','${row.used_point} ');" value="예약취소">
		                                	</c:if>
		                                	
		                                	<c:if test="${row.rev_status ==0 && row.use_status == 0 && row.pay_status==0}">
		                                		<input type="button" onclick="accountcancel('${row.reserv_no}');" value="예약취소">
		                                	</c:if>
		                                	<c:if test="${row.rev_status !=0 || row.use_status != 0}">-</c:if>
		                                </td>
						
										<td>
											<c:if test="${row.use_status == 1 && row.review_status==0}">
												<a onclick="location.href='../review/write.do?guest_no=${loginInfo.guest_no}&reserv_no=${row.reserv_no }&hotel_no=${row.hotel_no}&room_no=${row.room_no }'">[리뷰 작성하기]</a>
											</c:if>
											<c:if test="${row.review_status==1}">
												<a onclick="location.href='/hotel/main/hotelView.do?hotel_no=${row.hotel_no}'">[리뷰보기]</a>
											</c:if>
										</td>
		                            </tr>
		                          
							</c:forEach>
					
							
						
                        </tbody>
                    </table>
                   
                    
                    <!-- 페이지 처리 -->
                     <div class="pagenate clear">
		               <ul class='paging'>
			               <c:if test="${data.prev ==true }">
			               		<li><a href ="index.do?page=${data.startPage-1}&stype=${param.stype}&sword=${param.sword}"><</a>
			               </c:if>
			               
			               	<c:forEach var="page" begin="${data.startPage}" end="${data.endPage}">
			               		<li><a href ='index.do?page=${page}&stype=${param.stype}&sword=${param.sword}' <c:if test="${roomVO.page == page}">class='current'</c:if>>${page}</a></li></a>
			               	</c:forEach>
			               	
			               	<c:if test="${data.next ==true }">
			               		<li><a href = "index.do?page=${data.endPage+1}&stype=${param.stype}&sword=${param.sword}">></a></li>
			               	</c:if>
		               </ul>
		            </div>
                
                    <!-- 페이지처리 -->
                    
                 
                </div>
            </div>
        </div>
        
</body>
</html>