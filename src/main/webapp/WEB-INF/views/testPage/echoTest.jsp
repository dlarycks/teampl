<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script src="/js/sockjs.min.js"></script>
<script>
var socket = null;
$(document).ready(function(){
    
    $(".chat_start_main").click(function(){
        $(this).css("display","none");
        $(".chat_main").css("display","inline");
        connectWS();
    });
    
    $(".chat_main .modal-header").click(function(){
        $(".chat_start_main").css("display","inline");
        $(".chat_main").css("display","none");
    });
 
    function connectWS() {
        var sock = new SockJS("/echo");
            socket = sock;
        sock.onopen = function() {
        	console.log("info: connection opened.");
        };
        sock.onmessage = function(e) {
            console.log(e);
            var strArray = e.data.split(":");
            if(e.data.indexOf(":") > -1){
                $(".chat_start_main").text(strArray[0] + "님이 메세지를 보냈습니다.");
            }
            $("#chat").append(e.data + "<br/>");
        }
        sock.onclose = function(){
            $("#chat").append("연결 종료");
        }
        sock.onerror = function (err) {
        	console.log("Errors : " , err);
        };
 
        $("#chatForm").submit(function(event){
            event.preventDefault();
            sock.send($("#message").val());
            $("#message").val('').focus();    
        });
    } // connectWS
});
</script>
<form id="chatForm">
    <div class="chat_start_main">
        상담 CHAT
    </div>
    <div class="chat_main" style="display:none;">
        <div class="modal-header" style="height:20%;">
            상담 CHAT 
        </div>
        <div class="modal-content" id="chat" style="height:60%;">
            
        </div>
        <div class="modal-footer">
            <input type="text" id="message" class="form-control" style="height:20%;" placeholder="메세지를 입력하세요"/>    
        </div>
    </div>
    <button class="">send</button>
</form>



<%@ include file="/WEB-INF/views/include/footer.jsp" %>
    