<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<style>
.thumbnail img{
	width: 240px;
	height: 135px;
}
.userimage img{
	width: 45px;
	height: 45px;
}

</style>

<div class="container">
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header">
					<div class="row my-2"> <!-- row1 -->
						<div class="col-1">
						</div>
						<div class="col-10" style="padding:0;">
							<h2 class="float-left" style="margin:0;">${info.boardName}</h2>
						</div>
						<div class="col-1" style="padding:0;">
							<button id="regBtn" class="btn btn-s btn-primary ">글쓰기</button>
						</div>
					</div>
					<div class="row my-2"> <!-- row2 -->
						<div class="col-3 text-center" style="padding:0;">
							<img alt="boardImage" src="${ctxPath}/resources/images/main/${boardType}.jpg" style="width: 200px; height: 200px;"/>
						</div>
						<div class="col-6" style="padding:0;">
							<h3 class="float-left" style="margin:0;">
								<div>${info.expanation}</div>
							</h3>
						</div>
						<div class="col-3 text-center" style="padding:0;">
						</div>
					</div>
<!-- 					<div class="float-right d-flex"> -->
<!-- 						<select class="amount form-control mx-2"> -->
<%-- 							<option value="10" ${criteria.amount==10 ? 'selected':''}>10개씩 보기</option> --%>
<%-- 							<option value="25" ${criteria.amount==25 ? 'selected':''}>25개씩 보기</option> --%>
<%-- 							<option value="50" ${criteria.amount==50 ? 'selected':''}>50개씩 보기</option> --%>
<%-- 							<option value="100" ${criteria.amount==100 ? 'selected':''}>100개씩 보기</option> --%>
<!-- 						</select> -->
<!-- 						<button id="regBtn" class="btn btn-s btn-primary ">register</button> -->
<!-- 					</div> -->

				</div>
				
				<div class="card-body">
					<div class="container">
						<c:if test="${!empty list}">
							<c:forEach items="${list}" var="board" varStatus="s">
								<c:if test="${s.index mod 4 == 0}"> <div class="row"> </c:if>
									<div class="col-3">
											<div class="thumbnail"  style="margin:auto;">
												<a class="move" href="${board.bno}">
												<img class="" alt="thumbnail" src="${ctxPath}/resources/images/main/${boardType}.jpg">
												</a>
											</div>
											<div class="row content-info">
												<div class="col-2 userimage " style="margin:auto;">
													<a class="userpage" href="#">
														<img class="rounded-circle" alt="userimage" src="${ctxPath}/resources/images/member/userImage.png">
													</a><!-- col-2 END -->
												</div>
												<div class="col-9 float-left">
													<a class="move" href="${board.bno}">
														<div>${board.title }</div>
														<div>댓글 ${board.replyCnt} • 추천 ${board.likeHit}</div>
													</a>
													<a class="userpage" href="#">
														<div>${board.writer}</div>
													</a>
												</div><!-- col-9 END -->
											</div> <!-- row content-info END -->
									</div><!-- col-3 -->
								<c:if test="${s.index mod 4 == 3}"> </div> </c:if>
							</c:forEach>
						</c:if>
						<c:if test="${empty list}">
							<tbody>
								<tr>
									<td colspan="5">게시물이 존재하지 않습니다.</td>
								</tr>
							</tbody>
						</c:if>
					</div>
				</div>
				<div class="card-body">	
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
					
					
				</div><!-- card-body end -->
			</div><!-- card end -->
		</div><!-- col-12 end -->
	</div><!-- row end -->
</div><!-- container end -->

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
