<%@page import="archive.ArchiveDAO"%>
<%@page import="archive.ArchiveDTO"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

ArchiveDTO dto = new ArchiveDTO();

dto.setYear(Integer.parseInt(request.getParameter("year")));
dto.setCnt(Integer.parseInt(request.getParameter("cnt")));
dto.setSubject_cd(Integer.parseInt(request.getParameter("subject_cd")));
dto.setQ_num(Integer.parseInt(request.getParameter("q_num")));
dto.setQ_subject(request.getParameter("q_subject"));
dto.setQ_subject(request.getParameter("q_content"));
dto.setA_1(request.getParameter("a_1"));
dto.setA_2(request.getParameter("a_2"));
dto.setA_3(request.getParameter("a_3"));
dto.setA_4(request.getParameter("a_4"));
dto.setAnswer(Integer.parseInt(request.getParameter("answer")));
ArchiveDAO dao = new ArchiveDAO();
int insertCount = dao.insertArchive(dto);

if(insertCount > 0) {
	response.sendRedirect("./archive.jsp");
} else {
%>
<script type="text/javascript">
alert("글쓰기 실패");
history.back();
</script>
<%}%>
