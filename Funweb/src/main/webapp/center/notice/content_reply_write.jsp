<%@page import="board.content_replyDTO"%>
<%@page import="board.content_replyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

int post_num = Integer.parseInt(request.getParameter("post_num"));
String comment_id = (String)session.getAttribute("sessionId");

//세션 아이디가 없을 경우 - 알림창 띄우고 이전페이지로 이동
if (comment_id == null) {
%>
<script>
	alert("로그인 세션이 만료되었습니다.");
	history.back();
</script>
<%
}
String comment = request.getParameter("comment");
int comment_class = Integer.parseInt(request.getParameter("comment_class"));
int group_num = 0;
if(comment_class != 0) {
group_num = Integer.parseInt(request.getParameter("group_num"));
}
content_replyDAO dao = new content_replyDAO();
// int createCount = dao.CreateTempTable();  테이블 생성 메서드 호출
// System.out.println(createCount);  테이블 생성 여부 확인
content_replyDTO dto = new content_replyDTO();
dto.setPost_num(post_num);
dto.setComment_id(comment_id);
dto.setComment(comment);
dto.setComment_class(comment_class);
dto.setGroup_num(group_num);
int insertCount = dao.insertComment(dto);
response.sendRedirect("./notice_content.jsp?num="+post_num);
%>