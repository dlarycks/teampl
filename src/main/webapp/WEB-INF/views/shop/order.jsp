<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
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

<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
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
		requestPay();
	});
	
    /** 결제 **/
    // 결제 금액, 구매자의 이름, 이메일
    const priceAmount = "${orderDto.total_price}";
    const buyerMemberEmail = "${memberVo.member_email}";
    const buyerMemberName = "${memberVo.member_name}";
    const IMP = window.IMP;
    IMP.init("/* !! 본인의 가맹점 식별코드 !! */");

    function requestPay() {
        // IMP.request_pay(param, callback) 결제창 호출
        IMP.request_pay({ // param
            pg: "kakaopay.TC0ONETIME",
            pay_method: "card",
            merchant_uid: 'cart_' + new Date().getTime(),
            name: "TEST 컴퓨터 완본체",
            amount: priceAmount,
            buyer_email: buyerMemberEmail,
            buyer_name: buyerMemberName,
        }, function (rsp) {
        	// callback
       		$.ajax({
                type: "POST",
                url: "/verifyIamport/" + rsp.imp_uid
            }).done(function(result) {
            	
            	if(rsp.paid_amount == result.response.amount) {
					alert("결제금액: " + setCommas(result.response.amount) + "원");
	                alert("결제가 완료되었습니다.");
	                paySuccess();
            	} else {
            		alert("결제에 실패했습니다. 에러코드 : " + rsp.error_code + "에러 메시지 : " + rsp.error_message);
            	}
            });
        }); //callback
    }
    
   	function paySuccess() {
		var order_content = "${orderDto.order_cpu_name}, ${orderDto.order_mb_name}";
		order_content += "${orderDto.order_ram_name}, ${orderDto.order_vga_name}";
		order_content += "${orderDto.order_power_name}, ${orderDto.order_case_name}, ${orderDto.order_ssd_name}";
		/* 추가 : 결제 상세정보가 추가되면 아래 form을(+dto) 수정하자 */
		$("#order_content").val(order_content);
		$("#order_price").val("${orderDto.total_price}");
		$("#frmPayment").submit();
   	} 
    
});

</script>
<!-- 주문용 hidden form -->
<form id="frmPayment" action="/shop/payment" method="post">
	<!-- for TBL_ORDER -->
	<input type="hidden" name="order_content" id="order_content">
	<input type="hidden" name="order_price" id="order_price">
	<!-- for TBL_ORDER_DETAIL -->
	<input type="hidden" name="member_no" value="${memberVo.member_no}">
	<input type="hidden" name="order_cpu" value="${orderDetailVo.order_cpu}">
	<input type="hidden" name="order_mb" value="${orderDetailVo.order_mb}">
	<input type="hidden" name="order_ram" value="${orderDetailVo.order_ram}">
	<input type="hidden" name="order_vga" value="${orderDetailVo.order_vga}">
	<input type="hidden" name="order_power" value="${orderDetailVo.order_power}">
	<input type="hidden" name="order_case" value="${orderDetailVo.order_case}">
	<input type="hidden" name="order_ssd" value="${orderDetailVo.order_ssd}">
