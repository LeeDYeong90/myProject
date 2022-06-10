<%@page import="board.content_replyDTO"%>
<%@page import="board.content_replyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

int index_comment = Integer.parseInt(request.getParameter("index_comment"));
int comment_class = Integer.parseInt(request.getParameter("comment_class"));
int post_num = Integer.parseInt(request.getParameter("post_num"));

content_replyDAO dao = new content_replyDAO();
dao.delete_content_reply(index_comment, comment_class);

response.sendRedirect("./notice_content.jsp?num="+post_num);
%>