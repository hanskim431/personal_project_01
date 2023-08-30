<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<div class="container">
	<div class="row">
		<div class="col-12">
			<h1 class="page-header"></h1>
		</div>
	</div>

	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header">
					<h3 class="float-left">게시판</h3>
					<div class="float-right d-flex">
						<select class="amount form-control mx-2">
							<option value="10" ${criteria.amount==10 ? 'selected':''}>10개씩 보기</option>
							<option value="25" ${criteria.amount==25 ? 'selected':''}>25개씩 보기</option>
							<option value="50" ${criteria.amount==50 ? 'selected':''}>50개씩 보기</option>
							<option value="100" ${criteria.amount==100 ? 'selected':''}>100개씩 보기</option>
						</select>
						<button id="regBtn" class="btn btn-s btn-primary ">register</button>
					</div>
				</div>
				<div class="card-body">
					<table class="table table-striped table-bordered table-hover">
						<c:if test="${!empty list}">
							<thead>
								<tr>
									<th>#번호</th>
									<th>게시판</th>
									<th>제목</th>
									<th>작성자</th>
									<th>추천수</th>
									<th>작성일</th>
									<th>수정일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="board">
									<tr>
										<td>${board.bno}</td>
										<td>${board.boardType}</td>
										<td>
											<a class="move" href="${board.bno}">
												${board.title } ${board.replyCnt==0?'':[board.replyCnt]}
											</a>
										</td>
										<td>${board.writer}</td>
										<td>${board.likeHit}</td>
										<td><tf:formatDateTime value="${board.regDate}"
												pattern="yyyy-MM-dd HH:mm" /></td>
										<td><tf:formatDateTime value="${board.updateDate}"
												pattern="yyyy-MM-dd HH:mm" /></td>
										<td><button type="button" class="btn btn-primary active">보이기</button>
											<button type="button" class="btn btn-primary disabled">숨기기</button></td>
										<td><button type="button" class="btn btn-primary active">삭제</button></td>
									</tr>
								</c:forEach>
							</tbody>
							</c:if>
							<c:if test="${empty list}">
								<tbody>
									<tr>
										<td colspan="5">게시물이 존재하지 않습니다.</td>
									</tr>
								</tbody>
							</c:if>
					</table>
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
					
					<form class="text-center my-3" id="searchForm" action="${ctxPath}/board/${boardType}/list">
						<div class="d-inline-block">
							<select name="type" class="form-control">
								<option value="TCW" ${criteria.type eq 'TCW' ? 'selected' : ''}>제목+내용+작성자</option>
								<option value="T" ${criteria.type eq 'T' ? 'selected' : ''}>제목</option>
								<option value="C" ${criteria.type eq 'C' ? 'selected' : ''}>내용</option>
								<option value="W" ${criteria.type eq 'W' ? 'selected' : ''}>작성자</option>
								<option value="TC" ${criteria.type eq 'TC' ? 'selected' : ''}>제목+내용</option>
								<option value="TW" ${criteria.type eq 'TW' ? 'selected' : ''}>제목+작성자</option>
							</select>
						</div>
						<div class="d-inline-block col-4">
							<input type="text" name="keyword" value="${p.criteria.keyword}" class="form-control">
						</div>
						<div class="d-inline-block">
							<button class="btn btn-primary">검색</button>
						</div>
					</form>

					<form id="listForm" action="${ctxPath}/board/${boardType}/list" method="get">
						<input type="hidden" name="pageNum" value="${p.criteria.pageNum}">
						<input type="hidden" name="amount" value="${p.criteria.amount}">
						<input type="hidden" name="type" value="${param.type}">
						<input type="hidden" name="keyword" value="${param.keyword}">
						<input type="hidden" name="boardType" value="${boardType}">
					</form>
					
					
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
	console.log('${criteria.type}')
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
				.attr('action','${ctxPath}/board/${boardType}/get')
				.submit();
	});
	
	// 게시물 수 변경 
	$('.amount').change(function(){
		let amount = $(this).val();
		listForm.find('input[name="amount"]').val(amount)
		listForm.submit();		
	})
	
	// 글쓰기 페이지로 이동
	$('#regBtn').click(function(){
		listForm.attr('action','${ctxPath}/board/${boardType}/register')
				.submit();
	});
	
	// 검색 이벤트 처리 
	let searchForm = $('#searchForm');
	$('#searchForm button').click(function(e){
		e.preventDefault();
		if(!searchForm.find('[name="keyword"]').val()){
			alert('키워드를 입력하세요');
			return; 
		}
		searchForm.submit();
	});
</script>

<%@ include file="../includes/footer.jsp"%>
