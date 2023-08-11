<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<div class="container">
	<div class="row">
		<div class="col-12">
			<h1 class="page-header">Tables</h1>
		</div>
	</div>

	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header"></div>
				<div class="card-body">
					<table class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>#번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>수정일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="board">
								<tr>
									<td>${board.bno}</td>
									<td><a class="move" href="${board.bno}">${board.title }</a>
									</td>
									<td>${board.writer }</td>
									<td><tf:formatDateTime value="${board.regDate }"
											pattern="yyyy-MM-dd HH:mm" /></td>
									<td><tf:formatDateTime value="${board.updateDate }"
											pattern="yyyy-MM-dd HH:mm" /></td>
									<td><a href="">숨기기</a></td>
									<td><a href="">삭제</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<form id="listForm" action="${ctxPath}/board/list" method="get">
						<input type="hidden" name="pageNum" value="${p.criteria.pageNum}">
						<input type="hidden" name="amount" value="${p.criteria.amount}">
					</form>

					<ul class="pagination justify-content-center">
						<c:if test="${p.prev }">
							<li class="page-item"><a class="page-link"
								href="${p.startPage-p.displayPageNum}">이전페이지</a></li>
						</c:if>
						<c:forEach begin="${p.startPage}" end="${p.endPage }"
							var="pagelink">
							<li
								class="page-item ${ pagelink == p.criteria.pageNum ? 'active':''}">
								<a href="${pagelink}" class="page-link ">${pagelink}</a>
							</li>
						</c:forEach>
						<c:if test="${p.next }">
							<li class="page-item"><a class="page-link"
								href="${p.endPage+1}">다음페이지</a></li>
						</c:if>
					</ul>

				</div>
				<!-- card-body end -->
			</div>
			<!-- card end -->
		</div>
		<!-- col-12 end -->
	</div>
	<!-- row end -->
</div>
<!-- container end -->

<script>
	//페이지 이동 
	let listForm = $('#listForm');
	$('.pagination a').click(function(e) {
		e.preventDefault();
		let pageNum = $(this).attr('href');
		listForm.find('input[name="pageNum"]').val(pageNum)
		listForm.submit();
	})
	
// 조회 페이지로 이동 
	$('.move').click(function(e){
		e.preventDefault();
		let bnoValue = $(this).attr('href');
		listForm.append($('<input/>',{type : 'hidden', name : 'bno', value : bnoValue}))
				.attr('action','${ctxPath}/board/get')
				.submit();
	});
</script>

<%@ include file="../includes/footer.jsp"%>
