<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/mj/include/header.jsp"%>
<style>
.table-container {
	width:80%;
	height:100%;
	text-align: center;
}
#board_title {
	text-align:start;
}
#board_content {
	height:500px;
	text-align:start;
	overflow:scroll;
}
.attach {
	display:block;
}
#likeImg {
	text-align:center;
}
.reply {
	cursor:pointer;
}
</style>
<script>
$(function(){
	/* 시작 시에 실행 : 이미지 로딩 */
	function getImageList() {
		
		var url = "/upload/getImageList";
		var sData = {
			"board_no" : "${boardVo.board_no}"	
		};
		$.post(url, sData, function(rData) {
			
			$.each(rData, function(index, file) {
				var img = $("#imgClone").clone();
				var imgsrc = "";
				if (isImage(file)) { 
					imgsrc = "/upload/displayImage?filePath=" + file;
				} else {
					imgsrc = "/mj/images/default.png";
				}
				img.removeAttr("id").attr("src", imgsrc).show();
				$("#board_content").prepend(img);
			});
		});
	}
	getImageList();
	/* 시작 시에 실행 : 좋아요 여부 확인 */
	var isLiked = false;
	var likeCount = 0;
	function getIsLiked() {
		
		var url = "/like/isLiked";
		var sData = {
			"member_id" : "${loginInfo.member_id}",
			"board_no" : "${boardVo.board_no}"
		}
		$.post(url, sData, function(rData){
			if (rData == "true") {
				$("#likeThumbs").css("color", "#3399EE");
				isLiked = true;
			}
		});
	}
	getIsLiked();
	/* 시작 시에 실행 : 좋아요 갯수 확인 */
	function getLikeCount() {
		
		var url = "/like/getLikeCount";
		var sData = {
			"board_no" : "${boardVo.board_no}"
		};
		$.get(url, sData, function(rData){
			setLikeCount(rData);
			likeCount = parseInt(rData);
		});
	}
	function setLikeCount(count) {
		$("#likedCount").text("[" + count + "]");
	}
	getLikeCount();
	
	/* 좋아요 누르기 / 좋아요 취소 */
	$("#likeThumbs").click(function(){
		
		if ("${loginInfo.member_id}" == "") {
			$("#likeLoginWarning").fadeIn(600).delay(3000).fadeOut(600);
			return;
		}
		
		var url = "/like/addLike";
		var color = "#3399EE";
		var change = 1;
		
		if (isLiked) { /* 좋아요를 이미 누른 상태일 경우 */
			url = "/like/deleteLike";
			color = "#999999";
			change = -1;
		}
		var sData = {
			"member_id" : "${loginInfo.member_id}",
			"board_no" : "${boardVo.board_no}"
		};
		$.post(url, sData, function(rData){
			if(rData == "success") {

				$("#likeThumbs").css("color", color);
				/* 좋아요 갯수 재설정 */
				likeCount = likeCount + change;
				setLikeCount(likeCount);
				/* true - false 바꾸기 */
				isLiked = !isLiked; 
			}
		});
	});
	
	/* 시작 시에 실행 : 댓글목록 가져오기 */
	function getReplyList() {
		var url = "/reply/getReplyList";
		var sData = {
			"board_no" : "${boardVo.board_no}"	
		};
		$.post(url, sData, function(rData){
			
			$.each(rData, function(index, replyVo) {
				
				<!-- 대댓글 데이터 <div> -->
				var div = $("#divClone").clone();
				div.removeAttr("id");
				var data =  "<input type='hidden' class='reply_no' value='" + replyVo.reply_no + "'>"
					data += "<input type='hidden' class='reply_group' value='" + replyVo.reply_group + "'>"
					data += "<input type='hidden' class='reply_seq' value='" + replyVo.reply_seq + "'>"
					data += "<input type='hidden' class='reply_level' value='" + replyVo.reply_level + "'>"
				div.html(data);
				$("#replyList > tbody").append(div); // div 붙이기
				
				<!-- 댓글 표시용 <tr> --> 
				var replyTr = $("#replyClone").clone();
				replyTr.removeAttr("id");
				<!-- 아이디, 내용, 작성일, 수정버튼, 삭제버튼 반복 -->
				var td = "<td>" + replyVo.member_id + "</td>";
				if(replyVo.reply_level == 0) {
					td += "<td class='reply_content' style='text-align:start;'>" + replyVo.reply_content + "</td>";
				} else {
					td += "<td class='reply_content' style='text-align:start; padding-left:" + (replyVo.reply_level * 30) + "px;'>" +
							 "└ " + replyVo.reply_content + "</td>";
				}
				td += "<td>" + toDateString(replyVo.reply_regdate) + "</td>";
				if(replyVo.member_id == "${loginInfo.member_id}")	 {
					td += "<td class='tdReplyModify'>";
					td += "		<button class='btn btn-secondary btnReplyModify'>수정</button>";
					td += "</td>";
					td += "<td>";
					td += "		<button class='btn btn-danger btnReplyDelete'>삭제</button>";
					td += "</td>";
				} else {
					td += "<td></td><td></td>";
				}
				replyTr.html(td);
				$("#replyList > tbody").append(replyTr); // tr,td 붙이기
			});
		});
	}
	getReplyList();

	/* 댓글 작성 */
	$("#btnReply").click(function(){
		var url = "/reply/comment";
		var sData = {
			"board_no" : "${boardVo.board_no}",
			"member_id" : "${loginInfo.member_id}",
			"reply_content" : $("#replytext").val()
		}
		$.post(url, sData, function(rData){
			if(rData == "success") {
				$("#replytext").val("");
				$(".reply:gt(0)").remove();
				getReplyList();
			}
		});
	});
	/* 대댓글 작성 */
	var nestedComment = false;
		/* 기존 댓글 클릭 시 아래에 댓글창 생성 */
	$("#replyList > tbody").on("click", ".reply_content", function() {
		
		/* 대댓글창이 이미 켜진 상태라면 제거하고 새로 표시 */
		if (nestedComment == true) {
			$("#nestedInput").remove();
		}
		var tr = $("#replyClone").clone(); // tr복사
			tr.removeAttr("id");
			tr.removeClass("reply");
			tr.attr("id", "nestedInput"); // tr에 "nestedInput" 이라는 ID 추가
			
		var td = "<td>" + "${loginInfo.member_id}" + "</td>"; // 대댓글 나의 id
			td += "<td>"
			td += "	<div class='input-group mb-3'>";
			td += "		<input type='text' class='form-control' placeholder='답글 입력' aria-label='답글 입력' aria-describedby='basic-addon2'>";
			td += "		<div class='input-group-append'>";
			td += "			<button type='button' class='btn btn-primary' id='nestedInputButton'>작성</button>";
			td += "		</div>";
			td += "	</div>";
			td += "</td>";
		tr.html(td);
		$(this).parent().after(tr);
		nestedComment = true;
	});
		
	$("#replyList > tbody").on("click", "#nestedInputButton", function() {
		var myTr = $(this).parent().parent().parent().parent();
		var div = myTr.prev().prev();
		
		var nestedInputText = $(this).parent().prev().val();
		var reply_group = div.find(".reply_group").val();
		var reply_seq = div.find(".reply_seq").val();
		var reply_level = div.find(".reply_level").val();

		var url = "/reply/nestedComment";
		var sData = {
			"board_no" : "${boardVo.board_no}",
			"member_id" : "${loginInfo.member_id}",
			"reply_content" : nestedInputText,
			"reply_group" : reply_group,
			"reply_seq" : reply_seq,
			"reply_level" : reply_level
		};
		$.post(url, sData, function(rData){
			if (rData == "success") {
				/* 답글창 제거 */
				myTr.remove();
				$(".reply:gt(0)").remove();
				getReplyList();
			}
		});
	});
	/* 댓글 수정 */
	$("#replyList > tbody").on("click", ".btnReplyModify", function() {
		var myTr = $(this).parent().parent();
		var reply_no = $(this).parent().parent().prev().find(".reply_no").val();
		
		var inputModify = "<input type='text' placeholder='수정'>";
		myTr.find(".reply_content").html(inputModify);
		var btnModify = "<button type='button' class='btnReplyModifyRun'>수정완료</button>";
		myTr.find(".tdReplyModify").html(btnModify);
		
		/* 수정 중 답글입력 방지를 위해 Class삭제 */
		var contentTd = myTr.find(".reply_content");
		contentTd.removeClass("reply_content");
		/* 나와있는 답글창 삭제 */
		$("#nestedInput").remove();
	});
	/* 댓글 수정 완료 */
	$("#replyList > tbody").on("click", ".btnReplyModifyRun", function() {
		var myTr = $(this).parent().parent();
		var reply_no = $(this).parent().parent().prev().find(".reply_no").val();
		var reply_content = myTr.find("td:eq(1)").find("input").val();
		
		var url = "/reply/updateReply";
		var sData = {
			"reply_no" : reply_no,
			"reply_content" : reply_content
		};
		$.post(url, sData, function(rData){
			if (rData == "success") {
				myTr.remove();
				$("#nestedInput").remove();
				$(".reply:gt(0)").remove();
				getReplyList();
			}
		});
	});
	
	/* 댓글 삭제 */
	$("#replyList > tbody").on("click", ".btnReplyDelete", function() {
		var myTr = $(this).parent().parent();
		var reply_no = myTr.prev().find(".reply_no").val();
		var url = "/reply/deleteReply";
		var sData = {
			"reply_no" : reply_no
		};
		$.post(url, sData, function(rData){
			if(rData == "success") {
				myTr.fadeOut(600);	
			}
		});
		
	});
	
});
</script>


