<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
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
.btn-finish {
	margin-top:10px;
	width:100%;
	height:50px;
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
	
	/*******************************************************************
 		추 가 된 부 분 입 니 다 아 아 아아아아아아아아
		호환성 체크 비동기 전송
	******************************************************************/
	$("#btnCompability").click(function() {
		
		var pnoList = $("#my_list").find(".my-pno");
		if (pnoList.length != 7) {
			showAlert();
			return;
		}
		$("#modal-489780").trigger("click");
		
		var url = "/check/compability";
		var regex = /[^0-9]/g; //0~9까지 모든 숫자
		var product_no = $(".my-pno").text().replace(regex, ""); //문자열("")을 regex로 대체한다.
		var seperation = product_no.toString().replace(/\B(?<!\.\d*)(?=(\d{6})+(?!\d))/g, ",");
		var seperationSplit = seperation.split(",");

		var first = seperationSplit[0];
		var second = seperationSplit[1];
		var third = seperationSplit[2];
		var fourth = seperationSplit[3];
		var fifth = seperationSplit[4];
		var sixth = seperationSplit[5];
		var seventh = seperationSplit[6];
		var sData = {
			"cpu_product_no" : first,
			"mb_product_no" : second,
			"ram_product_no" : third,
			"vga_product_no" : fourth,
			"power_product_no" : fifth,
			"case_product_no" : sixth,
			"ssd_product_no" : seventh
		};
		
		$.post(url, sData, function(rData){
			
			$("#card_list").empty();
			var src = "";
			for(var key in rData) {
				
				var names = key.split("_"); // 배열
				var li;
				
				if (rData[key] == true) {
					li = $("#ul_li").find("li:eq(0)").clone();
					li.find(".tit").eq(0).text(names[0]);
					li.find(".tit").eq(1).text(names[1]);
					li.find(".txt").text("호환성공");
					li.find("p").text("호환 가능 합니다.");
					li.find(".img_result").attr("src", "/images/checkSuccess.png");
				} else {
					li = $("#ul_li").find("li:eq(0)").clone();
					li.find(".tit").eq(0).text(names[0]);
					li.find(".tit").eq(1).text(names[1]);
					li.find(".txt").css("color", "red");
					li.find(".txt").text("호환실패");
					li.find("p").css("color", "red");
					li.find("p").text("호환 되지 않습니다.")
					li.find(".img_result").attr("src", "/images/checkFail.png");
				} //if
				$("#card_list").append(li);
			}
		}); //$.post
	});
	
	/*******************************************************************
		추 가 된 부 분 입 니 다 아 아 아아아아아아아아
		호환성 체크 비동기 전송  
		-------------끝-----------
	******************************************************************/
	
	/* 이름 검색 */
	$("#inputSearcher").keyup(function(){
		$("#product_list > .listClone").hide();
		var searchText = $(this).val().toUpperCase(); // 대,소문자 구분을 없애기 위해 검색텍스트와 상품명을 모두 대문자로 만듦 
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
				var imgsrc = "/images/product/" + productVo.product_no + ".webp";
				if (productVo.product_name == "") {
					imgsrc = "/images/default.png"
				}
				var inner = "<img style='width:100px; height:100px;' src='" + imgsrc + "'><br>";
					inner += "<div class='product_detail'>" + productVo.product_manufacturer + "</div>";
					inner += "<div class='product_detail'>" + productVo.product_name + "</div>";
					inner += "<span class='search_name' style='display:none;'>" + productVo.product_name.toUpperCase() + "</span>";
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
		var tr =  "<tr><td class='my-pno'>상품번호: " + product_no + "</td><td class='my-price'>가격: " + product_price + "</td></tr>";
			tr += "<tr><td class='my-pname'>이름: " + product_name + "</td><td>제조사: " + product_manufacturer + "</td></tr>";
			tr += "<tr><td>항목: " + product_category + "</td><td>출시일: " + product_releasedate + "</td></tr>";
		$("#" + category).html(tr); // table에 tr넣기
// 		$("#" + category).focus(); // 내 리스트에 포커스
		
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
		/* 전송 form 작업 */
		// 상품번호 7개넣기
		var pnoList = $("#my_list").find(".my-pno");
		if (pnoList.length != 7) {
			showAlert();
			return;
		}
		$.each(pnoList, function(index, td){
			var pno = $(td).text().slice(-6);
			$("#frmOrder").find(".order_no").eq(index).val(pno);
		});
		// 상품 이름 7개 넣기
		var pnameList = $("#my_list").find(".my-pname");
		$.each(pnameList, function(index, td){
			var pname = $(td).text().substr(4);
			$("#frmOrder").find(".order_name").eq(index).val(pname);
		});
		// 상품 가격 7개 넣기
		var priceList = $("#my_list").find(".my-price");
		$.each(priceList, function(index, td){
			var price = fullPriceToInt($(td).text().substr(4));
			$("#frmOrder").find(".order_price").eq(index).val(price);
		});
		// 총 가격 넣기
		var total_price = fullPriceToInt($("#my_total_price").text());
		$("#frmOrder").find(".order_price").eq(INDEX_TOTAL_PRICE).val(total_price);
		
		$("#frmOrder").submit();
	});
	// 경고창 보이기
	function showAlert() {
		var offset = $("#divAlert").offset();
		$("html").animate({scrollTop : offset.top}, 400);
		$("#divAlert").addClass("alert alert-warning form-control").text("부품을 모두 골라 주세요.");
	}
	
	// 추천목록 7개 받아오기
	var wizard_no = "${wizard_no}";
	if (wizard_no != "") {
		getRecommend(wizard_no);
	}
	
	function getRecommend(wizard_no) {
		
		var url = "/shop/recommend?wizard_no=" + wizard_no;
		var totalPrice = 0;
		
		$.getJSON(url, function(rData) {
			
			$.each(rData, function(index, vo) {
				var tr =  "<tr><td class='my-pno'>상품번호: " + vo.product_no + "</td><td class='my-price'>가격: " + setCommas(vo.product_price) + "</td></tr>";
				tr += "<tr><td class='my-pname'>이름: " + vo.product_name + "</td><td>제조사: " + vo.product_manufacturer + "</td></tr>";
				tr += "<tr><td>항목: " + vo.product_category + "</td><td>출시일: " + toDateString(vo.product_releasedate) + "</td></tr>";
				totalPrice += parseInt(vo.product_price);
				$("#" + vo.product_category).html(tr); // table에 tr넣기
			});
			$("#my_total_price").text(setCommas(totalPrice));
		});
		
		var badgeList = $("#my_list").find(".badge");
		for (var v = 0; v < 7; v++) {
			$(badgeList[v]).text("1");
		}
		$(badgeList[7]).text("7");
	} // getProductInfo
	
}); 
</script>
<!-- hidden form (for submit) -->
<form id="frmOrder" action="/shop/order" method="post">
	<!-- OrderDetailVo (number) -->
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
	
	<input type="hidden" class="order_price" name="order_cpu_price">
	<input type="hidden" class="order_price" name="order_mb_price">
	<input type="hidden" class="order_price" name="order_ram_price">
	<input type="hidden" class="order_price" name="order_vga_price">
	<input type="hidden" class="order_price" name="order_power_price">
	<input type="hidden" class="order_price" name="order_case_price">
	<input type="hidden" class="order_price" name="order_ssd_price">
	<input type="hidden" class="order_price" name="total_price">
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
<!-- 				<img src="/images/default.png"><br> -->
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
				<a style="margin-left:auto; text-decoration:none;" href="/shop/wizard">
					<img src="/images/s_magic-stick-icon.jpg" alt="마법봉">
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
					<img src="/images/cpu.png"> CPU &nbsp;<span class="badge badge-secondary badge-pill">0</span><br>
					<div class="product_detail">
						<!-- 상세 테이블 예시 (JavaScript로 삽입) -->
						<table id="CPU" class="table-responsive-sm"></table>
					</div>
				</div>
				<!-- 메인보드 -->
				<div class="list-group-item my-list-item" data-keyword="2">
					<img src="/images/mb.png">메인보드 &nbsp;<span class="badge badge-secondary badge-pill">0</span><br>
					<div class="product_detail">
						<!-- 상세 테이블이 나올 자리입니다. -->
						<table id="MB" class="table-responsive-sm"></table>
					</div>
				</div>
				<!-- RAM -->
				<div class="list-group-item my-list-item" data-keyword="3">
					<img src="/images/ram.png"> RAM &nbsp;<span class="badge badge-secondary badge-pill">0</span><br>
					<div class="product_detail">
						<!-- 상세 테이블이 나올 자리입니다. -->
						<table id="RAM" class="table-responsive-sm"></table>
					</div>
				</div>
				<!-- 그래픽카드 -->
				<div class="list-group-item my-list-item" data-keyword="4">
					<img src="/images/vga.png"> 그래픽카드 &nbsp;<span class="badge badge-secondary badge-pill">0</span><br>
					<div class="product_detail">
						<!-- 상세 테이블이 나올 자리입니다. -->
						<table id="VGA" class="table-responsive-sm"></table>
					</div>
				</div>
				<!-- 파워 -->
				<div class="list-group-item my-list-item" data-keyword="5">
					<img src="/images/power.png"> 파워 &nbsp;<span class="badge badge-secondary badge-pill">0</span><br>
					<div class="product_detail">
						<!-- 상세 테이블이 나올 자리입니다. -->
						<table id="POWER" class="table-responsive-sm"></table>
					</div>
				</div>
				<!-- 케이스 -->
				<div class="list-group-item my-list-item" data-keyword="6">
					<img src="/images/case.png"> 케이스 &nbsp;<span class="badge badge-secondary badge-pill">0</span><br>
					<div class="product_detail">
						<!-- 상세 테이블이 나올 자리입니다. -->
						<table id="CASE" class="table-responsive-sm"></table>
					</div>
				</div>
				<!-- SSD -->
				<div class="list-group-item my-list-item" data-keyword="7">
					<img src="/images/ssd.png"> SSD &nbsp;<span class="badge badge-secondary badge-pill"></span><br>
					<div class="product_detail">
						<!-- 상세 테이블이 나올 자리입니다. -->
						<table id="SSD" class="table-responsive-sm"></table>
					</div>
				</div>
				<!-- 총가격(my_list_badge) -->
				<div class="list-group-item list-group-item-action list_menu" style="font-size:20px; text-align:center;">
					총 가격 : <span id="my_total_price">0</span>원
					<span class="badge bg-dark text-white ms-1 rounded-pill" id="my_list_badge">0</span>
				</div>
				<!-- 결제버튼 -->
				<div class="row">
					<div class="col-md-4">
						<button class="btn btn-large btn-info btn-finish" id="btnCompability">
							호환성 검사
						</button>
					</div>
					<div class="col-md-8">
						<!-- 결제버튼(btnOrder) -->
						<button type="button" class="btn btn-large btn-danger btn-finish" id="btnOrder">
							결제하기
						</button>
					</div>
				</div>
			</div><!-- 나의 부품 리스트(my_list) -->
		</div>
		<!-- 빈칸 (12 : 2) -->
		<div class="col-md-2">
		</div>
	</div><!-- row -->
