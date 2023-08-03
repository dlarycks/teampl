<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/mj/include/mybootstrap.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<style>
#wrap {
	margin: 0 auto;
	width:600px;
	height:100%;
}
#btnLogin{
	margin-top:10px;
	margin-bottom:40px;
	display:block;
	background-color:#FF7E00;
	width:100%;
	height:45px;
}
#btnLogin:hover{
	background-color:#FF5500;
}
.loginLabel{
	font-size:20px;
}
.btnFind{
	text-align:center;
	color: #333333;
}
.btnFind:hover{
	background-color:#333333;
	color: #DDDDDD;
}
</style>
<script>
$(function(){
	$("#btnLogin").click(function(){
		$("#frmLogin").submit();
	});
});
</script>
</head>
<body>
<div style="height:100px;">
</div>
<div>
</div>
<div id="wrap">
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<form id="frmLogin" role="form" method="post">
				<img src="/mj/images/logo.png" alt="로고이미지">
				<div class="form-group" style="margin-top:50px;">
					<label class="loginLabel" for="member_id">아이디</label>
					<input type="text" class="form-control" id="member_id" name="member_id"/>
				</div>
				<div class="form-group">
					<label class="loginLabel" for="member_pw">비밀번호</label>
					<input type="password" class="form-control" id="member_pw" name="member_pw"/>
				</div>
				<div class="checkbox">
					<label>
						<input type="checkbox" name="remember_id"/>아이디 기억하기
					</label>
				</div> 
				<button type="submit" id="btnLogin" class="btn btn-primary">
					로그인
				</button>
			</form>
		</div>
	</div>
	<div class="row">
		<div class="col-md-4 btnFind">
			<a>아이디 찾기</a>
		</div>
		<div class="col-md-4 btnFind">
			<a>비밀번호 찾기</a>
		</div>
		<div class="col-md-4 btnFind">
			<a href="/user/register">회원가입</a>
		</div>
	</div>
</div>
</div>
</body>
</html>