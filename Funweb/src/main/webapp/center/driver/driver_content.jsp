<%@page import="board.FileBoardDTO"%>
<%@page import="board.FileBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int num = 0;

if (request.getParameter("num") == null) {
%>
<script type="text/javascript">
    	alert("잘못된 접근입니다.");
    	location.href="../main/main.jsp";
    	</script>
<%
} else {

num = Integer.parseInt(request.getParameter("num"));
}
int pageNum = Integer.parseInt(request.getParameter("page"));

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/driver_content.jsp</title>
<link href="../../css/default.css" rel="stylesheet" type="text/css">
<link href="../../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../../inc/top.jsp" />
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
<%

FileBoardDAO fileBoardDAO = new FileBoardDAO();
fileBoardDAO.updateFileReadcount(num);

FileBoardDTO dto = fileBoardDAO.selectFileBoard(num);
if(dto != null) {
%>
		<article>
			<h1>Driver Content</h1>
			<table id="notice">
				<tr>
					<td>글번호</td>
					<td><%=num %></td>
					<td>글쓴이</td>
					<td><%=dto.getName() %></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><%=dto.getDate() %></td>
					<td>조회수</td>
					<td><%=dto.getReadcount() %></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><%=dto.getSubject() %></td>
				</tr>
				<tr>
					<td>파일</td>
<!-- 					사용자가 실제 업로드할 때의 파일명(원본파일명)을 표시 -->
					<td colspan="3">
					<%=dto.getOriginal_file() %>&nbsp;&nbsp;
					<a href="../upload/<%=dto.getFile()%>" download="<%=dto.getOriginal_file()%>"><input type="button" value="다운로드" ></a>
<!-- 					실제 파일과 연결하여 다운로드를 위한 하이퍼링크 작성(HTML5 기능) -->
<!-- 					하이퍼링크 태그에 download 속성 지정 시 파일 다운로드 기능 동작 -->
<!-- 					단, 다운로드 받을 땐, 실제 저장된 파일명이 되기때문에 download속성으로 다운로드할 파일명 지정-> 원래 이름대로 변경해줌 -->
					</td>
				</tr>
				
				<tr>
					<td>내용</td>
					<td colspan="3"><%=dto.getContent() %></td>
				</tr>
			</table>
			<%
			}
			%>
<!-- 			<div> -->
<!-- 			<textarea rows="4" cols="30"></textarea> -->
<!-- 			<input type="button" value="댓글달기" onclick="#"> -->
<!-- 			</div> -->
			<div id="table_search">
				<input type="button" value="글수정" class="btn" onclick="location.href='driver_update.jsp?num=<%=num%>&page=<%=pageNum%>'"> 
				<input type="button" value="글삭제" class="btn" onclick="location.href='driver_delete.jsp?num=<%=num %>'"> 
				<input type="button" value="글목록" class="btn" onclick="location.href='../driver.jsp?page=<%=request.getParameter("page")%>'">
<!-- 					다시 목록을 눌럿을때 처음 목록이 아닌 지 페이지 목록으로 가기 위해 페이지 번호를 들고다녀야함 -->
			</div>

			<div class="clear"></div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>