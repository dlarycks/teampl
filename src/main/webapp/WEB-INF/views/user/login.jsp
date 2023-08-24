<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/include/mybootstrap.jsp" %>
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
<script src="https://t1.kakaocdn.net/kakao_js_sdk/v1/kakao.min.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script>
$(function(){
	var loginResult = "${loginResult}";
	if (loginResult != "") {
		$("#divLoginResult").fadeIn(600);
	}
	// 아이디, 비밀번호 입력 여부 검증 
	$("#btnLogin").click(function(){
		login();
	});
	// 엔터키 쳐도 로그인
	$("#member_pw").keydown(function(k){
		if (k.keyCode == 13) {
			login();	
		}
	});
	function login() {
		var member_id = $("#member_id").val();
		var member_pw = $("#member_pw").val();
		if (member_id == null) {
			$("#alertText").show().css("color", "red").text("아이디를 입력해 주세요.");
		} else if (member_pw == null){
			$("#alertText").show().css("color", "red").text("비밀번호를 입력해 주세요.");
		} else {
			$("#frmLogin").submit();
		}
	}
	$("#forgotId").click(function(e){
		e.preventDefault();
		$("#modal-200160").trigger("click");
	});
	// 아이디 찾기
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
	/* 카카오톡 로그인 */
	$("#btn-kakao-login").click(function(e){

		e.preventDefault();
		// 카카오 로그인 실행시 오류메시지를 표시하는 경고창을 화면에 보이지 않게 한다.
		$("alert-kakao-login").addClass("d-none");
		
		Kakao.init('/* !! KAKAO_INIT_KEY !! */');
		Kakao.Auth.login({
			
			success:function(auth){
				
				Kakao.API.request({
					url: '/v2/user/me',
					success: function(response){
						// 사용자 정보를 가져와서 폼에 추가.
						var account = response.kakao_account;
						$('#form-kakao-login input[name=member_id]').val(account.profile.nickname);
// 						$('#form-kakao-login input[name=email]').val(account.email);
						$("#form-kakao-login").submit();
					},
					fail: function(error){
						$('alert-kakao-login').removeClass("d-none").text("카카오 로그인 처리 중 오류가 발생했습니다.")
					}
				});
			},
			fail:function(error){
				// 경고창에 에러메시지 표시
				$('alert-kakao-login').removeClass("d-none").text("카카오 로그인 처리 중 오류가 발생했습니다.")
			}
		});
	});
	/* 네이버 로그인 */
	const naverLogin = new naver.LoginWithNaverId(
            {
                clientId: "/* !! NAVER_INIT_KEY !! */",
                callbackUrl: "http://localhost/user/login",
                loginButton: {color: "green", type: 3, height: 55}
            }
        );
	
 	naverLogin.init();
 	
 	naverLogin.getLoginStatus(function (status) {
    	if (status) {
    		var userid = naverLogin.user.getEmail();
			var username = naverLogin.user.getName();
			userid = userid.substr(0, userid.indexOf("@"));
			naverLogin.logout(); // 네이버 로그아웃 후 id만 받아서 사이트 로그인 할것 
			$("#form-naver-login input[name=member_id]").val(userid);
			$("#form-naver-login").submit();
      	}
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
	<div id="divLoginResult" class="row" style="display:none;">
		<div class="alert alert-success">
		  <strong>로그인 실패!</strong>${loginResult}
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<form action="/user/login" id="frmLogin" role="form" method="post">
				<a href="/"><img src="/images/logo.png" alt="로고이미지"></a>
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
	<!-- 카카오톡 로그인 -->
	<div class="row justify-content-center mt-4">
		<a id="btn-kakao-login">
		  <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="222"
		    alt="카카오 로그인 버튼" />
		</a>
		<form action="/oauth/kakao" method="post" id="form-kakao-login">
  			<input type="hidden" name="member_id"/>
  		</form>
	</div>
	<!-- 네이버 로그인 -->
	<div class="row justify-content-center mt-3">
  		<div id="button_area"> 
        	<div id="naverIdLogin"></div>
      	</div>
		<form action="/oauth/naver" method="post" id="form-naver-login">
  			<input type="hidden" name="member_id"/>
  		</form>
	</div>
	<div id="message">
	
	</div>
</div>
</div>
</body>
</html>