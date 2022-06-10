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
		<%
		//세션에 저장된 아이디를 id변수에 저장
		String id = (String) session.getAttribute("sessionId");

		//세션 아이디가 없을 경우 - 알림창 띄우고 이전페이지로 이동
		if (id == null) {
		%>
		<script>
			alert("회원만 접근 가능합니다.")
			history.back();
		</script>
		<%
		} else if (id.equals("admin")) {
		%>
		<nav id="sub_menu">
			<ul>
				<li><a href="./archive_write.jsp">문제 입력</a></li>
				<li><a href="./memberScoreList.jsp">회원점수목록</a></li>
			</ul>
		</nav>
		<%
		}
		%>
		
		<!-- 본문 내용 -->
		<div class="question">
			<h2 style="font-size: 30px;">정보처리기사 기출문제</h2>

			<table class="question2"  align="center">
				<tr>
					<td colspan="3">정보처리기사 2021년 3회 기출문제</td>
					</tr>
				<tr>
					<th>과목명</th>
					<th>점수</th>
					<th>풀기</th>
					</tr>
				<%
// 				2021년 3회차 정보를 int값으로 지정
				int score = 0;
				GradeDTO gradeDto = new GradeDTO();
				GradeDAO gradeDao = new GradeDAO();
				%>
				<tr>
					<td>소프트웨어 설계</td>
					<% score = gradeDao.selectScore(id, 2021, 3, 1);%>
					<td><%if(score!=0) {%><%=score %><%}else { %>미응시<%} %></td>
					<td><%if(score!=0) {%><a href="./archive_content.jsp?year=2021&cnt=3&subject_cd=1" style="font-size: 15px;">다시풀기</a>
					<%}else { %>
					<a href="./archive_content.jsp?year=2021&cnt=3&subject_cd=1" style="font-size: 15px;">응시하기</a><%} %></td>
					</tr>
				<tr>
					<td>소프트웨어 개발</td>
					<% score = gradeDao.selectScore(id, 2021, 3, 2);%>
					<td><%if(score!=0) {%><%=score %><%}else { %>미응시<%} %></td>
					<td><%if(score!=0) {%><a href="./archive_content.jsp?year=2021&cnt=3&subject_cd=2" style="font-size: 15px;">다시풀기</a>
					<%}else { %>
					<a href="./archive_content.jsp?year=2021&cnt=3&subject_cd=2" style="font-size: 15px;">응시하기</a><%} %></td>
					</tr>
				<tr>
					<td>데이터베이스 구축</td>
					<% score = gradeDao.selectScore(id, 2021, 3, 3);%>
					<td><%if(score!=0) {%><%=score %><%}else { %>미응시<%} %></td>
					<td><%if(score!=0) {%><a href="./archive_content.jsp?year=2021&cnt=3&subject_cd=3" style="font-size: 15px;">다시풀기</a>
					<%}else { %>
					<a href="./archive_content.jsp?year=2021&cnt=3&subject_cd=3" style="font-size: 15px;">응시하기</a><%} %></td>
					</tr>
			</table>
		</div>
	</div>
</body>
</html>


