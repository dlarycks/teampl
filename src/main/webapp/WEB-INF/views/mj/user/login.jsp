<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	/* 아이디, 비밀번호 입력 여부 검증 */
	$("#btnLogin").click(function(){
		var member_id = $("#member_id").val();
		var member_pw = $("#member_pw").val();
		if (member_id == null) {
			$("#alertText").show().css("color", "red").text("아이디를 입력해 주세요.");
		} else if (member_pw == null){
			$("#alertText").show().css("color", "red").text("비밀번호를 입력해 주세요.");
		} else {
			$("#frmLogin").submit();
		}
	});
	
	$("#forgotId").click(function(e){
		e.preventDefault();
		$("#modal-200160").trigger("click");
	});
	
	$("#btnFindId").click(function(){
		var member_name = $("#member_name").val();
		var member_email = $("#member_email").val();
		var url = "/user/chkForgotId";
		var sData = {
				"member_name" : member_name,
				"member_email" : member_email
		};
		$.post(url, sData, function(rData){
			$("#closeModal").trigger("click");
			$("#modal-200161").trigger("click");
			if (rData == "") {
				$("#result-modal-body").text("일치하는 회원정보가 없습니다.");
			} else {
				$("#result-modal-body").text("회원님의 아이디는 " + rData + "입니다.");
				$("#member_id").val(rData);
			}
		});
	});
	
});
</script>
</head>
<body>
<!-- modal(for findID) -->
<a id="modal-200160" href="#modal-container-200160"
	 	role="button" class="btn" data-toggle="modal" style="display:none;"></a>
<div class="modal fade" id="modal-container-200160" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myModalLabel">아이디 찾기</h5> 
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<input type="text" class="form-control" id="member_name" placeholder="이름">
				<input type="email" class="form-control" id="member_email" placeholder="이메일">
			</div>
			<div class="modal-footer">
				<button type="button" id="btnFindId" class="btn btn-primary">아이디 찾기</button> 
				<button type="button" id="closeModal" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- second modal(for findID result) -->
<a id="modal-200161" href="#modal-container-200161"	role="button" class="btn" data-toggle="modal" style="display:none;"></a>
<div class="modal fade" id="modal-container-200161" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myModalLabel">아이디 찾기 결과</h5> 
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div id="result-modal-body" class="modal-body">결과 텍스트</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- wrap -->
<div style="height:100px;">
</div>
<div>
</div>
<div id="wrap">
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<form id="frmLogin" role="form" method="post">
				<a href="/"><img src="/mj/images/logo.png" alt="로고이미지"></a>
				<div class="form-group" style="margin-top:50px;">
					<label class="loginLabel" for="member_id">아이디</label>
					<input type="text" class="form-control" id="member_id" name="member_id" value="${cookie_id}"/>
				</div>
				<div class="form-group">
					<label class="loginLabel" for="member_pw">비밀번호</label>
					<input type="password" class="form-control" id="member_pw" name="member_pw"/>
				</div>
				<div class="checkbox">
					<label>
						<input type="checkbox" name="remember_id"
							<c:if test="${not empty cookie_id}">checked</c:if>
						/>아이디 기억하기
					</label>
				</div> 
				<button type="button" id="btnLogin" class="btn btn-primary">
					로그인
				</button>
				<span id="alertText" style="dislpay:none;"></span>
			</form>
		</div>
	</div>
	<div class="row">
		<div class="col-md-4 btnFind">
			<a href="/" id="forgotId">아이디 찾기</a>
		</div>
		<div class="col-md-4 btnFind">
			<a href="/user/forgotPassword">비밀번호 찾기</a>
		</div>
		<div class="col-md-4 btnFind">
			<a href="/user/register">회원가입</a>
		</div>
	</div>
</div>
</div>
</body>
</html>