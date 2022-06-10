<%@page import="board.FileBoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.FileBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/driver.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>

	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top2.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"></div>
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="./notice.jsp">공지사항</a></li>
				<li><a href="./driver.jsp">자료실</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Driver Download</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Writer</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
				<%
				// FileBoardDAO 객체를 활용하여 게시물 목록 가져오기
				FileBoardDAO fileBoardDAO = new FileBoardDAO();

				int pageNum = 1; //현재 페이지를 저장할 변수
				// 				request 객체를 통해 전달받은 페이지 번호 (page 파라미터)가 있을 경우(null 이 아닐 경우)
				if (request.getParameter("page") != null) {
					pageNum = Integer.parseInt(request.getParameter("page"));
				}

				//게시물 목록을 가져오기 전, 전체 게시물 목록 갯수 조회를 위한 getListCount()메서드 호출
				int listLimit = 3; //페이지 당 보여줄 게시물 수
				int listCount = fileBoardDAO.getListCount(); //전체 게시물 수
				int pageLimit = 10; //페이지 당 보여줄 페이지 수

				// 페이징 처리를 위한 계산 작업
				// 1. 전체 페이지 수 계산(총 게시물 수 / 페이지 당 게시물 수 + 0.9)
				// 				int maxPage = (int) ((double) listCount / listLimit + 0.9);
				int maxPage = (int) Math.ceil((double) listCount / listLimit); //올림처리 메서드

				// 2. 현재 페이지에서 보여줄 시각 페이지 번호(1, 11, 21 등의 시작번호) 계산
				// 				ex) 12페이지 일 경우, (int)1.2+0.9 -> (2 -1) *10 +1 -> 11페이지가 시작번호
				int startPage = ((int) ((double) pageNum / pageLimit + 0.9) - 1) * 10 + 1;

				// 3. 현재 페이지에서 보여줄 끝 페이지 번호 (10, 20, 30 등의 끝번호) 계산
				int endPage = startPage + pageLimit - 1;

				// 4. 마지막 페이지가 현재 페이지에서 표시할 최대 페이지 수보다 클 경우
				// 끝 페이지 번호를 총 페이지 수로 대체
				if (endPage > maxPage) {
					endPage = maxPage;
				}

				// 				ArrayList<FileBoardDTO> fileBoardList = fileBoardDAO.selectFileBoardList();

				// 				게시물 목록 가져올 때 페이지에서 표시할 목록 갯수만큼만 조회할 경우
				// =>파라미터로 현재 페이지 번호와 페이지 당 게시물 수 전달
				ArrayList<FileBoardDTO> fileBoardList = fileBoardDAO.selectFileBoardList(pageNum, listLimit);

				if (fileBoardList != null && fileBoardList.size() > 0) {
					for (FileBoardDTO fileBoard : fileBoardList) {
				%>
				<tr
					onclick="location.href = './driver/driver_content.jsp?num=<%=fileBoard.getNum()%>&page=<%=pageNum%>'">
<!-- 					다시 목록을 눌럿을때 처음 목록이 아닌 지 페이지 목록으로 가기 위해 &page=.. 입력 -->
					<td><%=fileBoard.getNum()%></td>
					<td class="left"><%=fileBoard.getSubject()%></td>
					<td><%=fileBoard.getName()%></td>
					<td><%=fileBoard.getDate()%></td>
					<td><%=fileBoard.getReadcount()%></td>
				</tr>
				<%
				}
				} else {
				%>
				<!-- 			fileBoardList 가 null이거나 size()가 0 일 경우 () -->
				<!-- 두 가지의 경우는 다름! null 값은 사이즈 자체가 없음  (ArrayList<FileBoardDTO> fileBoardList = null;) -->
				<!-- 			size가 0인 경우(ArrayList<FileBoardDTO> fileBoardList = new ArrayList(); 해놓고 아무것도 안넣음) -->

				<tr>
					<td colspan="5">작성된 게시물이 없습니다.</td>
				</tr>
				<%
				}
				%>
			</table>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn"
					onclick="location.href='./driver/driver_write.jsp'">
			</div>
			<div id="table_search">
				<form action="./driver/driver_search.jsp" method="post">
				<select name="keyword">
						<option value="name">작성자</option>
						<option value="subject">제목</option>
						<option value="content">내용</option>
				</select>
					<input type="text" name="search" class="input_box">
					<input type="submit" value="Search" class="btn">
				</form>
			</div>
			<div class="clear"></div>
			<div id="page_control">
				<!-- 이전 페이지 버튼은 현재 페이지 번호가 시작페이지 번호보다 클 때만 링크 표시하며  -->
				<!-- 현재 페이지번호 -1 값을 파라미터로 전달 -->
				<%
				if (pageNum == startPage) {
				%>
				Prev&nbsp;&nbsp;&nbsp;
				<%} else {
				%>
				<a href="./driver.jsp?page=<%=pageNum - 1%>">Prev</a>
				<%
				}
				%>

				<%
				// 페이지 목록은 시작 페이지번호부터 끝 페이지 번호까지 차례대로 표시
				for (int i = startPage; i <= endPage; i++) {
					if (i == pageNum) {
				%>
				<span class="active_num"><%=i%></span>
				<!--  단, 현재 페이지 번호는 하이퍼링크 없이 표시 -->
				<%} else {
				%>
				<a href="./driver.jsp?page=<%=i%>"><%=i%></a>
				<!-- 페이지 번호 클릭 시 driver.jsp 페이지로 페이지번호(page)를 전달 -->
				<%}}%>
				
				<%
				if (pageNum < maxPage) {
				%>
				<a href="./driver.jsp?page=<%=pageNum + 1%>">Next</a>								
				<%} else {%>
				&nbsp;&nbsp;Next
				<%}%>
			</div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom2.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


