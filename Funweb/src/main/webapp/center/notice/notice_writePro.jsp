<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

//BoardDTO 객체 생성 및 폼파라미터 값 저장
BoardDTO dto = new BoardDTO();
dto.setName(request.getParameter("name"));
dto.setPass(request.getParameter("pass"));
dto.setSubject(request.getParameter("subject"));
dto.setContent(request.getParameter("content"));

//BoardDAO 객체 생성 및 insertBoard 메서드 호출(파라미터 : dto, 리턴값 : int)
BoardDAO boardDAO = new BoardDAO();
int insertCount = boardDAO.insertBoard(dto);

//게시물 작성 성공 시 notice.jsp 페이지로 포워딩
if(insertCount > 0) {
	response.sendRedirect("../notice.jsp");
} else {
	//게시물 작성 실패 시, 알림창 띄우고 이전 페이지로 이동
%>
<script type="text/javascript">
alert("글쓰기 실패");
history.back();
</script>
<%}%>
