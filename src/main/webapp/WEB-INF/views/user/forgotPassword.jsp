<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/mybootstrap.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<style>
#wrap {
	margin: 0 auto;
	width:600px;
	height:100%;
}
form-row {
	margin-top: 10px;
}
</style>
<script>
$(function(){
	$("#btnCheckInfo").click(function(){
		
		var member_id = $("#member_id").val();
		var member_name = $("#member_name").val();
		var member_email = $("#member_email").val();
		if (member_id == "" || member_name == "" || member_email == "") {
			$("#chkInfo").show().css("color", "red").text("정보를 모두 입력해 주세요.");
			return;
		}
		var url = "/user/chkForgotPassword";
		var sData = {
				"member_id" : member_id,
				"member_name" : member_name,
				"member_email" : member_email
		};
		$.post(url, sData, function(rData) {
			if (rData == "success") {
				$("#frmForgotPassword").hide();
				$("#inputPassword").show();
				$("#hidden_id").val(member_id);
			} else {
				$("#chkInfo").show().css("color", "red").html("일치하는 정보가 없습니다.");
			}
		});
	});
	
	var same_password = false;
	
	$("#new_password_confirm").keyup(function(){
		var new_password = $("#new_password").val();
		var new_password_confirm = $("#new_password_confirm").val();
		if (new_password != new_password_confirm) {
			$("#chkSamePassword").css("color", "red").text("비밀번호가 일치하지 않습니다.");
			same_password = false;
		} else {
			$("#chkSamePassword").css("color", "green").text("비밀번호가 일치합니다.");
			same_password = true;
		}
	});
	$("#btnNewPassword").click(function(){
		
		var new_password_confirm = $("#new_password_confirm").val();
		if(new_password_confirm == "") {
			$("#chkSamePassword").css("color", "red").text("비밀번호를 입력해 주세요.");
			return;
		}
		if (same_password == true) {
			$("#frmNewPassword").submit();
		}
	});
	
});
</script>
</head>
<body>
<div id="wrap">
	<a href="/"><img src="/images/logo.png" alt="로고이미지"></a>
	<!-- 회원정보 입력창 -->
	<form id="frmForgotPassword" action="/user/register" method="post" style="margin-top:30px;">
		<div class="form-row">
			<div class="form-group col-md-12"><label>비밀번호 찾기</label></div>
		</div>
		<div class="form-row">
			<div class="form-group col-sm-12">
				<input type="text" class="form-control" id="member_id" name="member_id" placeholder="아이디">
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-12">
				<input type="text" class="form-control" id="member_name" name="member_name" placeholder="이름">
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-12">
				<input type="email" class="form-control" id="member_email" name="member_email" placeholder="이메일">
			</div>
		</div>
		<button id="btnCheckInfo" type="button" class="btn btn-primary">회원정보 확인</button>
		<span id="chkInfo" style="display:none;"></span>
	</form>
	
	<!-- 회원정보가 확인되면 보이는 비밀번호 변경 창 -->
	<div id="inputPassword" style="display:none; margin-top:20px; margin-bottom: 20px;">
		<div>새 비밀번호 입력</div><br>
		<form id="frmNewPassword" action="/user/changePassword" method="post">
			<input type="hidden" id="hidden_id" name="member_id">
			<div class="form-row">
				<div class="form-group col-md-12">
					<input type="password" class="form-control" id="new_password" name="new_password" placeholder="새 비밀번호">
				</div>
			</div>
			<div class="form-row">
				<div class="form-group col-md-12">
					<input type="password" class="form-control" id="new_password_confirm" name="new_password_confirm" placeholder="비밀번호 확인">
				</div>
			</div>
			<div class="form-row">
				<div class="form-group col-md-6">
					<button id="btnNewPassword" type="button" class="btn btn-primary">비밀번호 변경</button>
				</div>
				<div class="form-group col-md-6">
					<span id="chkSamePassword" style="float:right;"></span>
				</div>
			</div>
		</form>
	</div>
</div><!-- #wrap -->
</body>
</html>