<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_update.jsp</title>
<link href="../../css/default.css" rel="stylesheet" type="text/css">
<link href="../../css/subpage.css" rel="stylesheet" type="text/css">
<body>
<%
String id = (String) session.getAttribute("sessionId");

if (!id.equals("admin")) {
%>
<script>
	alert("해당 게시물은 관리자만 접근 가능합니다.")
	history.back();
</script>
<%
}
int num = Integer.parseInt(request.getParameter("num"));
BoardDAO boardDao = new BoardDAO();
BoardDTO dto =  boardDao.selectContent(num);
%>
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
		<article>
			<h1>Notice Update</h1>
			<form action="./notice_updatePro.jsp" method="post">
				<table id="notice">
				<tr><td colspan="2"><input type="hidden" name="num"	 value="<%=num %>"></td></tr>
					<tr>
						<td>글쓴이</td>
						<td><input type="text" name="name" readonly="readonly" value="<%=dto.getName() %>"></td>
					</tr>
					<tr>
						<td>패스워드</td>
						<td><input type="password" name="pass" ></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" value=""<%=dto.getSubject() %>></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="10" cols="20" name="content"><%=dto.getContent() %></textarea></td>
					</tr>
				</table>

				<div id="table_search">
					<input type="submit" value="글수정" class="btn">
				</div>
			</form>
			<div class="clear"></div>
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


