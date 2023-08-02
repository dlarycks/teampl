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