<div id="wrap">
<div class="container-fluid table-container">
	<div class="row">
			<div class="col-md-12">
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<div class="input-group-text">${boardVo.board_type}</div>
					</div>
					<div class="form-control" id="board_title">${boardVo.board_title}</div>
				</div>
			</div>	
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="form-control" id="board_content">
					<img id="imgClone" class="attach" src="" style="display:none;">
<!-- 					<img class="attach" src="/mj/images/default.png"> -->
<!-- 					<img class="attach" src="/mj/images/default.png"> -->
<!-- 					<img class="attach" src="/mj/images/default.png"> -->
					<div>
						${boardVo.board_content}
					</div>
				</div>
			</div>
		</div><!-- row -->
		
		<!-- 미로그인 경고창 -->
		<span class="alert alert-warning my-alert" role="alert"
				style="display:none; margin:auto;" id="likeLoginWarning">
			로그인한 사용자만 추천이 가능합니다.
		</span>
		<!-- 좋아요 -->
		<div id="likeImg" style="margin-top:30px;">
			<i class="fa fa-thumbs-up" style="font-size:60px;color:#999999;cursor:pointer;"
				id="likeThumbs"></i>
			<span style="font-size:50px;" id="likedCount"></span>
		</div>
		
		<!-- 댓글 입력 -->
		<c:if test="${not empty loginInfo}">
		<div class="row" style="margin-top:30px;">
			<div class="col-md-12">
				<div class="input-group mb-3">
					<div class="input-group-prepend">
				    	<span class="input-group-text">${loginInfo.member_id}</span>
					</div>
					<input type="text" class="form-control" placeholder="댓글내용" id="replytext">
					<div class="input-group-append">
						<button type="button" class="btn btn-primary" id="btnReply">입력</button>
					</div>
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 댓글창 -->
		<div id="replyListDiv" class="row" style="margin-top:30px;">
			<hr>
			<div class="col-md-12">
				<div id="divClone"></div>
				<table id="replyList" class="table">
					<thead>
						<!-- 아이디, 내용, 작성일 반복 -->
						<tr>
							<td>아이디</td>
							<td>내용</td>
							<td>작성일</td>
							<td>수정</td>
							<td>삭제</td>
						</tr>
					</thead>
					<tbody>
						<!-- reply tr, div for clone (divClone는 위에다 뒀음) -->
						<tr class="reply" style="cursor:pointer;" id="replyClone">
						</tr>
						<!-- div-tr이 반복될 곳 -->
						

					</tbody>
				</table>
			</div>
		</div>
		
</div><!-- container -->
</div><!-- wrap -->
<%@ include file="/WEB-INF/views/mj/include/footer.jsp"%>