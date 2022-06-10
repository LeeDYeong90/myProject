<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

//파일 업로드 관련 정보 처리를 위해 MultipartRequest 객체를 활용해야 함
//     1. 업로드할 파일이 저장되는 이클립스 프로젝트 상의 경로를 변수에 저장

String uploadPath = "/upload";
//     2.업로드 할 파일의 크기를 정수형태로 지정(10MB 로 지정)
int fileSize = 1024 * 1024 * 10;

// 3. 현재 프로젝트(서블릿)를 처리하는 객체를 서블릿 컨텍스트라고 하며 
ServletContext context = request.getServletContext();
//      4. 업로드할 파일이 저장되는 실제 경로를 저장할 변수 선언
String realPath = context.getRealPath(uploadPath);

// 5. 게시물 작성 후 글쓰기 버튼 클릭 시 게시물 정보는 request 객체에 담겨 전달되므로 해당 파라미터들을 가져와서 BoardDTO()객체에 
// 담겨 전달되므로 해당 파라미터들을 가져와서 BoardDTO 객체에 저장하기 위해서 request.getParameter()메서드 대신 MultipartRequest 객체를
// 통해 가져와야 함
// (WEB-INF / lib 폴더에 복사 및 Build path 등록 필요)
MultipartRequest multi = new MultipartRequest(request, //1) 실제 요청 정보가 포함된 request 객체
		realPath, //2) 길제 업로드 폴더 경로
		fileSize, //3) 업로드 파일 크기
		"UTF-8", //4) 한글 파일명에 대한 인코딩 방식
		new DefaultFileRenamePolicy() //5) 중복 파일명에 대한 처리를 담당하는 객체
);

// 	6. MultipartRequest 객체의 getParameter()를 사용하여 폼 파라미터 데이터를 가져와서 BoardDTO 객체에 저장
// =>주의! request.getParameter() 메서드가 아니다(이러면 null값 나옴)
FileBoardDTO fileBoard = new FileBoardDTO();
fileBoard.setName(multi.getParameter("name"));
fileBoard.setPass(multi.getParameter("pass"));
fileBoard.setSubject(multi.getParameter("subject"));
fileBoard.setContent(multi.getParameter("content"));
// 단, 파일 정보를 가져올 때는 multi.getParameter() 메서드 사용 불가!
// 1) 파일명을 관리하는 객체에 접근 가져오기
String fileElement = multi.getFileNames().nextElement().toString();
// 2) 1번에서 가져온 이름을 활용하여 원본 파일명과 실제 업로드 된 파일명 가져오기
String original_file = multi.getOriginalFileName(fileElement);
String file = multi.getFilesystemName(fileElement);
// out.print("실제 파일명 :" + realFile +"<br> 원본 파일명 : " + original_file);
fileBoard.setOriginal_file(original_file);
fileBoard.setFile(file);


FileBoardDAO fileBoardDAO = new FileBoardDAO();
int insertFileCount = fileBoardDAO.insertFileBoard(fileBoard);
if(insertFileCount > 0) {
	response.sendRedirect("../driver.jsp");
} else {
 %>
<script>
	alert("파일 업로드 실패");
	history.back();
</script>
<%} %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


</body>
</html>