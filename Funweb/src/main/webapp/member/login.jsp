<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String cookieHeader = request.getHeader("Cookie");
	String cookieID = null;
	String cookiePASS = null;
	
	if(cookieHeader != null) {
		Cookie[] cookies = request.getCookies();
		for(int i = 0; i < cookies.length; i++) {
			if(cookies[i].getName().equals("cookieID")) {
				cookieID = cookies[i].getValue();
			} else if(cookies[i].getName().equals("cookiePASS")) {
				cookiePASS = cookies[i].getValue();
			} 
		}
	}%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/login.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script>
function idRem() {
	document.getElementById("myRemember").value="idRem";
}
function loginRem() {
	document.getElementById("myRemember").value="loginRem";
}
</script>
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top2.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->
		  
		<!-- 본문들어가는 곳 -->
		  <!-- 본문 메인 이미지 -->
		  <div id="sub_img_member"></div>
		  <!-- 왼쪽 메뉴 -->
		  <nav id="sub_menu">
		  	<ul>
		  		<li><a href="./join.jsp">Join us</a></li>
		  		<li><a href="#">Privacy policy</a></li>
		  	</ul>
		  </nav>
		  <!-- 본문 내용 -->
		  <article>
		  	<h1>Login</h1>
		  	<form action="loginPro.jsp" method="post" id="join">
		  		<fieldset>
		  			<legend>Login Info</legend>
		  			<label>User Id</label>
		  			<input type="text" name="id" required="required" value="<%=cookieID%>"><br>
		  			
		  			<label>Password</label>
		  			<input type="password" name="pass" required="required" value="<%=cookiePASS%>"><br>
		  			<input type="checkbox" name="remember" onclick="idRem()">아이디 기억하기
		  			<input type="checkbox" name="remember" onclick="loginRem()">로그인 기억하기
		  			<input type="hidden" id="myRemember" name="myRemember">
		  		</fieldset>
		
		  		<div class="clear"></div>
		  		<div id="buttons">
		  			<input type="submit" value="Submit" class="submit">
		  			<input type="reset" value="Cancel" class="cancel">
		  		</div>
		  	</form>
		  </article>
		  
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


