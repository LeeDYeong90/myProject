<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>	
<%
request.setCharacterEncoding("UTF-8");

String uploadPath = "/upload";
int fileSize = 1024 * 1024 * 10;

ServletContext context = request.getServletContext();
String realPath = context.getRealPath(uploadPath);
MultipartRequest multi = new MultipartRequest(request, realPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());

FileBoardDTO dto = new FileBoardDTO();
dto.setNum(Integer.parseInt(multi.getParameter("num")));
dto.setPass(multi.getParameter("pass"));
dto.setSubject(multi.getParameter("subject"));
dto.setContent(multi.getParameter("content"));

String pageNum = multi.getParameter("pageNum");
String fileElement = multi.getFileNames().nextElement().toString();
String original_file = multi.getOriginalFileName(fileElement);
String file = multi.getFilesystemName(fileElement);
dto.setOriginal_file(original_file);
dto.setFile(file);

FileBoardDAO dao = new FileBoardDAO();
int updateFileCount = dao.updateFileBoard(dto);
if (updateFileCount > 0) {
	response.sendRedirect("./driver_content.jsp?num="+Integer.parseInt(multi.getParameter("num"))+"&page="+pageNum);
} else {
%>
<script>
	alert("수정실패! \n비밀번호를 다시 입력해주세요.");
	history.back();
</script>
<%
}
%>

</head>
<body>


</body>
</html>