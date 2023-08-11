<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/mj/include/header.jsp"%>
<style>
#wrap {
	text-align: center;
}
.table-container {
	width:80%;
	height:100%;
}
#ta_board_content {
	height: 500px;
}
#dropBox {
	height:120px;
	border: 5px dashed orange;
	background-color: yellow;
}
</style>
<script>
$(function(){
	$("#btnRegister").click(function(){
		var board_type = $("#select_board_type").val();
		var board_title = $("#input_board_title").val();
		var board_content = $("#ta_board_content").val();
		$("input[name=board_type]").val(board_type);
		$("input[name=board_title]").val(board_title);
		$("input[name=board_content]").val(board_content);
		$("#frmRegister").submit();
	});
	
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
				
				var extension = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();
// 				console.log("uploaded file extension is : " + extension);
				
				if (extension == "JPG" || extension == "PNG" ||extension == "GIF") {
					var thumbnail = getThumbnailName(rData);
					div.find("img").attr("src", "/upload/displayImage?filePath=" + thumbnail);
				}
				div.find("a").attr("data-filename", rData);

				$("#uploadedItem").append(div);
				div.show();
			}
		});
	});
	
	$("#frmRegister").submit(function() {
		
		$(".uploadedItem a").each(function(index) {
			
			var fullname = $(this).attr("data-filename");
			var inputTag = "<input type='hidden' ";
				inputTag += " name='files[" + (index++) + "]'";
				inputTag += " value='" + fullname + "'>";
			$("#frmRegister").prepend(inputTag);
		});
// 		return false;
	});
	
	
	
});
</script>
<!-- hidden form for register -->
<form id="frmRegister" action="/board/register" method="post">
	<input type="hidden" name="board_type">
	<input type="hidden" name="board_title">
	<input type="hidden" name="board_content">
	<input type="hidden" name="member_id" value="${loginInfo.member_id}">
</form>


<!-- wrap -->
<div id="wrap">
	<div class="container-fluid table-container">
		
		<div class="row">
			<div class="col-md-12">
				<div class="input-group mb-3">
					<div class="input-group-prepend">
				    	<select id="select_board_type" class="input-group-text">
							<option value="질문">질문</option>
							<option value="잡담" selected>잡담</option>
							<option value="정보">정보</option>
						</select>
					</div>
					<input type="text" class="form-control" id="input_board_title" placeholder="제목을 입력해 주세요">
				</div>
			</div>	
		</div>
		<div class="row">
			<div class="col-md-12">
				<textarea class="form-control" id="ta_board_content" placeholder="내용을 입력해 주세요"></textarea>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div style="height:30px; text-align:left; color:gray;">파일을 아래에 끌어다 주세요.</div>
				<!-- display zone -->
				<div id="dropBox" class="form-control"></div>
				
				<!-- clone -->		
				<div id="uploadClone" style="display:none; float:left; margin:10px;">
					<img src="/mj/images/default.png" alt="document"><br>
					<span></span>
					<a href="#">&times;</a>
				</div>
				
				<!-- displayed zone -->
				<div id="uploadedItem" style="height:100px;">
				</div>
			</div>			
		</div>
		<div class="row">
			<div class="col-md-11"></div>
			<div class="col-md-1">
				<button id="btnRegister" class="form-control btn btn-primary" type="button">작성</button>
			</div>
		</div>
	</div>
</div><!-- wrap -->




<%@ include file="/WEB-INF/views/mj/include/footer.jsp"%>
