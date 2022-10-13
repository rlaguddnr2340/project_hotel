<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="utf-8">

<title>apiTest</title>

</head>
<body>
	<div>
		<c:forEach var="boardList" items="${boardList}" varStatus="status">
			<tr>
				<td> 번호 : ${boardList.gboard_no} </td>
				<td> 제목 : ${boardList.gboard_title} </td>
				<td> 조회수 : ${boardList.gboard_viewcount} </td>
				<td> 내용 : ${boardList.gboard_content} </td>
				<td> 작성일 : ${boardList.gboard_regdate} </td>
				<td> 작성자 : ${boardList.gboard_writer} </td>
				<td> 답변상태 : ${boardList.gboard_status} </td>
			</tr>
		</c:forEach>
	</div>
</body>
</html>


