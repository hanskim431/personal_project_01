<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<div class="container">
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header"></div>
				<!-- card-header end -->
				<div class="card-body">
					<div class="form-group">
						<label>
							<div class="dropdown">
								<a href="" class="button list">←</a>
								<button class="btn btn-primary dropdown-toggle" type="button"
									data-toggle="dropdown">
									Dropdown <span class="caret"></span>
								</button>
								<ul class="dropdown-menu">
									<li><a href="" class="button report">신고</a></li>
									<li><a href="" class="button modify">수정</a></li>
									<li><a href="" class="button remove">삭제</a></li>
								</ul>
							</div>
						</label> <input type="text" class="form-control" name="title"
							value="${board.title}" readonly="readonly">
					</div>
					<div class="form-group">
						<label>작성자</label> <input type="text" class="form-control"
							name="writer" value="${board.writer}" readonly="readonly">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="10" cols="" name=content
							readonly="true">${board.content}</textarea>
					</div>

					<form>
						<input type="hidden" name="bno" value="${board.bno}">
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
// 	$(function() {
// 		let getForm = $('form');

// 		$('.remove').click(function(e) {
// 					e.preventDefault();
// 					getForm.attr('action', '${ctxPath}/board/remove')
// 					.attr('method', 'post')
// 					.submit();
// 				})
// 	})
	
$(function(){
	// 목록 or 수정 페이지로
	let form = $('form')
	$('a').click(function(){
		console.log('a태그 작동');
		let operration = $(this).data('oper');
		form.append($('<input/>',{type : 'hidden', name : 'pageNum', value : '${criteria.pageNum}'}))
			.append($('<input/>',{type : 'hidden', name : 'amount', value : '${criteria.amount}'}))
			.attr('method','get')
		if(operration=='list'){
			form.find('#bno').remove();
			form.attr('action','${ctxPath}/board/list')
		} else if(operration=='modify'){
			form.attr('action','${ctxPath}/board/modify')
		}
		form.submit();
	});
});
</script>

<%@ include file="../includes/footer.jsp"%>
