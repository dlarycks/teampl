<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/mj/include/header.jsp" %>
<style>
#infoTotalPrice {
	font-size:18px;
	font-weight:bold;
 	color:#231709;
}
.btn-mine {
	background-color:#B0C4DE;
	width:180px;
	height:60px;
	margin:auto;
}
</style>
<script>
$(function(){
	/* 1000자리마다 콤마 찍기*/
	function setCommas(number) {
	    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	function fullPriceToInt(number_won){
		var endstr = number_won.slice(-1);
		if (endstr == "원") {
		    return number_won.slice(0, -1).replace(/,/g, "");
		} else {
			return number_won.replace(/,/g, "");
		}
	}
	$("#infoTotalPrice").text("총 가격 : " + setCommas(${orderDto.total_price}) + "원");
	
	$("#hr").hide();
	$("#divCredit").hide();
	$("#divAccount").hide();
	$("#divAddr").hide();
	
	function fadeInById(id) {
		$("#divAccount").hide();
		$("#divCredit").hide();
		var component = $("#" + id);
		component.fadeIn(800);
		$("#hr").fadeIn(800);
		$("#divAddr").fadeIn(800);
	}
	$("#btnCredit").click(function(){
		fadeInById("divCredit");
	});
	$("#btnAccount").click(function(){
		fadeInById("divAccount");
	});
	/* 신용카드 */
	$("#sameUserInfo").click(function(){
		if ($("#sameUserInfo").is(":checked")) {
			$("#payerName").val("${memberVo.member_name}").prop("readonly", true);
			$("#payerEmail").val("${memberVo.member_email}").prop("readonly", true);
			$("#payerPno").val("${memberVo.member_pno}").prop("readonly", true);
		} else {
			$("#payerName").val("").prop("readonly", false);
			$("#payerEmail").val("").prop("readonly", false);
			$("#payerPno").val("").prop("readonly", false);
		}
	});
	/* 배송지주소 */
	$("#sameUserInfo2").click(function(){
		if ($("#sameUserInfo2").is(":checked")) {
			$("#recipientAddr1").val("${memberVo.member_addr1}").prop("readonly", true);
			$("#recipientAddr2").val("${memberVo.member_addr2}").prop("readonly", true);
		} else {
			$("#recipientAddr1").val("").prop("readonly", true);
			$("#recipientAddr2").val("").prop("readonly", true);
		}
	});
	
	/* 결제하기 버튼 */
	$("#btnPay").click(function(){
		console.log("clicked");
		var order_content = "${orderDto.order_cpu_name}, ${orderDto.order_mb_name}";
			order_content += "${orderDto.order_ram_name}, ${orderDto.order_vga_name}";
			order_content += "${orderDto.order_power_name}, ${orderDto.order_case_name}, ${orderDto.order_ssd_name}";

		/* 추가 : 결제 상세정보가 추가되면 아래 form을(+dto) 수정하자 */
		$("#order_content").val(order_content);
		$("#order_price").val("${orderDto.total_price}");
		
		$("#frmPayment").submit();
	});
	
});

</script>
<!-- 주문용 hidden form -->
<form id="frmPayment" action="/shop/payment" method="post">
	<!-- for TBL_ORDER -->
	<input type="hidden" name="order_content" id="order_content">
	<input type="hidden" name="order_price" id="order_price">
	<!-- for TBL_ORDER_DETAIL -->
	<input type="hidden" name="member_no" value="${memberVo.member_no}">
	<input type="hidden" name="order_cpu" value="${orderVo.order_cpu}">
	<input type="hidden" name="order_mb" value="${orderVo.order_mb}">
	<input type="hidden" name="order_ram" value="${orderVo.order_ram}">
	<input type="hidden" name="order_vga" value="${orderVo.order_vga}">
	<input type="hidden" name="order_power" value="${orderVo.order_power}">
	<input type="hidden" name="order_case" value="${orderVo.order_case}">
	<input type="hidden" name="order_ssd" value="${orderVo.order_ssd}">
</form>
<div class="container-fluid">
	<!--  장바구니 / 장바구니 목록 -->
	<div class="row" style="margin-top:30px;">
		<div class="col-md-2"></div>
		<div class="col-md-2">
			<h3>장바구니</h3>
		</div>
		<div class="col-md-6">
			<div class="list-group">
				<div class="list-group-item list-group-item-secondary">CPU : ${orderDto.order_cpu_name}</div>
				<div class="list-group-item">메인보드 : ${orderDto.order_mb_name}</div>
				<div class="list-group-item list-group-item-secondary">RAM : ${orderDto.order_ram_name}</div>
				<div class="list-group-item">그래픽카드 : ${orderDto.order_vga_name}</div>
				<div class="list-group-item list-group-item-secondary">파워 : ${orderDto.order_power_name}</div>
				<div class="list-group-item">케이스 : ${orderDto.order_case_name}</div>
				<div class="list-group-item list-group-item-secondary">SSD : ${orderDto.order_ssd_name}</div>
				<div class="list-group-item list-group-item-danger" id="infoTotalPrice">총 가격 : 원</div>
			</div>
		</div>
		<div class="col-md-2">
		</div>
	</div>
	<!-- hr -->
	<div class="row" style="margin-top:10px;">
		<div class="col-md-2"></div>
		<div class="col-md-8"><hr></div>
	</div>
	
	<!-- 결제방식 선택 -->
	<div class="row" style="margin-top:10px;">
		<div class="col-md-2">
		</div>
		<div class="col-md-2">
		
			<h3>결제방식 선택</h3>
		</div>
		<div class="col-md-6">
			<button type="button" class="btn btn-mine" id="btnCredit">신용카드</button> 
			<button type="button" class="btn btn-mine" id="btnAccount">계좌이체</button> 
		</div>
		<div class="col-md-2">
		</div>
	</div>
	<div class="row" style="margin-top:10px;">
		<div class="col-md-2"></div>
		<div class="col-md-8"><hr></div>
	</div>
	
	<!-- 신용카드 선택 시 나타날 div (divCredit) -->
	<div class="row" style="margin-top:10px; display:none;" id="divCredit">
		<div class="col-md-2">
		</div>
		<div class="col-md-2">
			<h3>신용카드</h3>
			<h5>결제정보 입력</h5>
		</div>
		<div class="col-md-6">
			<div style="text-align:start">
				<label for="sameUserInfo" style="user-select:none">
					<input type="checkbox" id="sameUserInfo">회원정보와 동일
				</label><br>
			</div>
			<!-- 결제자 성함, 결제자 이메일, 결제자 전화번호 -->
			<div class="row" style="margin-top:10px;"><!-- row안의 row -->
				<div class="col-md-10">
					<form role="form">
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">결제자 성함</span>
							</div>
							<input type="text" class="form-control" aria-describedby="basic-addon3" id="payerName">
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
						    	<span class="input-group-text">결제자 이메일</span>
							</div>
							<input type="email" class="form-control" aria-describedby="basic-addon3" id="payerEmail">
						</div>
						<div class="input-group mb-3">
						  <div class="input-group-prepend">
						    <span class="input-group-text">결제자 전화번호</span>
						  </div>
						  <input type="text" class="form-control" aria-describedby="basic-addon3" id="payerPno">
						</div><br>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">카드번호</span>
							    <select class="btn btn-outline-secondary">
							    	<option>농협</option>
							    	<option>신한</option>
							    	<option>KB</option>
							    </select>
							</div>
							<input type="text" class="form-control" placeholder="카드번호를 입력해 주세요." aria-describedby="basic-addon1">
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="col-md-2">
		</div>
	</div>
	
	<!-- 계좌이체 선택 시 나타날 div (divAccount) -->
	<div class="row" style="margin-top:10px; display:none;" id="divAccount">
		<div class="col-md-2">
		</div>
		<div class="col-md-2">
			<h3>계좌이체</h3>
		</div>
		<div class="col-md-6">
			<address>
				 <strong>입금하실곳</strong>: <abbr title="account">농협: </abbr>111-1111-111111(대표 용팔이)<br> 
			</address>
			<span style="background-color:orange;">
				 &nbsp;&nbsp;결제자 송금 은행: <span></span>
				 &nbsp;&nbsp;결제자 전화번호: <span>${memberVo.member_pno}</span>
				 &nbsp;&nbsp;결제자 성함: <span>${memberVo.member_name}</span>
			</span>
		</div>
		<div class="col-md-2">
		</div>
	</div>
	<!-- hr -->
	<div class="row" style="margin-top:10px;" style="display:none;" id="hr">
		<div class="col-md-2"></div>
		<div class="col-md-8"><hr></div>
	</div>
	
	<!-- 배송지 정보입력 -->
	<div class="row" style="margin-top:20px;" style="display:none;" id="divAddr">
		<div class="col-md-2">
		</div>
		<div class="col-md-2">
			<h3>배송지 정보입력</h3>
		</div>
		<div class="col-md-6">
			<form role="form">
				<div style="text-align:start"> 
					<label for="sameUserInfo2" style="user-select:none">
						<input type="checkbox" id="sameUserInfo2">회원정보와 동일
					</label><br>
				</div>
				<div class="form-group" style="margin-top:10px;">
					<label for="addr1">주소1</label>
					<input type="text" class="form-control" id="recipientAddr1"/>
				</div>
				<div class="form-group">
					<label for="addr2">주소2</label>
					<input type="text" class="form-control" id="recipientAddr2"/>
				</div>
				<button type="button" class="btn btn-primary" id="btnPay">결제하기</button>
			</form>
		</div>
		<div class="col-md-2">
		</div>
	</div>
</div>
	
	
	
<%@ include file="/WEB-INF/views/mj/include/footer.jsp" %>
	