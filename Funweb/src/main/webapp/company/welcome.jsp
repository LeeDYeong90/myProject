<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>company/welcome.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top2.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img"></div>
		<nav id="sub_menu">
			<ul>
				<li><a href="./welcome.jsp">인사말</a></li>
				<li><a href="./contact_us.jsp">오시는 길</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Welcome</h1>
			<figure class="ceo">
				<img src="../images/ceo2.jpg">
				<figcaption>JungDanGi CEO Da_Yeong Lee</figcaption>
			</figure>
			<p>정단기 사이트를 찾아주신 여러분을 진심으로 환영합니다.

		우리 정단기는 이용자 중심의 다양한 자료를 보유함을 물론 최신 지식정보를 빠르고 정확하게 전달함으로써 
		평생교육증진에 기여하도록 최선을 다하겠습니다.
		또한 사이트를 찾아주시는 이용자 누구나 정보를 공유ㆍ소통하며 자격증 취득을 통해 개개인의 삶의 질 향상에 
		기여하는 사이트의 역할을 성실히 수행하겠습니다.

		여러분의 많은 관심과 사랑 부탁드립니다.</p>
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


