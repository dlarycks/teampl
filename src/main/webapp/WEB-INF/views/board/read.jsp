<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<style>
.table-container {
	width:75%;
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
#dropBox {
	height:120px;
	border: 5px dashed orange;
	background-color: yellow;
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
				img.removeAttr("id");
				var imgsrc = "";
				if (isImage(file)) { 
					imgsrc = "/upload/displayImage?filePath=" + file;
				} else {
					imgsrc = "/images/default.png";
				}
				img.attr("src", imgsrc).attr("data-filename", file).show();
				$("#board_content").prepend(img);
			});
			$("#imgClone").remove();
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
				// 대댓글 데이터 <div> 복제
				var div = $("#divClone").clone();
				div.removeAttr("id");
				var data =  "<input type='hidden' class='reply_no' value='" + replyVo.reply_no + "'>"
					data += "<input type='hidden' class='reply_group' value='" + replyVo.reply_group + "'>"
					data += "<input type='hidden' class='reply_seq' value='" + replyVo.reply_seq + "'>"
					data += "<input type='hidden' class='reply_level' value='" + replyVo.reply_level + "'>"
				div.html(data);
				$("#replyList > tbody").append(div); // div 붙이기
				// 댓글 표시용 <tr> 복제
				var replyTr = $("#replyClone").clone();
				replyTr.removeAttr("id");
				// 댓글 표시용 <tr>에 아이디, 내용, 작성일, 수정버튼, 삭제버튼 반복넣기
				var td = "<td>" + replyVo.member_id + "</td>";
				// 대댓글일 시 들여쓰기 하기
				if(replyVo.reply_level == 0) {
					td += "<td class='reply_content' style='text-align:start;'>" + replyVo.reply_content + "</td>";
				} else {
					td += "<td class='reply_content' style='text-align:start; padding-left:" + (replyVo.reply_level * 30) + "px;'>" +
							 "└ " + replyVo.reply_content + "</td>";
				}
				td += "<td>" + toDateString(replyVo.reply_regdate) + "</td>";
				if(replyVo.member_id == "${loginInfo.member_id}") {
					td += "<td class='tdReplyModify'>";
					td += "		<button class='btn btn-secondary btnReplyModify'>수정</button>";
					td += "</td>";
					td += "<td>";
					td += "		<button class='btn btn-danger btnReplyDelete'>삭제</button>";
					td += "</td>";
				} else {
					td += "<td></td><td></td>";
				}
				// tr,td 붙이기
				replyTr.html(td);
				$("#replyList > tbody").append(replyTr); 
			});
		});
	}
	getReplyList();
	
	/* 글 수정 */
	$("#btnUpdate").click(function(){
		var images = $("#board_content").find(".attach");
		/* 위의 이미지를 전부 아래 썸네일로 보냄 */
		$.each(images, function(index, image){
			
			var div = $("#uploadClone").clone();
			div.removeAttr("id");
			div.addClass("uploadedItem");
			
			var filename = $(image).attr("data-filename");
			var mininame = filename.substring(filename.indexOf("_") + 1);
			div.find("span").text(mininame);
			div.find("a").attr("data-filename", filename);
			
			if (isImage(filename)) {
				var thumbnail = getThumbnailName(filename);
				div.find("img").attr("src", "/upload/displayImage?filePath=" + thumbnail);
			}
			$("#uploadedItem").append(div);
			div.show();
		});
		$("#board_type").hide();
		$("#board_content").hide();
		$("#replyInput").hide();
		$("#replyListDiv").hide();
		$("#likeThumbs").hide();
		$("#likedCount").hide();
		$("#divUpdate").empty();
		
		$("#update_board_type").show();
		$("#board_title").attr("readonly", false);
		$("#taUpdate").val("${boardVo.board_content}").show();
		$("#dropBox").show();
		$("#uploadedItem").show();
		$("#divUpdate").append($("#btnUpdateComplete").show());
	});
	
	/* 글 수정 시 파일 드롭박스 처리 */
	$("#dropBox").on("dragenter dragover", function(e) {
		e.preventDefault();
	});
	$("#dropBox").on("drop", function(e) {
		e.preventDefault();
		var file = e.originalEvent.dataTransfer.files[0];
		var formData = new FormData();
		formData.append("file", file);
		url = "/upload/uploadFile";
		
		$.ajax({
			"type" : "post",
			"processData" : false,
			"contentType" : false,
			"url" : url,
			"data" : formData,
			"success" : function(rData) {

				var div = $("#uploadClone").clone();
				div.removeAttr("id");
				div.addClass("uploadedItem");
				div.addClass("newUpload");
				
				var filename = rData.substring(rData.indexOf("_") + 1);
				div.find("span").text(filename);
				
				if (isImage(filename)) {
					var thumbnail = getThumbnailName(rData);
					div.find("img").attr("src", "/upload/displayImage?filePath=" + thumbnail);
				}
				div.find("a").attr("data-filename", rData);
				$("#uploadedItem").append(div);
				div.show();
			}
		});
	});
	/* 글 수정 시 올라온 이미지 x 눌렀을때 처리 */
	$("#uploadedItem").on("click", "a", function(){
		
		var filename = $(this).attr("data-filename");
		var url = "/upload/deleteFile";
		var that = $(this).parent();
		$.ajax({
			"type" : "delete",
			"url" : url,
			"dataType" : "text",
			"data" : filename,
			"headers" : {
				"Content-Type" : "text/plain; charset=utf-8",
				"X-HTTP-Method-Override" : "delete"
			},
			"success" : function(rData) {
				if (rData == "SUCCESS") {
					that.fadeOut(1000);
				}
			}
		});
	});
	
	/* 글 수정완료 */
	$("#btnUpdateComplete").click(function(){
		var new_board_type = $("#update_board_type option:selected").val();
		var new_board_title = $("#board_title").val();
		var new_board_content = $("#taUpdate").val();
		
		$("#frmUpdate [name='board_type']").val(new_board_type);
		$("#frmUpdate [name='board_title']").val(new_board_title);
		$("#frmUpdate [name='board_content']").val(new_board_content);
		
		$(".newUpload a").each(function(index) {
			var fullname = $(this).attr("data-filename");
			var inputTag = "<input type='hidden' ";
				inputTag += " name='files[" + (index++) + "]'";
				inputTag += " value='" + fullname + "'>";
			$("#frmUpdate").prepend(inputTag);
		});
		$("#frmUpdate").submit();
	});
	
	/* 글 삭제 */
	$("#btnDelete").click(function(){
		$("#frmDelete").submit();
	});

	/* 댓글 작성 */
	$("#btnReply").click(function(){
		if ($("#replytext").val() == "") {return;}
		
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
	/* 대댓글 작성 완료 */
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
				/* 대댓글창 제거 */
				myTr.remove();
				$(".reply:gt(0)").remove();
				getReplyList();
			}
		});
	});
	/* 댓글 수정 버튼 클릭 */
	$("#replyList > tbody").on("click", ".btnReplyModify", function() {
		var myTr = $(this).parent().parent();
		var reply_no = $(this).parent().parent().prev().find(".reply_no").val();
		/* 수정 중 대댓글 입력을 방지를 위해 class삭제 */
		var contentTd = myTr.find(".reply_content");
		contentTd.removeClass("reply_content");
		/* 나와있는 대댓글창 삭제 */
		$("#nestedInput").remove();
		
		/* 댓글 내용이 있던 자리에 input 추가 */
		var inputModify = "<input type='text' placeholder='수정'>";
		myTr.find(".reply_content").html(inputModify);
		var btnModify = "<button type='button' class='btnReplyModifyRun'>수정완료</button>";
		myTr.find(".tdReplyModify").html(btnModify);
		
	});
	/* 댓글 수정완료 버튼 클릭 */
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
<form id="frmUpdate" action="/board/update" method="post">
	<input type="hidden" name="board_type">
	<input type="hidden" name="board_title">
	<input type="hidden" name="board_content">
	<input type="hidden" name="board_no" value="${boardVo.board_no}">
	<!-- <img class="newUpload" src="">... -->
