<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1><%=session.getAttribute("sessionId") %>님! 회원 가입을 축하합니다.</h1>
<input type="button" value="홈으로" onclick="location.href='../main/main.jsp'">
</body>
</html>