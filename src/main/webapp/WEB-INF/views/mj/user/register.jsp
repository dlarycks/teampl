<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/mj/include/mybootstrap.jsp" %>
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
	var isDup = true;
	
	$("#btnDupCheck").click(function(e) {
		e.preventDefault();
		var url = "/user/isDup"
		var sData = {
				"member_id" : $("#member_id").val()
				};
		$.post(url, sData, function(rData) {
			$("#dupInfo").show();
			if (rData == "success") {
				$("#dupInfo").css("color", "green").text("사용 가능한 ID입니다.");
				$("#chkDup").hide();
				isDup = false;
			} else if (rData == "fail") {
				$("#dupInfo").css("color", "red").text("이미 존재하는 ID입니다.");
				isDup = true;
			}
		});
	});
	
	$("#btnRegister").click(function(){
		if (isDup == true) {
			$("#chkDup").show().css("color", "red").text("아이디 중복검사를 수행해 주세요.");		
		} else {
			$("#frmRegister").submit();
		}
	});
});
</script>
</head>
<body>
<div id="wrap">
	<img src="/mj/images/logo.png" alt="로고이미지">
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
				<input type="password" class="form-control" id="member_pw" name="member_pw" placeholder="비밀번호">
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-12">
				<input type="email" class="form-control" id="member_email" name="member_email" placeholder="이메일">
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-6"><label>이름</label></div>
			<div class="form-group col-md-6"><label>생일</label></div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-6">
				<input type="text" class="form-control" id="member_name" name="member_name" placeholder="이름">
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
				<input type="text" class="form-control" id="member_pno" name="member_pno" placeholder="전화번호">
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