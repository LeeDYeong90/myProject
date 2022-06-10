<%@page import="board.content_replyDTO"%>
<%@page import="board.content_replyDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice/notice_content.jsp</title>
<%
int num = Integer.parseInt(request.getParameter("num"));
String id = (String) session.getAttribute("sessionId");

//세션 아이디가 없을 경우 - 알림창 띄우고 이전페이지로 이동
if (id == null) {
%>
<script>
	alert("로그인 후 이용해주세요.");
	history.back();
</script>
<%
}

BoardDAO boardDAO = new BoardDAO();
boardDAO.updateReadcount(num);

BoardDTO dto = boardDAO.selectContent(num);
System.out.println(num);
%>

<script>
function show(idx) {
	var isShow = document.getElementById(idx);
	if (isShow.style.display == 'none') {
		isShow.style.display = 'block';
	} else {
		isShow.style.display = 'none';
	}
}
</script>
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

		<article>
			<h1>Notice Content</h1>
			<table id="notice">
				<tr>
					<td>글번호</td>
					<td><%=num%></td>
					<td>글쓴이</td>
					<td><%=dto.getName()%></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><%=dto.getDate()%></td>
					<td>조회수</td>
					<td><%=dto.getReadcount()%></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><%=dto.getSubject()%></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3"><%=dto.getContent()%></td>
					
				</tr>
			</table>
			<%
			int index_comment = 0;
			content_replyDAO contentDao = new content_replyDAO();
			ArrayList<content_replyDTO> replyList = contentDao.select_content_reply(num);
			for (content_replyDTO replyDto : replyList) {
			%>
			<form
				action="./content_reply_write.jsp?group_num=<%=replyDto.getIndex_comment()%>&post_num=<%=num%>&comment_class=1"
				method="post">
				<%
				if (replyDto.getComment_class() == 0) {
				%>
				<table class="reply_table" style="width: 100%">
					<colgroup>
						<col width="50%" />
						<col width="10%" />
						<col width="10%" />
						<col width="30%" />
					</colgroup>
					<tr>
						
						<td><%=replyDto.getComment()%></td>
						<td><%=replyDto.getComment_id()%></td>
						<td><%=replyDto.getDate()%></td>
						<td align="right"><input type="button" value="댓글" onclick="show('<%=replyDto.getIndex_comment()%>')">
<!-- 						로그인 아이디가 댓글 작성자와 같을 경우에만 수정, 삭제 버튼 보여줌 -->
						<%
						if(session.getAttribute("sessionId").equals(replyDto.getComment_id())) {
						%>
						<input type="button" value="삭제" onclick="location.href='./content_reply_delete.jsp?index_comment=<%=replyDto.getIndex_comment()%>&post_num=<%=num%>&comment_class=1'"></td>
						<%} %>
					</tr>
				</table>
				<%
				} else {
				%>

				<table class="reply_table" style="width: 100%">
					<colgroup>
						<col width="50%" />
						<col width="10%" />
						<col width="10%" />
						<col width="30%" />
					</colgroup>
					<tr>
						
						<td>&nbsp;&nbsp;└&nbsp;<%=replyDto.getComment()%><input type="hidden" name="index_comment" value="<%=replyDto.getIndex_comment()%>"></td>
						<td><%=replyDto.getComment_id()%></td>
						<td><%=replyDto.getDate()%></td>
						<td align="right">
						<%
						if(session.getAttribute("sessionId").equals(replyDto.getComment_id())) {
						%>
						<input type="button" value="삭제" onclick="location.href='./content_reply_delete.jsp?index_comment=<%=replyDto.getIndex_comment()%>&post_num=<%=num%>&comment_class=0'"></td>
						<%} %>
					</tr>
				</table>
				<%
				}
				%>
				<table class="reply_table" >
					<tr id="<%=replyDto.getIndex_comment()%>" style="display: none;" align="right">
						<td><input type="text"   name="comment"></td>
						<td><input type="submit" value="대댓글" style="width: 70px;" /></td>
					</tr>
				</table>
			</form>
			<%
			}
			%>
			<div>
				<form
					action="./content_reply_write.jsp?post_num=<%=num%>&comment_class=0"
					method="post">
					<div style="text-align: center; height: 50px; margin-top: 10px;">
						<textarea rows="4" cols="30" name="comment"
							style="width: 85%; height: 100%; float: left;"></textarea>
						<input type="submit" value="댓글달기"
							style="border: 0px; background: none; width: 10%; vertical-align: middle;">
					</div>
				</form>
			</div>
			<div id="table_search">
				<input type="button" value="글수정" class="btn"
					onclick="location.href='./notice_update.jsp?num=<%=num%>'">
				<input type="button" value="글삭제" class="btn"
					onclick="location.href='./notice_delete.jsp?num=<%=num%>'">
				<input type="button" value="글목록" class="btn"
					onclick="location.href='../notice.jsp?page=<%=page%>'">
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


