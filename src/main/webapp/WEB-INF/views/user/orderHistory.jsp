<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-2">
		</div>
		<div class="col-md-8 ml-5 mt-5">
			<div class="page-header">
				<h1>${member_name}<small>님의 주문내역입니다.</small></h1>
			</div>
		</div>
		<div class="col-md-2">
		</div>
	</div>
	<div class="row">
		<div class="col-md-2">
		</div>
		<div class="col-md-8 ml-5">
			<table class="table">
				<thead>
					<tr>
						<th>주문번호</th>
						<th>주문상세</th>
						<th>가격</th>
						<th>주문일자</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${orderList}" var="list">
					<tr>
						<td>${list.order_no}</td>
						<td>${list.order_content}</td>
						<td>${list.order_price}원</td>
						<td>${list.order_orderdate}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="col-md-2">
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
