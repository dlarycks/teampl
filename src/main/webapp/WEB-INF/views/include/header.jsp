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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- 글리피콘 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- styles.css(template) -->
<link rel="stylesheet" href="/css/styles.css">
<!-- mycss.css -->
<link rel="stylesheet" href="/css/mycss.css">
<!-- myscript.js -->
<script src="/js/myscript.js"></script>

<!-- DANAWA CSS -->
<link href="//static.danawa.com/new/recss/estimate.css" rel="stylesheet" type="text/css">

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
	$("#btnOrderHistory").click(function(){
		location.href = "/user/orderHistrory";
	});
});
</script>
<body>

<header>
<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
<!--     <div class="container px-4 px-lg-5"> -->
    <div class="container">
        <a class="navbar-brand" href="/">
        	<img src="/images/logo2.png" alt="로고">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item">
                	<a class="nav-link active" aria-current="page" href="/">홈</a>
                </li>
                <li class="nav-item ml-5">
                	<a class="nav-link active" href="/shop/list">PC견적</a>
                </li>
                <%--
                <!-- PC견적, 공지사항 '게시판' 카테고리 안에 통합 -->
                <li class="dropdown nav-item ml-5">
				  	<a class="nav-link active dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">
					    게시판
				  	</a>
				  	<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="/board/list">PC견적</a></li>
					    <li><a class="dropdown-item" href="/board/list?board_type=공지">공지사항</a></li>
					</ul>
                </li>
                 --%>
                <li class="nav-item ml-5">
                	<a class="nav-link active" href="/board/list">견적상담</a>
                </li>
                <li class="nav-item ml-5">
                	<a class="nav-link active" href="https://open.kakao.com/o/sFk2Adzf"
                	 onClick="window.open(this.href, '', 'width=950, height=1000, left=950, top=0'); return false;"
                	 >1:1채팅</a>
                </li>
                <li class="nav-item ml-5">
                	<a class="nav-link active" href="/board/list?board_type=공지" id="openTalk">공지사항</a>
                </li>
                <%--
                <!-- 테스트용 -->
                <li class="nav-item ml-5">
                	<a class="nav-link active" href="/shop/testOrder">(테스트)결제화면</a>
                </li>
                 --%>
            </ul>
            
            <!-- (hidden)결제 완료 창 -->
			<div class="alert alert-primary" role="alert" id="registerResult" style="display:none;">
				${register_name}님, 가입을 환영합니다.
			</div>
			<div class="alert alert-warning" role="alert" id="logoutResult" style="display:none;">
				로그아웃 하였습니다.
			</div>
			<div class="alert alert-success" role="alert" id="payResult" style="display:none;">
				결제가 완료되었습니다. 감사합니다.
			</div>
            
            <form class="d-flex">
            	<c:choose>
				<c:when test="${not empty loginInfo}">
	                <button class="btn btn-outline-dark" type="button" id="btnOrderHistory">
	                    <i class="bi-cart-fill me-1"></i>
	                    주문내역
	                </button>
                <!-- 회원아이콘 -->
					<div class="dropdown ml-5">
						<img src="/images/s_usericon.jpg" alt="로그인유저" 
							class="dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">
						<ul class="dropdown-menu">
						    <li><a class="dropdown-item" href="/user/userInfo">회원정보</a></li>
						    <li><a class="dropdown-item" href="/user/logout">로그아웃</a></li>
						</ul>
					</div>
				</c:when>
				<c:otherwise>
					<div class="nav-item ml-5 align-self-center">
						<a class="nav-link active" href="/user/login">로그인</a>
					</div>
				</c:otherwise>			
			</c:choose>
            </form>
        </div>
    </div>
</nav>
</header>