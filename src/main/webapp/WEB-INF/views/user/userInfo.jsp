<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
#userInfo {
	text-align:center;
}
dt {
	margin-top:25px;
}
</style>
<div id="userInfo">
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<img alt="로그인유저" src="/images/s_usericon.jpg" />
			<dl>
				<dt>아이디</dt>
				<dd>${memberVo.member_id}</dd>
				<dt>이름</dt>
				<dd>${memberVo.member_name}</dd>
				<dt>생년월일</dt>
				<dd>${memberVo.member_birth}</dd>
				<dt>전화번호</dt>
				<dd>${memberVo.member_pno}</dd>
				<dt>이메일</dt>
				<dd>${memberVo.member_email}</dd>
				<dt>주소1</dt>
				<dd>${memberVo.member_addr1}</dd>
				<dt>주소2</dt>
				<dd>${memberVo.member_addr2}</dd>
				<dt>가입일</dt>
				<dd>${memberVo.member_regdate}</dd>
				<dt>포인트</dt>
				<dd>${memberVo.member_point}</dd>
			</dl>
		</div>
	</div>
</div>
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>
