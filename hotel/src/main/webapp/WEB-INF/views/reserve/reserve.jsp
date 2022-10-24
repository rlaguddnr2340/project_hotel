<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/G_header.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a5d133f411d7216df47f409d9f8b79bd"></script>

<style>
*:focus{
	outline: 0;
}
.hr1{
	width:300px;
	margin:30px 0 0 400px;
	border-width: 1px;
}

.hr2{
	width:300px;
}
.insertdiv{
	display:inline-block;
	width : 130px;
}
.insertdiv2{
	display:inline-block;
	width : 30px;
}
.div1{
	width: 300px;
}

.leftdiv{
	
	width: 800px;
	float: left;
	
}
.rightdiv{
	display: inline-block;
	margin:200px 0 0 200px;
	background-color: lavenderblush;
	
	float: left;
}
#submit{
	width: 300px;
	height: 50px;
	border : solid 1px;
	font-size : 1.4em;
	color: white;
	background-color: #FF3366;
	
}
#totalprice{
	font-size: 1.4em;
	background-color: lavenderblush;
}

</style>
<script>

$(function(){
	var startdate=${param.startdate};
	var orgtotalprice = ${totalprice};
	$("#totalprice").val(orgtotalprice.toLocaleString('ko-KR'));
	
	$("#coupon_price").on("focusout",function(){
		var totalprice = ${totalprice}-$('#point').val()-$('#coupon_price').val();
		
		$("#totalprice").val(totalprice.toLocaleString('ko-KR'));
		if(totalprice< 100){
			alert("최소 결제금액은 100원 입니다.");
			$("#totalprice").val(orgtotalprice.toLocaleString('ko-KR'));
			$("#point").val('');
			resetcoupon();
		}
	});	
	
	$("#point").on("focusout",function(){
		var totalprice = ${totalprice}-$('#point').val()-$('#coupon_price').val();
		console.log(totalprice.toLocaleString('ko-KR'));
		if(${totalpoint} < $("#point").val()){
    		alert("포인트가 부족합니다. 다시입력하세요");
			$("#point").val('');
			$("#point").focus();
			
		}	
		
		$("#totalprice").val(totalprice.toLocaleString('ko-KR'));
		if(totalprice<100){
			alert("최소 결제금액은 100원 입니다.");
			$("#totalprice").val(orgtotalprice.toLocaleString('ko-KR'));
			$("#point").val('');
			resetcoupon();
		}
	});	
});

function showPopup(data) { 
	window.open("/hotel/reserve/couponlist.do?guest_id="+data, "coupon_list", "width=500, height=500, left=200, top=200"); 
}

function resetcoupon(){
	$("#coupon_price").val("");
	$("#coupon_no").val("");
	var totalprice = ${totalprice}-$('#point').val()-$('#coupon_price').val();
	$("#totalprice").val(totalprice.toLocaleString('ko-KR'));
	
}


