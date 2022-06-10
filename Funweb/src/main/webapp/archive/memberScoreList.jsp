<%@page import="grade.GradeDTO"%>
<%@page import="grade.GradeDAO"%>
<%@page import="archive.ArchiveDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="archive.ArchiveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Archive.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top2.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->

		<div id="sub_img"></div>

		<nav id="sub_menu">
			<ul>
				<li><a href="./archive_write.jsp">문제 입력</a></li>
				<li><a href="./memberScoreList.jsp">회원점수목록</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<div class="question">
			<h2 style="font-size: 30px;">회원점수목록</h2>

			<table border="1"   class="question2">
			<tr align="center">
			<th>회원정보</th>
			<th colspan="4">문제정보</th>
			</tr>
			<tr align="center">
					<th>아이디</th>
					<th>기출년도</th>
					<th>기출회차</th>
					<th>과목명</th>
					<th>점수</th>
					</tr>
				<%
				GradeDAO gradeDao = new GradeDAO();
				ArrayList<GradeDTO> memberScoreList = gradeDao.selectMember();
				for(GradeDTO gradeDto : memberScoreList) {
				%>
				<tr>
					<td><%=gradeDto.getId() %></td>
					<td><%=gradeDto.getYear() %></td>
					<td><%=gradeDto.getCnt() %></td>
					<td><%=gradeDto.getSubject_name() %></td>
					<td><%=gradeDto.getScore() %></td>
					</tr>
				<%} %>
			</table>
		</div>
	</div>
</body>
</html>


