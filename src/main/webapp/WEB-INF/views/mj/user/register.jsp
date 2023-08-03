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
</head>
<body>
<div id="wrap">
	<img src="/mj/images/logo.png" alt="로고이미지">
	<form action="/user/register" method="post" style="margin-top:30px;">
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
				<input type="number" class="form-control" id="member_pno" name="member_pno" placeholder="전화번호">
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
		
		
		
		<button type="submit" class="btn btn-primary">회원가입</button>
	</form>
	
<!-- 	<form> -->
<!-- 	<div class="form-row"> -->
<!-- 	  <div class="form-group col-md-6"> -->
<!-- 	    <label for="inputEmail4">Email</label> -->
<!-- 	    <input type="email" class="form-control" id="inputEmail4" placeholder="Email"> -->
<!-- 	  </div> -->
<!-- 	  <div class="form-group col-md-6"> -->
<!-- 	    <label for="inputPassword4">Password</label> -->
<!-- 	    <input type="password" class="form-control" id="inputPassword4" placeholder="Password"> -->
<!-- 	  </div> -->
<!-- 	</div> -->
<!-- 	<div class="form-group"> -->
<!-- 	  <label for="inputAddress">Address</label> -->
<!-- 	  <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St"> -->
<!-- 	</div> -->
<!-- 	<div class="form-group"> -->
<!-- 	  <label for="inputAddress2">Address 2</label> -->
<!-- 	  <input type="text" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor"> -->
<!-- 	</div> -->
<!-- 	<div class="form-row"> -->
<!-- 	  <div class="form-group col-md-6"> -->
<!-- 	    <label for="inputCity">City</label> -->
<!-- 	    <input type="text" class="form-control" id="inputCity"> -->
<!-- 	  </div> -->
<!-- 	  <div class="form-group col-md-4"> -->
<!-- 	    <label for="inputState">State</label> -->
<!-- 	    <select id="inputState" class="form-control"> -->
<!-- 	      <option selected>Choose...</option> -->
<!-- 	      <option>...</option> -->
<!-- 	    </select> -->
<!-- 	  </div> -->
<!-- 	  <div class="form-group col-md-2"> -->
<!-- 	    <label for="inputZip">Zip</label> -->
<!-- 	    <input type="text" class="form-control" id="inputZip"> -->
<!-- 	  </div> -->
<!-- 	</div> -->
<!-- 	<div class="form-group"> -->
<!-- 	  <div class="form-check"> -->
<!-- 	    <input class="form-check-input" type="checkbox" id="gridCheck"> -->
<!-- 	    <label class="form-check-label" for="gridCheck"> -->
<!-- 	      Check me out -->
<!-- 	    </label> -->
<!-- 	  </div> -->
<!-- 	</div> -->
<!-- 	<button type="submit" class="btn btn-primary">Sign in</button> -->
</form>
</div><!-- #wrap -->
</body>
</html>