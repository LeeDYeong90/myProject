<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

BoardDTO dto = new BoardDTO();
dto.setNum(Integer.parseInt(request.getParameter("num")));
dto.setName(request.getParameter("name"));
dto.setPass(request.getParameter("pass"));
dto.setSubject(request.getParameter("subject"));
dto.setContent(request.getParameter("content"));


BoardDAO dao = new BoardDAO();
int updateCount = dao.updateBoard(dto);
if (updateCount > 0) {
	response.sendRedirect("./notice_content.jsp?num="+Integer.parseInt(request.getParameter("num")));
} else {
%>
<script>
	alert("수정실패! \n비밀번호를 다시 입력해주세요.");
	history.back();
</script>
<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


</body>
</html>