</div><!-- container -->



<!-------------추 가 된 부 분 입 니 다 아 아 아아아아아아아아 ------------>
<!-------------------	숨긴 ul   ------------------->
	<ul id="ul_li" style="display:none;">
		<li class="card_item success">
			<div class="ico_card">
				<i><img class="img_result"/></i><br>
				<span class="txt"></span>
			</div>
			<div class="cate_list">
				<span class="tit"></span> <span class="tit"></span>
			</div>
			<div class="comp_desc">
				<p class="desc_p">
					<strong>test</strong>
				</p>
			</div>
		</li>
	</ul>
<!------------------------------ 숨긴 ul 끝----------------------------->

<!-------------------------------------------------
	 						호환성 검사 모달 
	 ---------------------------------------------------->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-5"></div>
		<div class="col-md-5">
			<a id="modal-489780" href="#modal-container-489780" role="button"
				class="btn btn-large btn-primary" data-toggle="modal" style="display:none;"></a>
			<div class="modal fade" id="modal-container-489780" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="myModalLabel">호환성 체크</h5>
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">
						<!----------------------------------------- 
										바-----디 
						---------------------------------------------->
							<div class="container-fluid">
								<div class="row">
									<div class="col-md-12">
										<div class="tabbable" id="tabs-197497">
											<ul class="nav nav-tabs">
												<li class="nav-item"><a class="nav-link active"
													href="#tab1" data-toggle="tab">호환성 체크</a></li>
												<li class="nav-item"><a class="nav-link" href="#tab2"
													data-toggle="tab">호환성 체크 안내</a></li>
											</ul>
											<div class="tab-content">
												<div class="tab-pane active" id="tab1">
													<p>＊호환성 체크는 CPU, 메인보드, 메모리, 케이스 그래픽카드, 파워를 대사응로 합니다.</p>
													<p>＊본 서비스는 제조사의 상품정보를 기반으로 제공되며, 일부 상품의 경우 호환성 체크대상에서
														제외됩니다.</p>
													<p>＊호환 성공 여부는 단순 참고용이며, 자세한 내요은 판매점 또는 제조사에 재확인이 필요할
														수 있습니다.</p>
													<div>
														<ul id="card_list">
														<!-----------------
															cpu, ram
														------------------->
														<!-- 성공 시 출력 할 카드 -->
														</ul>
													</div>
												</div>
												<div class="tab-pane" id="tab2">
													<p>＊CPU, 메인보드, 메모리, 케이스, 그래픽카드, 파워를 대상으로 합니다.</p>
													<p>＊카테고리별로 상품을 1개씩만 담을 때만 호환성 체크가 가능합니다.</p>
													<p>＊출시일이 오래된 상품 또는 특수 상품의 경우 호환성 체크 대상에서 제외될 수 있습니다.</p>
													<h5>＊호환성 비교 체크 카테고리 및 옵션 안내</h5>
													<img src="/images/check.png" alt="check">
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>