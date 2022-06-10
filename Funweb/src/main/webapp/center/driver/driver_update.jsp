<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/driver_update.jsp</title>
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
		<%
		int num = Integer.parseInt(request.getParameter("num"));
		String name = request.getParameter("name");
		int pageNum = Integer.parseInt(request.getParameter("page"));

		%>
		<article>
			<h1>Driver Update</h1>
			<form action="./driver_updatePro.jsp" method="post" enctype="multipart/form-data">
				<table id="notice">
					<input type="hidden" name="num" value="<%=num%>">
					<input type="hidden" name="pageNum" value="<%=pageNum%>">
					<tr>
						<td>비밀번호</td>
						<td colspan="3"><input type="password" name="pass" required="required"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td colspan="3"><input type="text" name="subject" required="required"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="3"><textarea rows="10" cols="20" name="content"
								required="required"></textarea></td>
					</tr>
					<tr>
						<td>파일</td>
						<td colspan="3"><input type="file" name="file" required="required"></td>
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


