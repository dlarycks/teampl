<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- BootStrap CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- myscript.js -->
<script src="/js/myscript.js"></script>

<style>
p {
	text-align: center;
}

h2 {
	text-align: center;
}

.item {
	background-color: orange;
	margin: auto;
}

.container {
	place-items: center start;
	display: grid;
	grid-template-columns: 1fr 1fr 1.1fr;
	grid-template-rows: 1fr 1fr 1fr;
	gap: 50px 50px;
	grid-auto-flow: row;
	grid-template-areas: "A B C" "D E F" "G H I";
}

.container4 {
  display: grid; 
  grid-template-columns: 1fr 1fr 1.1fr; 
  grid-template-rows: 1fr; 
  gap: 50px 50px; 
  grid-template-areas: 
    "A B C"; 
}

.wrap {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.btn4 {
	margin: auto;
}
</style>

<script>
	$(function() {
		// 1 ~ 4단계 값
		var phase1_val = "";
		var phase2_val = "";
		var phase3_val = "";
		var phase4_val = "";
		
		// 가중치 최종합
		var phase_total = "";

		// 1단계 값 추출 (1 ~ 5)
		$(".btn1").click(function() {
			var gameVal = $(this).val();
			phase1_val = gameVal;

			$("#phase1").hide();
			$("#phase2").show();
		});// btn1

		// 2단계 값 추출 (1 ~ 3)
		$(".btn2").click(function() {
			var displayVal = $(this).val();
			phase2_val = displayVal;

			$("#phase2").hide();
			$("#phase3").show();
		});// btn2

		// 3단계 값 추출 (2 ~ 4)
		$(".btn3").click(function() {
			var hzVal = $(this).val();
			phase3_val = hzVal;

			// 가중치 총합
			phase_total = Number(phase1_val) + Number(phase2_val) + Number(phase3_val);
			
			var url = "/shop/threeResult"
			var sData = {
					"wizard_value" : phase_total
			};
			
			var that = $(".container4");
			
			$.get(url, sData, function(rData) {
				
				$.each(rData, function(index, wizardVo) {
					
					var wizard_product = $(".yabal").clone();
					wizard_product.removeAttr("class");
					wizard_product.addClass("wizardClone");
					
					var imgsrc = "/images/wizard/" + wizardVo.wizard_no + ".png";
					var inner = "<img class='btn4' style='width:200px; height:200px;' src='" + imgsrc + "'><br>";
						inner += "<div style='text-align: center; font-size: 2rem;'>" + setCommas(wizardVo.wizard_price) + "원</div>";
					wizard_product.html(inner).fadeIn(600);
					$(".container4").append(wizard_product);
				});// each
			});// get
			
			$("#phase3").hide();
			$("#phase4").show();
			
		});// btn3
		
		// 4단계 값 추출
		$(".container4 ").on("click", "img", function() {
 			var wizard_no =  getWizard($(this).attr("src")).trim();
			// 폼 전송
			$("#wizardEnd").val(wizard_no);
			var form = $("#hiddenWizard");
			form.submit();
		});// btn4
		
		function getWizard(stringWizard) {
			return stringWizard.substring(15, 23);
		}
	});
</script>

<!-- hidden Form -->
<form id="hiddenWizard" action="/shop/finalResult" method="post">
	<input id="wizardEnd" type="hidden" name="wizard_no" value="">
</form>
<!-- hidden Form -->

<!-- phase1_container -->
<div id="phase1" class="wrap">
	<h2>평소에 즐겨하시는 게임을 선택해주세요!</h2>

	<div class="container">
		<div class="item">
			<button class="btn btn1 btn-outline-dark btn-lg" value="2">
				리그 오브 레전드
			</button>
		</div>
		<div class="item">
			<button class="btn btn1 btn-outline-dark btn-lg" value="3">
				FIFA 온라인 4
			</button>
		</div>
		<div class="item">
			<button class="btn btn1 btn-outline-dark btn-lg" value="1">
				메이플스토리
			</button>
		</div>
		<div class="item">
			<button class="btn btn1 btn-outline-dark btn-lg" value="4">
				발로란트
			</button>
		</div>
		<div class="item">
			<button class="btn btn1 btn-outline-dark btn-lg" value="2">
				서든어택
			</button>
		</div>
		<div class="item">
			<button class="btn btn1 btn-outline-dark btn-lg" value="3">
				오버워치 2
			</button>
		</div>
		<div class="item">
			<button class="btn btn1 btn-outline-dark btn-lg" value="1">
				던전앤파이터
			</button>
		</div>
		<div class="item">
			<button class="btn btn1 btn-outline-dark btn-lg" value="5">
				디아블로 4
			</button>
		</div>
		<div class="item">
			<button class="btn btn1 btn-outline-dark btn-lg" value="4">
				로스트아크
			</button>
		</div>
	</div>
</div>
<!-- phase1_container -->


<!-- phase2_container -->
<div id="phase2" class="wrap" style="display: none">
	<h2>평소에 사용하시는 모니터의 해상도를 선택해주세요!</h2>

	<div class="container">
		<div class="item">
			<button class="btn btn2 btn-outline-dark btn-lg" value="1">FHD</button>
		</div>
		<div class="item">
			<button class="btn btn2 btn-outline-dark btn-lg" value="2">QHD</button>
		</div>
		<div class="item">
			<button class="btn btn2 btn-outline-dark btn-lg" value="3">UHD(4K)</button>
		</div>
	</div>
</div>
<!-- phase2_container -->

<!-- phase3_container -->
<div id="phase3" class="wrap" style="display: none">
	<h2>평소에 사용하시는 모니터의 주사율(Hz)을 선택해주세요!</h2>

	<div class="container">
		<div class="item">
			<button class="btn btn3 btn-outline-dark btn-lg" value="2">60Hz</button>
		</div>
		<div class="item">
			<button class="btn btn3 btn-outline-dark btn-lg" value="3">120Hz</button>
		</div>
		<div class="item">
			<button class="btn btn3 btn-outline-dark btn-lg" value="4">144Hz</button>
		</div>
	</div>
</div>
<!-- phase3_container -->

<!-- phase4_container -->
<div id="phase4" class="wrap" style="display: none">
	<h2>추천PC 중 1대를 선택해주세요!</h2>

	<div class="container4">
		<div class="item yabal" style="display: none">
		</div>
	</div>
</div>
<!-- phase4_container -->