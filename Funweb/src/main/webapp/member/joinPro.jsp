<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
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
	//post방식에서 한글이 안깨지기 위한 언어 설정
	request.setCharacterEncoding("UTF-8");
	//join.jsp에서 입력한 값을 받아서 저장
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String mobile = request.getParameter("mobile");
	String address = request.getParameter("address");
	String phone = request.getParameter("phone");

	//MemberDTO 객체 생성 및 setter를 이용해 dto에 폼파라미터 데이터 저장
	MemberDTO dto = new MemberDTO();
	dto.setId(id);
	dto.setPass(pass);
	dto.setName(name);
	dto.setEmail(email);
	dto.setMobile(mobile);
	dto.setAddress(address);
	dto.setPhone(phone);

	//MemberDAO 객체 생성 및 insertMember 메소드 호출(파라미터값은 dto/리턴값은 int)
	MemberDAO memberDAO = new MemberDAO();
	int insertCount = memberDAO.insertMember(dto);

	//insertMember의 리턴값이 0보다 클 경우(회원가입 성공 시) joinSuccess.jsp로 이동
	if (insertCount > 0) {
		session.setAttribute("sessionId", id);
		response.sendRedirect("./joinSuccess.jsp");
	} else {
	%>
<!-- 	회원가입 실패 시, 실패 알림창을 띄우고 이전 페이지로 이동 -->
	<script type="text/javascript">
		alert("회원가입실패");
		history.back();
	</script>
	<%
	}
	%>
</body>
</html>