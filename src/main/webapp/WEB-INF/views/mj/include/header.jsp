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

<!-- MY CSS -->
<style>
a {
	color:black;
}
html {
	position: relative;
	min-height: 100%;
}
body {
	margin-bottom: 250px; /* Margin bottom by footer height */
}
.footer {
	position: absolute;
	bottom: 0;
	width: 100%;
	height: 150px; /* Set the fixed height of the footer here */
	line-height: 50px; /* Vertically center the text there */
	background-color: #DDDDDD;
}
.footer_text{ 
	height:12px;
	font-size:12px;
	margin-left:150px;
}
#footer_logo{
	padding-top: 30px;
}
#header_buton_list {
	padding-top: 10px;
}
.header_button {
	text-align: center;
	font-weight: bold;
	color: black;
}
@keyframes header_button_hover {
	from {background-color: white;}
	to {background-color: #FFD400;}
}

.header_button:hover {
	animation-name: header_button_hover;
	animation-duration: 1s;
}

</style>

</head>
<body>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-10">
			<a href="/"><img src="/mj/images/logo.png" alt="로고"></a>
		</div>
		<div class="col-md-1" style="margin:auto; display:block;">
			<a>주문내역</a>
		</div>
		<div class="col-md-1" style="margin:auto; display:block;">
			<c:choose>
				<c:when test="${not empty loginInfo}">
					<a href="/user/userInfo">
						<img src="/mj/images/s_usericon.jpg" alt="로그인유저">
					</a>
				</c:when>
				<c:otherwise>
					<a href="/user/login">
						로그인
					</a>
				</c:otherwise>			
			</c:choose>
		</div>
	</div>
	<div class="row" id="header_buton_list">
		<div class="col-md-1 header_button">
			<a href="/"><span>홈</span></a>
		</div>
		<div class="col-md-1 header_button">
			<a><span>PC견적</span></a>
		</div>
		<div class="col-md-1 header_button">
			<a href="/board/list"><span>견적상담</span></a>
		</div>
		<div class="col-md-1 header_button">
			<a><span>1:1채팅</span></a>
		</div>
		<div class="col-md-1 header_button">
			<a><span>공지사항</span></a>
		</div>
		<div class="col-md-7">
		</div>
	</div>
</div>
<hr>