<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/WEB-INF/views/admin/include/headHtml.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</head>
<style>
	.list{
		display: inline-block;
  		overflow: auto;
  		height:210px;
  		border-spacing: 0;
  		border: 1px solid black;
  		margin-right: 10px;
	}
	th {
		position: sticky;
		background-color : gray;
    	top: 0px;
	}
	.list2{
		display: inline-block;
  		overflow: auto;
  		height:210px;
  		border-spacing: 0;
  		border: 1px solid black;
	}
	.div1{
		clear:both;
		width:620px; 
		height:150px;
		float:left;
	}
	.div2{
		width:50px; 
		height:150px;
		float:left;
	}
</style>
<script>
$(function() {
	search();
	
	$(".coupon_price").change(function(){
		var idx = $(this).index(".coupon_price");
		if($(this).is(":checked")==true){
			console.log($(this).is(":checked"));
			$("input[name='amount']").eq(idx).removeAttr("disabled");
		}
		else{
			console.log($(this).is(":checked"));
			$("input[name='amount']").eq(idx).attr("disabled","true");
		}
	})

	$("input[name=allcheck]").click(function(){
		 if($("input[name=allcheck]").prop("checked")){
		        $("input[name=guest_id]").prop("checked",true);   // 전체 체크
		    }
		 else{
		        $("input[name=guest_id]").prop("checked",false);  // 전체 체크 해제
		    }
	});
	
})

function search(){
	var data=$('#sword').val();
	$.ajax({
		url : "/hotel/coupon/idList.do?sword="+data,
		cache:false,
		success: function(res){
			$("#idlist").empty();
			$("#idlist").append(res);
		}
	});
}

function create(){
	if($("input[name=guest_id]:checked").length==0){ //checked박스 선택된 갯수 확인
		alert("ID를 선택하세요!!");
		return false;
	} 
	
	if($("input[name=coupon_price]:checked").length==0){
		alert("쿠폰 종류를 선택하세요!!");
		return false;
	} 
	return true;
}





</script>
<body> 
<div id="wrap">
	<!-- canvas -->
	<div id="canvas">
		<%@ include file="/WEB-INF/views/admin/include/top.jsp" %>
		<div id="container" style="text-align: center;">
			<div id="content">
				<div class="con_tit" style="padding: 0 0 4% 1%">
					<h2>쿠폰발급 - [생성 및 발급]</h2>
				</div>
				
				<div style="padding: 0 0 0 20%; text-align: left" >
				<form id="frm" method="post" action="/hotel/coupon/create.do" onsubmit="return create();" >
					<table border="1" class="list" style="float:left;">
						<tr>
							<th style="width: 450px;height: 30px">ID 
								<div style="float: right; color: blue">
									<input type="checkbox" name="allcheck"> 전체선택
								</div>	
							</th>
						</tr>
						<tr id="idlist" style="text-align: center;">
								
						</tr>
					</table>
					<table border="1" class="list2" style="float:left; width: 450px">
						<tr>
							<th style="width: 225px; height: 30px">쿠폰 종류</th>
							<th style="width: 225px; height: 30px">쿠폰 수량</th>
						</tr>
						<tr height="59px">
							<td ><input type="checkbox" class="coupon_price" name="coupon_price" value="1000">1000원</td>
							<td><input type="number" id="prcie1" name="amount" min="1" value="1" disabled>개</td>
						</tr>
						<tr height="59px">	
								<td ><input type="checkbox" class="coupon_price" name="coupon_price" value="5000">5000원</td>
								<td><input type="number" id="prcie2" name="amount" min="1" value="1" disabled>개</td>
							</tr>
						<tr height="59px">
							<td><input type="checkbox" class="coupon_price" name="coupon_price" value="10000">10000원</td>
							<td><input type="number" id="prcie3" name="amount"  min="1" value="1" disabled>개</td>
						</tr>
					</table>
					<div class="div1">
						 <input type="text" style="width: 370px" id="sword" name="sword" value="${param.sword}"><input type="button"  style="width: 100px" value="검색" onclick="search();">
					</div>
					<div class="div2" align="right">
						<input type="submit" style="width: 150px; height:30px " id="sumbit" value="쿠폰생성"	>
					</div>
				</form>
					</div>
				
			</div>
		</div>
	</div>
</div>
</body>
</html>