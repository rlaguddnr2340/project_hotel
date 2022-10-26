<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/WEB-INF/views/admin/include/headHtml.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
		function conBtn(){
					if($('input:radio[name="isConfirm"]:checked').val() == 2) {
						if($('#reject').val() !=''){
							alert('거절사유가 입력되어있습니다.');
							$('#reject').focus();
							return false;
						} else {
							alert("승인처리 되었습니다.");
							location.href = "hostList.do";
						}
					} else{
						if($('#reject').val() ==''){
							alert('거절사유를 입력해주세요.');
							$('#reject').focus();
							return false;
						} else{
							alert("반려처리 되었습니다.");
							location.href = "hostList.do";
						}
					}
				}

</script>
</head>

<body> 
<%@ include file="/WEB-INF/views/admin/include/top.jsp" %>


<div class="container">
	<div id="infoTable" style="display: inline;">
		<table id="hotelInfo" border="2px solid #black;">
			<th>호텔명 : ${view.hotel.hotel_name}</th>
			<tr>
				<td>주소 : ${view.hotel.addr}</td>
			</tr>
		</table>	
	</div>
	<div id="imageArea">
		<div id="hotel image" style="border: 2px solid black;">
			<c:forEach var="hotelImage" items="${view.imageH }">
				<img alt="이미지없음" src="/hotel/upload/${hotelImage.filename_real}">
			</c:forEach>
		</div>
		<div id="room image" style="border: 2px solid black; margin-top: 20px;">
			<div id="roomInfo">
				<c:forEach var="room" items="${view.room }">
					${room.room_name}
				</c:forEach>
			</div>
			<div>
				<c:forEach var="roomImage" items="${view.imageR }" varStatus="idx">
					<img alt="이미지없음" src="/hotel/upload/${roomImage.filename_real}" width="100px" height="100px">
				</c:forEach>		
			</div>
		</div>
	</div>
	<form action="/hotel/admin/main/setConfirm.do" method="post" onsubmit="return conBtn();">
		<div id="confirmBtn" style="margin-top: 20px;">
			<textarea id="reject" rows="10" cols="100" name="reject" placeholder="거절사유를 입력하세요.">${view.hotel.reject}</textarea><br>
			<input type="radio" value="3" name="isConfirm"<c:if test="${view.hotel.isConfirm == 3 }">checked</c:if>>반려<br>	
			<input type="radio" value="2" name="isConfirm"<c:if test="${view.hotel.isConfirm == 2 }">checked</c:if>>승인<br>	
			<input type="hidden" name="host_no" value="${param.host_no }">
			<input type="submit" value="제출">
		</div>
	</form>
</div>
</body>
</html>