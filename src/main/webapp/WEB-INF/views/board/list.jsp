<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<style>
#wrap {
	text-align: center;
}
.table-container {
	width:75%;
	height:100%;
}
.boardTitle {
	cursor:pointer;
}
</style>
<script>
if ("${redirect_board_type}" == "공지") {
	location.href = "/board/list?board_type=공지";
}
$(function(){
	/* 글 읽기 */	
	$(".boardTitle").click(function() {
		var board_no = $(this).attr("data-bno");
		location.href = "/board/read/" + board_no; 
	});
	/* 글 분류(공지, 정보, 잡담, 질문) 버튼 클릭 */
	$(".board-type").click(function() {
		$("#board_type").val($(this).text());
		$("#currentPage").val("1");
		$("#frmPaging").submit();
	});
	/* 페이지 번호 클릭*/
	$(".page-count").click(function() {
		$("#currentPage").val($(this).text());
		$("#frmPaging").submit();
	});
	/* 페이지 왼쪽, 오른쪽 화살표 클릭  */
	$(".arrow").click(function() {
		var direction = $(this).attr("data-arrow");
		var startPage = parseInt("${pagingDto.startPage}");
		if (direction == "left") {
			$("#currentPage").val(startPage - 10);
		} else if (direction == "right") {
			$("#currentPage").val(startPage + 10);
		}
		$("#frmPaging").submit();
	});
	
	/* 검색타입 결정 */
	if ("${pagingDto.searchType}" != "") {
		$("#searchType").val("${pagingDto.searchType}");
		$("#navbarDropdownMenuLink").text("${pagingDto.searchType}");
	}
	$("#searchMenu > .dropdown-item").click(function(e){
		e.preventDefault();
		$("#navbarDropdownMenuLink").text($(this).text());
		var searchType = $(this).text();
	});
	
	/* 검색하기 */
	$("#inputKeyword").keydown(function(k){
		if (k.keyCode == 13) {
			k.preventDefault();
			search();
		}
	});
	$("#btnSearch").click(function(e){
		e.preventDefault();
		search();
	});
	function search() {
		var keyword = $("#inputKeyword").val();
		var searchType = $("#navbarDropdownMenuLink").text().trim();

		/* frmPaging에 파라미터를 넣어준다 */
		if ("${pagingDto.keyword}" == "") {
			$("#frmPaging").append("<input type='hidden' id='searchType' name='searchType' value='" + searchType + "'>");			
			$("#frmPaging").append("<input type='hidden' id='keyword' name='keyword' value='" + keyword + "'>");			
		}
		$("#searchType").val(searchType);
		$("#keyword").val(keyword);
		$("#currentPage").val("1");
		$("#frmPaging").submit();
	}
});
</script>
<div id="wrap">
<!-- hidden form (for Paging) -->
<form id="frmPaging" action="/board/list" method="get">
	<input type="hidden" id="board_type" name="board_type" value="${pagingDto.board_type}">
	<input type="hidden" id="currentPage" name="currentPage" value="${pagingDto.currentPage}">
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
			<table class="table table-hover mt-3">
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
<!-- 							<img src="/images/s_picture.png" alt="img"> -->
<%-- 						</c:if> --%>
							<a class="boardTitle nav-link" data-bno="${boardVo.board_no}">${boardVo.board_title}</a>
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
			<nav class="mt-5">
				<ul class="pagination justify-content-center">
				
					<c:if test="${pagingDto.startPage != 1}">
					<li class="page-item"><a class="page-link arrow" data-arrow="left" href="#">&laquo;</a></li>
					</c:if>
					
					<c:forEach begin="${pagingDto.startPage}" end="${pagingDto.endPage}" varStatus="status">
						<li class="page-item
							<c:if test="${pagingDto.currentPage == status.index}">
									active
							</c:if>">
							<a class="page-count page-link" href="#">${status.index}</a>
						</li>
					</c:forEach>
					
					<c:if test="${pagingDto.endPage != pagingDto.totalPageCount}">
					<li class="page-item"><a class="page-link arrow" data-arrow="right" href="#">&raquo;</a></li>
					</c:if>
				</ul>
			</nav>
		</div>
	</div>
	<!-- 글쓰기버튼 -->
	<div class="row">
		<div class="col-md-12">
		<c:choose>
			<c:when test="${list[0].board_type == '공지' && loginInfo.member_id != 'admin'}">
			</c:when>
			<c:otherwise>
				<a class="btn btn-success" href="/board/register" style="float:right;">글쓰기</a>
			</c:otherwise>
		</c:choose>
		</div>
	</div>
	<!-- 검색창 -->
	<div class="row">
		<div class="col-md-12">
			<nav class="navbar navbar-expand-lg navbar-light bg-light mt-3">
				<div class="collapse navbar-collapse justify-content-center" id="bs-example-navbar-collapse-1">
					<ul class="navbar-nav">
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink" data-toggle="dropdown">
								전체
							</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink" id="searchMenu">
								<div class="dropdown-item">전체</div> 
								<div class="dropdown-item">제목+내용</div>
								<div class="dropdown-item">작성자</div>
							</div>
						</li>
					</ul>
					<div class="form-inline">
						<input type="text" class="form-control mr-sm-2" id="inputKeyword" name="keyword" value="${pagingDto.keyword}"/>
						<button class="btn btn-primary my-2 my-sm-0" type="button" id="btnSearch">검색</button>
					</div>
				</div>
			</nav>
		</div>
		<!-- 검색 경고창 -->
		<div class="justify-content-center">
			<span id="searchWarning" style="color:red; display:none;">검색은 2글자 이상만 사용 가능합니다.</span>
		</div>
	</div><!-- 검색창 row -->
	
</div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
