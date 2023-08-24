<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script src="/js/sockjs.min.js"></script>
<style>

	#demo {
		width: 1000px;
		/* 브라우저 사진 크기 맞추기 위해 수정 500 to 480 */
		height: 480px;  
		margin: 0 auto;
	}
	/* Make the image fully responsive */
	.carousel-inner img {
		width: 100%;
		height: 100%;
	}
	.chat_start_main {
		position: fixed;
		top: 600;
		/* width: 100% */
		left: 1200;
		right: 0;
	}
	#chatform {
		position: absolute;
	    top: 150px;
	    left: 1200px;
	    width: 500px;
	    height: 520px;
	    border: 1px solid #ddd;
	    overflow: hidden;
	    padding-bottom: 20px;
	    word-break: break-all;
	    word-wrap: break-word;
	    background: #FFFFFF;
	    z-index: 17013;
	}
</style>
<script>
$(function(){

	var socket = null;
	var connected = false;
	
    $(".chat_start_main").click(function(){
        $(this).css("display","none");
        $("#chatform").css("display", "inline");
        if (!connected) {
	        connectWS();
			connected = true;        	
        }
    });
    
    $(".modal-header").click(function(){
        $("#chatform").css("display","none");
        $(".chat_start_main").css("display", "inline");
    });
 
    function connectWS() {
    	
        var sock = new SockJS("/echo");
        socket = sock; // 전역변수에 sock 집어넣기
        
        sock.onopen = function() {
//         	console.log("info: connection opened.");
        	clearInterval(sInterval);
        };
        sock.onmessage = function(e) {
//             var strArray = e.data.split(":");
//             if(e.data.indexOf(":") > -1){
//                 $(".chat_start_main").text(strArray[0] + "님이 메세지를 보냈습니다.");
//             }
            $("#chat").append(e.data + "\n");
            var top = $('#chat').prop("scrollHeight");
            $("#chat").scrollTop(top);
        }
        sock.onclose = function(){
            $("#chat").append("연결 종료");
        }
        sock.onerror = function (err) {
//         	console.log("Errors : " , err);
        };
 
        $("#chatform").submit(function(e){
            e.preventDefault();
            sock.send($("#message").val());
            $("#message").val("").focus();    
        });
        
    } // connectWS
//     if ("${loginInfo.member_id}" != "") {
// 	    var sInterval = setInterval(connectWS, 1000);
//     }
});
</script>
<!-- Header-->
<header class="bg-dark py-5">
    <div class="container px-4 px-lg-5 my-5">
        <div class="text-center text-white">
            <h1 class="display-4 fw-bolder">Shop in style</h1>
            <p class="lead fw-normal text-white-50 mb-0">클릭으로 만드는 나만의 컴퓨터</p>
        </div>
    </div>
</header>

<c:if test="${not empty loginInfo}">
<a class="chat_start_main">
	<img src="/images/chat.png" alt="1:1상담">
</a>
</c:if>

<!-- Test: chat -->
<form id="chatform" style="display:none;">
    <div class="chat_main" style="height:100%">
        <div class="modal-header" style="height:20%;">
            상담 CHAT 
        </div>
        <textarea class="modal-content" id="chat" style="height:60%;" readonly>
            
        </textarea>
        <div class="modal-footer">
            <input type="text" id="message" class="form-control" style="height:20%;" placeholder="메세지를 입력하세요"/>    
        </div>
    </div>
</form>

<div id="demo" class="carousel slide" data-ride="carousel">
	<!-- The slideshow -->
	<div class="carousel-inner">
		<div class="carousel-item active">
    		<img src="/images/main_image1.jpg" alt="img1">
    	</div>
    	<div class="carousel-item">
    		<img src="/images/main_image2.jpg" alt="img2">
    	</div>
    	<!--  추가 된 부분 -->
    	<div class="carousel-item">
    		<img src="/images/main_image3.jpg" alt="img3">
    	</div>
    	<!--  추가 된 부분 끝 -->
	</div>
	<!-- Left and right controls -->
	<a class="carousel-control-prev" href="#demo" data-slide="prev">
	    <span class="carousel-control-prev-icon"></span>
	</a>
	<a class="carousel-control-next" href="#demo" data-slide="next">
	    <span class="carousel-control-next-icon"></span>
	</a>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>