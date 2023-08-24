<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- BOOTSTRAP CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- 글리피콘 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<!-- mycss.css -->
<link rel="stylesheet" href="/css/mycss.css">
<!-- myscript.js -->
<script src="/js/myscript.js"></script>



<script>
$(function(){
	/* 회원가입 완료 메세지*/
	if ("${register_result}" == "success") {
		$("#registerResult").fadeIn(600).delay(3000).fadeOut(600);
	}
	/* 로그아웃 메세지*/
	if ("${logoutResult}" == "true") {
		$("#logoutResult").fadeIn(600).delay(3000).fadeOut(600);
	}
	/* 결제 완료 메세지 */
	if ("${payResult}" == "true") {
		$("#payResult").fadeIn(600).delay(3000).fadeOut(600);
	}
});
</script>
<body>
<div class="container-fluid">
	<div class="row">
		<!-- 사이트 로고 -->
		<div class="col-md-2">
			<a href="/"><img src="/images/logo.png" alt="로고"></a>
		</div>
		<!-- hidden alerts -->
		<div class="col-md-8">
			<div class="alert alert-warning my-alert" role="alert" id="logoutResult">
				로그아웃 하였습니다.
			</div>
			<div class="alert alert-primary my-alert" role="alert" id="registerResult">
				${register_name}님, 가입을 환영합니다.
			</div>
			<div class="alert alert-success my-alert" role="alert" id="payResult">
				결제가 완료되었습니다. 감사합니다.
			</div>
		</div>
		<!-- 주문내역 버튼 -->
		<div class="col-md-1" style="margin:auto; display:block;">
			<c:if test="${not empty loginInfo}">
			<a class="header-link" href="/user/orderHistrory">주문내역</a>
			</c:if>
		</div>
		<!-- 로그인 or 회원로고 -->
		<div class="col-md-1" style="margin:auto; display:block;">
			<c:choose>
				<c:when test="${not empty loginInfo}">
					<div class="dropdown">
						<img src="/images/s_usericon.jpg" alt="로그인유저" 
							class="dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">
						<div class="dropdown-menu">
						    <a class="dropdown-item header-link" href="/user/userInfo">회원정보</a>
						    <a class="dropdown-item header-link" href="/user/logout">로그아웃</a>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<a class="header-link" href="/user/login">
						로그인
					</a>
				</c:otherwise>			
			</c:choose>
		</div>
	</div>
	<div class="row" id="header_buton_list">
		<div class="col-md-1 header_button">
			<a class="header-link" href="/"><span>홈</span></a>
		</div>
		<div class="col-md-1 header_button">
			<a class="header-link" href="/shop/list"><span>PC견적</span></a>
		</div>
		<div class="col-md-1 header_button">
			<a class="header-link" href="/board/list"><span>견적상담</span></a>
		</div>
		<div class="col-md-1 header_button">
			<a class="header-link" href="https://open.kakao.com/o/sFk2Adzf" target="_blank"><span>1:1채팅</span></a>
		</div>
		<div class="col-md-1 header_button">
			<a class="header-link" href="/board/list?board_type=공지"><span>공지사항</span></a>
		</div>
		<div class="col-md-7">
			<a class="header-link" href="/shop/testOrder">(테스트)결제화면</a>
		</div>
	</div>
</div>
<hr>