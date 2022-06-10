<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	//login.jsp 에서 입력받은 id와 pass값을 가져옴
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
System.out.println(request.getParameter("myRemember"));

if(request.getParameter("myRemember") != null) {
	if(request.getParameter("myRemember").equals("idRem")) {
		Cookie cookieID = new Cookie("cookieID", id);
	cookieID.setMaxAge(60 * 60 * 24 * 30); // 1일 = 60초 * 60분 * 24시간 * 30일
		if(request.getParameter("myRemember").equals("loginRem")) {
			Cookie cookiePASS = new Cookie("cookiePass", pass);
			cookiePASS.setMaxAge(60 * 60 * 24 * 30); // 1일 = 60초 * 60분 * 24시간 * 30일
			response.addCookie(cookiePASS);
		}
	response.addCookie(cookieID);
	} 
}

	//MemberDAO 객체 생성 및 checkUser메서드 호출(파라미터 : 폼파라미터로 받은 id, pass값 / 리턴값 : boolean)
	MemberDAO memberDAO = new MemberDAO();
	boolean isLoginSuccess = memberDAO.checkUser(id, pass);

	//checkUser의 리턴값이 true(로그인 성공)일 때, id값을 session값으로 저장하고 loginSuccess.jsp로 이동
	if (isLoginSuccess) {
		session.setAttribute("sessionId", id);
		response.sendRedirect("./loginSuccess.jsp");
	} else {
	%>
<!-- 	checkUser의 리턴값이 false(로그인 실패)일 때, 로그인실패 알림창 띄우고 이전 페이지로 이동 -->
	<script type="text/javascript">
		alert("아이디 또는 패스워드가 일치하지 않습니다.");
		history.back();
	</script>
	<%
	}
	%>
</body>
</html>