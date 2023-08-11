<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/mj/include/header.jsp" %>
<style>
#inputSearcher {
  width: 100%;
  border: 1px solid #bbb;
  border-radius: 8px;
  padding: 10px 12px;
  font-size: 14px;
}
#product_list > .list-group-item > img {
	float:left;
}
@keyframes list_item_hover {
	from {background-color: white;}
	to {background-color: #E5E5E5;}
}
#my_list > .my-list-item:hover {
	cursor:pointer;
	animation-name: list_item_hover;
	animation-duration: 0.8s;
}
.listClone:hover {
	cursor:pointer;
	animation-name: list_item_hover;
	animation-duration: 0.8s;
}
#my_list > .list-group-item > img {
	float:left;
}
#my_list > .list-group-item > .product_detail {
	margin-top:10px;	
}
.list_menu {
	background-color:#343434;
	color:white;
}
.table {
	width:auto;
	height:100%;
}
</style>
<script>
$(function(){
	const INDEX_TOTAL_PRICE = 7;
	/* 1000자리마다 콤마 찍기*/
	function setCommas(number) {
	    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	/* 콤마 제거 */
	function fullPriceToInt(number_won){
		var endstr = number_won.slice(-1);
		if (endstr == "원") {
		    return number_won.slice(0, -1).replace(/,/g, "");
		} else {
			return number_won.replace(/,/g, "");
		}
	}
	/* 이름 검색 */
	$("#inputSearcher").keyup(function(){
		$("#product_list > .listClone").hide();
		var searchText = $(this).val();
		var temp = $("#product_list > .listClone > .search_name:contains('" + searchText + "')");
		$(temp).parent().show();
	});
	
	/* 나의 부품 클릭 시 왼쪽에 상품목록 출력 */
	$("#my_list > .my-list-item").click(function(){
		
		$("#product_list").find(".listClone").remove();
		var keyword = $(this).attr("data-keyword");
		var url = "/shop/productList";
		var sData = {
				"category_key" : keyword
		};
		$.get(url, sData, function(rData){
			
			$.each(rData, function(index, productVo){
				var div = $("#listClone").clone();
				div.removeAttr("id");
				div.addClass("listClone");
				var imgsrc = "/mj/images/default.png"
				var inner = "<img src='" + imgsrc + "'><br>";
					inner += "<div class='product_detail'>" + productVo.product_manufacturer + "</div>";
					inner += "<div class='product_detail search_name'>" + productVo.product_name + "</div>";
					inner += "<div class='product_detail'>" + setCommas(productVo.product_price) + "원</div>";
					inner += "<div class='d-none'>" + productVo.product_no + "</div>";
					inner += "<div class='d-none'>" + productVo.product_category + "</div>";
					inner += "<div class='d-none'>" + toDateString(productVo.product_releasedate) + "</div>";
				div.html(inner).fadeIn(600);
				$("#product_list").append(div);
			});
			$("#list_menu_header").text(rData[0].product_category);
			var a = $("#goUp");
			a.fadeIn(600);
			$("#product_list").append(a);
			$("#list_menu_header").focus();
		});
	});
	
	/* 상품목록 클릭 시 내쪽으로 이동 */
	$("#product_list").on("click", ".listClone", function(){
		
		var product_no = $(this).find("div:eq(3)").text();
		var product_price = $(this).find("div:eq(2)").text();
		var product_name = $(this).find("div:eq(1)").text();
		var product_manufacturer = $(this).find("div:eq(0)").text();
		var product_category = $(this).find("div:eq(4)").text();
		var product_releasedate = $(this).find("div:eq(5)").text();
		var category = $("#list_menu_header").text();
		
		// 총 뱃지 개수 변화
		var isInput = $("#" + category).text();
		if (isInput == "") {
			var total_badge_count = parseInt($("#my_list_badge").text());
			$("#my_list_badge").text(total_badge_count + 1);
			$("#" + category).parent().prev().prev().text("1"); // 선택한 부품 뱃지(카운트)를 1로 만듦 
		}
		
		// 내 부품항목으로 테이블 넣기
		var tr = "<tr><td class='my-pno'>상품번호: " + product_no + "</td><td class='my-price'>가격: " + product_price + "</td></tr>";
			tr += "<tr><td class='my-pname'>이름: " + product_name + "</td><td>제조사: " + product_manufacturer + "</td></tr>";
			tr += "<tr><td>항목: " + product_category + "</td><td>출시일: " + product_releasedate + "</td></tr>";
		$("#" + category).html(tr); // table에 tr넣기
// 		$("#" + category).parent().parent().next().focus(); // 내 리스트에 포커스 ( 안됨 )
// 		$("#" + category).parent().parent().next().next().focus();
		
		// 총 가격 변화
		var total_price = 0;
		var price_list = $("#my_list").find(".my-price");
		$.each(price_list, function(index, td){
			var price_text = $(td).text();
			var price = fullPriceToInt(price_text.substr(price_text.indexOf(":") + 2));
			total_price += parseInt(price);
		});
		$("#my_total_price").text(setCommas(total_price));
	});
	// 위쪽으로 가기
	$("#goUp").click(function(e){
		e.preventDefault();
		$("#list_menu_header").focus();
	});
	// 결제하기
	$("#btnOrder").click(function(){
		// 전송 form에 product_no 넣기
		var pnoList = $("#my_list").find(".my-pno");
		if (pnoList.length != 7) {
			var offset = $("#divAlert").offset();
			$("html").animate({scrollTop : offset.top}, 400);
			
			$("#divAlert").addClass("alert alert-warning form-control").text("부품을 모두 골라 주세요.");
			// 잠시 뒤에 경고창 사라지게?
			return;
		}
		$.each(pnoList, function(index, td){
			var pno = $(td).text().slice(-6);
			$("#frmOrder").find(".order_no").eq(index).val(pno);
		});
		// 전송 form에 product_name 넣기
		var pnameList = $("#my_list").find(".my-pname");
		$.each(pnameList, function(index, td){
			var pname = $(td).text().substr(4);
			$("#frmOrder").find(".order_name").eq(index).val(pname);
		});
		// total_price 넣기
		var total_price = fullPriceToInt($("#my_total_price").text());
		$("#frmOrder").find(".order_name").eq(INDEX_TOTAL_PRICE).val(total_price);
		// 전송		
		$("#frmOrder").submit();
	});
});
</script>
<!-- hidden form -->
<form id="frmOrder" action="/shop/order" method="post">
	<!-- OrderVo (number) -->
	<input type="hidden" class="order_no" name="order_cpu">
	<input type="hidden" class="order_no" name="order_mb">
	<input type="hidden" class="order_no" name="order_ram">
	<input type="hidden" class="order_no" name="order_vga">
	<input type="hidden" class="order_no" name="order_power">
	<input type="hidden" class="order_no" name="order_case">
	<input type="hidden" class="order_no" name="order_ssd">
	<!-- OrderDto (name, totalPrice) -->
	<input type="hidden" class="order_name" name="order_cpu_name">
	<input type="hidden" class="order_name" name="order_mb_name">
	<input type="hidden" class="order_name" name="order_ram_name">
	<input type="hidden" class="order_name" name="order_vga_name">
	<input type="hidden" class="order_name" name="order_power_name">
	<input type="hidden" class="order_name" name="order_case_name">
	<input type="hidden" class="order_name" name="order_ssd_name">
	<input type="hidden" class="order_name" name="total_price">
</form>
<!-- wrap -->
<div class="container-fluid">
	<div class="row">
		<!-- 빈칸 (12 : 2) -->
		<div class="col-md-2"></div>
		
		<!-- 상품목록 전체(12 : 3) -->
		<div class="col-md-3">
			<div style="height:50px;">
			</div>
			<!-- 검색창 -->
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<input type="text" class="form-control" placeholder="검색하기" id="inputSearcher">
					<i class="fa fa-sort" aria-hidden="true" style="margin:auto;"></i>
				</div>
			</div>
			<!-- 상품목록(product_list) -->
			<div id="product_list" class="list-group">
				
				<!-- 상품목록 헤더 -->
				<a href="#" class="list-group-item list-group-item-action list_menu"
					id="list_menu_header">상품을 선택해 주세요.</a>
				
				<!-- 나의 부품 클릭시 상품이 나올 자리입니다. -->
				<div class="list-group-item" id="listClone" style="display:none;">
					<!-- 예시 -->
<!-- 				<img src="/mj/images/default.png"><br> -->
<!-- 				<div class="product_detail">INTEL</div> -->
<!-- 				<div class="product_detail">i7-10000</div> -->
				</div>
				<a href="" class="list-group-item list-group-item-action list_menu" 
					style="display:none;" id="goUp">위쪽으로 가기</a>
			</div>
		</div>
		
		<!-- 나의 상품 전체(12 : 5) -->
		<div class="col-md-5">
			<!-- 견적마법사 -->
			<div style="display:flex;">
				<a style="margin-left:auto;">
					<img src="/mj/images/s_magic-stick-icon.jpg" alt="마법봉">
					<button class="btn btn-info">견적마법사</button>
				</a>
			</div>
			<!-- 경고창 메세지 : 부품을 모두 골라 주세요. -->
			<div role="alert" style="height:50px;" id="divAlert">
			</div>
			<!-- 나의 부품 리스트(my_list) -->
			<div id="my_list" class="list-group" style="margin-top:15px;">
				<div class="list-group-item list-group-item-action list_menu">부품 리스트</div>
				<!-- Table for clone -->
<!-- 				<table> -->
<!-- 					<tr id="trClone"></tr> -->
<!-- 				</table> -->
				<!-- cpu -->
				<div class="list-group-item my-list-item" data-keyword="1">
					<img src="/mj/images/cpu.png"> CPU &nbsp;<span class="badge badge-secondary badge-pill">0</span><br>
					<div class="product_detail">
						<!-- 상세 테이블 예시 (JavaScript로 삽입) -->
						<table id="CPU" class="table-responsive-sm"></table>
					</div>
				</div>
				<!-- 메인보드 -->
				<div class="list-group-item my-list-item" data-keyword="2">
					<img src="/mj/images/mb.png">메인보드 &nbsp;<span class="badge badge-secondary badge-pill">0</span><br>
					<div class="product_detail">
						<!-- 상세 테이블이 나올 자리입니다. -->
						<table id="MB" class="table-responsive-sm"></table>
					</div>
				</div>
				<!-- RAM -->
				<div class="list-group-item my-list-item" data-keyword="3">
					<img src="/mj/images/ram.png"> RAM &nbsp;<span class="badge badge-secondary badge-pill">0</span><br>
					<div class="product_detail">
						<!-- 상세 테이블이 나올 자리입니다. -->
						<table id="RAM" class="table-responsive-sm"></table>
					</div>
				</div>
				<!-- 그래픽카드 -->
				<div class="list-group-item my-list-item" data-keyword="4">
					<img src="/mj/images/vga.png"> 그래픽카드 &nbsp;<span class="badge badge-secondary badge-pill">0</span><br>
					<div class="product_detail">
						<!-- 상세 테이블이 나올 자리입니다. -->
						<table id="VGA" class="table-responsive-sm"></table>
					</div>
				</div>
				<!-- 파워 -->
				<div class="list-group-item my-list-item" data-keyword="5">
					<img src="/mj/images/power.png"> 파워 &nbsp;<span class="badge badge-secondary badge-pill">0</span><br>
					<div class="product_detail">
						<!-- 상세 테이블이 나올 자리입니다. -->
						<table id="POWER" class="table-responsive-sm"></table>
					</div>
				</div>
				<!-- 케이스 -->
				<div class="list-group-item my-list-item" data-keyword="6">
					<img src="/mj/images/case.png"> 케이스 &nbsp;<span class="badge badge-secondary badge-pill">0</span><br>
					<div class="product_detail">
						<!-- 상세 테이블이 나올 자리입니다. -->
						<table id="CASE" class="table-responsive-sm"></table>
					</div>
				</div>
				<!-- SSD -->
				<div class="list-group-item my-list-item" data-keyword="7">
					<img src="/mj/images/ssd.png"> SSD &nbsp;<span class="badge badge-secondary badge-pill"></span><br>
					<div class="product_detail">
						<!-- 상세 테이블이 나올 자리입니다. -->
						<table id="SSD" class="table-responsive-sm"></table>
					</div>
				</div>
				<!-- 총가격(my_list_badge) -->
				<div class="list-group-item list-group-item-action list_menu" style="font-size:20px; text-align:center;">
					총 가격 : <span id="my_total_price">0</span>원
					<span class="badge badge-light badge-pill" id="my_list_badge">0</span>
				</div>
			</div>
		</div>
		<!-- 빈칸 (12 : 2) -->
		<div class="col-md-2">
		</div>
	</div>
	<!-- 결제버튼 -->
	<div class="row">
		<div class="col-md-5">
		</div>
		<div class="col-md-5">
			<div style="display:flex;">
				<!-- 결제버튼(btnOrder) -->
				<button type="button" class="btn btn-large btn-danger" 
					style="margin-top:10px; width:100%; height:50px;" id="btnOrder">
					결제하기
				</button>
			</div>
		</div>
		<div class="col-md-2">
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/mj/include/footer.jsp" %>