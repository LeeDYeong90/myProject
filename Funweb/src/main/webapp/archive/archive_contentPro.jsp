<%@page import="grade.GradeDAO"%>
<%@page import="grade.GradeDTO"%>
<%@page import="archive.ArchiveDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="archive.ArchiveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//세션에 저장된 아이디값을 불러옴
String id = (String) session.getAttribute("sessionId");
//해당회차정보를 저장
int year = Integer.parseInt(request.getParameter("year"));
int cnt = Integer.parseInt(request.getParameter("cnt"));
int subject_cd = Integer.parseInt(request.getParameter("subject_cd"));

boolean[] isCorrect = new boolean[10];
String[] input_answer = new String[10];
int trueCount = 0;
for (int i = 0; i < 10; i++) {

	System.out.println(request.getParameter("input_answer_" + i));
	input_answer[i] = request.getParameter("input_answer_" + i);
	if(input_answer[i]==null) {
		input_answer[i]="0";
	}
	String answer = request.getParameter("answer_" + i);
	if (input_answer[i].equals(answer)) {
		isCorrect[i] = true;
		trueCount++;
	} else {
		isCorrect[i] = false;
	}

	System.out.println(isCorrect[i]);
}
int score = trueCount*10;
int total = input_answer.length*10;
request.setAttribute("isCorrect", isCorrect);
request.setAttribute("input_answer", input_answer);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>archive_content.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top2.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img"></div>
		<div class="question">
			<h2>
				정보처리기사
				<%=year%>년
				<%=cnt%>회 기출문제
			</h2>
			<h3>본인이 선택한 답과 정답을 비교해보세요.</h3>
			<form action="./archive_content.jsp?year=<%=year%>&cnt=<%=cnt%>&subject_cd=<%=subject_cd%>"
				name="fr" method="post">
				<div class="red">점수 : <%=score %>/<%=total %> 점</div>
				<%
// 				grade테이블에 시험결과 저장
				GradeDTO gradeDto = new GradeDTO();
				gradeDto.setId(id);
				gradeDto.setYear(year);
				gradeDto.setCnt(cnt);
				gradeDto.setSubject_cd(subject_cd);
				gradeDto.setScore(score);
				GradeDAO gradeDao = new GradeDAO();
				gradeDao.insertGrade(gradeDto);
// 				-----------------------------------------------------------------------------------------
				ArchiveDAO dao = new ArchiveDAO();
				ArrayList<ArchiveDTO> archiveList = dao.selectArchiveList(year, cnt, subject_cd);
				for (int i = 0; i < archiveList.size(); i++) {
					ArchiveDTO dto = (ArchiveDTO) archiveList.get(i);
				%>
				<h4><%=dto.getQ_num()%>번&nbsp;<%=dto.getQ_subject()%></h4>
				<%if(dto.getQ_content()!=null){ %>
				<p class="question_1"><%=dto.getQ_content()%></p>
				<%} %>

				<div><%if(input_answer[i].equals("1")){ %><mark><%=dto.getA_1()%></mark><%}else{ %><%=dto.getA_1()%><%} %></div>
				<div><%if(input_answer[i].equals("2")){ %><mark><%=dto.getA_1()%></mark><%}else{ %><%=dto.getA_2()%><%} %></div>
				<div><%if(input_answer[i].equals("3")){ %><mark><%=dto.getA_1()%></mark><%}else{ %><%=dto.getA_3()%><%} %></div>
				<div><%if(input_answer[i].equals("4")){ %><mark><%=dto.getA_1()%></mark><%}else{ %><%=dto.getA_4()%><%} %></div>
				<br>					
				<div class="answer" align="right">정답 : <%=dto.getAnswer()%></div>
				<br><br><br>
				<%
				}
				%>

				<input type="submit" value="다시 풀기">
			</form>
		</div>
		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom2.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>