</form>
<div class="container-fluid">
	<div class="row mt-5">
		<div class="col-md-2">
		</div>
		<!-- 시작 -->
		<div class="col-md-8 ml-5">
			<div class="row">
			
	          	<!-- 장바구니(오른쪽) -->
				<div class="col-md-4 order-md-2 mb-4">
					<h4 class="d-flex justify-content-between align-items-center mb-3">
			            <span class="text-muted">장바구니</span>
			            <span class="badge badge-secondary badge-pill">7</span>
		          	</h4>
		          	<ul class="list-group mb-3">
		            	<li class="list-group-item d-flex justify-content-between lh-condensed">
		              		<div>       		
		              			<h6 class="my-0">CPU</h6>
		                		<small class="text-muted">${orderDto.order_cpu_name}</small>
		              		</div>
		              		<span class="text-muted">₩ ${orderDto.order_cpu_price}</span>
		            	</li>
		            	<li class="list-group-item d-flex justify-content-between lh-condensed">
		              		<div>
		                		<h6 class="my-0">MB</h6>
		                		<small class="text-muted">${orderDto.order_mb_name}</small>
		              		</div>
		              		<span class="text-muted">₩ ${orderDto.order_mb_price}</span>
		            	</li>
		            	<li class="list-group-item d-flex justify-content-between lh-condensed">
		              		<div>
		                		<h6 class="my-0">RAM</h6>
		                		<small class="text-muted">${orderDto.order_ram_name}</small>
		              		</div>
		              		<span class="text-muted">₩ ${orderDto.order_ram_price}</span>
		            	</li>
		            	<li class="list-group-item d-flex justify-content-between lh-condensed">
		              		<div>
		                		<h6 class="my-0">VGA</h6>
		                		<small class="text-muted">${orderDto.order_vga_name}</small>
		              		</div>
		              		<span class="text-muted">₩ ${orderDto.order_vga_price}</span>
		            	</li>
		            	<li class="list-group-item d-flex justify-content-between lh-condensed">
		              		<div>
		                		<h6 class="my-0">POWER</h6>
		                		<small class="text-muted">${orderDto.order_power_name}</small>
		              		</div>
		              		<span class="text-muted">₩ ${orderDto.order_power_price}</span>
		            	</li>
		            	<li class="list-group-item d-flex justify-content-between lh-condensed">
		              		<div>
		                		<h6 class="my-0">CASE</h6>
		                		<small class="text-muted">${orderDto.order_case_name}</small>
		              		</div>
		              		<span class="text-muted">₩ ${orderDto.order_case_price}</span>
		            	</li>
		            	<li class="list-group-item d-flex justify-content-between lh-condensed">
		              		<div>
		                		<h6 class="my-0">SSD</h6>
		                		<small class="text-muted">${orderDto.order_ssd_name}</small>
		              		</div>
		              		<span class="text-muted">₩ ${orderDto.order_ssd_price}</span>
		            	</li>
		            	<li class="list-group-item d-flex justify-content-between bg-light">
		              		<div class="text-success">
		                		<h6 class="my-0">배송비</h6>
		                		<small>무료배송</small>
		              		</div>
		              		<span class="text-success">₩ 0</span>
		            	</li>
		            	<li class="list-group-item d-flex justify-content-between">
		              		<span>총합 (KRW)</span>
		              		<strong id="infoTotalPrice">₩ </strong>
		            	</li>
		       		</ul>
					<!-- 결제버튼 -->
					<button style="width:100%; height:50px;" class="btn btn-danger btn-large" id="btnPay">
						결제하기
					</button>
				</div>
				
				<!-- 결제 정보(왼쪽) -->
				<div class="col-md-8 order-md-1">
					<!-- 회원정보 -->
					<div class="row" style="margin-top:20px;">
						<div class="col-md-6">
							<h4>회원정보</h4>
							<div class="input-group mb-3" style="margin-top:10px;">
								<div class="input-group-prepend">
									<span class="input-group-text">이름</span>
								</div>
								<input type="text" class="form-control" aria-describedby="basic-addon3" value="${memberVo.member_name}" required>
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text">이메일</span>
								</div>
								<input type="text" class="form-control" aria-describedby="basic-addon3" value="${memberVo.member_email}" required>
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text">전화번호</span>
								</div>
								<input type="text" class="form-control" aria-describedby="basic-addon3" value="${memberVo.member_pno}" required>
							</div>
						</div>
					</div><!-- 회원정보 row -->
					<hr>
					<!-- 결제방식 선택 -->
					<div class="mb-3" style="margin-top:10px;">
		        		<h4>결제방식 선택</h4>
		        		<div style="margin-top:10px;">
				           	<button type="button" class="btn btn-mine" id="btnCredit"><strong>신용카드</strong></button> 
							<button type="button" class="btn btn-mine" id="btnAccount"><strong>계좌이체</strong></button>
						</div> 
			       	</div>
					<hr>
			       	<!-- 신용카드 선택 시 나타남 -->
					<div class="mb-3" style="margin-top:10px; display:none;" id="divCredit">
		        		<h3>신용카드</h3>
		        		<small class="text-muted">결제정보 입력</small>
						<!-- 체크박스 : 회원정보와 동일 -->
						<div style="text-align:start; margin-top:15px;">
							<label for="sameUserInfo" style="user-select:none">
								<input type="checkbox" id="sameUserInfo">회원정보와 동일
							</label><br>
						</div>
						<!-- 결제자 성함, 결제자 이메일, 결제자 전화번호 -->
						<div class="row" style="margin-top:10px;">
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
	       			
	       			<!-- 계좌이체 선택 시 나타남 -->
					<div class="mb-3" style="margin-top:10px; display:none;" id="divAccount">
						<h3>계좌이체</h3>
						<address>
							 <strong>입금하실곳</strong>: <abbr title="account">농협: </abbr>111-1111-111111(대표 용팔이)<br> 
						</address>
						
						<div style="background-color:orange;">
							<div class="input-group mb-3">
								<span>&nbsp;&nbsp;결제자 이름:&nbsp;</span>
								<div class="input-group-append">
									<input type="text" class="form-control" placeholder="결제자 이름" aria-describedby="basic-addon1">
								</div>
							</div>
							<div class="input-group mb-3">
								<span>&nbsp;&nbsp;결제자 전화번호:&nbsp;</span>
								<div class="input-group-append">
									<input type="text" class="form-control" placeholder="결제자 전화번호" aria-describedby="basic-addon1">
								</div>
							</div>
							<div class="input-group mb-3">
								<div class="input-group-append">
									<span>&nbsp;&nbsp;입금 계좌번호:&nbsp;</span>
								</div>
								<div>
									<select class="btn btn-outline-secondary">
								    	<option>농협</option>
								    	<option>신한</option>
								    	<option>KB</option>
								    </select>
								</div>
								<div class="input-group-append">
									<input type="text" class="form-control" placeholder="입금 계좌번호" aria-describedby="basic-addon1">
								</div>
							</div>
						</div>
					</div>
					
					<!-- 배송지 정보입력 -->
					<div class="row" style="margin-top:20px;" style="display:none;" id="divAddr">
						<div class="col-md-8">
							<h3>배송지 정보입력</h3>
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
							</form>
						</div>
					</div> <!-- 배송지 정보입력 -->
				</div> <!-- 결제 정보(왼쪽) -->
			</div> <!-- inner row -->
		</div> <!-- col-md-9(wrap) -->
		
		<div class="col-md-2">
		</div> <!-- col-md-1 -->
		
	</div><!-- row -->
</div><!-- container-fluid -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	