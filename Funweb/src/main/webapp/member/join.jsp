<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
var isCheckId;
var isCheckPass;
function idCheck() {
	window.open("./idCheck.jsp", "아이디 중복확인 창", "width=500px, height=300px");
	isCheckId = true;
	//id중복확인 후 다시 id입력창 수정을 방지
// 	document.getElementById("id").readOnly = !eval(document.getElementById("id").readOnly);
}

function pwCheck(inputPass) {
	var colorRG = document.getElementById("retypePassCheckResult");
	if(document.fr.pass2.value != document.fr.pass.value) {
		colorRG.style.color = "red";
		document.getElementById("retypePassCheckResult").innerHTML = "비밀번호 불일치";
		idCheckPass = false;
	} else {
		colorRG.style.color = "green";
		document.getElementById("retypePassCheckResult").innerHTML = "비밀번호 일치";
		isCheckPass = true;
		
	}
}

function checkForm() {
	if(!isCheckId){ //아이디 중복확인을 수행하지 않았을 경우
		alert("아이디 중복 확인을 하셔야 회원가입이 가능합니다.");
		document.fr.id.focus();
		return false;  
	} else if(!isCheckPass) {
		alert("비밀번호를 다시 입력해주세요.");
		document.fr.pass2.focus();
		return false;
	
	}else {
		return true;
	}
}
</script>
<title>member/join.jsp</title>
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
		  	<h1>Join Us</h1>
		  	<form action="joinPro.jsp" method="post" id="join" name="fr" onsubmit="return checkForm()">
		  		<fieldset>
		  			<legend>Basic Info</legend>
		  			<label>User Id</label>
		  			<input type="text" name="id" class="id" id="id" required="required" readonly="readonly">
		  			<input type="button" value="아이디 중복확인" class="dup" id="btn" onclick="idCheck()"><br>
		  			
		  			<label>Password</label>
		  			<input type="password" name="pass" id="pass" placeholder="" required="required">
		  			<span id="retypePassCheckResult"><!--패스워드 일치 여부 결과 표시하는 영역--></span><br> 			
		  			
		  			<label>Retype Password</label>
		  			<input type="password" name="pass2" onkeyup="pwCheck(this.value)" required="required"><br>
		  			
		  			<label>Name</label>
		  			<input type="text" name="name" id="name" required="required"><br>
		  			
		  			<label>E-Mail</label>
		  			<input type="email" name="email" id="email" required="required"><br>
		  			
		  			<label>Mobile Phone Number</label>
		  			<input type="text" name="mobile" required="required" ><br>
		  		</fieldset>
		  		
		  		<fieldset>
		  			<legend>Optional</legend>
		  			<label>Address</label>
		  			<input type="text" name="address" ><br>
		  			<label>Phone Number</label>
		  			<input type="text" name="phone" ><br>
		  			
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