function reserve(){
	if($("#rev_name").val()==''){
		alert("예약자 이름을 입력하세요");
		$("#rev_name").focus();
		return false;
	}
	
	if($("#rev_hp").val()==''){
		alert("예약자 전화번호를 입력하세요");
		$("#rev_hp").focus();
		return false;
	}
	
	if($("#point").val()==''){
		$("#point").val('0');
	}
	
	if($("#payselect").val()==0){
		var con = true;
		var IMP = window.IMP;      
		IMP.init('imp74083745');                 
		IMP.request_pay({            
			pg: 'html5_inicis',
			pay_method: 'card',
			merchant_uid: 'merchant_' + new Date().getTime(),
			name: "${hotelinfo.hotel_name}",//상품페이지에서 있는 객실이름
			amount: ${totalprice}-$('#point').val()-$('#coupon_price').val(), //상품페이지에서 있는 금액
			buyer_email: "${loginInfo.guest_email}",//로그인 세션에 저장되어있는 이메일
			buyer_name: "${loginInfo.guest_name}",//로그인 세션에 저장되어있는 이름
			buyer_tel: "${loginInfo.guest_hp}",//로그인 세션에 저장되어있는 전화번호
			buyer_addr: "${loginInfo.guest_addr1}",//로그인 세션에 저장되어있는 주소
			},function (rsp) { 
				console.log(rsp)
						   if (rsp.success) {
						    $.ajax({
						           url: "reserveinsert.do",
						           type : "POST",
						           async : false,
						           data : 
						           {imp_uid: rsp.imp_uid,
						        	total_price : ${totalprice}-$('#point').val()-$('#coupon_price').val(),
						        	startdate :  '${param.startdate}',
						        	enddate :  '${param.enddate}',
						        	room_no : ${param.room_no},
						        	hotel_no : ${param.hotel_no},
						        	guest_no : ${loginInfo.guest_no},
						        	guest_hp : "${loginInfo.guest_hp}",
						        	rev_name : $("#rev_name").val(),
						        	rev_hp : $("#rev_hp").val(),
						        	used_point : $("#point").val(),
						        	coupon_no : $("#coupon_no").val(),
						        	totalpoint : ${totalpoint}-$("#point").val()
						           }
						       }).done(function (data) {
						    	   if(data ==0){
							          alert("결제 완료");
							          location.href="/hotel/reserve/index.do";
 						    	   }
						    	   else{
						    		  alert("이미 예약완료된 객실입니다.\n 결제가 취소됩니다.");
						    		  $.ajax({
									   		url : "/hotel/cancel/cancel.do",
									   		type: "post",
									   		data : {imp_uid : rsp.imp_uid,
									   				guest_no : ${loginInfo.guest_no},
									   				totalpoint : ${totalpoint}
									   		},
									   		success : function(res){
									   		}
									   	});
						    		   }
						       })
						     } else {
						       alert("결제에 실패하였습니다.\n 다시 시도해주세요");
						       window.location.reload();
						      con =false;
						  }
				});
		}
	else{
		$(function(){
			$.ajax({
				url :"/hotel/reserve/paytransfer.do",
				type :"post",
				async : false,
				data : {
					imp_uid : "imp_"+new Date().getTime(),
					total_price : ${totalprice}-$('#point').val()-$('#coupon_price').val(),
		        	startdate :  '${param.startdate}',
		        	enddate :  '${param.enddate}',
		        	room_no : ${param.room_no},
		        	hotel_no : ${param.hotel_no},
		        	guest_no : ${loginInfo.guest_no},
		        	guest_hp : "${loginInfo.guest_hp}",
		        	rev_name : $("#rev_name").val(),
		        	rev_hp : $("#rev_hp").val(),
		        	used_point : Number($("#point").val()),
		        	coupon_no : $("#coupon_no").val(),
		        	totalpoint : ${totalpoint}-$("#point").val(),
		        	pay_type : $("#payselect").val()
				},
				success : function(res){
					if(res.check ==0 ){
						alert("예약완료되었습니다.)");
						location.href="/hotel/reserve/paytransfer.do?hotel_no="+${param.hotel_no}+"&imp_uid="+res.imp_uid;
					}
					else{
						alert("이미 예약완료된 객실입니다.\n다른객실 이용부탁드립니다.");
						location.href="/hotel/main/hotelView.do?hotel_no="+${param.hotel_no}
					}
				}
			});
		});
	}
}  
</script>
<head>
<meta charset="UTF-8">
<title>예약 확인</title>
</head>
<body>

<div class="leftdiv">
	<div style="margin:200px 0 0 400px"> 
		<h4>예약자 정보</h4>
	</div>
	
	<div style="margin:30px 0 0 400px">
		예약자 이름 <br>
		<input type="text" id="rev_name" name="rev_name" style="width:300px;" placeholder="체크인시 필요한 정보입니다.">
	</div>
	
	<div style="margin:30px 0 0 400px">
		예약자 전화번호 <br>
		<input type="text" id="rev_hp" name="rev_hp" style="width:300px;"  placeholder="체크인시 필요한 정보입니다">
	</div>
	
	<hr class="hr1">
	
	<div style="margin:40px 0 0 400px"> 
		<h4>할인수단 선택</h4>
	</div>
	
	<div class="div1" style="margin:30px 0 0 400px" >
		<div>
			구매 총액
			<div class="insertdiv">
		</div>
			<b>총 금액적기</b><br><br>
			<button type="button" style="margin-bottom: 20px;" id="btn" onclick="showPopup('${loginInfo.guest_id}');">보유 쿠폰 보기</button>
			<div class="insertdiv2"></div>
			<input type="text" name="coupon_price" style="width:130px;" id="coupon_price" readonly="readonly" value="">
			<br>
			<input type="button" id="reset" onclick="resetcoupon();" value="쿠폰취소">
			<input type="hidden" name="coupon_no" id="coupon_no" value=""><br><br>
			포인트 사용 <fmt:formatNumber value="${totalpoint}" pattern="#,###" />P
			<input type="text" id="point" name="point" style="width: 153.55px">
		</div>
	</div>
	
	<hr class="hr1">
	
	<div style="margin:40px 0 0 400px"> 
		<h4>결제 수단</h4>
		<select id="payselect">
				<option value="0" selected="selected">카드</option>
				<option value="1">무통장입금</option>
		</select>
	</div>
</div>
<div class="rightdiv">
	호텔이름
	<h4>${hotelinfo.hotel_name}</h4><br>
	객실이름
	<h4>${roominfo.room_name}</h4><br>
	체크인
	<h4>${param.startdate} 15:00</h4><br>
	체크아웃
	<h4>${param.enddate} 12:00</h4><br>
	
	<hr class="hr2">
	
	<h3>총 결제 금액</h3><br>
	<b>총가격</b> &nbsp;<input type="text" id="totalprice" style="border:none" readonly="readonly" 
	value="">
	<br>
	<input type="button" id="submit" value="예약" onclick="return reserve();">
</div>
</body>
</html>