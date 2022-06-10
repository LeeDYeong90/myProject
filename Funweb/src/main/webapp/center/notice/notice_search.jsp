<%@page import="member.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String search = request.getParameter("search");
String keyword = request.getParameter("keyword");
BoardDAO dao = new BoardDAO();
int pageNum = 1;

if (request.getParameter("page") != null) {
	pageNum = Integer.parseInt(request.getParameter("page"));
}
int listLimit = 3;
int searchListCount = dao.getSearchListCount(keyword, search);
int pageLimit = 10;
int maxPage = (int) Math.ceil((double) searchListCount / listLimit);
int startPage = ((int) ((double) pageNum / pageLimit + 0.95) - 1) * pageLimit + 1;
int endPage = startPage + pageLimit - 1;
if (endPage > maxPage) {
	endPage = maxPage;
}
ArrayList<BoardDTO> boardList = dao.selectSearch(pageNum, listLimit, keyword, search);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice.jsp</title>
<link href="../../css/default.css" rel="stylesheet" type="text/css">
<link href="../../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>

	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->
		<div class="clear"></div>   
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
			<h1>Notice Search</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Writer</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
				<tr><td colspan="5" align="left"> &nbsp; 검색 결과 : <%=searchListCount%>건</td></tr>
				<%
				if(boardList != null && boardList.size() >0) {
					for(BoardDTO dto : boardList){
 				%> 
				<tr onclick="location.href='./notice_content.jsp?num=<%=dto.getNum()%>&page=<%=pageNum%>'">
					<td><%=searchListCount--%></td>
					<td class="left"><%=dto.getSubject() %></td>
					<td><%=dto.getName() %></td>
					<td><%=dto.getDate() %></td>
					<td><%=dto.getReadcount() %></td>
				</tr>
				<%} }else {%>
				<tr>
					<td colspan="5">검색된 데이터가 없습니다.</td>
				</tr>
				<%
				}
				%>
			</table>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='./notice_write.jsp'">
			</div>
			<div id="table_search">
				<form action="./notice_search.jsp?" method="post">
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
				<a href="./notice_search.jsp?page=<%=pageNum-1%>&search=<%=search%>&keyword=<%=keyword%>">Prev</a>
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
				<a href="./notice_search.jsp?page=<%=i%>&search=<%=search%>&keyword=<%=keyword%>"><%=i%></a>
				<!-- 페이지 번호 클릭 시 notice.jsp 페이지로 페이지번호(page)를 전달 -->
				<%}}%>
				
				<%
				if (pageNum < maxPage) {
				%>
				<a href="./notice_search.jsp?page=<%=pageNum + 1%>&search=<%=search%>&keyword=<%=keyword%>">Next</a>								
				<%} else {%>
				&nbsp;&nbsp;Next
				<%}%>
			</div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


