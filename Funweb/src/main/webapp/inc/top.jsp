<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<header>
	<!-- login join -->
	<%
	String sessionId = (String)session.getAttribute("sessionId");
	if (sessionId == null) {
	%>
	<div id="login">
		<a href="../../member/login.jsp">login</a> | <a href="../../member/join.jsp">join</a>
	</div>
	<%
	} else {
	%>
	<div id="login">
		<a href="#"><%=sessionId %></a> 님 | <a href="../../member/logout.jsp">logout</a>
	</div>
	<%
	}
	%>
	<div class="clear"></div>
	<!-- 로고들어가는 곳 -->
	<div id="logo">
		<a href="../../main/main.jsp"><img src="../../images/logo2.png"></a>
	</div>
	<!-- 메뉴들어가는 곳 -->
	<nav id="top_menu">
		<ul>
			<li><a href="../../main/main.jsp">HOME</a></li>
			<li><a href="../../company/welcome.jsp">COMPANY</a></li>
			<li><a href="../../archive/archive.jsp">ARCHIVE</a></li>
			<li><a href="../../center/notice.jsp">CUSTOMER CENTER</a></li>
		</ul>
	</nav>
</header>