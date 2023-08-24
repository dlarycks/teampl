<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/mybootstrap.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 등록</title>
<style>
#wrap {
	margin: 0 auto;
	width:600px;
	height:100%;
}
</style>
<script>
$(function() {
	
	var isChecked = false;
	$("#member_id").keyup(function() {
		if (isChecked) {
			isChecked = false;
			$("#dupInfo").css("color", "red").text("아이디 중복검사를 다시 수행해 주세요.");
		}
	});
	
	$("#btnDupCheck").click(function(e) {
		e.preventDefault();
		var url = "/user/isDup"
		var sData = {
				"member_id" : $("#member_id").val()
				};
		$.post(url, sData, function(rData) {
			if (rData == "success") {
				$("#dupInfo").css("color", "green").text("사용 가능한 ID입니다.");
				$("#chkDup").hide();
				isChecked = true;
			} else if (rData == "fail") {
				$("#dupInfo").css("color", "red").text("이미 존재하는 ID입니다.");
			}
			$("#dupInfo").show();
		});
	});
	
	$("#btnRegister").click(function(){
		if (!isChecked) {
			$("#chkDup").show().css("color", "red").text("아이디 중복검사를 수행해 주세요.");
			return;
		}
		var member_pw = $("#member_pw").val();
		if (member_pw == "") {$("#chkDup").css("color", "red").text("'비밀번호'는 필수 입력 항목입니다.").show(); return;}
		var member_email = $("#member_email").val();
		if (member_email == "") {$("#chkDup").css("color", "red").text("'이메일'은 필수 입력 항목입니다.").show(); return;}
		var member_name = $("#member_name").val();
		if (member_name == "") {$("#chkDup").css("color", "red").text("'이름'은 필수 입력 항목입니다.").show(); return;}
		var member_pno = $("#member_pno").val();
		if (member_pno == "") {$("#chkDup").css("color", "red").text("'전화번호'는 필수 입력 항목입니다.").show(); return;}
		$("#frmRegister").submit();
	});
	
	
});
</script>
</head>
<body>
<div id="wrap">
	<a href="/">
		<img src="/images/logo.png" alt="로고이미지">
	</a>
	<form id="frmRegister" action="/user/register" method="post" style="margin-top:30px;">
		<div class="form-row">
			<div class="form-group col-md-12"><label>아래 정보를 정확하게 입력해 주세요.</label></div>
		</div>
		<div class="form-row">
			<div class="form-group col-sm-10">
				<input type="text" class="form-control" id="member_id" name="member_id" placeholder="아이디">
			</div>
			<div class="form-group col-sm-2">
				<a id="btnDupCheck" class="btn btn-large btn-info">중복확인</a>
			</div>
		</div>
		<span id="dupInfo" style="display:none;">아이디 중복여부 출력</span>
		<div class="form-row">
			<div class="form-group col-md-12">
				<input type="password" class="form-control" id="member_pw" name="member_pw" placeholder="비밀번호" required>
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-12">
				<input type="email" class="form-control" id="member_email" name="member_email" placeholder="이메일" required>
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-6"><label>이름</label></div>
			<div class="form-group col-md-6"><label>생일</label></div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-6">
				<input type="text" class="form-control" id="member_name" name="member_name" placeholder="이름" required>
			</div>
			<div class="form-group col-md-6">
				<input type="date" class="form-control" id="member_birth" name="member_birth" placeholder="생일">
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-12"><label>전화번호</label></div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-6">
				<input type="text" class="form-control" id="member_pno" name="member_pno" placeholder="전화번호" required>
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-12"><label>주소</label></div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-6">
				<input type="text" class="form-control" id="member_addr1" name="member_addr1" placeholder="주소1">
			</div>
			<div class="form-group col-md-6">
				<input type="text" class="form-control" id="member_addr2" name="member_addr2" placeholder="주소2">
			</div>
		</div>
		
		
		<button id="btnRegister" type="button" class="btn btn-primary">회원가입</button>
		<span id="chkDup" style="display:none;">아이디 중복검사 여부 출력</span>
	</form>
</div><!-- #wrap -->
</body>
</html>