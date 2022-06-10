<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>archive_write.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
//세션에 저장된 아이디를 id변수에 저장
String id = (String) session.getAttribute("sessionId");

//세션 아이디가 없을 경우 - 알림창 띄우고 이전페이지로 이동
if (id == null) {
%>
<script>
	alert("회원만 접근 가능합니다.").
	history.back();
</script>
<%
}
%>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top2.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img"></div>
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="./archive_write.jsp">문제 입력</a></li>
				<li><a href="./memberScoreList.jsp">회원점수목록</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Notice Write</h1>
			<form action="./archive_writePro.jsp" method="post">
				<table id="archive">

					<tr class="archive_1">
						<td><input type="text" name="year" required="required" placeholder="기출년도"></td>
						<td><input type="text" name="cnt" required="required" placeholder="기출회차"></td>
						<td><input type="text" name="subject_cd" required="required" placeholder="제?과목"></td>
						<td><input type="text" name="q_num" required="required" placeholder="문제번호"></td>
						<td><input type="text" name="answer" required="required" placeholder="정답"></td>
					</tr>
					<tr class="archive_2">
						<td colspan="5"><input type="text" name="q_subject" required="required" placeholder="문제명"></td>
					</tr>
					<tr class="archive_2">
						<td colspan="5"><input type="textarea" rows="4" cols="30" name="q_content" placeholder="문제내용"></td>
					</tr>
					<tr class="archive_2">
						<td  colspan="5"><input type="text" name="a_1" required="required" placeholder="보기1번"></td>
					</tr>
					<tr class="archive_2">
						<td  colspan="5"><input type="text" name="a_2" required="required" placeholder="보기2번"></td>
					</tr>
					<tr class="archive_2">	
						<td  colspan="5"><input type="text" name="a_3" required="required" placeholder="보기3번"></td>
					</tr>
					<tr class="archive_2">	
						<td  colspan="5"> <input type="text" name="a_4" required="required" placeholder="보기4번"></td>
					</tr>
				</table>

				<div id="table_search">
					<input type="submit" value="글쓰기" class="btn">
				</div>
			</form>
			<div class="clear"></div>
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


