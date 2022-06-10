<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main/main.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top2.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->

		<div class="clear"></div>
		<!-- 본문들어가는 곳 -->
		<!-- 메인 이미지 -->
		<div id="main_img">
			<img src="../images/main_img.jpg">
		</div>
		<!-- 본문 내용 -->
		<article id="front">
			<div id="solution">
				<%
				LocalDateTime current = LocalDateTime.now(); //오늘날짜 및 시간
				LocalDateTime exam = LocalDateTime.of(2022, 3, 5, 9, 00); //기준날짜 및 시간(시험일)
				long days = ChronoUnit.DAYS.between(current, exam); //오늘날짜로부터 기준날짜까지 남은 일수
				long time1 = ChronoUnit.HOURS.between(current, exam); //지금시간으로부터 기준시간까지 남은 시간
				long time2 = time1 % 24;
				long time3 = time2 % 60;
				%>
				<br> 필기 시험까지 남은 시간 :
				<%=days%>일 <%=time2%>시간 <%=time3%>분!!
			</div>
			<div class="clear"></div>
			<div id="sec_news">
				<h3>
					<span class="orange">Notice</span>
				</h3>
				<%
				BoardDAO dao = new BoardDAO();
// 				notice 게시물을 ArrayList에 담아서 리턴
				ArrayList<BoardDTO> boardList = dao.selectBoardList();
// 				조회되는 게시물이 있을 경우
				if (boardList != null && boardList.size() > 0) {

					for (BoardDTO dto : boardList) {
				%>
				<dl>
<!-- 				링크주소 파라미터값으로 글번호를 넘겨줌 -->
					<dt><a href="../center/notice/notice_content.jsp?num=<%=dto.getNum()%>"><%=dto.getSubject()%></a></dt>
					<dd align="right"><%=dto.getDate()%></dd>
				</dl>
				<%
				}}
				%>
			</div>
			<div id="news_notice">
				<h3 class="brown">Driver Download</h3>
				<%
				FileBoardDAO dao2 = new FileBoardDAO();
// 				driver 게시물을 ArrayList에 담아서 리턴
				ArrayList<FileBoardDTO> fileBoardList = dao2.selectFileBoardList();
				if (fileBoardList != null && fileBoardList.size() > 0) {

					for (FileBoardDTO dto2 : fileBoardList) {
				%>
				<dl>
				<!-- 				링크주소 파라미터값으로 글번호를 넘겨줌 -->
					<dt><a href="../center/notice/notice_content.jsp?num=<%=dto2.getNum()%>"><%=dto2.getSubject()%></a></dt>
					<dd align="right"><%=dto2.getDate()%></dd>
				</dl>
				<%
				}}
				%>
			</div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom2.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


