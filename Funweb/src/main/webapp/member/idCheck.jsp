<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function goParent() {
		opener.document.fr.id.value = document.fr2.id2.value;
		window.close();
	}
</script>
<title>Insert title here</title>
</head>
<body>
	<form action="./idCheck.jsp" method="post" name="fr2">
		<%
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id2");

		MemberDAO dao = new MemberDAO();
		String dupicate_id = dao.idCheck(id);
		System.out.println(dupicate_id);
		if (id == null | id == "") {
		%>
		<input type="text" name="id2" id="id2" placeholder="아이디 입력">
		<input type="submit" value="확인">
		<%
		} else if (id != null && !dupicate_id.equals("duplicate")) {
		out.println("<br>사용가능한 아이디입니다.");
		%>
		<br> <input type="text" name="id2" id="id2" value="<%=dupicate_id%>" readonly="readonly"> 
			<input type="button" value="아이디 사용하기" onclick="goParent()">
		<%
		} else if (dupicate_id.equals("duplicate")) {

		out.println("<br>이미 사용중인 아이디입니다.");
		%>
		<br> <input type="text" name="id2" id="id2"
			placeholder="다른 아이디 입력"> <input type="submit" value="확인">
		<%
		}
		%>


	</form>
</body>
</html>