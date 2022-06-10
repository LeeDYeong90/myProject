<%@page import="java.util.Arrays"%>
<%@page import="java.sql.Array"%>
<%@page import="java.util.ArrayList"%>
<%@page import="archive.ArchiveDTO"%>
<%@page import="archive.ArchiveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
// 	라디오버튼에서 선택한 답의 값을 input_answer_i 값으로 저장
	function number_check(checkValue, i) {
		document.getElementById("input_answer_"+i).value = checkValue;
		
	}
</script>
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

		<!-- 본문 내용 -->
<%
// 		링크 파라미터로 받은 기출문제 정보를 각 변수에 저장
			int year=Integer.parseInt(request.getParameter("year"));
			int cnt = Integer.parseInt(request.getParameter("cnt"));
			int subject_cd = Integer.parseInt(request.getParameter("subject_cd"));

			ArchiveDAO dao = new ArchiveDAO();
// 			기출문제 검색 메서드
			ArrayList<ArchiveDTO> archiveList = dao.selectArchiveList(year, cnt, subject_cd);
			%>
			<div class="question">
			<h2>정보처리기사 <%=year%>년 <%=cnt %>회 기출문제</h2>
<!-- 			결과 페이지에서 다시 문제를 조회하기 위해 파라미터를 보냄 -->
			<form action="./archive_contentPro.jsp?year=<%=year %>&cnt=<%=cnt %>&subject_cd=<%=subject_cd %>" name="fr" method="post">
				<%
				for (int i = 0; i < archiveList.size(); i++) {
					ArchiveDTO dto = (ArchiveDTO) archiveList.get(i);
				%>
				<h4><%=dto.getQ_num()%>번&nbsp;<%=dto.getQ_subject()%></h4>
				<div class="question_1"><%=dto.getQ_content()%></div>

					<input type="radio" name="number_<%=i%>" onclick="number_check(1,<%=i%>)"><%=dto.getA_1() %><br>
					<input type="radio" name="number_<%=i%>" onclick="number_check(2,<%=i%>)"><%=dto.getA_2() %><br>
					<input type="radio" name="number_<%=i%>" onclick="number_check(3,<%=i%>)"><%=dto.getA_3() %><br>
					<input type="radio" name="number_<%=i%>" onclick="number_check(4,<%=i%>)"><%=dto.getA_4() %><br>
<!-- 					선택값과 정답을 archivePro.jsp에게 폼파라미터 값으로 넘기기위해 별도의 input창을 둠 -->
					<input type="hidden" id="answer_<%=i%>" name="answer_<%=i%>" value="<%=dto.getAnswer()%>"><br>
					<input type="text" id="input_answer_<%=i%>" name="input_answer_<%=i%>" readonly="readonly">
					
				<% }%>
				
				<input type="submit" value="정답제출">
			</form>
		</div>
		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom2.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
	
</body>
</html>


