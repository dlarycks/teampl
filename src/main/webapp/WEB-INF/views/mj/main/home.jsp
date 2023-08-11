<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/mj/include/header.jsp" %>
<style>
	#demo {
		width: 1000px;
		height: 500px;
		margin: 0 auto;
	}
	/* Make the image fully responsive */
	.carousel-inner img {
	  width: 100%;
	  height: 100%;
	}
</style>
<div id="demo" class="carousel slide" data-ride="carousel">
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
	<!-- The slideshow -->
	<div class="carousel-inner">
		<div class="carousel-item active">
    	<img src="/mj/images/main_image1.jpg" alt="img1">
    </div>
    <div class="carousel-item">
    	<img src="/mj/images/main_image2.jpg" alt="img2">
    </div>
  </div>

  <!-- Left and right controls -->
  <a class="carousel-control-prev" href="#demo" data-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </a>
  <a class="carousel-control-next" href="#demo" data-slide="next">
    <span class="carousel-control-next-icon"></span>
  </a>
</div>

<%@ include file="/WEB-INF/views/mj/include/footer.jsp" %>