<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
function couponset(){
		var check = $(".couponset_check").is(":checked") ? true : false;
		console.log(check);
		if(check == false){
			console.log(opener.coupon_price.value ="0");
		}else{
		var idx = $(".couponset_check:checked").val();
		console.log(idx);
		var coupon_price = $("input[name='coupon_price']").eq(idx).val();
		var coupon_no = $("input[name='coupon_no']").eq(idx).val();
		console.log(coupon_price);
		console.log(coupon_no);
		opener.coupon_price.value = coupon_price; 
		opener.coupon_no.value = coupon_no;
		opener.coupon_price.focus();
		}
		window.close();
}

</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<div align="center">
			쿠폰적용
			<form id="frm">
			<c:forEach var="list" items="${data}" varStatus="status">
				<div style="border: 0.5px solid;">
					<label><input type="radio" class="couponset_check" name="radioArr" value="${status.index}">${list.coupon_price}&nbsp;쿠폰</label> 
					<input type="hidden" class="coupon_price" name="coupon_price" value="${list.coupon_price}">
					<input type="hidden" class="couponset_no" name="coupon_no" value="${list.coupon_no}">
				</div>
			</c:forEach>
			<input type="button" value="적용" onclick="couponset();">
			</form>
		</div>
	</div>

	
</body>
</html>