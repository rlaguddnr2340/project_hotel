<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>게스트마이페이지</title>
    <link rel="stylesheet" href="/hotel/css/mypage.css"/>
    <link rel="stylesheet" href="/hotel/css/reset.css"/>
    <link rel="stylesheet" href="/hotel/css/contents.css"/>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
</head>
<body>
 <%@ include file="/WEB-INF/views/includes/G_header.jsp"  %>

		<div class="sub">
			<div class="size">
				<h1 class="sub_title">마이페이지<br>GUEST</h1>
					<table >
						<tbody>
							<tr class="tr-head" >
								<th colspan="2">
								
									<div class="user-name">${loginInfo.guest_name }님</div>
									<div class="user-email">${loginInfo.guest_email }</div>
									<div class="d-grid gap-2 col-3 mx-auto">
									  <button class="btn btn-warning" type="button" onclick="location.href='myinfo.do'">
									  	<img src="/hotel/image/mypage/confidential.png" width="50px;">
									  	내 정보 관리
									  </button>
									</div>
								</th>
							</tr>
							<tr>
								<td>
									<button type="button" class="component">Large button</button>
								</td>
								<td>
									<button type="button" class="component">Large button</button>
								</td>
							</tr>
							<tr>
								<td>
									<button type="button" class="component">Large button</button>
								</td>
								<td>
									<button type="button" class="component">Large button</button>
								</td>
							</tr>
							<tr>
								<td>
									<button type="button" class="component">Large button</button>
								</td>
								<td>
									<button type="button" class="component">Large button</button>
								</td>
							</tr>
						
							
						</tbody>
					</table>
			</div>
		</div>
	
</body>
</html>