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
#navigation {
	width:80%;
}
.boardTitle {
	cursor:pointer;
}
</style>
<script>
$(function(){
	
	$(".board-type").click(function(){
		$("#board_type").val($(this).text());
		$("#currentPage").val("1");
		$("#frmPaging").submit();
	});
	$(".page-count").click(function(){
		$("#currentPage").val($(this).text());
		$("#frmPaging").submit();
	});
	$(".boardTitle").click(function(){
		var board_no = $(this).attr("data-bno");
		location.href = "/board/read/" + board_no; 
	});
	/* 검색 */
	var searchType = "전체";
	$(".dropdown-item").click(function(e){
		e.preventDefault();
		$("#navbarDropdownMenuLink").text($(this).text());
		searchType = $(this).text();
	});
	$("#btnSearch").click(function(){
		var keyword = $(this).parent().find("input").val();
		if ("${pagingDto.keyword}" == "") {
			$("#frmPaging").append("<input type='hidden' id='searchType' name='searchType' value='" + searchType + "'>");			
			$("#frmPaging").append("<input type='hidden' id='keyword' name='keyword' value='" + keyword + "'>");			
		}
		$("#currentPage").val("1");
		$("#searchType").val(searchType);
		$("#keyword").val(keyword);
		$("#frmPaging").submit();
	});
	
});
</script>
<div id="wrap">
<!-- hidden form (for Paging) -->
<form id="frmPaging" action="/board/list" method="get">
	<input type="hidden" id="board_type" name="board_type" value="${pagingDto.board_type}">
	<input type="hidden" id="currentPage" name="currentPage">
	<c:if test="${not empty pagingDto.keyword}">
	<input type="hidden" id="searchType" name="searchType" value="${pagingDto.searchType}">
	<input type="hidden" id="keyword" name="keyword" value="${pagingDto.keyword}">
	</c:if>
</form>
<!-- table -->
<div class="container-fluid table-container">
	<div class="row">
		<div class="col-md-12">
			<div class="btn-group" role="group" style="float:right; margin-top:30px;">
			<c:choose>
				<c:when test="${pagingDto.board_type != '공지'}">
					<button class="btn btn-secondary board-type" type="button">전체</button>
					<button class="btn btn-secondary board-type" type="button">질문</button>
					<button class="btn btn-secondary board-type" type="button">잡담</button>
					<button class="btn btn-secondary board-type" type="button">정보</button>
				</c:when>
				<c:otherwise>
					<button class="btn btn-info" type="button">공지</button>
				</c:otherwise>
			</c:choose>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<table class="table" style="margin-top:30px;">
				<thead>
					<tr>
						<th>#</th>
						<th>분류</th>
						<th>제목</th>
						<th>작성일</th>
						<th>작성자</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${list}" var="boardVo">
					<tr>
						<td> <!-- 글번호 -->
						<c:if test="${boardVo.board_type != '공지'}">
							${boardVo.board_no}
						</c:if>
						</td>
						<td> <!-- 분류 -->
							${boardVo.board_type}
						</td>
						<td> <!-- 글제목 -->
<%-- 						<c:if test="${not empty boardVo.files}"> --%>
<!-- 							<img src="/mj/images/s_picture.png" alt="img"> -->
<%-- 						</c:if> --%>
							<a class="boardTitle" data-bno="${boardVo.board_no}">${boardVo.board_title}</a>
						</td>
						<td>${boardVo.board_regdate}</td>
						<td>${boardVo.member_id}</td>
						<td>${boardVo.board_viewcount}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			
		</div>
	</div>
	<!-- 페이징 -->
	<div class="row">
		<div class="col-md-12">
			<nav>
				<ul class="pagination justify-content-center">
					<li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
					
					<c:forEach begin="${pagingDto.startPage}" end="${pagingDto.endPage}" varStatus="status">
						<li class="page-item
							<c:if test="${pagingDto.currentPage == pagingDto.startPage + status.index - 1}">
									active
							</c:if>">
							<a class="page-count page-link" href="#">${pagingDto.startPage + status.index - 1}</a>
						</li>
					</c:forEach>
					
					<li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- 글쓰기버튼 -->
	<div class="row">
		<div class="col-md-12">
			<a class="btn btn-success" href="/board/register" style="float:right;">글쓰기</a>
		</div>
	</div>
	<!-- 검색창 -->
	<div class="row">
		<div class="col-md-12">
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<div class="collapse navbar-collapse justify-content-center" id="bs-example-navbar-collapse-1">
					<ul class="navbar-nav">
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown">
								전체
							</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
								<a class="dropdown-item" href="#">전체</a> 
								<a class="dropdown-item" href="#">제목+내용</a>
								<a class="dropdown-item" href="#">작성자</a>
							</div>
						</li>
					</ul>
					<form class="form-inline">
						<!-- 검색창 input -->
						<input type="text" class="form-control mr-sm-2" id="keyword" name="keyword"/>
						<button class="btn btn-primary my-2 my-sm-0" type="button" id="btnSearch">검색</button>
					</form>
				</div>
			</nav>
		</div>
	</div>
</div>
</div>
<%@ include file="/WEB-INF/views/mj/include/footer.jsp"%>