</form>
<form id="frmDelete" action="/board/delete" method="post">
	<input type="hidden" name="board_no" value="${boardVo.board_no}">
	<input type="hidden" name="board_type" value="${boardVo.board_type}">
</form>
<div class="container-fluid table-container">
	<!-- 글제목 -->
	<div class="row">
		<div class="col-md-12">
			<div class="input-group mt-5 mb-3">
				<div class="input-group-prepend">
					<div id="board_type" class="input-group-text">${boardVo.board_type}</div>
					<select class="form-select" id="update_board_type" style="display:none;">
						<c:choose>
							<c:when test="${boardVo.board_type == '공지'}">
							<option value="공지" selected>공지</option>
							</c:when>
							<c:otherwise>
							<option value="질문"
								<c:if test="${boardVo.board_type == '질문'}">
									selected
								</c:if>
							>질문</option>
							<option value="잡담"
								<c:if test="${boardVo.board_type == '잡담'}">
									selected
								</c:if>
							>잡담</option>
							<option value="정보"
								<c:if test="${boardVo.board_type == '정보'}">
									selected
								</c:if>
							>정보</option>
							</c:otherwise>
						</c:choose>
					</select>
				</div>
				<input class="form-control" id="board_title" value="${boardVo.board_title}" readonly style="background-color:white;">
			</div>
		</div>	
	</div>
	<!-- 글내용<div> -->
	<div class="row">
		<div class="col-md-12">
			<div class="form-control" id="board_content">
				<img id="imgClone" class="attach" src="" style="display:none;">
					<!-- 이미지가 반복될 곳 -->
					<!-- <img class="attach" src="/images/default.png"> ...  -->
				<div>
					${boardVo.board_content}
				</div>
			</div>
			<!-- 수정시 나타날 텍스트창 -->
			<textarea id="taUpdate" style="display:none; width:100%; height:500px;">
			</textarea>
			
			<!-- 수정시 나타날 dropbox -->
			<div id="dropBox" class="form-control" style="display:none;"></div>
			
			<!-- 수정용 이미지 clone -->
			<div id="uploadClone" style="display:none; float:left; margin:10px;">
				<img src="/images/default.png" alt="document"><br>
				<span style="width:100px;"></span>
				<a href="#">&times;</a>
			</div>
			
			<!-- 수정시 나타날 이미지들 -->
			<div id="uploadedItem" style="display:none;">
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
		<!-- 수정, 삭제버튼 -->
		<c:if test="${boardVo.member_id == loginInfo.member_id}">
		<div id="divUpdate" class="float-right">
			<button class="btn btn-lg btn-secondary" id="btnUpdate">수정</button>
			<button class="btn btn-lg btn-danger" id="btnDelete">삭제</button>
		</div>
			<button class="btn btn-lg btn-info" id="btnUpdateComplete" style="display:none;">수정완료</button>
		</c:if>
	</div>
	
	<!-- 댓글 입력 -->
	<c:if test="${not empty loginInfo}">
	<div id="replyInput" class="row" style="margin-top:30px;">
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
<%@ include file="/WEB-INF/views/include/footer.jsp"%>