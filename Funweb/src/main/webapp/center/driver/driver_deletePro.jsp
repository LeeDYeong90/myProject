<%@page import="board.FileBoardDAO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

    	
    int num = Integer.parseInt(request.getParameter("num"));
    String pass = request.getParameter("pass");
    FileBoardDAO dao = new FileBoardDAO();
    boolean isDeleteSuccess = dao.deleteFileBoard(num, pass);
    
    if(isDeleteSuccess) {
    	response.sendRedirect("../driver.jsp");
    } else {
    %>
    <script>
    alert("글 삭제 실패!");
    history.back();
    </script>
    <%
    }%>